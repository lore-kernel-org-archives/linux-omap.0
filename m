From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 05/40] DSPBRIDGE: err code replace CHNL_E_BUFSIZE with EINVAL
Date: Thu,  3 Jun 2010 00:47:18 -0500
Message-ID: <1275544073-20418-6-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44865 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab0FCF4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:16 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_BUFSIZE with EINVAL

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/chnl_sm.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 6dcea60..3d53881 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -457,7 +457,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *                      I/O is allowed.
  *      CHNL_E_EOS:     End of stream was already marked on a previous
  *                      IORequest on this channel.  No further I/O is expected.
- *      CHNL_E_BUFSIZE: Buffer submitted to this output channel is larger than
+ *      -EINVAL: Buffer submitted to this output channel is larger than
  *                      the size of the physical shared memory output window.
  *  Requires:
  *  Ensures:
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 99a4a42..3cebf94 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -176,7 +176,7 @@ func_cont:
 			/* Check buffer size on output channels for fit. */
 			if (byte_size >
 			    io_buf_size(pchnl->chnl_mgr_obj->hio_mgr))
-				status = CHNL_E_BUFSIZE;
+				status = -EINVAL;
 
 		}
 	}
-- 
1.7.1

