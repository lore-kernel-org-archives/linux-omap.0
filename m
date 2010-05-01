From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 01/11] DSPBRIDGE: Rename wmd_dev_context structure by bridge_dev_context
Date: Fri, 30 Apr 2010 19:45:41 -0500
Message-ID: <1272674751-21557-2-git-send-email-ivan.gomez@ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56916 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab0EAAwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 20:52:51 -0400
In-Reply-To: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

This change is done because "wmd" refers to Windows OS.

wmd = windows mini driver

And the new name "bridge_dev_context" make more sense.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dev.h   |    2 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h |   14 ++--
 arch/arm/plat-omap/include/dspbridge/wmd.h   |   30 ++++----
 drivers/dsp/bridge/pmgr/dev.c                |    4 +-
 drivers/dsp/bridge/pmgr/ioobj.h              |    3 +-
 drivers/dsp/bridge/rmgr/node.c               |    4 +-
 drivers/dsp/bridge/rmgr/proc.c               |    2 +-
 drivers/dsp/bridge/rmgr/pwr.c                |   16 ++--
 drivers/dsp/bridge/wmd/_deh.h                |    3 +-
 drivers/dsp/bridge/wmd/_tiomap.h             |   12 ++--
 drivers/dsp/bridge/wmd/_tiomap_mmu.h         |    2 +-
 drivers/dsp/bridge/wmd/_tiomap_pwr.h         |   26 ++++---
 drivers/dsp/bridge/wmd/_tiomap_util.h        |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c               |   18 ++--
 drivers/dsp/bridge/wmd/mmu_fault.c           |    8 +-
 drivers/dsp/bridge/wmd/tiomap3430.c          |  116 +++++++++++++-------------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c      |   19 ++--
 drivers/dsp/bridge/wmd/tiomap_io.h           |   12 ++--
 drivers/dsp/bridge/wmd/ue_deh.c              |    8 +-
 19 files changed, 154 insertions(+), 147 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 13b0cad..6df8db7 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -526,7 +526,7 @@ extern dsp_status dev_get_symbol(struct dev_object *hdev_obj,
  *      else:           *phWmdContext is NULL;
  */
 extern dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
-				      OUT struct wmd_dev_context
+				      OUT struct bridge_dev_context
 				      **phWmdContext);
 
 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index bebf011..177bfeb 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -263,21 +263,21 @@ extern dsp_status io_sh_msetting(struct io_mgr *hio_mgr, u8 desc, void *pargs);
 /* Maximum channel bufsize that can be used. */
 extern u32 io_buf_size(struct io_mgr *hio_mgr);
 
-extern u32 io_read_value(struct wmd_dev_context *hDevContext, u32 dwDSPAddr);
+extern u32 io_read_value(struct bridge_dev_context *hDevContext, u32 dwDSPAddr);
 
