From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 05/11] DSPBRIDGE: Replace code containing "WMD"
Date: Fri, 30 Apr 2010 19:45:45 -0500
Message-ID: <1272674751-21557-6-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35605 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757740Ab0EAAwz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Apr 2010 20:52:55 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

This patch removes references to Windows OS, and since "WMD" means
windows mini driver, then it is replaced by "BRD" which means Bridge.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h  |   12 +++---
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/wmdioctl.h |   38 +++++++++++-----------
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    6 ++--
 drivers/dsp/bridge/rmgr/pwr.c                   |   10 +++---
 drivers/dsp/bridge/wmd/_tiomap.h                |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |   14 ++++----
 drivers/dsp/bridge/wmd/tiomap3430.c             |   32 +++++++++---------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |    4 +-
 10 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index d43ff86..ff0c2de 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -268,10 +268,10 @@
 #define DEV_EBASE                   (DSP_COMP_EBASE + 0x000)
 
 /* The mini-driver expected a newer version of the class driver. */
-#define DEV_E_NEWWMD                (DEV_EBASE + 0x00)
+#define DEV_E_NEWBRD                (DEV_EBASE + 0x00)
 
 /* bridge_drv_entry function returned a NULL function interface table. */
-#define DEV_E_NULLWMDINTF           (DEV_EBASE + 0x01)
+#define DEV_E_NULLBRDINTF           (DEV_EBASE + 0x01)
 
 /* FAILURE Codes : LDR */
 #define LDR_EBASE                   (DSP_COMP_EBASE + 0x100)
@@ -417,16 +417,16 @@
 #define SYNC_E_TIMEOUT              (SYNC_EBASE + 0x01)
 
 /* FAILURE Codes : WMD */
-#define WMD_EBASE                   (DSP_COMP_EBASE + 0x700)
+#define BRD_EBASE                   (DSP_COMP_EBASE + 0x700)
 
 /* A test of hardware assumptions or integrity failed. */
-#define WMD_E_HARDWARE              (WMD_EBASE + 0x00)
+#define BRD_E_HARDWARE              (BRD_EBASE + 0x00)
 
 /* One or more configuration parameters violated WMD hardware assumptions. */
-#define WMD_E_BADCONFIG             (WMD_EBASE + 0x01)
+#define BRD_E_BADCONFIG             (BRD_EBASE + 0x01)
 
 /* Timeout occurred waiting for a response from the hardware. */
-#define WMD_E_TIMEOUT               (WMD_EBASE + 0x02)
+#define BRD_E_TIMEOUT               (BRD_EBASE + 0x02)
 
 /* FAILURE Codes : REG */
 #define REG_EBASE                   (DSP_COMP_EBASE + 0x800)
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 4355590..cebc8c5 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -41,7 +41,7 @@
  *  Any IOCTLS at or above this value are reserved for standard WMD
  *  interfaces.
  */
-#define WMD_RESERVEDIOCTLBASE   0x8000
+#define BRD_RESERVEDIOCTLBASE   0x8000
 
 /* Handle to mini-driver's private device context. */
 struct bridge_dev_context;
diff --git a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
index ba921bc..9fe5543 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmdioctl.h
@@ -27,37 +27,37 @@
  * Any IOCTLS at or above this value are reserved for standard WMD
  * interfaces.
  */
-#define WMDIOCTL_RESERVEDBASE       0x8000
+#define BRDIOCTL_RESERVEDBASE       0x8000
 
-#define WMDIOCTL_CHNLREAD           (WMDIOCTL_RESERVEDBASE + 0x10)
-#define WMDIOCTL_CHNLWRITE          (WMDIOCTL_RESERVEDBASE + 0x20)
-#define WMDIOCTL_GETINTRCOUNT       (WMDIOCTL_RESERVEDBASE + 0x30)
-#define WMDIOCTL_RESETINTRCOUNT     (WMDIOCTL_RESERVEDBASE + 0x40)
-#define WMDIOCTL_INTERRUPTDSP       (WMDIOCTL_RESERVEDBASE + 0x50)
+#define BRDIOCTL_CHNLREAD           (BRDIOCTL_RESERVEDBASE + 0x10)
+#define BRDIOCTL_CHNLWRITE          (BRDIOCTL_RESERVEDBASE + 0x20)
+#define BRDIOCTL_GETINTRCOUNT       (BRDIOCTL_RESERVEDBASE + 0x30)
+#define BRDIOCTL_RESETINTRCOUNT     (BRDIOCTL_RESERVEDBASE + 0x40)
+#define BRDIOCTL_INTERRUPTDSP       (BRDIOCTL_RESERVEDBASE + 0x50)
 /* DMMU */
