From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 20/35] ARM: OMAP2+: omap_device: remove omap_device_build from __init section
Date: Wed, 15 Apr 2015 15:53:07 +0300
Message-ID: <1429102402-5276-21-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52090 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438AbbDOMxF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:05 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Some devices are built late in boot with the introduction of hwmod
data modules, and the omap_device_build() function is required later
in boot also. Thus, remove it from the __init section.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index be9541e..52fcaad 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -507,10 +507,10 @@ void omap_device_delete(struct omap_device *od)
  * information.  Returns ERR_PTR(-EINVAL) if @oh is NULL; otherwise,
  * passes along the return value of omap_device_build_ss().
  */
-struct platform_device __init *omap_device_build(const char *pdev_name,
-						 int pdev_id,
-						 struct omap_hwmod *oh,
-						 void *pdata, int pdata_len)
+struct platform_device *omap_device_build(const char *pdev_name,
+					  int pdev_id,
+					  struct omap_hwmod *oh,
+					  void *pdata, int pdata_len)
 {
 	struct omap_hwmod *ohs[] = { oh };
 
@@ -535,11 +535,11 @@ struct platform_device __init *omap_device_build(const char *pdev_name,
  * platform_device record.  Returns an ERR_PTR() on error, or passes
  * along the return value of omap_device_register().
  */
-struct platform_device __init *omap_device_build_ss(const char *pdev_name,
-						    int pdev_id,
-						    struct omap_hwmod **ohs,
-						    int oh_cnt, void *pdata,
-						    int pdata_len)
+struct platform_device *omap_device_build_ss(const char *pdev_name,
+					     int pdev_id,
+					     struct omap_hwmod **ohs,
+					     int oh_cnt, void *pdata,
+					     int pdata_len)
 {
 	int ret = -ENOMEM;
 	struct platform_device *pdev;
-- 
1.7.9.5

