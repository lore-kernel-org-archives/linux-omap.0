From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/10] ARM: OMAP2+: Require proper GPMC timings for devices
Date: Wed, 29 Oct 2014 17:29:05 -0700
Message-ID: <1414628948-30702-8-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52282 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758051AbaJ3Aag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:36 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>

Now that we have timings in the .dts files for smc91x
and 8250, we can remove the device specific checks and
just print out the bootloader timings for devices that
may not have timings in the .dts files.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 0999923..0e74d1d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1708,22 +1708,6 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	}
 
 	/*
-	 * For some GPMC devices we still need to rely on the bootloader
-	 * timings because the devices can be connected via FPGA. So far
-	 * the list is smc91x on the omap2 SDP boards, and 8250 on zooms.
-	 * REVISIT: Add timing support from slls644g.pdf and from the
-	 * lan91c96 manual.
-	 */
-	if (of_device_is_compatible(child, "ns16550a") ||
-	    of_device_is_compatible(child, "smsc,lan91c94") ||
-	    of_device_is_compatible(child, "smsc,lan91c111")) {
-		dev_warn(&pdev->dev,
-			 "%s using bootloader timings on CS%d\n",
-			 child->name, cs);
-		goto no_timings;
-	}
-
-	/*
 	 * FIXME: gpmc_cs_request() will map the CS to an arbitary
 	 * location in the gpmc address space. When booting with
 	 * device-tree we want the NOR flash to be mapped to the
-- 
2.1.1

