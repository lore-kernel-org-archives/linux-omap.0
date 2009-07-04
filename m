From: Kalle Valo <kalle.valo@iki.fi>
Subject: mainline: misc.o uses VFP instructions error
Date: Sat, 04 Jul 2009 18:12:07 +0300
Message-ID: <87zlbkqy7s.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:44761 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZGDPMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jul 2009 11:12:07 -0400
Received: by fxm18 with SMTP id 18so2719307fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2009 08:12:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm trying to compile omap_generic_2420_defconfig in mainline and I get
this error:

  Kernel: arch/arm/boot/Image is ready
  LD      arch/arm/boot/compressed/vmlinux
arm-linux-ld: ERROR: arch/arm/boot/compressed/misc.o uses VFP
  instructions, whereas arch/arm/boot/compressed/vmlinux does not
arm-linux-ld: failed to merge target specific data of file
  arch/arm/boot/compressed/misc.o

Here are the exact commands I used:

make ARCH=arm CROSS_COMPILE=arm-linux- clean
make ARCH=arm CROSS_COMPILE=arm-linux- mrproper
make ARCH=arm CROSS_COMPILE=arm-linux- omap_generic_2420_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux- -j 2

The compiler and linker used:

$ arm-linux-gcc -v
Using built-in specs.
Target: arm-none-eabi
Configured with: /scratch/julian/lite-respin/eabi/src/gcc-4.3/configure
--build=i686-pc-linux-gnu --host=i686-pc-linux-gnu
--target=arm-none-eabi --enable-threads --disable-libmudflap
--disable-libssp --disable-libstdcxx-pch --with-gnu-as --with-gnu-ld
--enable-languages=c,c++ --disable-shared --with-newlib
--with-pkgversion='Sourcery G++ Lite 2008q3-66'
--with-bugurl=https://support.codesourcery.com/GNUToolchain/
--disable-nls --prefix=/opt/codesourcery --with-headers=yes
--with-sysroot=/opt/codesourcery/arm-none-eabi
--with-build-sysroot=/scratch/julian/lite-respin/eabi/install/arm-none-eabi
--with-gmp=/scratch/julian/lite-respin/eabi/obj/host-libs-2008q3-66-arm-none-eabi-i686-pc-linux-gnu/usr
--with-mpfr=/scratch/julian/lite-respin/eabi/obj/host-libs-2008q3-66-arm-none-eabi-i686-pc-linux-gnu/usr
--disable-libgomp --enable-poison-system-directories
--with-build-time-tools=/scratch/julian/lite-respin/eabi/install/arm-none-eabi/bin
--with-build-time-tools=/scratch/julian/lite-respin/eabi/install/arm-none-eabi/bin
Thread model: single
gcc version 4.3.2 (Sourcery G++ Lite 2008q3-66) 
$ arm-linux-ld -v
GNU ld (Sourcery G++ Lite 2008q3-66) 2.18.50.20080215
$ 

The commit in question is 746a99a5af6 (2.6.31-rc1 plus something on top)
from Linus' tree. 

Any ideas why this is happening? The same toolchain has worked fine with
n800 code in linux-omap.

-- 
Kalle Valo