-extern void io_write_value(struct wmd_dev_context *hDevContext,
+extern void io_write_value(struct bridge_dev_context *hDevContext,
 			   u32 dwDSPAddr, u32 dwValue);
 
-extern u32 io_read_value_long(struct wmd_dev_context *hDevContext,
+extern u32 io_read_value_long(struct bridge_dev_context *hDevContext,
 			      u32 dwDSPAddr);
 
-extern void io_write_value_long(struct wmd_dev_context *hDevContext,
+extern void io_write_value_long(struct bridge_dev_context *hDevContext,
 				u32 dwDSPAddr, u32 dwValue);
 
-extern void io_or_set_value(struct wmd_dev_context *hDevContext,
+extern void io_or_set_value(struct bridge_dev_context *hDevContext,
 			    u32 dwDSPAddr, u32 dwValue);
 
-extern void io_and_set_value(struct wmd_dev_context *hDevContext,
+extern void io_and_set_value(struct bridge_dev_context *hDevContext,
 			     u32 dwDSPAddr, u32 dwValue);
 
 extern void io_intr_dsp2(IN struct io_mgr *pio_mgr, IN u16 mb_val);
@@ -288,7 +288,7 @@ extern void io_sm_init(void);
  *  ========print_dsp_trace_buffer ========
  *      Print DSP tracebuffer.
  */
-extern dsp_status print_dsp_trace_buffer(struct wmd_dev_context
+extern dsp_status print_dsp_trace_buffer(struct bridge_dev_context
 					 *hwmd_context);
 
 #endif /* IOSM_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 6a41975..40be6da 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -44,7 +44,7 @@
 #define WMD_RESERVEDIOCTLBASE   0x8000
 
 /* Handle to mini-driver's private device context. */
-struct wmd_dev_context;
+struct bridge_dev_context;
 
 /*--------------------------------------------------------------------------- */
 /* 'Bridge MINI DRIVER FUNCTION TYPES */
@@ -67,7 +67,7 @@ struct wmd_dev_context;
  *      DSP_SOK:        Board is in BRD_IDLE state;
  *      else:           Board state is indeterminate.
  */
-typedef dsp_status(*fxn_brd_monitor) (struct wmd_dev_context *hDevContext);
+typedef dsp_status(*fxn_brd_monitor) (struct bridge_dev_context *hDevContext);
 
 /*
  *  ======== fxn_brd_setstate ========
@@ -86,7 +86,7 @@ typedef dsp_status(*fxn_brd_monitor) (struct wmd_dev_context *hDevContext);
  *      ulBrdState  <= BRD_LASTSTATE.
  *  Update the Board state to the specified state.
  */
-typedef dsp_status(*fxn_brd_setstate) (struct wmd_dev_context
+typedef dsp_status(*fxn_brd_setstate) (struct bridge_dev_context
 				       * hDevContext, u32 ulBrdState);
 
 /*
@@ -108,7 +108,7 @@ typedef dsp_status(*fxn_brd_setstate) (struct wmd_dev_context
  *                      Interrupts to the PC are enabled.
  *      else:           Board state is indeterminate.
  */
-typedef dsp_status(*fxn_brd_start) (struct wmd_dev_context
+typedef dsp_status(*fxn_brd_start) (struct bridge_dev_context
 				    * hDevContext, u32 dwDSPAddr);
 
 /*
@@ -131,7 +131,7 @@ typedef dsp_status(*fxn_brd_start) (struct wmd_dev_context
  *                      Interrupts to the PC are enabled.
  *      else:           Board state is indeterminate.
  */
-typedef dsp_status(*fxn_brd_memcopy) (struct wmd_dev_context
+typedef dsp_status(*fxn_brd_memcopy) (struct bridge_dev_context
 				      * hDevContext,
 				      u32 ulDspDestAddr,
 				      u32 ulDspSrcAddr,
@@ -156,7 +156,7 @@ typedef dsp_status(*fxn_brd_memcopy) (struct wmd_dev_context
  *      pHostBuf != NULL.
  *  Ensures:
  */
-typedef dsp_status(*fxn_brd_memwrite) (struct wmd_dev_context
+typedef dsp_status(*fxn_brd_memwrite) (struct bridge_dev_context
 				       * hDevContext,
 				       IN u8 *pHostBuf,
 				       u32 dwDSPAddr, u32 ul_num_bytes,
@@ -179,7 +179,7 @@ typedef dsp_status(*fxn_brd_memwrite) (struct wmd_dev_context
  *      hDevContext != NULL;
  *  Ensures:
  */
-typedef dsp_status(*fxn_brd_memmap) (struct wmd_dev_context
+typedef dsp_status(*fxn_brd_memmap) (struct bridge_dev_context
 				     * hDevContext, u32 ul_mpu_addr,
 				     u32 ulVirtAddr, u32 ul_num_bytes,
 				     u32 ulMapAttrs);
@@ -199,7 +199,7 @@ typedef dsp_status(*fxn_brd_memmap) (struct wmd_dev_context
  *      hDevContext != NULL;
  *  Ensures:
  */
-typedef dsp_status(*fxn_brd_memunmap) (struct wmd_dev_context
+typedef dsp_status(*fxn_brd_memunmap) (struct bridge_dev_context
 				       * hDevContext,
 				       u32 ulVirtAddr, u32 ul_num_bytes);
 
@@ -220,7 +220,7 @@ typedef dsp_status(*fxn_brd_memunmap) (struct wmd_dev_context
  *                      Interrupts to the PC are disabled.
  *      else:           Board state is indeterminate.
  */
-typedef dsp_status(*fxn_brd_stop) (struct wmd_dev_context *hDevContext);
+typedef dsp_status(*fxn_brd_stop) (struct bridge_dev_context *hDevContext);
 
 /*
  *  ======== bridge_brd_status ========
@@ -237,7 +237,7 @@ typedef dsp_status(*fxn_brd_stop) (struct wmd_dev_context *hDevContext);
  *  Ensures:
  *      *pdwState is one of {BRD_STOPPED, BRD_IDLE, BRD_RUNNING, BRD_UNKNOWN};
  */
-typedef dsp_status(*fxn_brd_status) (struct wmd_dev_context *hDevContext,
+typedef dsp_status(*fxn_brd_status) (struct bridge_dev_context *hDevContext,
 				     int *pdwState);
 
 /*
@@ -261,7 +261,7 @@ typedef dsp_status(*fxn_brd_status) (struct wmd_dev_context *hDevContext,
  *  Ensures:
  *  Will not write more than ul_num_bytes bytes into pHostBuf.
  */
-typedef dsp_status(*fxn_brd_read) (struct wmd_dev_context *hDevContext,
+typedef dsp_status(*fxn_brd_read) (struct bridge_dev_context *hDevContext,
 				   OUT u8 *pHostBuf,
 				   u32 dwDSPAddr,
 				   u32 ul_num_bytes, u32 ulMemType);
@@ -286,7 +286,7 @@ typedef dsp_status(*fxn_brd_read) (struct wmd_dev_context *hDevContext,
  *      pHostBuf != NULL.
  *  Ensures:
  */
-typedef dsp_status(*fxn_brd_write) (struct wmd_dev_context *hDevContext,
+typedef dsp_status(*fxn_brd_write) (struct bridge_dev_context *hDevContext,
 				    IN u8 *pHostBuf,
 				    u32 dwDSPAddr,
 				    u32 ul_num_bytes, u32 ulMemType);
@@ -685,7 +685,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *      function returns, they must not be stored into the device context
  *      structure.
  */
-typedef dsp_status(*fxn_dev_create) (OUT struct wmd_dev_context
+typedef dsp_status(*fxn_dev_create) (OUT struct bridge_dev_context
 				     **phDevContext,
 				     struct dev_object
 				     * hdev_obj,
@@ -709,7 +709,7 @@ typedef dsp_status(*fxn_dev_create) (OUT struct wmd_dev_context
  *      IOCTL completion routines provided.
  *  Ensures:
  */
-typedef dsp_status(*fxn_dev_ctrl) (struct wmd_dev_context *hDevContext,
+typedef dsp_status(*fxn_dev_ctrl) (struct bridge_dev_context *hDevContext,
 				   u32 dw_cmd, IN OUT void *pargs);
 
 /*
@@ -729,7 +729,7 @@ typedef dsp_status(*fxn_dev_ctrl) (struct wmd_dev_context *hDevContext,
  *  Ensures:
  *      DSP_SOK: Device context is freed.
  */
-typedef dsp_status(*fxn_dev_destroy) (struct wmd_dev_context *hDevContext);
+typedef dsp_status(*fxn_dev_destroy) (struct bridge_dev_context *hDevContext);
 
 /*
  *  ======== bridge_deh_create ========
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index e32757f..62ff655 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -64,7 +64,7 @@ struct dev_object {
 	struct list_head link;	/* Link to next dev_object. */
 	u32 dev_type;		/* Device Type */
 	struct cfg_devnode *dev_node_obj;	/* Platform specific dev id */
-	struct wmd_dev_context *hwmd_context;	/* WMD Context Handle */
+	struct bridge_dev_context *hwmd_context;	/* WMD Context Handle */
 	struct bridge_drv_interface wmd_interface;	/* Function interface to WMD. */
 	struct brd_object *lock_owner;	/* Client with exclusive access. */
 	struct cod_manager *cod_mgr;	/* Code manager handle. */
@@ -715,7 +715,7 @@ dsp_status dev_get_symbol(struct dev_object *hdev_obj,
  *      Retrieve the WMD Context handle, as returned by the WMD_Create fxn.
  */
 dsp_status dev_get_wmd_context(struct dev_object *hdev_obj,
-			       OUT struct wmd_dev_context **phWmdContext)
+			       OUT struct bridge_dev_context **phWmdContext)
 {
 	dsp_status status = DSP_SOK;
 	struct dev_object *dev_obj = hdev_obj;
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index f481765..5dd02bf 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -30,7 +30,8 @@
  */
 struct io_mgr_ {
 	/* These must be the first fields in a io_mgr struct: */
-	struct wmd_dev_context *hwmd_context;	/* WMD device context. */
+	/* WMD device context. */
+	struct bridge_dev_context *hwmd_context;
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD. */
 	struct dev_object *hdev_obj;	/* Device this board represents. */
 };
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 0475a09..0edf6ae 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3132,7 +3132,7 @@ static u32 ovly(void *priv_ref, u32 ulDspRunAddr, u32 ulDspLoadAddr,
 	u32 ul_size;
 	u32 ul_timeout;
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *hwmd_context;
+	struct bridge_dev_context *hwmd_context;
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 
 	DBC_REQUIRE(hnode);
@@ -3174,7 +3174,7 @@ static u32 mem_write(void *priv_ref, u32 ulDspAddr, void *pbuf,
 	u16 mem_sect_type;
 	u32 ul_timeout;
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *hwmd_context;
+	struct bridge_dev_context *hwmd_context;
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 
 	DBC_REQUIRE(hnode);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 884d0f5..bdcb862 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -95,7 +95,7 @@ struct proc_object {
 					 * GPP Client attached
 					 */
 	struct ntfy_object *ntfy_obj;	/* Manages  notifications */
-	struct wmd_dev_context *hwmd_context;	/* WMD Context Handle */
+	struct bridge_dev_context *hwmd_context;	/* WMD Context Handle */
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 	char *psz_last_coff;
 	struct list_head proc_list;
diff --git a/drivers/dsp/bridge/rmgr/pwr.c b/drivers/dsp/bridge/rmgr/pwr.c
index 51d8f44..e70f676 100644
--- a/drivers/dsp/bridge/rmgr/pwr.c
+++ b/drivers/dsp/bridge/rmgr/pwr.c
@@ -39,7 +39,7 @@
 dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 {
 	struct bridge_drv_interface *intf_fxns;
-	struct wmd_dev_context *dw_context;
+	struct bridge_dev_context *dw_context;
 	dsp_status status = DSP_EFAIL;
 	struct dev_object *hdev_obj = NULL;
 	u32 ioctlcode = 0;
@@ -50,7 +50,7 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 	     hdev_obj =
 	     (struct dev_object *)drv_get_next_dev_object((u32) hdev_obj)) {
 		if (DSP_FAILED(dev_get_wmd_context(hdev_obj,
-						   (struct wmd_dev_context **)
+						(struct bridge_dev_context **)
 						   &dw_context))) {
 			continue;
 		}
@@ -82,7 +82,7 @@ dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout)
 dsp_status pwr_wake_dsp(IN CONST u32 timeout)
 {
 	struct bridge_drv_interface *intf_fxns;
-	struct wmd_dev_context *dw_context;
+	struct bridge_dev_context *dw_context;
 	dsp_status status = DSP_EFAIL;
 	struct dev_object *hdev_obj = NULL;
 	u32 arg = timeout;
@@ -92,7 +92,7 @@ dsp_status pwr_wake_dsp(IN CONST u32 timeout)
 	     hdev_obj = (struct dev_object *)drv_get_next_dev_object
 	     ((u32) hdev_obj)) {
 		if (DSP_SUCCEEDED(dev_get_wmd_context(hdev_obj,
-						      (struct wmd_dev_context
+						      (struct bridge_dev_context
 						       **)&dw_context))) {
 			if (DSP_SUCCEEDED
 			    (dev_get_intf_fxns
@@ -115,7 +115,7 @@ dsp_status pwr_wake_dsp(IN CONST u32 timeout)
 dsp_status pwr_pm_pre_scale(IN u16 voltage_domain, u32 level)
 {
 	struct bridge_drv_interface *intf_fxns;
-	struct wmd_dev_context *dw_context;
+	struct bridge_dev_context *dw_context;
 	dsp_status status = DSP_EFAIL;
 	struct dev_object *hdev_obj = NULL;
 	u32 arg[2];
@@ -128,7 +128,7 @@ dsp_status pwr_pm_pre_scale(IN u16 voltage_domain, u32 level)
 	     hdev_obj = (struct dev_object *)drv_get_next_dev_object
 	     ((u32) hdev_obj)) {
 		if (DSP_SUCCEEDED(dev_get_wmd_context(hdev_obj,
-						      (struct wmd_dev_context
+						      (struct bridge_dev_context
 						       **)&dw_context))) {
 			if (DSP_SUCCEEDED
 			    (dev_get_intf_fxns
@@ -151,7 +151,7 @@ dsp_status pwr_pm_pre_scale(IN u16 voltage_domain, u32 level)
 dsp_status pwr_pm_post_scale(IN u16 voltage_domain, u32 level)
 {
 	struct bridge_drv_interface *intf_fxns;
-	struct wmd_dev_context *dw_context;
+	struct bridge_dev_context *dw_context;
 	dsp_status status = DSP_EFAIL;
 	struct dev_object *hdev_obj = NULL;
 	u32 arg[2];
@@ -164,7 +164,7 @@ dsp_status pwr_pm_post_scale(IN u16 voltage_domain, u32 level)
 	     hdev_obj = (struct dev_object *)drv_get_next_dev_object
 	     ((u32) hdev_obj)) {
 		if (DSP_SUCCEEDED(dev_get_wmd_context(hdev_obj,
-						      (struct wmd_dev_context
+						      (struct bridge_dev_context
 						       **)&dw_context))) {
 			if (DSP_SUCCEEDED
 			    (dev_get_intf_fxns
diff --git a/drivers/dsp/bridge/wmd/_deh.h b/drivers/dsp/bridge/wmd/_deh.h
index d7f2ef4..faa7a2e 100644
--- a/drivers/dsp/bridge/wmd/_deh.h
+++ b/drivers/dsp/bridge/wmd/_deh.h
@@ -24,7 +24,8 @@
 
 /* DEH Manager: only one created per board: */
 struct deh_mgr {
-	struct wmd_dev_context *hwmd_context;	/* WMD device context. */
+	/* Bridge device context. */
+	struct bridge_dev_context *hwmd_context;
 	struct ntfy_object *ntfy_obj;	/* NTFY object */
 	struct dsp_errorinfo err_info;	/* DSP exception info. */
 
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index a23c373..4cbf1d3 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -310,7 +310,7 @@ static const struct bpwr_clk_t bpwr_clks[] = {
 #define CLEAR_BIT_INDEX(reg, index)   (reg &= ~(1 << (index)))
 
 /* This mini driver's device context: */
-struct wmd_dev_context {
+struct bridge_dev_context {
 	struct dev_object *hdev_obj;	/* Handle to WCD device object. */
 	u32 dw_dsp_base_addr;	/* Arm's API to DSP virt base addr */
 	/*
@@ -355,10 +355,10 @@ struct wmd_dev_context {
 	 *     Given a DSP virtual address, traverse the page table and return
 	 *     a corresponding MPU physical address and size.
 	 */
-extern dsp_status wmd_tlb_dsp_va_to_mpu_pa(struct wmd_dev_context *dev_context,
-					   IN u32 ulVirtAddr,
-					   OUT u32 *ulPhysAddr,
-					   OUT u32 *sizeTlb);
+extern dsp_status wmd_tlb_dsp_va_to_mpu_pa(struct bridge_dev_context
+						*dev_context, IN u32 ulVirtAddr,
+						OUT u32 *ulPhysAddr,
+						OUT u32 *sizeTlb);
 
 /*
  *  ======== sm_interrupt_dsp ========
@@ -375,6 +375,6 @@ extern dsp_status wmd_tlb_dsp_va_to_mpu_pa(struct wmd_dev_context *dev_context,
  *  Requires:
  *  Ensures:
  */
-dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val);
+dsp_status sm_interrupt_dsp(struct bridge_dev_context *dev_context, u16 mb_val);
 
 #endif /* _TIOMAP_ */
diff --git a/drivers/dsp/bridge/wmd/_tiomap_mmu.h b/drivers/dsp/bridge/wmd/_tiomap_mmu.h
index 7af9e5e..66c1249 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_mmu.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_mmu.h
@@ -29,7 +29,7 @@
  *  SECTION = 1MB, LARGE_PAGE = 64KB, SMALL_PAGE = 4KB, TINY_PAGE = 1KB.
  *  DSP Byte address 0x40_0000 is word addr 0x20_0000.
  */
-extern void configure_dsp_mmu(struct wmd_dev_context *dev_context,
+extern void configure_dsp_mmu(struct bridge_dev_context *dev_context,
 			      u32 dataBasePhys,
 			      u32 dspBaseVirt,
 			      u32 sizeInBytes,
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index a7a4fc2..cfe3e56 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -23,46 +23,50 @@
  * ======== wake_dsp =========
  * Wakes up the DSP from DeepSleep
  */
-extern dsp_status wake_dsp(struct wmd_dev_context *dev_context, IN void *pargs);
+extern dsp_status wake_dsp(struct bridge_dev_context *dev_context,
+								IN void *pargs);
 
 /*
  * ======== sleep_dsp =========
  * Places the DSP in DeepSleep.
  */
-extern dsp_status sleep_dsp(struct wmd_dev_context *dev_context,
+extern dsp_status sleep_dsp(struct bridge_dev_context *dev_context,
 			    IN u32 dw_cmd, IN void *pargs);
 /*
  *  ========interrupt_dsp========
  *  	  Sends an interrupt to DSP unconditionally.
  */
-extern void interrupt_dsp(struct wmd_dev_context *dev_context, IN u16 mb_val);
+extern void interrupt_dsp(struct bridge_dev_context *dev_context,
+								IN u16 mb_val);
 
 /*
  * ======== wake_dsp =========
  * Wakes up the DSP from DeepSleep
  */
-extern dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
-					  IN void *pargs);
+extern dsp_status dsp_peripheral_clk_ctrl(struct bridge_dev_context
+						 *dev_context, IN void *pargs);
 /*
  *  ======== handle_hibernation_from_dsp ========
  *  	Handle Hibernation requested from DSP
  */
-dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context);
+dsp_status handle_hibernation_from_dsp(struct bridge_dev_context *dev_context);
 /*
  *  ======== post_scale_dsp ========
  *  	Handle Post Scale notification to DSP
  */
-dsp_status post_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs);
+dsp_status post_scale_dsp(struct bridge_dev_context *dev_context,
+								IN void *pargs);
 /*
  *  ======== pre_scale_dsp ========
  *  	Handle Pre Scale notification to DSP
  */
-dsp_status pre_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs);
+dsp_status pre_scale_dsp(struct bridge_dev_context *dev_context,
+								IN void *pargs);
 /*
  *  ======== handle_constraints_set ========
  *  	Handle constraints request from DSP
  */
-dsp_status handle_constraints_set(struct wmd_dev_context *dev_context,
+dsp_status handle_constraints_set(struct bridge_dev_context *dev_context,
 				  IN void *pargs);
 /*
  *  ======== dsp_peripheral_clocks_disable ========
@@ -71,7 +75,7 @@ dsp_status handle_constraints_set(struct wmd_dev_context *dev_context,
  *	DSP is entering Hibernation or when DSP is in
  *	Error state
  */
-dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
+dsp_status dsp_peripheral_clocks_disable(struct bridge_dev_context *dev_context,
 					 IN void *pargs);
 
 /*
@@ -79,7 +83,7 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
  *  	This function enables all the peripheral clocks that
  *	were requested by DSP.
  */
-dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
+dsp_status dsp_peripheral_clocks_enable(struct bridge_dev_context *dev_context,
 					IN void *pargs);
 
 /*
diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index e449946..ccdd678 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -37,7 +37,7 @@
  *  The argument dw_sync_addr is set to 1 before releasing the DSP.
  *  If the DSP starts running, it will clear this location.
  */
-extern bool wait_for_start(struct wmd_dev_context *dev_context,
+extern bool wait_for_start(struct bridge_dev_context *dev_context,
 			   u32 dw_sync_addr);
 
 #endif /* _TIOMAP_UTIL_ */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 5744b03..d452f98 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -83,7 +83,7 @@
 /* IO Manager: only one created per board */
 struct io_mgr {
 	/* These four fields must be the first fields in a io_mgr_ struct */
-	struct wmd_dev_context *hwmd_context;	/* WMD device context */
+	struct bridge_dev_context *hwmd_context;	/* WMD device context */
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 	struct dev_object *hdev_obj;	/* Device this board represents */
 
@@ -140,9 +140,9 @@ static void input_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr);
 static void output_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr);
 static u32 find_ready_output(struct chnl_mgr *chnl_mgr_obj,
 			     struct chnl_object *pchnl, u32 dwMask);
-static u32 read_data(struct wmd_dev_context *hDevContext, void *dest,
+static u32 read_data(struct bridge_dev_context *hDevContext, void *dest,
 		     void *pSrc, u32 usize);
-static u32 write_data(struct wmd_dev_context *hDevContext, void *dest,
+static u32 write_data(struct bridge_dev_context *hDevContext, void *dest,
 		      void *pSrc, u32 usize);
 
 #ifndef DSP_TRACEBUF_DISABLED
@@ -172,7 +172,7 @@ dsp_status bridge_io_create(OUT struct io_mgr **phIOMgr,
 	dsp_status status = DSP_SOK;
 	struct io_mgr *pio_mgr = NULL;
 	struct shm *shared_mem = NULL;
-	struct wmd_dev_context *hwmd_context = NULL;
+	struct bridge_dev_context *hwmd_context = NULL;
 	struct cfg_hostres host_res;
 	struct cfg_devnode *dev_node_obj;
 	struct chnl_mgr *hchnl_mgr;
@@ -270,7 +270,7 @@ func_end:
 dsp_status bridge_io_destroy(struct io_mgr *hio_mgr)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *hwmd_context;
+	struct bridge_dev_context *hwmd_context;
 	if (hio_mgr) {
 		status = dev_get_wmd_context(hio_mgr->hdev_obj, &hwmd_context);
 
@@ -1692,7 +1692,7 @@ func_end:
  *  ======== read_data ========
  *      Copies buffers from the shared memory to the host buffer.
  */
-static u32 read_data(struct wmd_dev_context *hDevContext, void *dest,
+static u32 read_data(struct bridge_dev_context *hDevContext, void *dest,
 		     void *pSrc, u32 usize)
 {
 	memcpy(dest, pSrc, usize);
@@ -1703,7 +1703,7 @@ static u32 read_data(struct wmd_dev_context *hDevContext, void *dest,
  *  ======== write_data ========
  *      Copies buffers from the host side buffer to the shared memory.
  */
-static u32 write_data(struct wmd_dev_context *hDevContext, void *dest,
+static u32 write_data(struct bridge_dev_context *hDevContext, void *dest,
 		      void *pSrc, u32 usize)
 {
 	memcpy(dest, pSrc, usize);
@@ -1939,7 +1939,7 @@ static dsp_status pack_trace_buffer(char *lpBuf, u32 bytes, u32 ul_num_words)
  *  Requires:
  *      hdeh_mgr muse be valid. Checked in bridge_deh_notify.
  */
-dsp_status print_dsp_trace_buffer(struct wmd_dev_context *hwmd_context)
+dsp_status print_dsp_trace_buffer(struct bridge_dev_context *hwmd_context)
 {
 	dsp_status status = DSP_SOK;
 	struct cod_manager *cod_mgr;
@@ -1952,7 +1952,7 @@ dsp_status print_dsp_trace_buffer(struct wmd_dev_context *hwmd_context)
 	char *psz_buf;
 	u16 *lpsz_buf;
 
-	struct wmd_dev_context *pwmd_context = (struct wmd_dev_context *)
+	struct bridge_dev_context *pwmd_context = (struct bridge_dev_context *)
 	    hwmd_context;
 	struct bridge_drv_interface *intf_fxns;
 	struct dev_object *dev_obj = (struct dev_object *)
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 2b82818..30ab29a 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -45,7 +45,7 @@
 static u32 dmmu_event_mask;
 u32 fault_addr;
 
-static bool mmu_check_if_fault(struct wmd_dev_context *dev_context);
+static bool mmu_check_if_fault(struct bridge_dev_context *dev_context);
 
 /*
  *  ======== mmu_fault_dpc ========
@@ -67,7 +67,7 @@ void mmu_fault_dpc(IN unsigned long pRefData)
 irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 {
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)pRefData;
-	struct wmd_dev_context *dev_context;
+	struct bridge_dev_context *dev_context;
 	struct cfg_hostres resources;
 	dsp_status status = DSP_SOK;
 
@@ -77,7 +77,7 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
 	if (deh_mgr_obj) {
 
 		dev_context =
-		    (struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
+		    (struct bridge_dev_context *)deh_mgr_obj->hwmd_context;
 		status = cfg_get_host_resources((struct cfg_devnode *)
 						drv_get_first_dev_extension(),
 						&resources);
@@ -118,7 +118,7 @@ irqreturn_t mmu_fault_isr(int irq, IN void *pRefData)
  *      Check to see if MMU Fault is valid TLB miss from DSP
  *  Note: This function is called from an ISR
  */
-static bool mmu_check_if_fault(struct wmd_dev_context *dev_context)
+static bool mmu_check_if_fault(struct bridge_dev_context *dev_context)
 {
 
 	bool ret = false;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 407e926..29519bf 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -78,47 +78,47 @@
 #define MMU_GFLUSH 0x60
 
 /* Forward Declarations: */
-static dsp_status bridge_brd_monitor(struct wmd_dev_context *dev_context);
-static dsp_status bridge_brd_read(struct wmd_dev_context *dev_context,
+static dsp_status bridge_brd_monitor(struct bridge_dev_context *dev_context);
+static dsp_status bridge_brd_read(struct bridge_dev_context *dev_context,
 				  OUT u8 *pbHostBuf,
 				  u32 dwDSPAddr, u32 ul_num_bytes,
 				  u32 ulMemType);
-static dsp_status bridge_brd_start(struct wmd_dev_context *dev_context,
+static dsp_status bridge_brd_start(struct bridge_dev_context *dev_context,
 				   u32 dwDSPAddr);
-static dsp_status bridge_brd_status(struct wmd_dev_context *dev_context,
+static dsp_status bridge_brd_status(struct bridge_dev_context *dev_context,
 				    int *pdwState);
-static dsp_status bridge_brd_stop(struct wmd_dev_context *dev_context);
-static dsp_status bridge_brd_write(struct wmd_dev_context *dev_context,
+static dsp_status bridge_brd_stop(struct bridge_dev_context *dev_context);
+static dsp_status bridge_brd_write(struct bridge_dev_context *dev_context,
 				   IN u8 *pbHostBuf,
 				   u32 dwDSPAddr, u32 ul_num_bytes,
 				   u32 ulMemType);
-static dsp_status bridge_brd_set_state(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_set_state(struct bridge_dev_context *hDevContext,
 				    u32 ulBrdState);
-static dsp_status bridge_brd_mem_copy(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_copy(struct bridge_dev_context *hDevContext,
 				   u32 ulDspDestAddr, u32 ulDspSrcAddr,
 				   u32 ul_num_bytes, u32 ulMemType);
-static dsp_status bridge_brd_mem_write(struct wmd_dev_context *dev_context,
+static dsp_status bridge_brd_mem_write(struct bridge_dev_context *dev_context,
 				    IN u8 *pbHostBuf, u32 dwDSPAddr,
 				    u32 ul_num_bytes, u32 ulMemType);
-static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_map(struct bridge_dev_context *hDevContext,
 				  u32 ul_mpu_addr, u32 ulVirtAddr,
 				  u32 ul_num_bytes, u32 ul_map_attr);
-static dsp_status bridge_brd_mem_un_map(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_un_map(struct bridge_dev_context *hDevContext,
 				     u32 ulVirtAddr, u32 ul_num_bytes);
-static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
-				    struct dev_object *hdev_obj,
-				    IN CONST struct cfg_hostres *pConfig,
-				    IN CONST struct cfg_dspres *pDspConfig);
-static dsp_status bridge_dev_ctrl(struct wmd_dev_context *dev_context,
+static dsp_status bridge_dev_create(OUT struct bridge_dev_context
+				**ppDevContext, struct dev_object *hdev_obj,
+				IN CONST struct cfg_hostres *pConfig,
+				IN CONST struct cfg_dspres *pDspConfig);
+static dsp_status bridge_dev_ctrl(struct bridge_dev_context *dev_context,
 				  u32 dw_cmd, IN OUT void *pargs);
-static dsp_status bridge_dev_destroy(struct wmd_dev_context *dev_context);
+static dsp_status bridge_dev_destroy(struct bridge_dev_context *dev_context);
 static u32 user_va2_pa(struct mm_struct *mm, u32 address);
-static dsp_status pte_update(struct wmd_dev_context *hDevContext, u32 pa,
+static dsp_status pte_update(struct bridge_dev_context *hDevContext, u32 pa,
 			     u32 va, u32 size,
 			     struct hw_mmu_map_attrs_t *map_attrs);
 static dsp_status pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 			  u32 size, struct hw_mmu_map_attrs_t *attrs);
-static dsp_status mem_map_vmalloc(struct wmd_dev_context *hDevContext,
+static dsp_status mem_map_vmalloc(struct bridge_dev_context *hDevContext,
 				  u32 ul_mpu_addr, u32 ulVirtAddr,
 				  u32 ul_num_bytes,
 				  struct hw_mmu_map_attrs_t *hw_attrs);
@@ -228,7 +228,7 @@ static inline void tlb_flush_all(const void __iomem *base)
 	__raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
 }
 
-static inline void flush_all(struct wmd_dev_context *dev_context)
+static inline void flush_all(struct bridge_dev_context *dev_context)
 {
 	if (dev_context->dw_brd_state == BRD_DSP_HIBERNATION ||
 	    dev_context->dw_brd_state == BRD_HIBERNATION)
@@ -278,10 +278,10 @@ void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
  *  Preconditions:
  *      Device in 'OFF' state.
  */
-static dsp_status bridge_brd_monitor(struct wmd_dev_context *hDevContext)
+static dsp_status bridge_brd_monitor(struct bridge_dev_context *hDevContext)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	u32 temp;
 	struct dspbridge_platform_data *pdata =
 				    omap_dspbridge_dev->dev.platform_data;
@@ -321,12 +321,12 @@ static dsp_status bridge_brd_monitor(struct wmd_dev_context *hDevContext)
  *  purpose:
  *      Reads buffers for DSP memory.
  */
-static dsp_status bridge_brd_read(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_read(struct bridge_dev_context *hDevContext,
 				  OUT u8 *pbHostBuf, u32 dwDSPAddr,
 				  u32 ul_num_bytes, u32 ulMemType)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	u32 offset;
 	u32 dsp_base_addr = hDevContext->dw_dsp_base_addr;
 
@@ -353,11 +353,11 @@ static dsp_status bridge_brd_read(struct wmd_dev_context *hDevContext,
  *  purpose:
  *      This routine updates the Board status.
  */
-static dsp_status bridge_brd_set_state(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_set_state(struct bridge_dev_context *hDevContext,
 				    u32 ulBrdState)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 
 	dev_context->dw_brd_state = ulBrdState;
 	return status;
@@ -373,11 +373,11 @@ static dsp_status bridge_brd_set_state(struct wmd_dev_context *hDevContext,
  *  b) DSP_RST1 is asserted.
  *  b) DSP_RST2 is released.
  */
-static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_start(struct bridge_dev_context *hDevContext,
 				   u32 dwDSPAddr)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	u32 dw_sync_addr = 0;
 	u32 ul_shm_base;	/* Gpp Phys SM base addr(byte) */
 	u32 ul_shm_base_virt;	/* Dsp Virt SM base addr */
@@ -706,10 +706,10 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
  *  Preconditions :
  *  a) None
  */
-static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
+static dsp_status bridge_brd_stop(struct bridge_dev_context *hDevContext)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	struct pg_table_attrs *pt_attrs;
 	u32 dsp_pwr_state;
 	dsp_status clk_status;
@@ -780,10 +780,10 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
  *  Preconditions :
  *  a) None
  */
-static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
+static dsp_status wmd_brd_delete(struct bridge_dev_context *hDevContext)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	struct cfg_hostres resources;
 	struct pg_table_attrs *pt_attrs;
 	dsp_status clk_status;
@@ -838,10 +838,10 @@ static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
  *  ======== bridge_brd_status ========
  *      Returns the board status.
  */
-static dsp_status bridge_brd_status(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_status(struct bridge_dev_context *hDevContext,
 				    int *pdwState)
 {
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	*pdwState = dev_context->dw_brd_state;
 	return DSP_SOK;
 }
@@ -850,12 +850,12 @@ static dsp_status bridge_brd_status(struct wmd_dev_context *hDevContext,
  *  ======== bridge_brd_write ========
  *      Copies the buffers to DSP internal or external memory.
  */
-static dsp_status bridge_brd_write(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_write(struct bridge_dev_context *hDevContext,
 				   IN u8 *pbHostBuf, u32 dwDSPAddr,
 				   u32 ul_num_bytes, u32 ulMemType)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 
 	if (dwDSPAddr < dev_context->dw_dsp_start_add) {
 		status = DSP_EFAIL;
@@ -877,13 +877,13 @@ static dsp_status bridge_brd_write(struct wmd_dev_context *hDevContext,
  *  ======== bridge_dev_create ========
  *      Creates a driver object. Puts DSP in self loop.
  */
-static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
-				    struct dev_object *hdev_obj,
-				    IN CONST struct cfg_hostres *pConfig,
-				    IN CONST struct cfg_dspres *pDspConfig)
+static dsp_status bridge_dev_create(OUT struct bridge_dev_context
+				**ppDevContext, struct dev_object *hdev_obj,
+				IN CONST struct cfg_hostres *pConfig,
+				IN CONST struct cfg_dspres *pDspConfig)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = NULL;
+	struct bridge_dev_context *dev_context = NULL;
 	s32 entry_ndx;
 	s32 tc_word_swap;
 	u32 tc_word_swap_size = sizeof(tc_word_swap);
@@ -895,7 +895,7 @@ static dsp_status bridge_dev_create(OUT struct wmd_dev_context **ppDevContext,
 
 	/* Allocate and initialize a data structure to contain the mini driver
 	 *  state, which becomes the context for later calls into this WMD. */
-	dev_context = kzalloc(sizeof(struct wmd_dev_context), GFP_KERNEL);
+	dev_context = kzalloc(sizeof(struct bridge_dev_context), GFP_KERNEL);
 	if (!dev_context) {
 		status = DSP_EMEMORY;
 		goto func_end;
@@ -1058,7 +1058,7 @@ func_end:
  *  ======== bridge_dev_ctrl ========
  *      Receives device specific commands.
  */
-static dsp_status bridge_dev_ctrl(struct wmd_dev_context *dev_context,
+static dsp_status bridge_dev_ctrl(struct bridge_dev_context *dev_context,
 				  u32 dw_cmd, IN OUT void *pargs)
 {
 	dsp_status status = DSP_SOK;
@@ -1112,11 +1112,11 @@ static dsp_status bridge_dev_ctrl(struct wmd_dev_context *dev_context,
  *  ======== bridge_dev_destroy ========
  *      Destroys the driver object.
  */
-static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
+static dsp_status bridge_dev_destroy(struct bridge_dev_context *hDevContext)
 {
 	struct pg_table_attrs *pt_attrs;
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = (struct wmd_dev_context *)
+	struct bridge_dev_context *dev_context = (struct bridge_dev_context *)
 	    hDevContext;
 
 	/* It should never happen */
@@ -1147,7 +1147,7 @@ static dsp_status bridge_dev_destroy(struct wmd_dev_context *hDevContext)
 	return status;
 }
 
-static dsp_status bridge_brd_mem_copy(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_copy(struct bridge_dev_context *hDevContext,
 				   u32 ulDspDestAddr, u32 ulDspSrcAddr,
 				   u32 ul_num_bytes, u32 ulMemType)
 {
@@ -1157,7 +1157,7 @@ static dsp_status bridge_brd_mem_copy(struct wmd_dev_context *hDevContext,
 	u32 copy_bytes = 0;
 	u32 total_bytes = ul_num_bytes;
 	u8 host_buf[BUFFERSIZE];
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	while ((total_bytes > 0) && DSP_SUCCEEDED(status)) {
 		copy_bytes =
 		    total_bytes > BUFFERSIZE ? BUFFERSIZE : total_bytes;
@@ -1187,12 +1187,12 @@ static dsp_status bridge_brd_mem_copy(struct wmd_dev_context *hDevContext,
 }
 
 /* Mem Write does not halt the DSP to write unlike bridge_brd_write */
-static dsp_status bridge_brd_mem_write(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_write(struct bridge_dev_context *hDevContext,
 				    IN u8 *pbHostBuf, u32 dwDSPAddr,
 				    u32 ul_num_bytes, u32 ulMemType)
 {
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	u32 ul_remain_bytes = 0;
 	u32 ul_bytes = 0;
 	ul_remain_bytes = ul_num_bytes;
@@ -1225,13 +1225,13 @@ static dsp_status bridge_brd_mem_write(struct wmd_dev_context *hDevContext,
  *
  *  TODO: Disable MMU while updating the page tables (but that'll stall DSP)
  */
-static dsp_status bridge_brd_mem_map(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_map(struct bridge_dev_context *hDevContext,
 				  u32 ul_mpu_addr, u32 ulVirtAddr,
 				  u32 ul_num_bytes, u32 ul_map_attr)
 {
 	u32 attrs;
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	struct hw_mmu_map_attrs_t hw_attrs;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
@@ -1445,7 +1445,7 @@ func_cont:
  *      So, instead of looking up the PTE address for every 4K block,
  *      we clear consecutive PTEs until we unmap all the bytes
  */
-static dsp_status bridge_brd_mem_un_map(struct wmd_dev_context *hDevContext,
+static dsp_status bridge_brd_mem_un_map(struct bridge_dev_context *hDevContext,
 				     u32 ulVirtAddr, u32 ul_num_bytes)
 {
 	u32 l1_base_va;
@@ -1462,7 +1462,7 @@ static dsp_status bridge_brd_mem_un_map(struct wmd_dev_context *hDevContext,
 	u32 va_curr;
 	struct page *pg = NULL;
 	dsp_status status = DSP_SOK;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	struct pg_table_attrs *pt = dev_context->pt_attrs;
 	u32 temp;
 	u32 paddr;
@@ -1670,7 +1670,7 @@ static u32 user_va2_pa(struct mm_struct *mm, u32 address)
  *      This function calculates the optimum page-aligned addresses and sizes
  *      Caller must pass page-aligned values
  */
-static dsp_status pte_update(struct wmd_dev_context *hDevContext, u32 pa,
+static dsp_status pte_update(struct bridge_dev_context *hDevContext, u32 pa,
 			     u32 va, u32 size,
 			     struct hw_mmu_map_attrs_t *map_attrs)
 {
@@ -1679,7 +1679,7 @@ static dsp_status pte_update(struct wmd_dev_context *hDevContext, u32 pa,
 	u32 pa_curr = pa;
 	u32 va_curr = va;
 	u32 num_bytes = size;
-	struct wmd_dev_context *dev_context = hDevContext;
+	struct bridge_dev_context *dev_context = hDevContext;
 	dsp_status status = DSP_SOK;
 	u32 page_size[] = { HW_PAGE_SIZE16MB, HW_PAGE_SIZE1MB,
 		HW_PAGE_SIZE64KB, HW_PAGE_SIZE4KB
@@ -1808,7 +1808,7 @@ static dsp_status pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 }
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
-static dsp_status mem_map_vmalloc(struct wmd_dev_context *dev_context,
+static dsp_status mem_map_vmalloc(struct bridge_dev_context *dev_context,
 				  u32 ul_mpu_addr, u32 ulVirtAddr,
 				  u32 ul_num_bytes,
 				  struct hw_mmu_map_attrs_t *hw_attrs)
@@ -1894,7 +1894,7 @@ static dsp_status mem_map_vmalloc(struct wmd_dev_context *dev_context,
  *  ======== configure_dsp_mmu ========
  *      Make DSP MMU page table entries.
  */
-void configure_dsp_mmu(struct wmd_dev_context *dev_context, u32 dataBasePhys,
+void configure_dsp_mmu(struct bridge_dev_context *dev_context, u32 dataBasePhys,
 		       u32 dspBaseVirt, u32 sizeInBytes, s32 nEntryStart,
 		       enum hw_endianism_t endianism,
 		       enum hw_element_size_t elem_size,
@@ -1918,7 +1918,7 @@ void configure_dsp_mmu(struct wmd_dev_context *dev_context, u32 dataBasePhys,
  *  ======== wait_for_start ========
  *      Wait for the singal from DSP that it has started, or time out.
  */
-bool wait_for_start(struct wmd_dev_context *dev_context, u32 dw_sync_addr)
+bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr)
 {
 	u16 timeout = TIHELEN_ACKTIMEOUT;
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 004c246..d9defcc 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -54,7 +54,7 @@ extern struct mailbox_context mboxsetting;
  *  ======== handle_constraints_set ========
  *  	Sets new DSP constraint
  */
-dsp_status handle_constraints_set(struct wmd_dev_context *dev_context,
+dsp_status handle_constraints_set(struct bridge_dev_context *dev_context,
 				  IN void *pargs)
 {
 #ifdef CONFIG_BRIDGE_DVFS
@@ -78,7 +78,7 @@ dsp_status handle_constraints_set(struct wmd_dev_context *dev_context,
  *  ======== handle_hibernation_from_dsp ========
  *  	Handle Hibernation requested from DSP
  */
-dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
+dsp_status handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 {
 	dsp_status status = DSP_SOK;
 #ifdef CONFIG_PM
@@ -145,7 +145,7 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
  *  ======== sleep_dsp ========
  *  	Put DSP in low power consuming state.
  */
-dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
+dsp_status sleep_dsp(struct bridge_dev_context *dev_context, IN u32 dw_cmd,
 		     IN void *pargs)
 {
 	dsp_status status = DSP_SOK;
@@ -255,7 +255,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
  *  ======== wake_dsp ========
  *  	Wake up DSP from sleep.
  */
-dsp_status wake_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
+dsp_status wake_dsp(struct bridge_dev_context *dev_context, IN void *pargs)
 {
 	dsp_status status = DSP_SOK;
 #ifdef CONFIG_PM
@@ -281,7 +281,7 @@ dsp_status wake_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
  *  ======== dsp_peripheral_clk_ctrl ========
  *  	Enable/Disable the DSP peripheral clocks as needed..
  */
-dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
+dsp_status dsp_peripheral_clk_ctrl(struct bridge_dev_context *dev_context,
 				   IN void *pargs)
 {
 	u32 ext_clk = 0;
@@ -379,7 +379,7 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
  *  Sends prescale notification to DSP
  *
  */
-dsp_status pre_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
+dsp_status pre_scale_dsp(struct bridge_dev_context *dev_context, IN void *pargs)
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 level;
@@ -412,7 +412,8 @@ dsp_status pre_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
  *  Sends postscale notification to DSP
  *
  */
-dsp_status post_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
+dsp_status post_scale_dsp(struct bridge_dev_context *dev_context,
+								IN void *pargs)
 {
 	dsp_status status = DSP_SOK;
 #ifdef CONFIG_BRIDGE_DVFS
@@ -453,7 +454,7 @@ dsp_status post_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
  *  ========dsp_peripheral_clocks_disable========
  *  Disables all the peripheral clocks that were requested by DSP
  */
-dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
+dsp_status dsp_peripheral_clocks_disable(struct bridge_dev_context *dev_context,
 					 IN void *pargs)
 {
 	u32 clk_idx;
@@ -498,7 +499,7 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
  *  ========dsp_peripheral_clocks_enable========
  *  Enables all the peripheral clocks that were requested by DSP
  */
-dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
+dsp_status dsp_peripheral_clocks_enable(struct bridge_dev_context *dev_context,
 					IN void *pargs)
 {
 	u32 clk_idx;
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.h b/drivers/dsp/bridge/wmd/tiomap_io.h
index ac78538..0f30fe7 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.h
+++ b/drivers/dsp/bridge/wmd/tiomap_io.h
@@ -47,14 +47,14 @@
  *  Reads it from DSP External memory. The external memory for the DSP
  * is configured by the combination of DSP MMU and shm Memory manager in the CDB
  */
-extern dsp_status read_ext_dsp_data(struct wmd_dev_context *dev_context,
+extern dsp_status read_ext_dsp_data(struct bridge_dev_context *dev_context,
 				    OUT u8 *pbHostBuf, u32 dwDSPAddr,
 				    u32 ul_num_bytes, u32 ulMemType);
 
 /*
  *  ======== write_dsp_data ========
  */
-extern dsp_status write_dsp_data(struct wmd_dev_context *dev_context,
+extern dsp_status write_dsp_data(struct bridge_dev_context *dev_context,
 				 OUT u8 *pbHostBuf, u32 dwDSPAddr,
 				 u32 ul_num_bytes, u32 ulMemType);
 
@@ -64,7 +64,7 @@ extern dsp_status write_dsp_data(struct wmd_dev_context *dev_context,
  *  The ext mem for progra is configured by the combination of DSP MMU and
  *  shm Memory manager in the CDB
  */
-extern dsp_status write_ext_dsp_data(struct wmd_dev_context *dev_context,
+extern dsp_status write_ext_dsp_data(struct bridge_dev_context *dev_context,
 				     IN u8 *pbHostBuf, u32 dwDSPAddr,
 				     u32 ul_num_bytes, u32 ulMemType,
 				     bool bDynamicLoad);
@@ -74,8 +74,8 @@ extern dsp_status write_ext_dsp_data(struct wmd_dev_context *dev_context,
  * Writes 32 bit data to the external memory
  */
 extern inline void write_ext32_bit_dsp_data(IN const
-					    struct wmd_dev_context *dev_context,
-					    IN u32 dwDSPAddr, IN u32 val)
+					struct bridge_dev_context *dev_context,
+					IN u32 dwDSPAddr, IN u32 val)
 {
 	*(u32 *) dwDSPAddr = ((dev_context->tc_word_swap_on) ? (((val << 16) &
 								 0xFFFF0000) |
@@ -88,7 +88,7 @@ extern inline void write_ext32_bit_dsp_data(IN const
  * ======== read_ext32_bit_dsp_data ========
  * Reads 32 bit data from the external memory
  */
-extern inline u32 read_ext32_bit_dsp_data(IN const struct wmd_dev_context
+extern inline u32 read_ext32_bit_dsp_data(IN const struct bridge_dev_context
 					  *dev_context, IN u32 dwDSPAddr)
 {
 	u32 ret;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index f10d185..3ef7f97 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -71,7 +71,7 @@ dsp_status bridge_deh_create(OUT struct deh_mgr **phDehMgr,
 	struct deh_mgr *deh_mgr_obj = NULL;
 	struct cfg_hostres cfg_host_res;
 	struct cfg_devnode *dev_node_obj;
-	struct wmd_dev_context *hwmd_context = NULL;
+	struct bridge_dev_context *hwmd_context = NULL;
 
 	/*  Message manager will be created when a file is loaded, since
 	 *  size of message buffer in shared memory is configurable in
@@ -191,7 +191,7 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *hdeh_mgr, u32 event_mask,
 void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct deh_mgr *deh_mgr_obj = (struct deh_mgr *)hdeh_mgr;
-	struct wmd_dev_context *dev_context;
+	struct bridge_dev_context *dev_context;
 	dsp_status status = DSP_SOK;
 	u32 mem_physical = 0;
 	u32 hw_mmu_max_tlb_count = 31;
@@ -208,7 +208,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		       "bridge_deh_notify: ********** DEVICE EXCEPTION "
 		       "**********\n");
 		dev_context =
-		    (struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
+		    (struct bridge_dev_context *)deh_mgr_obj->hwmd_context;
 
 		switch (ulEventMask) {
 		case DSP_SYSERROR:
@@ -243,7 +243,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			mem_physical =
 			    VIRT_TO_PHYS(PG_ALIGN_LOW
 					 ((u32) dummy_va_addr, PG_SIZE4K));
-			dev_context = (struct wmd_dev_context *)
+			dev_context = (struct bridge_dev_context *)
 			    deh_mgr_obj->hwmd_context;
 			/* Reset the dynamic mmu index to fixed count if it
 			 * exceeds 31. So that the dynmmuindex is always
-- 
1.7.0.3

