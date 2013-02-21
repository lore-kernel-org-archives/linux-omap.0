From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: AM335x mpurate + bogomips
Date: Thu, 21 Feb 2013 16:36:15 +0000
Message-ID: <51264CFF.8050200@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:46788 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754401Ab3BUQgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 11:36:17 -0500
Received: from [10.0.0.102] (unknown [10.0.0.102])
	by centos1.newflow.co.uk (Postfix) with ESMTP id EA67126B8035
	for <linux-omap@vger.kernel.org>; Thu, 21 Feb 2013 16:36:15 +0000 (GMT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Before I dig any deeper, can anyone tell me if the bootarg "mpurate" is meant to
be supported for AM335x SoCs ?

I've tried it on our custom board using 3v8, but no joy.

The boot log shows:-

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.8.0-03059-g621553c-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #113 SMP Thu Feb 21 16:29:48 GMT 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: Newflow NanoBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES1.0 (neon )
...
[    0.000000] Kernel command line: console=ttyO0,115200n8 mpurate=720 root=/dev/mmcblk0p2 ro rootfstype=ext2 rootwait
...
[    0.001119] Calibrating delay loop... 364.48 BogoMIPS (lpj=1425408)

I have seen other boot logs outputs [1] from other people where they are getting nearly double that.

Looking at omap2xxx_clk_arch_init(), only ompa24xx devices are supported.

Am I missing something obvious (like it's not yet supported !!) ?

Cheers
Mark J.

[1] http://e2e.ti.com/support/embedded/linux/f/354/t/245316.aspx
