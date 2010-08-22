From: kishon <a0393678@ti.com>
Subject: [RFC/PATCH] Fix to support multiple HWMODS for a single device
Date: Sun, 22 Aug 2010 15:20:53 +0530
Message-ID: <4C70F2FD.1080208@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070309020507000003050900"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49894 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046Ab0HVJvD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Aug 2010 05:51:03 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7M9owUe018953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 22 Aug 2010 04:51:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, Nishant Kamat <nskamat@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

This is a multi-part message in MIME format.
--------------070309020507000003050900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070309020507000003050900
Content-Type: text/x-patch;
 name="0001-RFC-PATCH-Fix-to-support-multiple-HWMODS-for-a-singl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-RFC-PATCH-Fix-to-support-multiple-HWMODS-for-a-singl.pa";
 filename*1="tch"

>From 24ffaa67c44065a9caa3ee3525dd863d32c67269 Mon Sep 17 00:00:00 2001
From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Sun, 22 Aug 2010 15:06:42 +0530
Subject: [RFC/PATCH] Fix to support multiple HWMODS for a single device

The current code expects multiple HWMODS to be filled in consecutive
memory location before passing to omap_device_build_ss(). Ignoring this
will result in incorrect data being populated in omap_hwmod_fill_resources().
This means before calling omap_device_build_ss() the user has to create memory
chunks, copy all the HWMOD structures to it taking care of the mutex
variable as well.

This fix does some pointer calculations to the existing function
omap_device_fill_resources() in order to fill the resources properly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/omap_device.c

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
old mode 100644
new mode 100755
index d2b1609..8013292
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -289,12 +289,12 @@ int omap_device_count_resources(struct omap_device *od)
  */
 int omap_device_fill_resources(struct omap_device *od, struct resource *res)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int c = 0;
 	int i, r;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++) {
-		r = omap_hwmod_fill_resources(oh, res);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++) {
+		r = omap_hwmod_fill_resources(*oh, res);
 		res += r;
 		c += r;
 	}
@@ -694,7 +694,6 @@ int omap_device_enable_hwmods(struct omap_device *od)
 {
 	struct omap_hwmod *oh;
 	int i;
-
 	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
 		omap_hwmod_enable(oh);
 
-- 
1.7.0.4


--------------070309020507000003050900--
