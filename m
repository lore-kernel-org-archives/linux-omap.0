From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] ARM: OMAP3: mmc-twl4030 fix for vmmc = 0
Date: Tue, 10 Mar 2009 14:11:17 -0700
Message-ID: <20090310211117.16425.39829.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57200 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbZCJVLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:11:22 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Resolve longstanding issue noted by Adrian Hunter:  confusion
between settting VSEL=0 (which is 1.8V on MMC1) and poweroff.

Also, leave VSEL alone if we're just powering the regulator off.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 042035c..2becaf3 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -178,7 +178,10 @@ static int twl_mmc_resume(struct device *dev, int slot)
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
@@ -203,8 +206,7 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
 			/* error if VSIM needed */
 			break;
 		default:
-			vmmc = 0;
-			break;
+			return -EINVAL;
 		}
 	} else if (c->twl_vmmc_dev_grp == VMMC2_DEV_GRP) {
 		/* VMMC2:  max 100 mA */
@@ -230,21 +232,21 @@ static int twl_mmc_set_voltage(struct twl_mmc_controller *c, int vdd)
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

