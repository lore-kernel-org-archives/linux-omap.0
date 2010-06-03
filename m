From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 23/40] DSPBRIDGE: err code replace DSP_EOVERLAYMEMORY with ENXIO
Date: Thu,  3 Jun 2010 00:47:36 -0500
Message-ID: <1275544073-20418-24-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56437 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab0FCF4U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:20 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace DSP_EOVERLAYMEMORY with ENXIO

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/rmm.h      |    2 +-
 drivers/dsp/bridge/rmgr/rmm.c                   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index b93671b..e5108b4 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -247,7 +247,7 @@ typedef bool(*nldr_initfxn) (void);
  *  Returns:
  *      0:                Success.
  *      -ENOMEM:            Insufficient memory on GPP.
- *      DSP_EOVERLAYMEMORY:     Can't overlay phase because overlay memory
+ *      -ENXIO:     Can't overlay phase because overlay memory
  *                              is already in use.
  *      -EILSEQ:           Failure in dynamic loader library.
  *      DSP_EFWRITE:            Failed to write phase's code or date to target.
diff --git a/arch/arm/plat-omap/include/dspbridge/rmm.h b/arch/arm/plat-omap/include/dspbridge/rmm.h
index 42da289..8958a50 100644
--- a/arch/arm/plat-omap/include/dspbridge/rmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/rmm.h
@@ -63,7 +63,7 @@ struct rmm_target_obj;
  *  Returns:
  *      0:                Success.
  *      -ENOMEM:            Memory allocation on GPP failed.
- *      DSP_EOVERLAYMEMORY:     Cannot "allocate" overlay memory because it's
+ *      -ENXIO:     Cannot "allocate" overlay memory because it's
  *                              already in use.
  *  Requires:
  *      RMM initialized.
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 64d8c56..efefb65 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -130,7 +130,7 @@ dsp_status rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 							   (prev_sect->addr +
 							    prev_sect->size >
 							    addr))) {
-				status = DSP_EOVERLAYMEMORY;
+				status = -ENXIO;
 			}
 			break;
 		}
-- 
1.7.1