-#define WMDIOCTL_SETMMUCONFIG       (WMDIOCTL_RESERVEDBASE + 0x60)
+#define BRDIOCTL_SETMMUCONFIG       (BRDIOCTL_RESERVEDBASE + 0x60)
 /* PWR */
-#define WMDIOCTL_PWRCONTROL         (WMDIOCTL_RESERVEDBASE + 0x70)
+#define BRDIOCTL_PWRCONTROL         (BRDIOCTL_RESERVEDBASE + 0x70)
 
 /* attention, modifiers:
  * Some of these control enumerations are made visible to user for power
  * control, so any changes to this list, should also be updated in the user
  * header file 'dbdefs.h' ***/
 /* These ioctls are reserved for PWR power commands for the DSP */
-#define WMDIOCTL_DEEPSLEEP          (WMDIOCTL_PWRCONTROL + 0x0)
-#define WMDIOCTL_EMERGENCYSLEEP     (WMDIOCTL_PWRCONTROL + 0x1)
-#define WMDIOCTL_WAKEUP             (WMDIOCTL_PWRCONTROL + 0x2)
-#define WMDIOCTL_PWRENABLE          (WMDIOCTL_PWRCONTROL + 0x3)
-#define WMDIOCTL_PWRDISABLE         (WMDIOCTL_PWRCONTROL + 0x4)
-#define WMDIOCTL_CLK_CTRL		    (WMDIOCTL_PWRCONTROL + 0x7)
+#define BRDIOCTL_DEEPSLEEP          (BRDIOCTL_PWRCONTROL + 0x0)
+#define BRDIOCTL_EMERGENCYSLEEP     (BRDIOCTL_PWRCONTROL + 0x1)
+#define BRDIOCTL_WAKEUP             (BRDIOCTL_PWRCONTROL + 0x2)
+#define BRDIOCTL_PWRENABLE          (BRDIOCTL_PWRCONTROL + 0x3)
+#define BRDIOCTL_PWRDISABLE         (BRDIOCTL_PWRCONTROL + 0x4)
+#define BRDIOCTL_CLK_CTRL		    (BRDIOCTL_PWRCONTROL + 0x7)
 /* DSP Initiated Hibernate */
-#define WMDIOCTL_PWR_HIBERNATE	(WMDIOCTL_PWRCONTROL + 0x8)
-#define WMDIOCTL_PRESCALE_NOTIFY (WMDIOCTL_PWRCONTROL + 0x9)
-#define WMDIOCTL_POSTSCALE_NOTIFY (WMDIOCTL_PWRCONTROL + 0xA)
-#define WMDIOCTL_CONSTRAINT_REQUEST (WMDIOCTL_PWRCONTROL + 0xB)
+#define BRDIOCTL_PWR_HIBERNATE	(BRDIOCTL_PWRCONTROL + 0x8)
+#define BRDIOCTL_PRESCALE_NOTIFY (BRDIOCTL_PWRCONTROL + 0x9)
+#define BRDIOCTL_POSTSCALE_NOTIFY (BRDIOCTL_PWRCONTROL + 0xA)
+#define BRDIOCTL_CONSTRAINT_REQUEST (BRDIOCTL_PWRCONTROL + 0xB)
 
 /* Number of actual DSP-MMU TLB entrries */
