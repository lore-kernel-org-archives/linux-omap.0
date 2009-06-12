From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] OMAP: gpmc-onenand: correct use of async timings
Date: Fri, 12 Jun 2009 15:07:59 +0300
Message-ID: <4A32451F.2010504@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43356 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbZFLMHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 08:07:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 2766ff4a4087bae99463813b4a018ef9ebe498fc Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 12 Jun 2009 14:39:22 +0300
Subject: [PATCH] OMAP: gpmc-onenand: correct use of async timings

Use async timings when sync timings are not requested.

Also ensure that OneNAND is in async mode when async
timings are used.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
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
-- 
1.5.6.3
