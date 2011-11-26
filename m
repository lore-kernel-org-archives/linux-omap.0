From: tom.leiming@gmail.com
Subject: [PATCH 2/3] omap4: build fdif omap device from hwmod
Date: Sat, 26 Nov 2011 12:31:43 +0800
Message-ID: <1322281904-14526-3-git-send-email-tom.leiming@gmail.com>
References: <1322281904-14526-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47954 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab1KZEcl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 23:32:41 -0500
In-Reply-To: <1322281904-14526-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, greg@kroah.com, arnd@arndb.de
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ming Lei <ming.lei@canonical.com>

From: Ming Lei <ming.lei@canonical.com>

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/devices.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 1166bdc..a392af5 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -728,6 +728,38 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
 
 #endif
 
+static struct platform_device* __init omap4_init_fdif(void)
+{
+	int id = -1;
+	struct platform_device *pd;
+	struct omap_hwmod *oh;
+	const char *dev_name = "fdif";
+
+	oh = omap_hwmod_lookup("fdif");
+	if (!oh) {
+		pr_err("Could not look up fdif hwmod\n");
+		return NULL;
+	}
+
+	pd = omap_device_build(dev_name, id, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pd), "Can't build omap_device for %s.\n",
+				dev_name);
+	return pd;
+}
+
+static void __init omap_init_fdif(void)
+{
+	if (cpu_is_omap44xx()) {
+		struct platform_device *pd;
+
+		pd = omap4_init_fdif();
+		if (!pd)
+			return;
+
+		pm_runtime_enable(&pd->dev);
+	}
+}
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
@@ -808,6 +840,7 @@ static int __init omap2_init_devices(void)
 	omap_init_sham();
 	omap_init_aes();
 	omap_init_vout();
+	omap_init_fdif();
 
 	return 0;
 }
-- 
1.7.5.4

