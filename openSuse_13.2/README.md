h1. OpenSuse 13.2 installation for Virtualisation (docker, QEMU, XEN, ...)

h2. Installation from DVD

* Chose language adn keyboard then Next

* Tick "Add Online Repositories Before Installation" then Next

* Edit Proposal Settings
  - No LVM, 
  - Root Partition with XFS,
  - Separate Home Partition with XFS
  - Enlarge Swap for Suspend

* Expert mode (disk of 1TB))
  - Delete all partitions
  - Add Swap 8GB XFS
  - Add / 100GB XFS
  - Add /home 500GB XFS
  - Add /var 200GB (images for docker, QEMU, ... in this directory)
  - Accept 

* Select your Time Zone then Next

* List of Online Repositories then Next

* Licence agreement then Next

* Desktop Selection (KDE) then Next

* Create the main user 
  - untick Automatic login 
  - then Next

* Installation Settings
  - Click on Software
  - Click on Details ...
  - Select Linux Kernel (for git-core)
  - Select Xen Virtual Machine Host Server (alli packages)
  - Select KVM Host Server (all packages)
  - then Accept (only the dependencies)
  - Export Configuration into /root
  - then Install and Confirm (/!\ all your disk will modified and FORMATTED)
  - then Install 

* Now go ito take a beer: It will take some time ;-)

h2. Intallation normally done

* Connect as root on system

* Launch an XTerm into /root and execute following list of commands
<pre>
  # git clone https://github.com/phcalas/project1.git
  # cd project1/opensuse_13.2
  # sh ./install_update.sh
</pre>
* Restore backup (DO NOT USE THIS PROCEDURE: my reminder)
<pre>
  # mkdir /save; mount /dev/sdc2 /save
  # (cd /save/root; tar cf - .) | (cd /root; tar xf -) 
  # (cd /save; tar cf - .) | (cd /home; tar xf -)
</pre>
  