-#define WMDIOCTL_NUMOFMMUTLB        32
+#define BRDIOCTL_NUMOFMMUTLB        32
 
 struct bridge_ioctl_extproc {
 	u32 ul_dsp_va;		/* DSP virtual address */
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index ddf54df..be641bc 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3155,7 +3155,7 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 			pr_debug("%s: failed to copy brd memory, status 0x%x\n",
 				 __func__, status);
 	} else {
-		pr_debug("%s: failed to get WMD context, status 0x%x\n",
+		pr_debug("%s: failed to get Bridge  context, status 0x%x\n",
 			 __func__, status);
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 6e32ad6..0a95355 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -348,12 +348,12 @@ dsp_status proc_ctrl(void *hprocessor, u32 dw_cmd, IN struct dsp_cbdata * arg)
 
 	if (p_proc_object) {
 		/* intercept PWR deep sleep command */
-		if (dw_cmd == WMDIOCTL_DEEPSLEEP) {
+		if (dw_cmd == BRDIOCTL_DEEPSLEEP) {
 			timeout = arg->cb_data;
 			status = pwr_sleep_dsp(PWR_DEEPSLEEP, timeout);
 		}
 		/* intercept PWR emergency sleep command */
-		else if (dw_cmd == WMDIOCTL_EMERGENCYSLEEP) {
+		else if (dw_cmd == BRDIOCTL_EMERGENCYSLEEP) {
 			timeout = arg->cb_data;
 			status = pwr_sleep_dsp(PWR_EMERGENCYDEEPSLEEP, timeout);
 		} else if (dw_cmd == PWR_DEEPSLEEP) {
@@ -361,7 +361,7 @@ dsp_status proc_ctrl(void *hprocessor, u32 dw_cmd, IN struct dsp_cbdata * arg)
 			status = pwr_sleep_dsp(PWR_DEEPSLEEP, timeout);
 		}
 		/* intercept PWR wake commands */
-		else if (dw_cmd == WMDIOCTL_WAKEUP) {
+		else if (dw_cmd == BRDIOCTL_WAKEUP) {
 			timeout = arg->cb_data;
 			status = pwr_wake_dsp(timeout);
 		} else if (dw_cmd == PWR_WAKEUP) {
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index 51eeb65..ff8c0c3 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -60,9 +60,9 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 			continue;
 		}
 		if (sleepCode == PWR_DEEPSLEEP)
-			ioctlcode = WMDIOCTL_DEEPSLEEP;
+			ioctlcode = BRDIOCTL_DEEPSLEEP;
 		else if (sleepCode == PWR_EMERGENCYDEEPSLEEP)
-			ioctlcode = WMDIOCTL_EMERGENCYSLEEP;
+			ioctlcode = BRDIOCTL_EMERGENCYSLEEP;
 		else
 			status = DSP_EINVALIDARG;
 
@@ -100,7 +100,7 @@ dsp_status pwr_wake_dsp(IN CONST u32 timeout)
 			      (struct bridge_drv_interface **)&intf_fxns))) {
 				status =
 				    (*intf_fxns->pfn_dev_cntrl) (dw_context,
-							WMDIOCTL_WAKEUP,
+							BRDIOCTL_WAKEUP,
 							(void *)&arg);
 			}
 		}
@@ -136,7 +136,7 @@ dsp_status pwr_pm_pre_scale(IN u16 voltage_domain, u32 level)
 			      (struct bridge_drv_interface **)&intf_fxns))) {
 				status =
 				    (*intf_fxns->pfn_dev_cntrl) (dw_context,
-						WMDIOCTL_PRESCALE_NOTIFY,
+						BRDIOCTL_PRESCALE_NOTIFY,
 						(void *)&arg);
 			}
 		}
