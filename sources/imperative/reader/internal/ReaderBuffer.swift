extension CSVReader {
    /// Buffer used to stored previously read unicode scalars.
    internal final class ScalarBuffer: IteratorProtocol {
        /// Unicode scalars read inferring configuration variables that were unknown.
        ///
        /// This buffer is reversed to make it efficient to remove elements.
        private var _readScalars: [Unicode.Scalar]
        
        /// Creates the buffer with a given capacity value.
        init(reservingCapacity capacity: Int) {
            self._readScalars = []
            self._readScalars.reserveCapacity(capacity)
        }
        
        func next() -> Unicode.Scalar? {
            guard !self._readScalars.isEmpty else { return nil }
            return self._readScalars.removeLast()
        }
        
        /// Inserts a single unicode scalar at the beginning of the buffer.
        func preppend(scalar: Unicode.Scalar) {
            self._readScalars.append(scalar)
        }
        
        /// Inserts a sequence of scalars at the beginning of the buffer.
        func preppend<S:Sequence>(scalars: S) where S.Element == Unicode.Scalar {
            self._readScalars.append(contentsOf: scalars.reversed())
        }
        
        /// Appends a single unicode scalar to the buffer.
        func append(scalar: Unicode.Scalar) {
            self._readScalars.insert(scalar, at: self._readScalars.startIndex)
        }
        
        /// Appends a sequence of unicode scalars to the buffer.
        func append<S:Sequence>(scalars: S) where S.Element == Unicode.Scalar {
            self._readScalars.insert(contentsOf: scalars.reversed(), at: self._readScalars.startIndex)
        }
        
        /// Removes all scalars in the buffer.
        func removeAll() {
            self._readScalars.removeAll()
        }
    }
}
