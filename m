From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/5] ARM: OMAP2+: gpmc: configuration enhancements
Date: Tue, 21 Oct 2014 15:41:44 +0300
Message-ID: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47073 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbaJUMmD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2014 08:42:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Hi Tony,

These patches address GPMC configuration issues and are for v3.19.
Patches based on v3.18-rc1.

- Make sure to print a user visible error if a requested GPMC timing
configuration can't be met.

- Don't create GPMC child device if a GPMC timing could not be set.

- Always enable address lines A26-A11 for non-NAND devices.

- Perform GPMC configuration as per recommended procedure i.e.
keep Chip Select disabled while changing GPMC configuration.

Tested on dra7-evm, am437x-gp-evm and beagleboard.

cheers,
-roger

Roger Quadros (5):
  ARM: OMAP2+: gpmc: Print error message in set_gpmc_timing_reg()
  ARM: OMAP2+: gpmc: Error out if timings fail in
    gpmc_probe_generic_child()
  ARM: OMAP2+: gpmc: Always enable A26-A11 for non NAND devices
  ARM: OMAP2+: gpmc: Keep Chip Select disabled while configuring it
  ARM: OMAP2+: gpmc: Sanity check GPMC fck on probe

 arch/arm/mach-omap2/gpmc.c | 87 ++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

-- 
1.8.3.2

