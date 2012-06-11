From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 12/14] ARM: OMAP2+: gpmc: cs reconfigure helper
Date: Mon, 11 Jun 2012 19:57:39 +0530
Message-ID: <8882ae964a4034d58953e743cf35664d3a107823.1339419492.git.afzal@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab2FKOnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:43:21 -0400
In-Reply-To: <cover.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helper for reconfiguring CS, peripheral that necessitated
it was OneNAND.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   32 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    2 ++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 281bd23..d493a4c 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1429,6 +1429,38 @@ struct platform_device *gpmc_create_device(struct gpmc_peripheral *p)
 	return pdev;
 }
 
+static int gpmc_match_device(char *name, int id)
+{
+	int i;
+	struct gpmc_peripheral *g_per = gpmc_peripheral;
+
+	for (i = 0; i < gpmc_num_peripheral; i++, g_per++)
+		if (!strcmp(g_per->name, name) && g_per->id == id)
+			return i;
+
+	return -ENOENT;
+}
+
+int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *c)
+{
+	int i;
+
+	i = gpmc_match_device(name, id);
+	if (IS_ERR_VALUE(i)) {
+		dev_err(gpmc_dev, "no device %s.%d to configure\n", name, id);
+		return i;
+	}
+
+	if (IS_ERR_VALUE(gpmc_setup_cs_config_timing(gpmc_peripheral + i, c))) {
+		dev_err(gpmc_dev, "error: configure device %s.%d\n", name, id);
+		return i;
+	}
+
+	return gpmc_setup_waitpin(gpmc_peripheral + i);
+
+}
+EXPORT_SYMBOL_GPL(gpmc_cs_reconfigure);
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index e1b130c..32017a1 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -247,6 +247,8 @@ extern int gpmc_cs_configure(int cs, int cmd, int wval);
 extern int gpmc_nand_read(int cs, int cmd);
 extern int gpmc_nand_write(int cs, int cmd, int wval);
 
+extern int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *c);
+
 int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size);
 int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
 
-- 
1.7.10.2

