From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: 2.6.38-rc1-git1 musb undefined references
Date: Thu, 20 Jan 2011 16:22:01 +0000
Message-ID: <4D386129.4080206@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:47287 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751739Ab1ATQWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 11:22:25 -0500
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PfxHE-0005B8-AF
	for linux-omap@vger.kernel.org; Thu, 20 Jan 2011 16:22:24 +0000
Received: from [94.173.242.84] (helo=[192.168.10.2])
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.72)
	(envelope-from <sboyce@blueyonder.co.uk>)
	id 1PfxGs-0005qP-BW
	for linux-omap@vger.kernel.org; Thu, 20 Jan 2011 16:22:02 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Cross compiling for Beagleboard on Ubuntu 11.04 x86_64.
# make-kpkg --revision=0 --append-to-version=-custom --arch=armel 
--cross-compile=/opt/arm-2010q1/bin/arm-none-linux-gnueabi- kernel-image 
--initrd

====== making target debian/stamp/build/kernel [new prereqs: vars]======
This is kernel package version 12.036+nmu1.
restore_upstream_debianization
test ! -f scripts/package/builddeb.kpkg-dist || mv -f 
scripts/package/builddeb.kpkg-dist scripts/package/builddeb
test ! -f scripts/package/Makefile.kpkg-dist || mv -f 
scripts/package/Makefile.kpkg-dist scripts/package/Makefile
/usr/bin/make  EXTRAVERSION=-rc1-git1-custom  ARCH=arm \
 
CROSS_COMPILE=/opt/arm-2010q1/bin/arm-none-linux-gnueabi- zImage
make[1]: Entering directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
scripts/kconfig/conf --silentoldconfig Kconfig
make[1]: Leaving directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
make[1]: Entering directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
   CHK     include/linux/version.h
   CHK     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   LD      fs/built-in.o
   LD      lib/zlib_deflate/built-in.o
   LD      lib/built-in.o
   LD      vmlinux.o
   MODPOST vmlinux.o
WARNING: modpost: Found 3 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
   GEN     .version
   CHK     include/generated/compile.h
   UPD     include/generated/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
drivers/built-in.o: In function `musb_free':
clkdev.c:(.text+0xf3d08): undefined reference to `dma_controller_destroy'
drivers/built-in.o: In function `musb_probe':
clkdev.c:(.init.text+0x64a8): undefined reference to `dma_controller_create'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/XXX/linux-2.6.38-rc1-git1'
make: *** [debian/stamp/build/kernel] Error 2
root@sdrbox:/usr/src/XXX/linux-2.6.38-rc1-git1#

root@sdrbox:/usr/src/XXX/linux-2.6.38-rc1-git1# grep OMAP2PLUS .config
CONFIG_ARCH_OMAP2PLUS=y
CONFIG_ARCH_OMAP2PLUS_TYPICAL=y
# CONFIG_USB_MUSB_OMAP2PLUS is not set
root@sdrbox:/usr/src/XXX/linux-2.6.38-rc1-git1# grep MUSB .config
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_OMAP2PLUS is not set
CONFIG_USB_MUSB_AM35X=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_PERIPHERAL is not set
CONFIG_USB_MUSB_OTG=y
CONFIG_USB_GADGET_MUSB_HDRC=y
CONFIG_USB_MUSB_HDRC_HCD=y
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_MUSB_DEBUG is not set

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

