variable "AWS_ACCESS_KEY"{}
variable "AWS_SECRET_KEY"{}
variable "region"{}
variable "keyname"{
	default="mainKey"
}
variable "PUBLIC_KEY_PATH"{}

variable "DB_PUBLIC_KEY"{}

variable "PUBLIC_WEB_KEY"{}
variable "subnetValues"{
	type="list"
	default=["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24","10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
}

variable "subnetPublic"{
	type="map"
	default={
		"10.0.1.0/24"="a"
		"10.0.3.0/24"="b"
		"10.0.5.0/24"="c"
	}
}

variable "subnetPrivate"{
        type="map"
        default={
                "10.0.2.0/24"="a"
                "10.0.4.0/24"="b"
                "10.0.6.0/24"="c"
        }
}
	
