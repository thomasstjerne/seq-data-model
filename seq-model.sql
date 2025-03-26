-- Given a pair of primers, find the relative abundance of each taxon in each sample
-- 1. get the relative abundance of each taxon in each sample
-- 2. filter out the taxon with relative abundance less than 0.01
-- 3. order the result by sample id and relative abundance in descending order
-- 4. return the sample id, taxon name, and relative abundance
-- 5. the result should be like:
-- | eventID   | scientificName | relativeAbundanceInSample |
-- |-----------|----------------|--------------------|
-- | 1         | taxon1         | 0.1                |
-- | 1         | taxon2         | 0.05               |
-- | 2         | taxon1         | 0.2                |
-- | 2         | taxon2         | 0.15               |  

SELECT e.eventID, t.scientificName, anl_seq.readCount/a.sampleSizeValue as relativeAbundanceInSample
FROM Event e JOIN geneticAnalysis a ON e.eventID = a.eventID 
JOIN geneticAnalysisSequence anl_seq ON a.geneticAnalysisID = anl_seq.geneticAnalysisID 
JOIN geneticSequence s ON anl_seq.geneticSequenceID = s.geneticSequenceID 
JOIN Identification i on s.geneticSequenceID = i.identificationBasedOnGeneticSequenceID
JOIN Taxon t on i.taxonID = t.taxonID
WHERE a.pcr_primer_fwd = "CCTACGGGNGGCWGCAG" AND a.pcr_primer_rev = "GACTACHVGGGTATCTAATCC" 
HAVING relative_abundance > 0.01
ORDER BY e.id, relative_abundance DESC