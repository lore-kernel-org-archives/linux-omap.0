From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 06/12] omap: mcbsp: Implement generic register and cache access
Date: Fri,  1 Jul 2011 11:52:30 +0300
Message-ID: <1309510356-27147-7-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab1GAIxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:05 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:04 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Get rid of is_omap tests in omap_mcbsp_write and omap_mcbsp_read by using
register size and register step variables that are passed via platform data

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap1/mcbsp.c             |    2 +
 arch/arm/mach-omap2/mcbsp.c             |    7 ++++++
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 +
 arch/arm/plat-omap/mcbsp.c              |   32 +++++++++++++++++-------------
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 3c985ac..36ab5d8 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -391,6 +391,8 @@ static void omap_mcbsp_register_board_cfg(struct resource *res, int res_count,
 			continue;
 		platform_device_add_resources(new_mcbsp, &res[i * res_count],
 					res_count);
+		config[i].reg_size = 2;
+		config[i].reg_step = 2;
 		new_mcbsp->dev.platform_data = &config[i];
 		ret = platform_device_add(new_mcbsp);
 		if (ret) {
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 4a6ef6a..1408156 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -137,6 +137,13 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 			pdata->buffer_size = 0x80;
 	}
 
+	pdata->reg_step = 4;
+	if (oh->class->rev < MCBSP_CONFIG_TYPE2)
+		pdata->reg_size = 2;
+	else
+		pdata->reg_size = 4;
+
+
 	oh_device[0] = oh;
 
 	if (oh->dev_attr) {
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 2202457..31b24c9 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -320,6 +320,8 @@ struct omap_mcbsp_platform_data {
 #endif
 	u16 buffer_size;
 	unsigned int mcbsp_config_type;
+	u8 reg_size;
+	u8 reg_step;
 };
 
 struct omap_mcbsp_st_data {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index a7ced1b..92d6d4f 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -36,31 +36,35 @@ int omap_mcbsp_count, omap_mcbsp_cache_size;
 
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
-	if (cpu_class_is_omap1()) {
-		reg /= 2;
-		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
-		__raw_writew((u16)val, mcbsp->io_base + reg);
-	} else if (cpu_is_omap2420()) {
-		((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)] = (u16)val;
+	int index;
+
+	if (mcbsp->pdata->reg_size == 2 && mcbsp->pdata->reg_step == 2)
+		reg /= 2; /* Calculate OMAP1 register offset */
+
+	index = reg / mcbsp->pdata->reg_step;
+	if (mcbsp->pdata->reg_size == 2) {
+		((u16 *)mcbsp->reg_cache)[index] = (u16)val;
 		__raw_writew((u16)val, mcbsp->io_base + reg);
 	} else {
-		((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)] = val;
+		((u32 *)mcbsp->reg_cache)[index] = val;
 		__raw_writel(val, mcbsp->io_base + reg);
 	}
 }
 
 static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 {
-	if (cpu_class_is_omap1()) {
-		reg /= 2;
-		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
-				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
-	} else if (cpu_is_omap2420()) {
+	int index;
+
+	if (mcbsp->pdata->reg_size == 2 && mcbsp->pdata->reg_step == 2)
+		reg /= 2; /* Calculate OMAP1 register offset */
+
+	index = reg / mcbsp->pdata->reg_step;
+	if (mcbsp->pdata->reg_size == 2) {
 		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
-				((u16 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+				     ((u16 *)mcbsp->reg_cache)[index];
 	} else {
 		return !from_cache ? __raw_readl(mcbsp->io_base + reg) :
-				((u32 *)mcbsp->reg_cache)[reg / sizeof(u32)];
+				     ((u32 *)mcbsp->reg_cache)[index];
 	}
 }
 
-- 
1.7.0.4

