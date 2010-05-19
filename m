From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 3/4] DSPBRIDGE: Remove comments refering to "mini driver"
Date: Wed, 19 May 2010 17:21:41 -0500
Message-ID: <1274307702-22637-4-git-send-email-ivan.gomez@ti.com>
References: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57027 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228Ab0ESWaP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 18:30:15 -0400
In-Reply-To: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

mini-driver refers to the Windows Driver Model, and as this code is
specific to Linux then these comments are removed.

This is a complement of the patch series to remove code refering
to other OS.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnl.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/dehdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/dev.h      |    8 ++--
 arch/arm/plat-omap/include/dspbridge/dspdefs.h  |   48 +++++++++++-----------
 arch/arm/plat-omap/include/dspbridge/dspioctl.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |    2 +-
 drivers/dsp/bridge/core/_tiomap.h               |    4 +-
 drivers/dsp/bridge/core/chnl_sm.c               |    2 +-
 drivers/dsp/bridge/core/io_sm.c                 |    6 +-
 drivers/dsp/bridge/core/tiomap3430.c            |    4 +-
 drivers/dsp/bridge/core/tiomap3430_pwr.c        |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    2 +-
 drivers/dsp/bridge/pmgr/chnlobj.h               |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                   |    4 +-
 drivers/dsp/bridge/pmgr/ioobj.h                 |    2 +-
 drivers/dsp/bridge/pmgr/msg.c                   |    2 +-
 drivers/dsp/bridge/pmgr/msgobj.h                |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                  |    2 +-
 20 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 2c4f688..6e6f609 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Global CFG constants and types, shared between class and mini driver.
+ * Global CFG constants and types, shared between class and Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index 6d2d3c4..d6fb427 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * DSP API channel interface: multiplexes data streams through the single
- * physical link managed by a mini-driver.
+ * physical link managed by a Bridge driver.
  *
  * See DSP API chnl.h for more details.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dehdefs.h b/arch/arm/plat-omap/include/dspbridge/dehdefs.h
index f6eff70..09f8bf8 100644
--- a/arch/arm/plat-omap/include/dspbridge/dehdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dehdefs.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Definition for mini-driver module DEH.
+ * Definition for Bridge driver module DEH.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index 8f3b6fc..69c7ddd 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Bridge Mini-driver device operations.
+ * Bridge Bridge driver device operations.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
@@ -41,7 +41,7 @@
  *      device's bridge_brd_write() function.
  *  Parameters:
  *      pArb:           Handle to a Device Object.
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      dwDSPAddr:      Address on DSP board (Destination).
  *      pHostBuf:       Pointer to host buffer (Source).
  *      ul_num_bytes:     Number of bytes to transfer.
@@ -61,7 +61,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
 /*
  *  ======== dev_create_device ========
  *  Purpose:
- *      Called by the operating system to load the 'Bridge Mini Driver for a
+ *      Called by the operating system to load the Bridge Driver for a
  *      'Bridge device.
  *  Parameters:
  *      phDevObject:    Ptr to location to receive the device object handle.
@@ -102,7 +102,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
 /*
  *  ======== dev_create_iva_device ========
  *  Purpose:
- *      Called by the operating system to load the 'Bridge Mini Driver for IVA.
+ *      Called by the operating system to load the Bridge Driver for IVA.
  *  Parameters:
  *      phDevObject:    Ptr to location to receive the device object handle.
  *      driver_file_name: Name of Bridge driver PE DLL file to load.  If the
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 7729993..0412050 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -3,11 +3,11 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Bridge mini driver entry point and interface function declarations.
+ * Bridge driver entry point and interface function declarations.
  *
  * Notes:
  *   The Bridge class driver obtains it's function interface to
- *   the Bridge mini driver via a call to bridge_drv_entry().
+ *   the Bridge driver via a call to bridge_drv_entry().
  *
  *   Bridge services exported to Bridge drivers are initialized by the
  *   DSP API on behalf of the Bridge driver.
@@ -43,11 +43,11 @@
  */
 #define BRD_RESERVEDIOCTLBASE   0x8000
 
