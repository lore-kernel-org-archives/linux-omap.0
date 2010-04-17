From: "Uribe de Leon, Armando" <x0095078@ti.com>
Subject: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding braces
Date: Fri, 16 Apr 2010 21:10:15 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90EC2622733@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46023 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758054Ab0DQCKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 22:10:20 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 451e9733672b7fd3879ec109f3c6b2ac55c21cf5 Mon Sep 17 00:00:00 2001
From: Armando Uribe De Leon <x0095078@ti.com>
Date: Thu, 8 Apr 2010 17:14:38 -0500
Subject: [PATCH 1/5] DSPBRIDGE: Remove checkpatch errors regarding braces

This patch removes checkpatch errors due to misleading braces

Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |    8 ++++----
 drivers/dsp/bridge/dynload/cload.c         |    4 ++--
 drivers/dsp/bridge/pmgr/cmm.c              |    5 ++---
 drivers/dsp/bridge/pmgr/dbll.c             |    3 +--
 drivers/dsp/bridge/wmd/io_sm.c             |    3 +--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |    6 ++----
 6 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 087f69f..effba29 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -172,10 +172,10 @@ extern void mem_free_phys_mem(void *pVirtualAddress,
  *      A subsequent call to MEM_IS_VALID_HANDLE() will fail for this object.
  */
 #define MEM_FREE_OBJECT(pObj)    \
-{                               \
-    pObj->dw_signature = 0x00;   \
-    kfree(pObj);                \
-}
+do {                               \
+	pObj->dw_signature = 0x00;   \
+	kfree(pObj);                \
+} while (0)
 
 /*
  *  ======== mem_get_num_pages ======== diff --git a/drivers/dsp/bridge/dynload/cload.c b/drivers/dsp/bridge/dynload/cload.c
index d0de525..7f3c3bd 100644
--- a/drivers/dsp/bridge/dynload/cload.c
+++ b/drivers/dsp/bridge/dynload/cload.c
@@ -48,8 +48,8 @@ static const char loader_dllview_root[] = { "?DLModules?" };
  */
 static const char readstrm[] = { "Error reading %s from input stream" };  static const char err_alloc[] = { "Syms->dload_allocate( %d ) failed" }; -static const char tgtalloc[] =
-    { "Target memory allocate failed, section %s size " FMT_UI32 };
+static const char tgtalloc[] = {
+	"Target memory allocate failed, section %s size " FMT_UI32 };
 static const char initfail[] = { "%s to target address " FMT_UI32 " failed" };  static const char dlvwrite[] = { "Write to DLLview list failed" };  static const char iconnect[] = { "Connect call to init interface failed" }; diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c index 7523361..8c770da 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -1010,11 +1010,10 @@ dsp_status cmm_xlator_delete(struct cmm_xlatorobject *xlator, bool bForce)
 
 	DBC_REQUIRE(refs > 0);
 
-	if (MEM_IS_VALID_HANDLE(xlator_obj, CMMXLATESIGNATURE)) {
+	if (MEM_IS_VALID_HANDLE(xlator_obj, CMMXLATESIGNATURE))
 		MEM_FREE_OBJECT(xlator_obj);
-	} else {
+	else
 		status = DSP_EHANDLE;
-	}
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c index 0e7c4a4..c983d6d 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -848,9 +848,8 @@ void dbll_unload(struct dbll_library_obj *lib, struct dbll_attrs *attrs)
 					    &zl_lib->symbol.dl_symbol,
 					    &zl_lib->allocate.dl_alloc,
 					    &zl_lib->init.dl_init);
-		if (err != 0) {
+		if (err != 0)
 			dev_dbg(bridge, "%s: failed: 0x%x\n", __func__, err);
-		}
 	}
 	/* remove symbols from symbol table */
 	if (zl_lib->sym_tab != NULL) {
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c index 1b5d977..0517f1a 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -578,9 +578,8 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 					ae_proc[ndx].ul_gpp_va,
 					ae_proc[ndx].ul_dsp_va *
 					hio_mgr->word_size, page_size[i]);
-				if (DSP_FAILED(status)) {
+				if (DSP_FAILED(status))
 					goto func_end;
-				}
 			}
 			pa_curr += page_size[i];
 			va_curr += page_size[i];
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 0b5d2f2..938d86d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -228,9 +228,8 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
 
 		/* Turn off DSP Peripheral clocks */
 		status = dsp_peripheral_clocks_disable(dev_context, NULL);
-		if (DSP_FAILED(status)) {
+		if (DSP_FAILED(status))
 			return status;
-		}
 #ifdef CONFIG_BRIDGE_DVFS
 		else if (target_pwr_state == PWRDM_POWER_OFF) {
 			struct dspbridge_platform_data *pdata = @@ -357,9 +356,8 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 			__raw_writel(value, resources.dw_sys_ctrl_base + 0x274);
 		}
 		dsp_clk_wakeup_event_ctrl(bpwr_clks[clk_id_index].clk_id, true);
-		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
+		if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1)))
 			(dev_context->dsp_per_clks) |= (1 << clk_id_index);
-		}
 		break;
 	default:
 		dev_dbg(bridge, "%s: Unsupported CMD\n", __func__);
--
1.6.0.4

