From: Rick Bronson <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Mon, 10 Nov 2008 09:25:12 -0800
Message-ID: <E1KzaVk-0002Ad-8j@amazonia.comcast.net>
References: <E1Kypkb-0001xP-PC@amazonia.comcast.net>
	<20081108.215706.219299730.Hiroshi.DOYU@nokia.com> <20081108.220531.30268045.Hiroshi.DOYU@nokia.com>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:41518 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbYKJRZP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2008 12:25:15 -0500
In-reply-to: <20081108.220531.30268045.Hiroshi.DOYU@nokia.com> (message from
	Hiroshi DOYU on Sat, 08 Nov 2008 22:05:31 +0200 (EET))
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

Hiroshi,

  It works!

  I used strace on ping.out and found out you need to be root to run
it.  You might add that to your HOWTO.  See new HOWTO below.

  My device got made but it's 252 instead of 251.  Not sure what
that's about.

> ls -al /dev/DspBridge                                                         
crw-rw---- 1 root root 252, 0 2008-11-10 08:17 /dev/DspBridge                   

  Thanks very much for the help.

  Rick


Updated OMAP3 DspBridge HOWTO:

1. First get the date of the most current patch.
DATE=20081107

2. Do this on your host Linux box:
git clone http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
mkdir -p patches
cd patches
wget http://4869037.web.fc2.com/tidspbridge-$DATE.tgz
tar xvzf tidspbridge-$DATE.tgz
cd ../linux-omap-2.6
git am ../patches/*.patch
make <your omap3 board>_defconfig # eg. omap3_beagle_defconfig
make menuconfig # add the following options in the menuconfig
 ...
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=14
 # CONFIG_CBUS is not set
 CONFIG_MPU_BRIDGE=m
 # CONFIG_BRIDGE_DVFS is not set
 CONFIG_BRIDGE_DEBUG=y

3. You can get bridge sample binaries as below, put these on your
   target file system somewhere. Extract it somewhere on target rootfs.

  https://omapzoom.org/gf/download/frsrelease/132/632/dspbridge_binaries.tar.bz2

4. Make the modules and put them on the target rootfs.  For example,
   on your host box do:

cd linux-omap-2.6; tar czf ../modules.tar.gz `find . -name "*.ko"`

5. Then on the target do:

sudo mkdir -p /lib/modules/`uname -r`/kernel/
sudo tar xzf modules.tar.gz -C /lib/modules/`uname -r`/kernel/
sudo depmod -a

# if you don't have libbridge.so see http://elinux.org/BeagleBoard/gst-openmax
# and do this on the target:
sudo cp libbridge.so /lib
sudo ln -s libbridge.so /lib/libbridge.so.2

# NOTE: set "PATH" below correctly
sudo modprobe bridgedriver base_img=/PATH/ddspbase_tiomap3430.dof64P
ls -al /dev/DspBridge  # check to see that the device got made
  crw-rw---- 1 root root 252, 0 2008-11-10 08:53 /dev/DspBridge                   
sudo /PATH/ping.out
grep DspBridge /proc/interrupts   # check to see that you have gotten some interrupts
 26:        334        INTC  DspBridge                                          
 28:          0        INTC  DspBridge                                          
