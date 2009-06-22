From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/12] OMAP2/3: gpmc-onenand: correct use of async timings
Date: Mon, 22 Jun 2009 14:49:05 +0300
Message-ID: <20090622114905.28477.48166.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63541 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZFVLtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:49:12 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Use async timings when sync timings are not requested.

Also ensure that OneNAND is in async mode when async
timings are used.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 2fd22f9..54fec53 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -31,6 +31,8 @@ static struct platform_device gpmc_onenand_device = {
 static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 {
 	struct gpmc_timings t;
+	u32 reg;
+	int err;
 
 	const int t_cer = 15;
 	const int t_avdp = 12;
@@ -43,6 +45,11 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	const int t_wpl = 40;
 	const int t_wph = 30;
 
+	/* Ensure sync read and sync write are disabled */
+	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = 0;
 	t.cs_on = 0;
@@ -74,7 +81,16 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 			  GPMC_CONFIG1_DEVICESIZE_16 |
 			  GPMC_CONFIG1_MUXADDDATA);
 
-	return gpmc_cs_set_timings(cs, &t);
+	err = gpmc_cs_set_timings(cs, &t);
+	if (err)
+		return err;
+
+	/* Ensure sync read and sync write are disabled */
+	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+
+	return 0;
 }
 
 static void set_onenand_cfg(void __iomem *onenand_base, int latency,
@@ -124,7 +140,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	} else if (cfg->flags & ONENAND_SYNC_READWRITE) {
 		sync_read = 1;
 		sync_write = 1;
-	}
+	} else
+		return omap2_onenand_set_async_mode(cs, onenand_base);
 
 	if (!freq) {
 		/* Very first call freq is not known */

