From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH] OMAP3ISP: Fix lsc_initialized flag setting
Date: Fri, 16 Jan 2009 16:51:03 -0600
Message-ID: <A24693684029E5489D1D202277BE8944165DC5D0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47355 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221AbZAPWvK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 17:51:10 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0GMp48L002912
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 16:51:09 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0GMp4d1003823
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 16:51:04 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 551a60b7f66bdf314702062214345464679e6481 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Fri, 16 Jan 2009 16:17:07 -0600
Subject: [PATCH] OMAP3ISP: Fix lsc_initialized flag setting

This patch fixes an incorrect clearing of the lsc_initialized
flag, so when loading an equal or lower size LSC table from abstraction
layer, the flag doesn't get cleared anymore.

The leakage comes because on ispccdc_cleanup(), the unmmap was
conditioned when lsc_initialized was set to 1.

Based on Fix by Margarita Olaya on Internal TI tree.

Signed-off-by: Margarita Olaya <magi.olaya@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/ispccdc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/isp/ispccdc.c b/drivers/media/video/isp/ispccdc.c
index 75a4a06..fab4f72 100644
--- a/drivers/media/video/isp/ispccdc.c
+++ b/drivers/media/video/isp/ispccdc.c
@@ -270,11 +270,12 @@ int omap34xx_isp_ccdc_config(void *userspace_add)
 						ispccdc_lsc_config)))
 					goto copy_from_user_err;
 				down(&ispccdc_mutex);
-				lsc_initialized = 0;
 				if (lsc_config.size <= old_size)
 					size_mismatch = 0;
-				else
+				else {
 					size_mismatch = 1;
+					lsc_initialized = 0;
+				}
 				up(&ispccdc_mutex);
 				ispccdc_config_lsc(&lsc_config);
 			}
-- 
1.5.6.5

