From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: [PATCH] ARM: OMAP: Clear GPMC bits when applying new setting
Date: Wed, 06 Feb 2013 14:15:34 +0000
Message-ID: <51126586.9030308@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:42829 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753869Ab3BFOPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 09:15:36 -0500
Received: from [10.0.0.102] (unknown [10.0.0.102])
	by centos1.newflow.co.uk (Postfix) with ESMTP id 916BE26B8035
	for <linux-omap@vger.kernel.org>; Wed,  6 Feb 2013 14:15:34 +0000 (GMT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

When setting the GPMC device type, make sure any previous
bits are cleared down, before applying the new setting.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/mach-omap2/gpmc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1adb2d4..026e786 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -613,6 +613,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)

 	case GPMC_CONFIG_DEV_TYPE:
 		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+		/* clear 3 target bits */
+		regval &= ~(GPMC_CONFIG1_DEVICETYPE(3) |
+			    GPMC_CONFIG1_MUXADDDATA);
+		/* set the proper value */
 		regval |= GPMC_CONFIG1_DEVICETYPE(wval);
 		if (wval == GPMC_DEVICETYPE_NOR)
 			regval |= GPMC_CONFIG1_MUXADDDATA;
-- 
1.7.9.5