@@ -172,7 +172,7 @@ dsp_status pwr_pm_post_scale(IN u16 voltage_domain, u32 level)
 			      (struct bridge_drv_interface **)&intf_fxns))) {
 				status =
 				    (*intf_fxns->pfn_dev_cntrl) (dw_context,
-						WMDIOCTL_POSTSCALE_NOTIFY,
+						BRDIOCTL_POSTSCALE_NOTIFY,
 						(void *)&arg);
 			}
 		}
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index b670b02..b539641 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -337,7 +337,7 @@ struct bridge_dev_context {
 	 * [See WMD_BRD_Ctrl()]  PROC info contains DSP-MMU TLB entries.
 	 */
 	/* DMMU TLB entries */
-	struct bridge_ioctl_extproc atlb_entry[WMDIOCTL_NUMOFMMUTLB];
+	struct bridge_ioctl_extproc atlb_entry[BRDIOCTL_NUMOFMMUTLB];
 	u32 dw_brd_state;	/* Last known board state. */
 	u32 ul_int_mask;	/* int mask */
 	u16 io_base;		/* Board I/O base */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 62624ad..e917c51 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -322,7 +322,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	u32 num_procs = 0;
 	s32 ndx = 0;
 	/* DSP MMU setup table */
-	struct bridge_ioctl_extproc ae_proc[WMDIOCTL_NUMOFMMUTLB];
+	struct bridge_ioctl_extproc ae_proc[BRDIOCTL_NUMOFMMUTLB];
 	struct cfg_hostres host_res;
 	u32 map_attrs;
 	u32 shm0_end;
@@ -600,7 +600,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 	 * Copy remaining entries from CDB. All entries are 1 MB and
 	 * should not conflict with shm entries on MPU or DSP side.
 	 */
-	for (i = 3; i < 7 && ndx < WMDIOCTL_NUMOFMMUTLB; i++) {
+	for (i = 3; i < 7 && ndx < BRDIOCTL_NUMOFMMUTLB; i++) {
 		if (hio_mgr->ext_proc_info.ty_tlb[i].ul_gpp_phys == 0)
 			continue;
 
@@ -666,7 +666,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 		i++;
 	}
 
-	for (i = ndx; i < WMDIOCTL_NUMOFMMUTLB; i++) {
+	for (i = ndx; i < BRDIOCTL_NUMOFMMUTLB; i++) {
 		ae_proc[i].ul_dsp_va = 0;
 		ae_proc[i].ul_gpp_pa = 0;
 		ae_proc[i].ul_gpp_va = 0;
@@ -704,7 +704,7 @@ dsp_status bridge_io_on_loaded(struct io_mgr *hio_mgr)
 
 		status =
 		    hio_mgr->intf_fxns->pfn_dev_cntrl(hio_mgr->hbridge_context,
-						      WMDIOCTL_SETMMUCONFIG,
+						      BRDIOCTL_SETMMUCONFIG,
 						      ae_proc);
 		if (DSP_FAILED(status))
 			goto func_end;
@@ -887,7 +887,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 		dev_dbg(bridge, "PM: Hibernate command\n");
 		status = pio_mgr->intf_fxns->
 				pfn_dev_cntrl(pio_mgr->hbridge_context,
-					      WMDIOCTL_PWR_HIBERNATE, parg);
+					      BRDIOCTL_PWR_HIBERNATE, parg);
 		if (DSP_FAILED(status))
 			pr_err("%s: hibernate cmd failed 0x%x\n",
 				       __func__, status);
@@ -896,7 +896,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 		dev_dbg(bridge, "PM: Requested OPP = 0x%x\n", parg[1]);
 		status = pio_mgr->intf_fxns->
 				pfn_dev_cntrl(pio_mgr->hbridge_context,
-					WMDIOCTL_CONSTRAINT_REQUEST, parg);
+					BRDIOCTL_CONSTRAINT_REQUEST, parg);
 		if (DSP_FAILED(status))
 			dev_dbg(bridge, "PM: Failed to set constraint "
 				"= 0x%x \n", parg[1]);
@@ -905,7 +905,7 @@ static void io_dispatch_pm(struct io_mgr *pio_mgr)
 			parg[0]);
 		status = pio_mgr->intf_fxns->
 				pfn_dev_cntrl(pio_mgr->hbridge_context,
-					      WMDIOCTL_CLK_CTRL, parg);
+					      BRDIOCTL_CLK_CTRL, parg);
 		if (DSP_FAILED(status))
 			dev_dbg(bridge, "PM: Failed to ctrl the DSP clk"
 				"= 0x%x\n", *parg);
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a8a2d02..d01cd63 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -265,7 +265,7 @@ void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
 	if (strcmp(driver_file_name, "UMA") == 0)
 		*ppDrvInterface = &drv_interface_fxns;
 	else
-		dev_dbg(bridge, "%s Unknown WMD file name", __func__);
+		dev_dbg(bridge, "%s Unknown Bridge driver file name", __func__);
 
 }
 
