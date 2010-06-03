From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 35/40] DSPBRIDGE: err code replace DSP_ECHANGEDURINGENUM with EIDRM
Date: Thu,  3 Jun 2010 00:47:48 -0500
Message-ID: <1275544073-20418-36-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39727 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932576Ab0FCF4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:23 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_ECHANGEDURINGENUM with EIDRM

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/mgr.h |    2 +-
 drivers/dsp/bridge/rmgr/dbdcd.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index 378afe4..942797d 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -104,7 +104,7 @@ extern dsp_status mgr_destroy(struct mgr_object *hmgr_obj);
  *      0:            Success.
  *      -EINVAL:    Parameter node_id is > than the number of nodes.
  *                          configutred in the system
- *      DSP_ECHANGEDURINGENUM:  During Enumeration there has been a change in
+ *      -EIDRM:  During Enumeration there has been a change in
  *                              the number of nodes configured or in the
  *                              the properties of the enumerated nodes.
  *      -EPERM:          Failed to querry the Node Data Base
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index c9dba67..d5b0bce 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -217,7 +217,7 @@ dsp_status dcd_enumerate_object(IN s32 cIndex, IN enum dsp_dcdobjtype obj_type,
 		 * than zero, then the current enum_refs must have been
 		 * incremented to greater than zero.
 		 */
-		status = DSP_ECHANGEDURINGENUM;
+		status = -EIDRM;
 	} else {
 		/*
 		 * Pre-determine final key length. It's length of DCD_REGKEY +
-- 
1.7.1

