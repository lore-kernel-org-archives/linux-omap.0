From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: GPMC: fix device size setup
Date: Fri, 20 Jan 2012 17:02:31 +0100
Message-ID: <4F199017.80506@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:52424 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab2ATQ0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 11:26:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

following statement can only change device size from 8-bit(0) to 16-bit(1),
but not vice versa:

regval |= GPMC_CONFIG1_DEVICESIZE(wval);

so as this field has 1 reserved bit, that could be used in future,
just clear both bits and then OR with the desired value

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/arch/arm/mach-omap2/gpmc.c
===================================================================
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -528,7 +528,13 @@
 
 	case GPMC_CONFIG_DEV_SIZE:
 		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		/* clear 2 target bits */
+		regval &= ~GPMC_CONFIG1_DEVICESIZE(3);
+
+		/* set the proper value */
 		regval |= GPMC_CONFIG1_DEVICESIZE(wval);
+
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
 		break;
 

