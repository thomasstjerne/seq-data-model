# given a pair of primers, find the relative abundance of each taxon in each sample
-- 1. get the relative abundance of each taxon in each sample
-- 2. filter out the taxon with relative abundance less than 0.01
-- 3. order the result by sample id and relative abundance in descending order
-- 4. return the sample id, taxon name, and relative abundance
-- 5. the result should be like:
-- | sample_id | taxon_name | relative_abundance |
-- |-----------|------------|--------------------|
-- | 1         | taxon1     | 0.1                |
-- | 1         | taxon2     | 0.05               |
-- | 2         | taxon1     | 0.2                |
-- | 2         | taxon2     | 0.15               |  

SELECT e.id, i.taxon_name, anl_seq.readCount/a.sampleSizeValue as relative_abundance
FROM SamplingEvent e JOIN Analysis a ON e.id = a.event_id JOIN AnalysisSequence anl_seq ON a.id = anl_seq.analysis_id JOIN Sequence s ON anl_seq.sequence_id = s.id JOIN Identification i on s.id = i.sequence_id
WHERE a.pcr_primer_fwd = "CCTACGGGNGGCWGCAG" AND a.pcr_primer_rev = "GACTACHVGGGTATCTAATCC" 
HAVING relative_abundance > 0.01
ORDER BY e.id, relative_abundance DESC