From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 5/7] omap3: sr: device: add unlikely checks
Date: Fri, 25 Jun 2010 16:46:38 -0500
Message-ID: <1277502400-9915-6-git-send-email-nm@ti.com>
References: <1277502400-9915-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab0FYVqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 17:46:46 -0400
In-Reply-To: <1277502400-9915-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

Add unlikely checks to better optimize the rare occurrance of
erroneous conditions.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 7d13704..177299a 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -43,8 +43,9 @@ static void __init sr_read_efuse(struct omap_sr_dev_data *dev_data,
 {
 	int i;
 
-	if (!dev_data || !dev_data->volts_supported || !dev_data->volt_data ||
-			!dev_data->efuse_nvalues_offs) {
+	if (unlikely(!dev_data || !dev_data->volts_supported ||
+			!dev_data->volt_data ||
+			!dev_data->efuse_nvalues_offs)) {
 		pr_warning("%s: Bad parameters! dev_data = %x,"
 			"dev_data->volts_supported = %x,"
 			"dev_data->volt_data = %x,"
@@ -87,8 +88,8 @@ static void __init sr_set_testing_nvalues(struct omap_sr_dev_data *dev_data,
 {
 	int i;
 
-	if (!dev_data || !dev_data->volts_supported ||
-			!dev_data->volt_data || !dev_data->test_nvalues) {
+	if (unlikely(!dev_data || !dev_data->volts_supported ||
+			!dev_data->volt_data || !dev_data->test_nvalues)) {
 		pr_warning("%s: Bad parameters! dev_data = %x,"
 			"dev_data->volts_supported = %x,"
 			"dev_data->volt_data = %x,"
@@ -123,7 +124,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	static int i;
 
 	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
-	if (!sr_data) {
+	if (unlikely(!sr_data)) {
 		pr_err("%s: Unable to allocate memory for %s sr_data.Error!\n",
 			__func__, oh->name);
 		return -ENOMEM;
@@ -150,7 +151,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	sr_data->device_idle = omap_device_idle;
 	sr_dev_data->volts_supported = omap_get_voltage_table(i,
 				&sr_dev_data->volt_data);
-	if (!sr_dev_data->volts_supported) {
+	if (unlikely(!sr_dev_data->volts_supported)) {
 		pr_warning("%s: No Voltage table registerd fo VDD%d. "
 				"Something is really wrong\n",
 				__func__, i + 1);
@@ -162,7 +163,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
 			       omap_sr_latency,
 			       ARRAY_SIZE(omap_sr_latency), 0);
-	if (IS_ERR(od)) {
+	if (unlikely(IS_ERR(od))) {
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
 		kfree(sr_data);
-- 
1.6.3.3

