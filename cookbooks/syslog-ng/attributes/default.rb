default[:syslog][:scripts]   =  {"rails" => {
    :filter => "rails",
    :destination => {:file_name => "/var/log/rails"}
    }
  }
