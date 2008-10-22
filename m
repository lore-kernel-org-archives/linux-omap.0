From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 1/3] [OMAPZOOM] OMAP3ISP: Remove 10 ms delay in ccdc enable
Date: Wed, 22 Oct 2008 16:48:32 -0500
Message-ID: <A24693684029E5489D1D202277BE894412705AF1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198AbYJVVsk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 17:48:40 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9MLmYv1007764
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:48:39 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9MLmY5N017122
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:48:34 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP3ISP: Remove 10 ms delay in ccdc enable

This patch removes a 10ms delay which was being invoked at VD0
interrupt time, making the CCDC be re-enabled AFTER VSync, which
caused 5MP frames to be lost in the pipeline.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/ispccdc.c |    1 -
 1 file changed, 1 deletion(-)

Index: omapkernel/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispccdc.c
+++ omapkernel/drivers/media/video/isp/ispccdc.c
@@ -1438,7 +1438,6 @@ void ispccdc_enable(u8 enable)
 			((ispccdc_obj.ccdc_inpfmt == CCDC_RAW) ||
 			(ispccdc_obj.ccdc_inpfmt == CCDC_RAW_PATTERN)))
 			ispccdc_enable_lsc(1);
-			mdelay(10);
 			omap_writel(omap_readl(ISPCCDC_PCR) | (ISPCCDC_PCR_EN),
 								ISPCCDC_PCR);
 	} else {

