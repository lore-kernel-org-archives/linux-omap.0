From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/5] ARM: OMAP2+: gpmc: Keep Chip Select disabled while configuring it
Date: Tue, 21 Oct 2014 15:41:48 +0300
Message-ID: <1413895309-9152-5-git-send-email-rogerq@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519AbaJUMmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2014 08:42:04 -0400
In-Reply-To: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>

As per the OMAP reference manual [1], the Chip Select must be
disabled (i.e. CSVALID is 0) while configuring any of the
Chip select parameters.

[1] - 10.1.5.1 Chip-Select Base Address and Region Size Configuration
http://www.ti.com/lit/pdf/swpu177

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 0ba95d3..437fb6f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -397,7 +397,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	return 0;
 }
 
-static int gpmc_cs_enable_mem(int cs, u32 base, u32 size)
+static int gpmc_cs_set_memconf(int cs, u32 base, u32 size)
 {
 	u32 l;
 	u32 mask;
@@ -421,6 +421,15 @@ static int gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 	return 0;
 }
 
+static void gpmc_cs_enable_mem(int cs)
+{
+	u32 l;
+
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+	l |= GPMC_CONFIG7_CSVALID;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
+}
+
 static void gpmc_cs_disable_mem(int cs)
 {
 	u32 l;
@@ -532,18 +541,18 @@ static int gpmc_cs_remap(int cs, u32 base)
 	gpmc_cs_get_memconf(cs, &old_base, &size);
 	if (base == old_base)
 		return 0;
-	gpmc_cs_disable_mem(cs);
+
 	ret = gpmc_cs_delete_mem(cs);
 	if (ret < 0)
 		return ret;
+
 	ret = gpmc_cs_insert_mem(cs, base, size);
 	if (ret < 0)
 		return ret;
-	ret = gpmc_cs_enable_mem(cs, base, size);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	ret = gpmc_cs_set_memconf(cs, base, size);
+
+	return ret;
 }
 
 int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
@@ -572,12 +581,17 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (r < 0)
 		goto out;
 
-	r = gpmc_cs_enable_mem(cs, res->start, resource_size(res));
+	/* Disable CS while changing base address and size mask */
+	gpmc_cs_disable_mem(cs);
+
+	r = gpmc_cs_set_memconf(cs, res->start, resource_size(res));
 	if (r < 0) {
 		release_resource(res);
 		goto out;
 	}
 
+	/* Enable CS */
+	gpmc_cs_enable_mem(cs);
 	*base = res->start;
 	gpmc_cs_set_reserved(cs, 1);
 out:
@@ -1539,6 +1553,9 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto no_timings;
 	}
 
+	/* CS must be disabled while making changes to gpmc configuration */
+	gpmc_cs_disable_mem(cs);
+
 	/*
 	 * FIXME: gpmc_cs_request() will map the CS to an arbitary
 	 * location in the gpmc address space. When booting with
@@ -1577,6 +1594,9 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	val &= ~GPMC_CONFIG_LIMITEDADDRESS;
 	gpmc_write_reg(GPMC_CONFIG, val);
 
+	/* Enable CS region */
+	gpmc_cs_enable_mem(cs);
+
 no_timings:
 	if (of_platform_device_create(child, NULL, &pdev->dev))
 		return 0;
-- 
1.8.3.2

