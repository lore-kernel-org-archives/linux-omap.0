From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 04/35] ARM: OMAP2+: hwmod: add support for specifying memalloc functionality
Date: Wed, 15 Apr 2015 15:52:51 +0300
Message-ID: <1429102402-5276-5-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35731 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755105AbbDOMwl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:41 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

hwmod currently uses memblock alloc, which only works very early in boot.
Change this by adding a runtime setup support for specifying memory alloc
functionality, this will allow hwmod init to be executed also later during
boot, when memblock allocation is no longer available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 355b089..939161e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -193,6 +193,7 @@ struct omap_hwmod_soc_ops {
 	int (*init_clkdm)(struct omap_hwmod *oh);
 	void (*update_context_lost)(struct omap_hwmod *oh);
 	int (*get_context_lost)(struct omap_hwmod *oh);
+	void * (*memalloc)(int size);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -2738,7 +2739,8 @@ static int __init _alloc_links(struct omap_hwmod_link **ml,
 	sz = sizeof(struct omap_hwmod_link) * LINKS_PER_OCP_IF;
 
 	*sl = NULL;
-	*ml = memblock_virt_alloc(sz, 0);
+
+	*ml = soc_ops.memalloc(sz);
 
 	*sl = (void *)(*ml) + sizeof(struct omap_hwmod_link);
 
@@ -2855,7 +2857,7 @@ static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
 	pr_debug("omap_hwmod: %s: allocating %d byte linkspace (%d links)\n",
 		 __func__, sz, max_ls);
 
-	linkspace = memblock_virt_alloc(sz, 0);
+	linkspace = soc_ops.memalloc(sz);
 
 	return 0;
 }
@@ -3208,6 +3210,11 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 	return ret;
 }
 
+static void __init *memblock_alloc(int size)
+{
+	return memblock_virt_alloc(size, 0);
+}
+
 /**
  * omap_hwmod_register_links - register an array of hwmod links
  * @ois: pointer to an array of omap_hwmod_ocp_if to register
@@ -3928,6 +3935,8 @@ void __init omap_hwmod_init(void)
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
 
+	soc_ops.memalloc = memblock_alloc;
+
 	inited = true;
 }
 
-- 
1.7.9.5

