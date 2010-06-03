From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 09/40] DSPBRIDGE: err code replace CHNL_E_NOMEMMAP with EFAULT
Date: Thu,  3 Jun 2010 00:47:22 -0500
Message-ID: <1275544073-20418-10-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39716 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405Ab0FCF4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:17 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Replace CHNL_E_NOMEMMAP with EFAULT

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |    2 +-
 drivers/dsp/bridge/core/io_sm.c                |   22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index f56fdca..6a2bba5 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -310,7 +310,7 @@ typedef dsp_status(*fxn_brd_write) (struct bridge_dev_context *hDevContext,
  *      0:            Success;
  *      -ENOMEM:        Insufficient memory for requested resources.
  *      -EIO:         Unable to plug ISR for given IRQ.
- *      CHNL_E_NOMEMMAP:    Couldn't map physical address to a virtual one.
+ *      -EFAULT:    Couldn't map physical address to a virtual one.
  *  Requires:
  *      phChnlMgr != NULL.
  *      pMgrAttrs != NULL
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 5902d8a..79baa2c 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -353,13 +353,13 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	status = cod_get_sym_value(cod_man, CHNL_SHARED_BUFFER_BASE_SYM,
 				   &ul_shm_base);
 	if (DSP_FAILED(status)) {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 		goto func_end;
 	}
 	status = cod_get_sym_value(cod_man, CHNL_SHARED_BUFFER_LIMIT_SYM,
 				   &ul_shm_limit);
 	if (DSP_FAILED(status)) {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 		goto func_end;
 	}
 	if (ul_shm_limit <= ul_shm_base) {
@@ -398,10 +398,10 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 				ul_mem_length = ul_shm_length + ul_msg_length;
 			}
 		} else {
-			status = CHNL_E_NOMEMMAP;
+			status = -EFAULT;
 		}
 	} else {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 	}
 	if (DSP_SUCCEEDED(status)) {
 #ifndef DSP_TRACEBUF_DISABLED
@@ -412,18 +412,18 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 					   &shm0_end);
 #endif
 		if (DSP_FAILED(status))
-			status = CHNL_E_NOMEMMAP;
+			status = -EFAULT;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		status =
 		    cod_get_sym_value(cod_man, DYNEXTBASE, &ul_dyn_ext_base);
 		if (DSP_FAILED(status))
-			status = CHNL_E_NOMEMMAP;
+			status = -EFAULT;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		status = cod_get_sym_value(cod_man, EXTEND, &ul_ext_end);
 		if (DSP_FAILED(status))
-			status = CHNL_E_NOMEMMAP;
+			status = -EFAULT;
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Get memory reserved in host resources */
@@ -680,7 +680,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	 * num_procs = 1.
 	 */
 	if (!hio_mgr->ext_proc_info.ty_tlb[0].ul_gpp_phys || num_procs != 1) {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 		goto func_end;
 	} else {
 		if (ae_proc[0].ul_dsp_va > ul_shm_base) {
@@ -751,7 +751,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	status = cod_get_sym_value(cod_man, SYS_PUTCBEG,
 				   &hio_mgr->ul_trace_buffer_begin);
 	if (DSP_FAILED(status)) {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 		goto func_end;
 	}
 
@@ -762,7 +762,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	status = cod_get_sym_value(cod_man, SYS_PUTCEND,
 				   &hio_mgr->ul_trace_buffer_end);
 	if (DSP_FAILED(status)) {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 		goto func_end;
 	}
 	hio_mgr->ul_trace_buffer_end =
@@ -772,7 +772,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	status = cod_get_sym_value(cod_man, BRIDGE_SYS_PUTC_CURRENT,
 				   &hio_mgr->ul_trace_buffer_current);
 	if (DSP_FAILED(status)) {
-		status = CHNL_E_NOMEMMAP;
+		status = -EFAULT;
 		goto func_end;
 	}
 	hio_mgr->ul_trace_buffer_current =
-- 
1.7.1

