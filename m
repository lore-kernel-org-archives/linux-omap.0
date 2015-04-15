From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 10/35] ARM: OMAP2+: hwmod: export hwmod APIs for driver use
Date: Wed, 15 Apr 2015 15:52:57 +0300
Message-ID: <1429102402-5276-11-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42508 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755382AbbDOMwt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:49 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

These are required for providing hwmod data in late boot through a module.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   14 ++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |    5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d20179a..1f2b659 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3234,6 +3234,11 @@ static void __init *memblock_alloc(int size)
 	return memblock_virt_alloc(size, 0);
 }
 
+static void *kzalloc_alloc(int size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
 /**
  * omap_hwmod_register_links - register an array of hwmod links
  * @ois: pointer to an array of omap_hwmod_ocp_if to register
@@ -3276,6 +3281,14 @@ int omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
 	return 0;
 }
 
+int omap_hwmod_register_links_late(struct omap_hwmod_ocp_if **ois)
+{
+	soc_ops.memalloc = kzalloc_alloc;
+
+	return omap_hwmod_register_links(ois);
+}
+EXPORT_SYMBOL(omap_hwmod_register_links_late);
+
 /**
  * _ensure_mpu_hwmod_is_setup - ensure the MPU SS hwmod is init'ed and set up
  * @oh: pointer to the hwmod currently being set up (usually not the MPU)
@@ -3344,6 +3357,7 @@ int omap_hwmod_setup_all(void)
 	return 0;
 }
 omap_core_initcall(omap_hwmod_setup_all);
+EXPORT_SYMBOL(omap_hwmod_setup_all);
 
 /**
  * omap_hwmod_enable - enable an omap_hwmod
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 6da0524..9612add 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -755,6 +755,9 @@ extern int ti81xx_hwmod_init(void);
 extern int dra7xx_hwmod_init(void);
 int am43xx_hwmod_init(void);
 
-extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois);
+int omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois);
+int omap_hwmod_register_links_late(struct omap_hwmod_ocp_if **ios);
+
+int omap_hwmod_setup_all(void);
 
 #endif
-- 
1.7.9.5

