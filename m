From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 1/3] ISP: Remove hardcoding of CCDC input offset.
Date: Thu, 26 Feb 2009 16:39:45 -0600
Message-ID: <200902261639.45623.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44270 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbZBZWjw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:39:52 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1QMdkiT005978
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:39:51 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n1QMdjr3021564
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:39:45 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 1/3] ISP: Remove hardcoding of CCDC input offset.

The Sony IMX046 patch set introduced a bug when setting CCDC input offsets.
The Sony patch set the horz & vert offsets to 0.
This worked from the Sony IMX046, but broke settings for other sensors like 
MT9P012 & OV3640.
The reason is that all three sensors send their data with different component 
orders.

The effect was to mess up colours in previewer module for MT9P012 & OV3640.
This patch reverts that bug.

The other patches in this set will provide a better way of setting these offsets, 
thus allowing easy setup for any type kind of incoming componenet order.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 drivers/media/video/isp/ispccdc.c |    2 --
 1 file changed, 2 deletions(-)

Index: omapzoom04/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/ispccdc.c
+++ omapzoom04/drivers/media/video/isp/ispccdc.c
@@ -1265,8 +1265,6 @@ int ispccdc_config_size(u32 input_w, u32
 	}
 
 	if (ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_VP) {
-		ispccdc_obj.ccdcin_woffset = 0;
-		ispccdc_obj.ccdcin_hoffset = 0;
 		omap_writel((ispccdc_obj.ccdcin_woffset <<
 					ISPCCDC_FMT_HORZ_FMTSPH_SHIFT) |
 					(ispccdc_obj.ccdcin_w <<
