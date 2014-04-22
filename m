From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Fix few omap gpmc regressions when booted with device tree
Date: Mon, 21 Apr 2014 17:54:38 -0700
Message-ID: <1398128080-18903-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12501 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751561AbaDVAyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 20:54:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Pekon Gupta <pekon@ti.com>

Hi all,

Here are two fixes to GPMC issues I've seen. It seems that we have
few more issues left to solve:

1. The remap of a device with gpmc_cs_remap seems to fail for
   a device if it's address specified in the .dts file is
   different from the address used by the bootloader

2. There seems to be some timing issues with smc911x where
   rsync of larger files and apt-get dist-upgrade can produce 
   strange errors. This seems to work reliably when booted in
   legacy mode.

3. The DT mappings of GPMC devices are wrong for most devices
   where the ranges property should contain the GPMC partition
   size (16, 32, 128 or 256 MB), and the reg property for the
   device should only contain the device IO range. So only NOR
   should use large values for ranges and IO range, the rest
   should use the minimum 16 MB range for GPMC partition, and
   0x4 - 0x20000 for the IO range. And while patching these
   it makes sense to also unify the GPMC ranges being used for
   devices.

Pekon, can you take a look at 1 and 2 above?

Then for 3 above, it seems that we cannot safely change
ranges before 1 and 2 are working reliably. Or else we have
patch things twice, once to fix the range sizes, then to
unify the mappings for the range address...

Regards,

Tony

Tony Lindgren (2):
  ARM: OMAP2+: Fix oops for GPMC free
  ARM: OMAP2+: Fix GPMC remap for devices using an offset

 arch/arm/mach-omap2/gpmc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
1.8.1.1

