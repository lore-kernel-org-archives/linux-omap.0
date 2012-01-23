From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH v2] GPMC: fix device size setup
Date: Mon, 23 Jan 2012 08:32:23 +0100
Message-ID: <4F1D0D07.7070807@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:52190 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab2AWHch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 02:32:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, arm-linux <linux-arm-kernel@lists.infradead.org>

following statement can only change device size from 8-bit(0) to 16-bit(1),
but not vice versa:

regval |= GPMC_CONFIG1_DEVICESIZE(wval);

so as this field has 1 reserved bit, that could be used in future,
just clear both bits and then OR with the desired value

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
v2: cc linux-arm-kernel mailing list

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
 

