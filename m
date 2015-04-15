From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 06/35] of/platform: export a couple of platform device init APIs
Date: Wed, 15 Apr 2015 15:52:53 +0300
Message-ID: <1429102402-5276-7-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42501 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbbDOMwo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:44 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Some custom platform bus registration code needs access to couple of
of/platform APIs, thus make these available outside of/platform.
The APIs exported in this patch are required by OMAP hwmod data module
support, which basically splits the platform bus registration to be done
in two phases; an early init containing only a small subset of the bus,
and a late init which adds everything else.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/of/platform.c       |    6 +++---
 include/linux/of_platform.h |    9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b189733..e933cf7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -218,7 +218,7 @@ static void of_dma_deconfigure(struct device *dev)
  * Returns pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
-static struct platform_device *of_platform_device_create_pdata(
+struct platform_device *of_platform_device_create_pdata(
 					struct device_node *np,
 					const char *bus_id,
 					void *platform_data,
@@ -345,8 +345,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 /**
  * of_devname_lookup() - Given a device node, lookup the preferred Linux name
  */
-static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *lookup,
-				 struct device_node *np)
+const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *lookup,
+					   struct device_node *np)
 {
 	struct resource res;
 
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 611a691..8af1e42 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -63,10 +63,19 @@ extern struct platform_device *of_find_device_by_node(struct device_node *np);
 extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent);
+extern struct platform_device *of_platform_device_create_pdata(
+						struct device_node *np,
+						const char *bus_id,
+						void *platform_data,
+						struct device *parent);
 
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
+
+extern const struct of_dev_auxdata *of_dev_lookup(
+					const struct of_dev_auxdata *lookup,
+					struct device_node *np);
 #ifdef CONFIG_OF_ADDRESS
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
-- 
1.7.9.5

