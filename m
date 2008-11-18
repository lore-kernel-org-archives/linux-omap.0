From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH][OMAPZOOM] OMAP: CAM: ISP: Check for CCDC busy on isp_stop
Date: Tue, 18 Nov 2008 15:15:42 -0600
Message-ID: <A24693684029E5489D1D202277BE89441522FE2D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49524 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbYKRVPt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 16:15:49 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAILFicT004571
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:15:49 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAILFhED017761
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:15:43 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: Check for CCDC busy on isp_stop

Wait also for CCDC pending operations (Like saving RAW frame to
memory)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: git-ti-omap34tree/drivers/media/video/isp/isp.c
===================================================================
--- git-ti-omap34tree.orig/drivers/media/video/isp/isp.c
+++ git-ti-omap34tree/drivers/media/video/isp/isp.c
@@ -1257,6 +1257,12 @@ void isp_stop()
 	omapisp_unset_callback();
 	ispccdc_enable_lsc(0);
 	ispccdc_enable(0);
+	while (ispccdc_busy() && (timeout < 100)) {
+		timeout++;
+		mdelay(10);
+	}
+
+	timeout = 0;
 	isppreview_enable(0);
 	while (isppreview_busy() && (timeout < 100)) {
 		timeout++;
