# haplotype caller

java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar \
-R /home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T HaplotypeCaller -I AHQT1.bam -o AHQT.gvcf \
--emitRefConfidence GVCF \
-variant_index_type LINEAR \
-variant_index_parameter 128000

# genotype gvcf

java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar -R \
/home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T GenotypeGVCFs \
-V AHQT.gvcf \
-o AHQT.vcf.gz \
--emitRefConfidence GVCF \
-variant_index_type LINEAR \
-variant_index_parameter 128000

# select variants (only keep biallelic)

java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar -R \
/home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T SelectVariants \
-V AHQT.vcf \
--select-type-to-include SNP \
--restrict-alleles-to BIALLELIC \
-o AHQT_biallelic_snps.vcf

# filter variants by quality

java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar -R \
/home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T VariantFiltration \
-V AHQT_biallelic_snps.vcf \
--filterExpression "QUAL &lt; 40.0” \ 
--filterName “QUAL” \ --filterExpression “DP &lt; 2” --filterName “DEPTH” 

# select variants based on filter

java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar -R \
/home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T SelectVariants \
-V AHQT_biallelic_snps.vcf \
--select-type-to-include SNP \
--exclude-filtered=TRUE
-o AHQT_biallelic_snps.filtered.dropped.output.vcf

# use filtered SNPs to generate an AHQT pseudoreference genome

java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar -R \
/home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T FastaAlternateReferenceMaker \
-V AHQT_biallelic_snps.filtered.dropped.output.vcf \
-o AHQT_pseudo.fa

# appending allelic identifiers:
sed 's/:.*/_SF5/' MguttatusV2refmtcp_SF5.fa | sed 's/.*\s/>/' >  MguttatusV2refmtcp_SF5_pseudo.fa




java -jar /home/thom_nelson/opt/GenomeAnalysisTK.jar -R \
/home/thom_nelson/resources/Mimulus/guttatus/IM62_v2.0/Mguttatus_V2refmtcp.fa \
-T HaplotypeCaller \
-I AHQNT1.6_8.bam \
-o AHQNT.gvcf \
--emitRefConfidence GVCF \
-variant_index_type LINEAR \
-variant_index_parameter 128000
