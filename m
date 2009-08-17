From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 07/20] OMAP: McBSP: Rename thres sysfs symbols
Date: Mon, 17 Aug 2009 14:51:06 +0300
Message-ID: <1250509879-6703-8-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23315 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757925AbZHQMF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:28 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch renames the symbols that handles threshold
sysfs properties. This way we can add more sysfs properties
to them.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0bbc912..ccaa9ae 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1077,24 +1077,24 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
-static const struct attribute *threshold_attrs[] = {
+static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
 	NULL,
 };
 
-static const struct attribute_group threshold_attr_group = {
-	.attrs = (struct attribute **)threshold_attrs,
+static const struct attribute_group additional_attr_group = {
+	.attrs = (struct attribute **)additional_attrs,
 };
 
-static inline int __devinit omap_thres_add(struct device *dev)
+static inline int __devinit omap_additional_add(struct device *dev)
 {
-	return sysfs_create_group(&dev->kobj, &threshold_attr_group);
+	return sysfs_create_group(&dev->kobj, &additional_attr_group);
 }
 
-static inline void __devexit omap_thres_remove(struct device *dev)
+static inline void __devexit omap_additional_remove(struct device *dev)
 {
-	sysfs_remove_group(&dev->kobj, &threshold_attr_group);
+	sysfs_remove_group(&dev->kobj, &additional_attr_group);
 }
 
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
@@ -1102,9 +1102,9 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 	if (cpu_is_omap34xx()) {
 		mcbsp->max_tx_thres = max_thres(mcbsp);
 		mcbsp->max_rx_thres = max_thres(mcbsp);
-		if (omap_thres_add(mcbsp->dev))
+		if (omap_additional_add(mcbsp->dev))
 			dev_warn(mcbsp->dev,
-				"Unable to create threshold controls\n");
+				"Unable to create additional controls\n");
 	} else {
 		mcbsp->max_tx_thres = -EINVAL;
 		mcbsp->max_rx_thres = -EINVAL;
@@ -1114,7 +1114,7 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 {
 	if (cpu_is_omap34xx())
-		omap_thres_remove(mcbsp->dev);
+		omap_additional_remove(mcbsp->dev);
 }
 #else
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
-- 
1.6.2.GIT

