From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] omap4 hsmmc: Register offset handling
Date: Fri, 01 Oct 2010 16:34:23 -0700
Message-ID: <20101001233423.31894.80954.stgit@baageli.muru.com>
References: <20101001233315.31894.49599.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56461 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab0JAXe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:34:28 -0400
In-Reply-To: <20101001233315.31894.49599.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: kishore kadiyala <kishore.kadiyala@ti.com>

In OMAP4, as per new PM programming model, the legacy registers
which were there in OMAP3 are all shifted by 0x100 while new one's
are added from offset 0 to 0x10.
For OMAP4, the register offset appending of 0x100 done in devices.c
currently, is moved to driver file.This change fits in for current
implementation as well as once the driver undergoes hwmod adaptation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c         |    8 +++-----
 arch/arm/mach-omap2/hsmmc.c           |    4 ++++
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    2 ++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 9e5d51b..9bd4b34 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -817,13 +817,13 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		case 3:
 			if (!cpu_is_omap44xx())
 				return;
-			base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
+			base = OMAP4_MMC4_BASE;
 			irq = OMAP44XX_IRQ_MMC4;
 			break;
 		case 4:
 			if (!cpu_is_omap44xx())
 				return;
-			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
+			base = OMAP4_MMC5_BASE;
 			irq = OMAP44XX_IRQ_MMC5;
 			break;
 		default:
@@ -834,10 +834,8 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			size = OMAP2420_MMC_SIZE;
 			name = "mmci-omap";
 		} else if (cpu_is_omap44xx()) {
-			if (i < 3) {
-				base += OMAP4_MMC_REG_OFFSET;
+			if (i < 3)
 				irq += OMAP44XX_IRQ_GIC_START;
-			}
 			size = OMAP4_HSMMC_SIZE;
 			name = "mmci-omap-hs";
 		} else {
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index df1311d..ab78a5a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -266,6 +266,10 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].caps = c->caps;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
+		if (cpu_is_omap44xx())
+			mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
+		else
+			mmc->reg_offset = 0;
 
 		mmc->get_context_loss_count = hsmmc_get_context_loss;
 
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 0f0f113..3107892 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -71,6 +71,9 @@ struct omap_mmc_platform_data {
 
 	u64 dma_mask;
 
+	/* Register offset deviation */
+	u16 reg_offset;
+
 	struct omap_mmc_slot_data {
 
 		/*
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 69858e7..dc95756 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2014,6 +2014,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
+	res->start += pdata->reg_offset;
+	res->end += pdata->reg_offset;
 	res = request_mem_region(res->start, res->end - res->start + 1,
 							pdev->name);
 	if (res == NULL)

