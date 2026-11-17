variable "name" {type = string }
variable "image_path" {  type = string }
variable "vm_id" {type = string }
variable "datastore_id" {type = string }

variable "node_name" {
  type = string 
  default = "maje"
}

variable "cores" {
  type = number
  default = 2
}

variable "memory" {
  type = number
  default = 2048
}

variable "storage" {
  type = number
  default = 20
}

variable "tags" {
  type = list(string)
  default = []
}

variable "nics" {
  type = list(object({
    bridge  = string
    vlan_id = optional(number)
  }))
}