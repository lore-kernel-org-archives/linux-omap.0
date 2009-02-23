From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc5-omap-git] mach-omap2/mmc-twl4030: fix for vmmc = 0
Date: Mon, 23 Feb 2009 10:14:26 -0800
Message-ID: <200902231014.26352.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n8b.bullet.sp1.yahoo.com ([69.147.64.169]:28437 "HELO
	n8b.bullet.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751629AbZBWSQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:16:07 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Resolve longstanding issue noted by Adrian Hunter:  confusion
between settting VSEL=0 (which is 1.8V on MMC1) and poweroff.

Also, leave VSEL alone if we're just powering the regulator off.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
NOTE: won't apply to current mainline GIT.

 arch/arm/mach-omap2/mmc-twl4030.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -178,7 +178,10 @@ static int twl_mmc_resume(struct device 
 static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 {
 	int ret;
-	u8 vmmc, dev_grp_val;
+	u8 vmmc = 0, dev_grp_val;
+
+	if (!vdd)
+		goto doit;
 
 	if (c->twl_vmmc_dev_grp == VMMC1_DEV_GRP) {
 		/* VMMC1:  max 220 mA.  And for 8-bit mode,
@@ -203,8 +206,7 @@ static int twl_mmc_set_voltage(struct tw
 			/* error if VSIM needed */
 			break;
 		default:
-			vmmc = 0;
-			break;
+			return -EINVAL;
 		}
 	} else if (c->twl_vmmc_dev_grp == VMMC2_DEV_GRP) {
 		/* VMMC2:  max 100 mA */
@@ -230,21 +232,21 @@ static int twl_mmc_set_voltage(struct tw
 			vmmc = VMMC2_315V;
 			break;
 		default:
-			vmmc = 0;
-			break;
+			return -EINVAL;
 		}
 	} else {
-		return 0;
+		return -EINVAL;
 	}
 
-	if (vmmc)
+doit:
+	if (vdd)
 		dev_grp_val = VMMC_DEV_GRP_P1;	/* Power up */
 	else
 		dev_grp_val = LDO_CLR;		/* Power down */
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 					dev_grp_val, c->twl_vmmc_dev_grp);
-	if (ret)
+	if (ret || !vdd)
 		return ret;
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,

