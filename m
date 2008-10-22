From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RESEND] [PATCH 2/3] [OMAPZOOM] OMAP3ISP: Fix Random System freeze
 on still capture
Date: Wed, 22 Oct 2008 16:55:52 -0500
Message-ID: <A24693684029E5489D1D202277BE894412705B0D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49293 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbYJVV4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 17:56:03 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9MLtvmc017316
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:56:02 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9MLtv2T022090
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:55:57 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Pallavi Kulkarni <p-kulkarni@ti.com>

OMAP3ISP: Fix Random System freeze on still capture

This patch adds checks for busy state of the ISP backend
Submodules before proceeding with isp stopping sequence.

Signed-off-by: Pallavi Kulkarni <p-kulkarni@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c
+++ omapkernel/drivers/media/video/isp/isp.c
@@ -1258,7 +1258,19 @@ void isp_stop()
 	ispccdc_enable_lsc(0);
 	ispccdc_enable(0);
 	isppreview_enable(0);
+	while (isppreview_busy() && (timeout < 100)) {
+		timeout++;
+		mdelay(10);
+	}
+
+	timeout = 0;
 	ispresizer_enable(0);
+	while (ispresizer_busy() && (timeout < 100)) {
+		timeout++;
+		mdelay(10);
+	}
+
+	timeout = 0;
 	isp_save_ctx();
 	omap_writel(omap_readl(ISP_SYSCONFIG) |
 		ISP_SYSCONFIG_SOFTRESET, ISP_SYSCONFIG);

