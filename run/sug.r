# Ben Fasoli

site   <- 'sug'

# Load settings and initialize lock file
source('/uufs/chpc.utah.edu/common/home/lin-group9/measurements/pipeline/_global.r')
site_config <- site_config[site_config$stid == site, ]
lock_create()

try({
  # Licor 6262 -----------------------------------------------------------------
  instrument <- 'licor_6262'
  proc_init()
  nd <- cr1000_init()
  if (!site_config$reprocess)
    update_archive(nd, data_path(site, instrument, 'raw'), check_header = F)
  nd <- licor_6262_qaqc()
  update_archive(nd, data_path(site, instrument, 'qaqc'))
  nd <- licor_6262_calibrate()
  update_archive(nd, data_path(site, instrument, 'calibrated'))
})

try({
  # MetOne ES642 ---------------------------------------------------------------
  instrument <- 'metone_es642'
  proc_init()
  nd <- cr1000_init()
  if (!site_config$reprocess)
    update_archive(nd, data_path(site, instrument, 'raw'), check_header = F)
  nd <- metone_es642_qaqc()
  update_archive(nd, data_path(site, instrument, 'qaqc'))
  nd <- metone_es642_calibrate()
  update_archive(nd, data_path(site, instrument, 'calibrated'))
})

lock_remove()
