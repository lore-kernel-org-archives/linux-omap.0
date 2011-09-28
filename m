From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP4: MMC: fix power and audio issue,
	decouple USBC1 from MMC1
Date: Wed, 28 Sep 2011 14:48:15 -0700
Message-ID: <20110928214815.29263.90657.stgit@kaulin.local>
References: <20110928214707.29263.58095.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29824 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab1I1VsS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 17:48:18 -0400
In-Reply-To: <20110928214707.29263.58095.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Bryan Buckley <bryan.buckley@ti.com>, Balaji T K <balajitk@ti.com>

From: Bryan Buckley <bryan.buckley@ti.com>

Remove OMAP4_USBC1_ICUSB_PWRDNZ_MASK during enable/disable PWRDNZ mode for
MMC1_PBIAS and associated extended-drain MMC1 I/O cell. This is in accordance
with the control module programming guide. This fixes a bug where if trying to
use gpio_98 or gpio_99 and MMC1 at the same time the GPIO signal will be
affected by a changing SDMMC1_VDDS.

Software must keep MMC1_PBIAS cell and MMC1_IO cell PWRDNZ signals low whenever
SDMMC1_VDDS ramps up/down or changes for cell protection purposes.

MMC1 is based on SDMMC1_VDDS whereas USBC1 is based on SIM_VDDS therefore
they can operate independently.

Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>
Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
Tested-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a9b45c7..097a42d 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -137,8 +137,7 @@ static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
 	 */
 	reg = omap4_ctrl_pad_readl(control_pbias_offset);
 	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-		OMAP4_MMC1_PWRDNZ_MASK |
-		OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+		OMAP4_MMC1_PWRDNZ_MASK);
 	omap4_ctrl_pad_writel(reg, control_pbias_offset);
 }
 
@@ -156,8 +155,7 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 		else
 			reg |= OMAP4_MMC1_PBIASLITE_VMODE_MASK;
 		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-			OMAP4_MMC1_PWRDNZ_MASK |
-			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			OMAP4_MMC1_PWRDNZ_MASK);
 		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 
 		timeout = jiffies + msecs_to_jiffies(5);
@@ -171,16 +169,14 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
 			pr_err("Pbias Voltage is not same as LDO\n");
 			/* Caution : On VMODE_ERROR Power Down MMC IO */
-			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK |
-				OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK);
 			omap4_ctrl_pad_writel(reg, control_pbias_offset);
 		}
 	} else {
 		reg = omap4_ctrl_pad_readl(control_pbias_offset);
 		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
 			OMAP4_MMC1_PWRDNZ_MASK |
-			OMAP4_MMC1_PBIASLITE_VMODE_MASK |
-			OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
+			OMAP4_MMC1_PBIASLITE_VMODE_MASK);
 		omap4_ctrl_pad_writel(reg, control_pbias_offset);
 	}
 }

