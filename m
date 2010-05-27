From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 1/7] DSPBRIDGE: enhance dmm_map_object
Date: Thu, 27 May 2010 19:02:08 +0300
Message-ID: <1274976134-22769-2-git-send-email-ohad@wizery.com>
References: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38997 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab0E0QCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 12:02:30 -0400
Received: by fxm7 with SMTP id 7so35401fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 09:02:28 -0700 (PDT)
In-Reply-To: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Enhance dmm_map_object to support additional mapping
and page information. This will be used to keep
track of mapping resources needed later to invoke
DMA transfers to/from the DSP.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 arch/arm/plat-omap/include/dspbridge/drv.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 7de3323..b1312aa 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -88,6 +88,10 @@ struct node_res_object {
 struct dmm_map_object {
 	struct list_head link;
 	u32 dsp_addr;
+	u32 mpu_addr;
+	u32 size;
+	u32 num_usr_pgs;
+	struct page **pages;
 };
 
 /* Used for DMM reserved memory accounting */
-- 
1.7.0.4