@@ -464,7 +464,7 @@ static dsp_status bridge_brd_start(struct bridge_dev_context *hDevContext,
 		hw_mmu_twl_disable(resources.dw_dmmu_base);
 
 		/* Only make TLB entry if both addresses are non-zero */
-		for (entry_ndx = 0; entry_ndx < WMDIOCTL_NUMOFMMUTLB;
+		for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB;
 		     entry_ndx++) {
 			if ((dev_context->atlb_entry[entry_ndx].ul_gpp_pa != 0)
 			    && (dev_context->atlb_entry[entry_ndx].ul_dsp_va !=
@@ -674,7 +674,7 @@ static dsp_status bridge_brd_start(struct bridge_dev_context *hDevContext,
 		/* Wait for DSP to clear word in shared memory */
 		/* Read the Location */
 		if (!wait_for_start(dev_context, dw_sync_addr))
-			status = WMD_E_TIMEOUT;
+			status = BRD_E_TIMEOUT;
 
 		/* Start wdt */
 		dsp_wdt_sm_set((void *)ul_shm_base);
@@ -914,7 +914,7 @@ static dsp_status bridge_dev_create(OUT struct bridge_dev_context
 	dev_context->dw_internal_size = OMAP_DSP_SIZE;
 	/*  Clear dev context MMU table entries.
 	 *  These get set on WMD_BRD_IOCTL() call after program loaded. */
-	for (entry_ndx = 0; entry_ndx < WMDIOCTL_NUMOFMMUTLB; entry_ndx++) {
+	for (entry_ndx = 0; entry_ndx < BRDIOCTL_NUMOFMMUTLB; entry_ndx++) {
 		dev_context->atlb_entry[entry_ndx].ul_gpp_pa =
 		    dev_context->atlb_entry[entry_ndx].ul_dsp_va = 0;
 	}
@@ -1067,39 +1067,39 @@ static dsp_status bridge_dev_ctrl(struct bridge_dev_context *dev_context,
 	s32 ndx;
 
 	switch (dw_cmd) {
-	case WMDIOCTL_CHNLREAD:
+	case BRDIOCTL_CHNLREAD:
 		break;
-	case WMDIOCTL_CHNLWRITE:
+	case BRDIOCTL_CHNLWRITE:
 		break;
-	case WMDIOCTL_SETMMUCONFIG:
+	case BRDIOCTL_SETMMUCONFIG:
 		/* store away dsp-mmu setup values for later use */
-		for (ndx = 0; ndx < WMDIOCTL_NUMOFMMUTLB; ndx++, pa_ext_proc++)
+		for (ndx = 0; ndx < BRDIOCTL_NUMOFMMUTLB; ndx++, pa_ext_proc++)
 			dev_context->atlb_entry[ndx] = *pa_ext_proc;
 		break;
-	case WMDIOCTL_DEEPSLEEP:
-	case WMDIOCTL_EMERGENCYSLEEP:
+	case BRDIOCTL_DEEPSLEEP:
+	case BRDIOCTL_EMERGENCYSLEEP:
 		/* Currently only DSP Idle is supported Need to update for
 		 * later releases */
 		status = sleep_dsp(dev_context, PWR_DEEPSLEEP, pargs);
 		break;
-	case WMDIOCTL_WAKEUP:
+	case BRDIOCTL_WAKEUP:
 		status = wake_dsp(dev_context, pargs);
 		break;
-	case WMDIOCTL_CLK_CTRL:
+	case BRDIOCTL_CLK_CTRL:
 		status = DSP_SOK;
 		/* Looking For Baseport Fix for Clocks */
 		status = dsp_peripheral_clk_ctrl(dev_context, pargs);
 		break;
-	case WMDIOCTL_PWR_HIBERNATE:
+	case BRDIOCTL_PWR_HIBERNATE:
 		status = handle_hibernation_from_dsp(dev_context);
 		break;
-	case WMDIOCTL_PRESCALE_NOTIFY:
+	case BRDIOCTL_PRESCALE_NOTIFY:
 		status = pre_scale_dsp(dev_context, pargs);
 		break;
-	case WMDIOCTL_POSTSCALE_NOTIFY:
+	case BRDIOCTL_POSTSCALE_NOTIFY:
 		status = post_scale_dsp(dev_context, pargs);
 		break;
-	case WMDIOCTL_CONSTRAINT_REQUEST:
+	case BRDIOCTL_CONSTRAINT_REQUEST:
 		status = handle_constraints_set(dev_context, pargs);
 		break;
 	default:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index d9defcc..8563dad 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -104,7 +104,7 @@ dsp_status handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 	}
 	if (timeout == 0) {
 		pr_err("%s: Timed out waiting for DSP off mode\n", __func__);
-		status = WMD_E_TIMEOUT;
+		status = BRD_E_TIMEOUT;
 		return status;
 	} else {
 
@@ -219,7 +219,7 @@ dsp_status sleep_dsp(struct bridge_dev_context *dev_context, IN u32 dw_cmd,
 		dev_get_deh_mgr(dev_context->hdev_obj, &hdeh_mgr);
 		bridge_deh_notify(hdeh_mgr, DSP_PWRERROR, 0);
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
-		return WMD_E_TIMEOUT;
+		return BRD_E_TIMEOUT;
 	} else {
 		/* Update the Bridger Driver state */
 		if (dsp_test_sleepstate == PWRDM_POWER_OFF)
-- 
1.7.0.3