-/* Handle to mini-driver's private device context. */
+/* Handle to Bridge driver's private device context. */
 struct bridge_dev_context;
 
 /*--------------------------------------------------------------------------- */
-/* 'Bridge MINI DRIVER FUNCTION TYPES */
+/* BRIDGE DRIVER FUNCTION TYPES */
 /*--------------------------------------------------------------------------- */
 
 /*
@@ -55,7 +55,7 @@ struct bridge_dev_context;
  *  Purpose:
  *      Bring the board to the BRD_IDLE (monitor) state.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device context.
+ *      hDevContext:    Handle to Bridge driver defined device context.
  *  Returns:
  *      DSP_SOK:        Success.
  *      -ETIMEDOUT:  Timeout occured waiting for a response from hardware.
@@ -71,9 +71,9 @@ typedef dsp_status(*fxn_brd_monitor) (struct bridge_dev_context *hDevContext);
 /*
  *  ======== fxn_brd_setstate ========
  *  Purpose:
- *      Sets the Mini driver state
+ *      Sets the Bridge driver state
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      ulBrdState:     Board state
  *  Returns:
  *      DSP_SOK:        Success.
@@ -93,7 +93,7 @@ typedef dsp_status(*fxn_brd_setstate) (struct bridge_dev_context
  *  Purpose:
  *      Bring board to the BRD_RUNNING (start) state.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device context.
+ *      hDevContext:    Handle to Bridge driver defined device context.
  *      dwDSPAddr:      DSP address at which to start execution.
  *  Returns:
  *      DSP_SOK:        Success.
@@ -141,7 +141,7 @@ typedef dsp_status(*fxn_brd_memcopy) (struct bridge_dev_context
  *      Write a block of host memory into a DSP address, into a given memory
  *      space.  Unlike bridge_brd_write, this API does reset the DSP
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      dwDSPAddr:      Address on DSP board (Destination).
  *      pHostBuf:       Pointer to host buffer (Source).
  *      ul_num_bytes:     Number of bytes to transfer.
@@ -166,7 +166,7 @@ typedef dsp_status(*fxn_brd_memwrite) (struct bridge_dev_context
  *  Purpose:
  *      Map a MPU memory region to a DSP/IVA memory space
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      ul_mpu_addr:      MPU memory region start address.
  *      ulVirtAddr:     DSP/IVA memory region u8 address.
  *      ul_num_bytes:     Number of bytes to map.
@@ -188,7 +188,7 @@ typedef dsp_status(*fxn_brd_memmap) (struct bridge_dev_context
  *  Purpose:
  *      UnMap an MPU memory region from DSP/IVA memory space
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      ulVirtAddr:     DSP/IVA memory region u8 address.
  *      ul_num_bytes:     Number of bytes to unmap.
  *  Returns:
@@ -207,7 +207,7 @@ typedef dsp_status(*fxn_brd_memunmap) (struct bridge_dev_context
  *  Purpose:
  *      Bring board to the BRD_STOPPED state.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device context.
+ *      hDevContext:    Handle to Bridge driver defined device context.
  *  Returns:
  *      DSP_SOK:        Success.
  *      -ETIMEDOUT:  Timeout occured waiting for a response from hardware.
@@ -226,7 +226,7 @@ typedef dsp_status(*fxn_brd_stop) (struct bridge_dev_context *hDevContext);
  *  Purpose:
  *      Report the current state of the board.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device context.
+ *      hDevContext:    Handle to Bridge driver defined device context.
  *      pdwState:       Ptr to BRD status variable.
  *  Returns:
  *      DSP_SOK:
@@ -245,7 +245,7 @@ typedef dsp_status(*fxn_brd_status) (struct bridge_dev_context *hDevContext,
  *      Read a block of DSP memory, from a given memory space, into a host
  *      buffer.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      pHostBuf:       Pointer to host buffer (Destination).
  *      dwDSPAddr:      Address on DSP board (Source).
  *      ul_num_bytes:     Number of bytes to transfer.
@@ -271,7 +271,7 @@ typedef dsp_status(*fxn_brd_read) (struct bridge_dev_context *hDevContext,
  *      Write a block of host memory into a DSP address, into a given memory
  *      space.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      dwDSPAddr:      Address on DSP board (Destination).
  *      pHostBuf:       Pointer to host buffer (Source).
  *      ul_num_bytes:     Number of bytes to transfer.
@@ -666,7 +666,7 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *      pDspConfig != NULL;
  *      Fields in pConfig and pDspConfig contain valid values.
  *  Ensures:
- *      DSP_SOK:        All mini-driver specific DSP resource and other
+ *      DSP_SOK:        All Bridge driver specific DSP resource and other
  *                      board context has been allocated.
  *      -ENOMEM:    Bridge failed to allocate resources.
  *                      Any acquired resources have been freed.  The DSP API
@@ -691,9 +691,9 @@ typedef dsp_status(*fxn_dev_create) (OUT struct bridge_dev_context
 /*
  *  ======== bridge_dev_ctrl ========
  *  Purpose:
- *      Mini-driver specific interface.
+ *      Bridge driver specific interface.
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device info.
+ *      hDevContext:    Handle to Bridge driver defined device info.
  *      dw_cmd:          Bridge driver defined command code.
  *      pargs:          Pointer to an arbitrary argument structure.
  *  Returns:
@@ -711,11 +711,11 @@ typedef dsp_status(*fxn_dev_ctrl) (struct bridge_dev_context *hDevContext,
  *  ======== bridge_dev_destroy ========
  *  Purpose:
  *      Deallocate Bridge device extension structures and all other resources
- *      acquired by the mini-driver.
- *      No calls to other mini driver functions may subsequently
+ *      acquired by the Bridge driver.
+ *      No calls to other Bridge driver functions may subsequently
  *      occur, except for bridge_dev_create().
  *  Parameters:
- *      hDevContext:    Handle to mini-driver defined device information.
+ *      hDevContext:    Handle to Bridge driver defined device information.
  *  Returns:
  *      DSP_SOK:        Success.
  *      -EPERM:      Failed to release a resource previously acquired.
@@ -1035,7 +1035,7 @@ typedef void (*fxn_msg_setqueueid) (struct msg_queue *msg_queue_obj,
 /*
  *  Bridge Driver interface function table.
  *
- *  The information in this table is filled in by the specific mini-driver,
+ *  The information in this table is filled in by the specific Bridge driver,
  *  and copied into the 'Bridge class driver's own space.  If any interface
  *  function field is set to a value of NULL, then the class driver will
  *  consider that function not implemented, and return the error code
@@ -1046,7 +1046,7 @@ typedef void (*fxn_msg_setqueueid) (struct msg_queue *msg_queue_obj,
  *  Bridge drivers and newer DSP API.  These must be set to
  *  BRD_API_MAJOR_VERSION and BRD_API_MINOR_VERSION, respectively.
  *
- *  A mini-driver need not export a CHNL interface.  In this case, *all* of
+ *  A Bridge driver need not export a CHNL interface.  In this case, *all* of
  *  the bridge_chnl_* entries must be set to NULL.
  */
 struct bridge_drv_interface {
@@ -1114,7 +1114,7 @@ struct bridge_drv_interface {
  *      memory space.
  *  Parameters:
  *      ppDrvInterface  Pointer to a location to receive a pointer to the
- *                      mini driver interface.
+ *                      Bridge driver interface.
  *  Returns:
  *  Requires:
  *      The code segment this function resides in must expect to be discarded
diff --git a/arch/arm/plat-omap/include/dspbridge/dspioctl.h b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
index 111422c..41e0594 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspioctl.h
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * BRIDGE Minidriver BRD_IOCtl reserved command definitions.
+ * Bridge driver BRD_IOCtl reserved command definitions.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index d1135f7..c73f0fd 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -424,7 +424,7 @@ extern bool node_init(void);
  *  Purpose:
  *      Gets called when RMS_EXIT is received for a node. PROC needs to pass
  *      this function as a parameter to msg_create(). This function then gets
- *      called by the mini-driver when an exit message for a node is received.
+ *      called by the Bridge driver when an exit message for a node is received.
  *  Parameters:
  *      hnode:      Handle of the node that the exit message is for.
  *      nStatus:    Return status of the node's execute phase.
diff --git a/drivers/dsp/bridge/core/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
index 9deb726..3e3ebfc 100644
--- a/drivers/dsp/bridge/core/_tiomap.h
+++ b/drivers/dsp/bridge/core/_tiomap.h
@@ -308,7 +308,7 @@ static const struct bpwr_clk_t bpwr_clks[] = {
 
 #define CLEAR_BIT_INDEX(reg, index)   (reg &= ~(1 << (index)))
 
-/* This mini driver's device context: */
+/* This Bridge driver's device context: */
 struct bridge_dev_context {
 	struct dev_object *hdev_obj;	/* Handle to Bridge device object. */
 	u32 dw_dsp_base_addr;	/* Arm's API to DSP virt base addr */
@@ -364,7 +364,7 @@ extern s32 dsp_debug;
  *      This is typicaly used when mailbox interrupt mechanisms allow data
  *      to be associated with interrupt such as for OMAP's CMD/DATA regs.
  *  Parameters:
- *      dev_context:    Handle to mini-driver defined device info.
+ *      dev_context:    Handle to Bridge driver defined device info.
  *      mb_val:         Value associated with interrupt(e.g. mailbox value).
  *  Returns:
  *      DSP_SOK:        Interrupt sent;
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 34d515f..7529b25 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -57,7 +57,7 @@
 #include <dspbridge/cfg.h>
 #include <dspbridge/sync.h>
 
-/*  ----------------------------------- Mini-Driver */
+/*  ----------------------------------- Bridge Driver */
 #include <dspbridge/dspdefs.h>
 #include <dspbridge/dspchnl.h>
 #include "_tiomap.h"
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index 8d306ad..ebc1c69 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -45,7 +45,7 @@
 #include <hw_defs.h>
 #include <hw_mmu.h>
 
-/* Mini Driver */
+/* Bridge Driver */
 #include <dspbridge/dspdeh.h>
 #include <dspbridge/dspio.h>
 #include <dspbridge/dspioctl.h>
@@ -2045,7 +2045,7 @@ void io_sm_init(void)
 }
 /**
  * dump_dsp_stack() - This function dumps the data on the DSP stack.
- * @bridge_context:	Mini driver's device context pointer.
+ * @bridge_context:	Bridge driver's device context pointer.
  *
  */
 dsp_status dump_dsp_stack(struct bridge_dev_context *bridge_context)
@@ -2235,7 +2235,7 @@ func_end:
 
 /**
  * dump_dl_modules() - This functions dumps the _DLModules loaded in DSP side
- * @bridge_context:		Mini driver's device context pointer.
+ * @bridge_context:		Bridge driver's device context pointer.
  *
  */
 void dump_dl_modules(struct bridge_dev_context *bridge_context)
diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 7a3ed32..a238589 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -161,7 +161,7 @@ struct pg_table_attrs {
 };
 
 /*
- *  This mini driver's function interface table.
+ *  This Bridge driver's function interface table.
  */
 static struct bridge_drv_interface drv_interface_fxns = {
 	/* Bridge API ver. for which this bridge driver is built. */
@@ -245,7 +245,7 @@ static void bad_page_dump(u32 pa, struct page *pg)
 /*
  *  ======== bridge_drv_entry ========
  *  purpose:
- *      Mini Driver entry point.
+ *      Bridge Driver entry point.
  */
 void bridge_drv_entry(OUT struct bridge_drv_interface **ppDrvInterface,
 		   IN CONST char *driver_file_name)
diff --git a/drivers/dsp/bridge/core/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
index aa896b7..0c86aac 100644
--- a/drivers/dsp/bridge/core/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/core/tiomap3430_pwr.c
@@ -34,7 +34,7 @@
 
 #include <dspbridge/pwr_sh.h>
 
-/*  ----------------------------------- Mini Driver */
+/*  ----------------------------------- Bridge Driver */
 #include <dspbridge/dspdeh.h>
 #include <dspbridge/wdt.h>
 
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index e6437dc..be75e48 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * DSP API channel interface: multiplexes data streams through the single
- * physical link managed by a Bridge mini-driver.
+ * physical link managed by a Bridge Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/pmgr/chnlobj.h b/drivers/dsp/bridge/pmgr/chnlobj.h
index 13b637b..51c04f0 100644
--- a/drivers/dsp/bridge/pmgr/chnlobj.h
+++ b/drivers/dsp/bridge/pmgr/chnlobj.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Structure subcomponents of channel class library channel objects which
- * are exposed to class driver from mini-driver.
+ * are exposed to class driver from Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 580c018..7b38c25 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -3,7 +3,7 @@
  *
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
- * Implementation of Bridge Mini-driver device operations.
+ * Implementation of Bridge Bridge driver device operations.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
@@ -128,7 +128,7 @@ u32 dev_brd_write_fxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 /*
  *  ======== dev_create_device ========
  *  Purpose:
- *      Called by the operating system to load the PM Mini Driver for a
+ *      Called by the operating system to load the PM Bridge Driver for a
  *      PM board (device).
  */
 dsp_status dev_create_device(OUT struct dev_object **phDevObject,
diff --git a/drivers/dsp/bridge/pmgr/ioobj.h b/drivers/dsp/bridge/pmgr/ioobj.h
index 18542d8..9fc706c 100644
--- a/drivers/dsp/bridge/pmgr/ioobj.h
+++ b/drivers/dsp/bridge/pmgr/ioobj.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Structure subcomponents of channel class library IO objects which
- * are exposed to class driver from mini-driver.
+ * are exposed to class driver from Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index cb43eca..8af9432 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -27,7 +27,7 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
 
-/*  ----------------------------------- Mini Driver */
+/*  ----------------------------------- Bridge Driver */
 #include <dspbridge/dspdefs.h>
 
 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/pmgr/msgobj.h b/drivers/dsp/bridge/pmgr/msgobj.h
index 7e215a3..7949800 100644
--- a/drivers/dsp/bridge/pmgr/msgobj.h
+++ b/drivers/dsp/bridge/pmgr/msgobj.h
@@ -4,7 +4,7 @@
  * DSP-BIOS Bridge driver support functions for TI OMAP processors.
  *
  * Structure subcomponents of channel class library msg_ctrl objects which
- * are exposed to class driver from mini-driver.
+ * are exposed to class driver from Bridge driver.
  *
  * Copyright (C) 2005-2006 Texas Instruments, Inc.
  *
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bdb3c53..e53397b 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -32,7 +32,7 @@
 #include <dspbridge/list.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/sync.h>
-/*  ----------------------------------- Mini Driver */
+/*  ----------------------------------- Bridge Driver */
 #include <dspbridge/dspdefs.h>
 #include <dspbridge/dspdeh.h>
 /*  ----------------------------------- Platform Manager */
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index b508b48..3cda906 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -30,7 +30,7 @@
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/sync.h>
 
-/*  ----------------------------------- Mini Driver */
+/*  ----------------------------------- Bridge Driver */
 #include <dspbridge/dspdefs.h>
 
 /*  ----------------------------------- Resource Manager */
-- 
1.7.0.3

