function test_bug2193

% TEST test_bug2193
% TEST ft_read_atlas

%%%%%% from http://fmri.wfubmc.edu

filename = dccnfilename('/home/common/matlab/fieldtrip/data/test/bug2193/wfu/aal_MNI_V4.nii');

aal = ft_read_atlas(filename);
assert(all(~cellfun(@isempty, aal.tissuelabel)), 'there is an empty tissuelabel');
assert(max(aal.tissue(:))==length(aal.tissuelabel), 'inconsistent number of tissues');

cfg = [];
cfg.atlas = filename;
bbl = ft_prepare_atlas(cfg);


%%%%%% from http://www.cyceron.fr
filename = dccnfilename('/home/common/matlab/fieldtrip/data/test/bug2193/aal/ROI_MNI_V4.nii');

aal = ft_read_atlas(filename);
assert(all(~cellfun(@isempty, aal.tissuelabel)), 'there is an empty tissuelabel');
assert(max(aal.tissue(:))==length(aal.tissuelabel), 'inconsistent number of tissues');

cfg = [];
cfg.atlas = filename;
bbl = ft_prepare_atlas(cfg);


% The following section depends on the current (10 June 2013) situation with spm8
% on home/common, which will probably not persist forever. Therefore this section
% should not be included in the automatic regression test.

if false
  cfg.atlas = '/home/common/matlab/spm8/toolbox/wfu_pickatlas_3.03-old2/MNI_atlas_templates/aal_MNI_V4.nii'
  aal1a = ft_prepare_atlas(cfg);
  aal1b = ft_read_atlas(cfg.atlas);
  assert(all(~cellfun(@isempty, aal1b.tissuelabel)), 'there is an empty tissuelabel');
  assert(max(aal1b.tissue(:))==length(aal1b.tissuelabel), 'inconsistent number of tissues');
  assert(all(cellfun(@strcmp, aal1a.descr.name, aal1b.tissuelabel)));
  assert(all(aal1a.brick0(:) == aal1b.tissue(:)));
  
  cfg.atlas = '/home/common/matlab/spm8/toolbox/wfu_pickatlas/MNI_atlas_templates/aal_MNI_V4.nii'
  aal2a = ft_prepare_atlas(cfg);
  aal2b = ft_read_atlas(cfg.atlas);
  assert(all(~cellfun(@isempty, aal2b.tissuelabel)), 'there is an empty tissuelabel');
  assert(max(aal2b.tissue(:))==length(aal2b.tissuelabel), 'inconsistent number of tissues');
  assert(all(cellfun(@strcmp, aal2a.descr.name, aal2b.tissuelabel)));
  assert(all(aal2a.brick0(:) == aal2b.tissue(:)));
  
  cfg.atlas = '/home/common/matlab/spm8/toolbox/wfu_pickatlas-old/MNI_atlas_templates/aal_MNI_V4.img'
  aal3a = ft_prepare_atlas(cfg);
  aal3b = ft_read_atlas(cfg.atlas);
  assert(all(~cellfun(@isempty, aal3b.tissuelabel)), 'there is an empty tissuelabel');
  assert(max(aal3b.tissue(:))==length(aal3b.tissuelabel), 'inconsistent number of tissues');
  assert(all(cellfun(@strcmp, aal3a.descr.name, aal3b.brick0label)));
  assert(all(aal3a.brick0(:) == aal3b.brick0(:)));
  % note: not sure why the fields are called brick0 for the old wfu
  % pickatlas rather than tissue
end