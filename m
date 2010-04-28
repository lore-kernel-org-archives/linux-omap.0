From: Rick Ball <rball@AESAustin.com>
Subject: Unable to build for omap3_evm_defconfig using latest kernel-omap3
 git
Date: Wed, 28 Apr 2010 15:31:10 +0000
Message-ID: <4B8557E2E5753944B2BB2E52F7C2A30C02C0C7E0@MAIL.AES.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.ascendant-es.com ([209.12.206.138]:37933 "EHLO
	mail.aesasutin.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754040Ab0D1PbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 11:31:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I get the following error when attempting to build a kernel for the default config of the OMAP3 EVM board with the latest 'git' from:

git://dev.omapzoom.org/pub/scm/integration/kernel-omap3.git

I'm compiling with CodeSourcery 2009q3, using the 'arm-none-linux-gnueabi-' cross-compile prefix, arch=arm:

  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `omap_reset_voltage':
arch/arm/mach-omap2/voltage.c:699: undefined reference to `get_vdd1_opp'
arch/arm/mach-omap2/voltage.c:711: undefined reference to `get_vdd2_opp'
arch/arm/mach-omap2/built-in.o: In function `vp_forceupdate_scale_voltage':
arch/arm/mach-omap2/voltage.c:391: undefined reference to `get_vdd1_opp'
arch/arm/mach-omap2/voltage.c:402: undefined reference to `get_vdd2_opp'
arch/arm/mach-omap2/built-in.o: In function `vp_reg_offs_configure':
arch/arm/mach-omap2/voltage.c:296: undefined reference to `get_vdd1_opp'
arch/arm/mach-omap2/built-in.o: In function `vp_latch_vsel':
arch/arm/mach-omap2/voltage.c:203: undefined reference to `get_vdd1_opp'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

Earlier, I got the following warnings while compiling 'voltage.c':

  CC      arch/arm/mach-omap2/voltage.o

arch/arm/mach-omap2/voltage.c: In function 'vp_latch_vsel':
arch/arm/mach-omap2/voltage.c:220: warning: passing argument 1 of 'opp_find_by_opp_id' makes pointer from integer without a cast
arch/arm/plat-omap/include/plat/opp.h:293: note: expected 'struct omap_opp *' but argument is of type 'int'
arch/arm/mach-omap2/voltage.c: In function 'omap_reset_voltage':
arch/arm/mach-omap2/voltage.c:716: warning: passing argument 1 of 'opp_find_by_opp_id' makes pointer from integer without a cast
arch/arm/plat-omap/include/plat/opp.h:293: note: expected 'struct omap_opp *' but argument is of type 'int'

It looks like the Makefile for the mach-omap2 folder doesn't include the file that defines 'get_vdd1_opp' (resource34xx.c), since CONFIG_OMAP_PM_SRF isn't set by the config.  But if I modify the config so it will also compile this file, it just opens a different can of worms.

Am I doing something wrong here?  Am I mistaken in thinking that compiling for this board should work?

Thanks,

Rick Ball (rball@aesaustin.com)
