From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 37/40] DSPBRIDGE: cleanup for duplicated error codes
Date: Thu,  3 Jun 2010 00:47:50 -0500
Message-ID: <1275544073-20418-38-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56440 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab0FCF4W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Some comments and pieces of code make reference to the same
error code, this was removed to just have one instance where
the code won't get too nested or complicated.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfg.h      |    9 ++-----
 arch/arm/plat-omap/include/dspbridge/chnl.h     |    6 ++--
 arch/arm/plat-omap/include/dspbridge/cod.h      |    8 +++---
 arch/arm/plat-omap/include/dspbridge/dbdcd.h    |   19 +++++------------
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    5 +--
 arch/arm/plat-omap/include/dspbridge/dev.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/dspdefs.h  |   12 +++-------
 arch/arm/plat-omap/include/dspbridge/io.h       |    4 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |   25 +++++++++++------------
 arch/arm/plat-omap/include/dspbridge/strm.h     |    6 ++--
 drivers/dsp/bridge/core/chnl_sm.c               |    8 +-----
 drivers/dsp/bridge/rmgr/strm.c                  |    3 +-
 12 files changed, 44 insertions(+), 65 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 2226723..4d5bd69 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -82,8 +82,7 @@ extern dsp_status cfg_get_cd_version(OUT u32 *pdwVersion);
  *      pdwValue:       Ptr to location to store the value.
  *  Returns:
  *      0:                Success.
- *      -EFAULT:  dev_node_obj is invalid.
- *      -EFAULT:   phDevObject is invalid.
+ *      -EFAULT: dev_node_obj is invalid or phDevObject is invalid.
  *      -ENODATA: The resource is not available.
  *  Requires:
  *      CFG initialized.
@@ -104,8 +103,7 @@ extern dsp_status cfg_get_dev_object(IN struct cfg_devnode *dev_node_obj,
  *      pstrExecFile:   Ptr to character buf to hold ExecFile.
  *  Returns:
  *      0:                Success.
- *      -EFAULT:  dev_node_obj is invalid.
- *      -EFAULT:   pstrExecFile is invalid.
+ *      -EFAULT:  dev_node_obj is invalid or pstrExecFile is invalid.
  *      -ENODATA: The resource is not available.
  *  Requires:
  *      CFG initialized.
@@ -160,8 +158,7 @@ extern void cfg_get_perf_value(OUT bool *pfEnablePerf);
  *      pstrZLFileName: Ptr to character buf to hold ZLFileName.
  *  Returns:
  *      0:                Success.
- *      -EFAULT:   pstrZLFileName is invalid.
- *      -EFAULT:  dev_node_obj is invalid.
+ *      -EFAULT: pstrZLFileName is invalid or dev_node_obj is invalid.
  *      -ENODATA: couldn't find the ZLFileName.
  *  Requires:
  *      CFG initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index ff3ed51..ac9acd9 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -61,13 +61,13 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *  Returns:
  *      0:                Success;
  *      -EFAULT:            hdev_obj is invalid.
- *      -EINVAL:        max_channels is 0.
+ *      -EINVAL: max_channels is 0.
+ *               Invalid DSP word size (must be > 0).
+ *               Invalid base address for DSP communications.
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      -ECHRNG:     This manager cannot handle this many channels.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
- *      -EINVAL: Invalid DSP word size.  Must be > 0.
- *      -EINVAL:  Invalid base address for DSP communications.
  *      -EEXIST:       Channel manager already exists for this device.
  *  Requires:
  *      chnl_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index 8a4919e..e27f942 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -212,8 +212,8 @@ extern dsp_status cod_get_loader(struct cod_manager *cod_mgr_obj,
  *      puLen:      Location to store length.
  *  Returns:
  *      0:                Success
- *      -ESPIPE:  Symbols have not been loaded onto the board.
- *      -ESPIPE:   The symbol could not be found.
+ *      -ESPIPE:  Symbols could not be found or have not been loaded onto
+ *                the board.
  *  Requires:
  *      COD module initialized.
  *      valid cod_mgr_obj.
@@ -242,8 +242,8 @@ extern dsp_status cod_get_section(struct cod_libraryobj *lib,
  *      value:      value of the symbol
  *  Returns:
  *      0:                Success.
- *      -ESPIPE:  Symbols have not been loaded onto the board.
- *      -ESPIPE:   The symbol could not be found.
+ *      -ESPIPE:  Symbols could not be found or have not been loaded onto
+ *                the board.
  *  Requires:
  *      COD module initialized.
  *      Valid cod_mgr_obj.
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdcd.h b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
index a879d6b..b0feecb 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdcd.h
@@ -34,9 +34,7 @@
  *                              objects to be registered.
  *  Returns:
  *      0:                Success.
- *      -EACCES: Unable to find auto-registration section.
- *      -EACCES:       Unable to read object code section.
- *      -EACCES:       Unable to load code base.
+ *      -EACCES: Unable to find auto-registration/read/load section.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
@@ -60,9 +58,7 @@ extern dsp_status dcd_auto_register(IN struct dcd_manager *hdcd_mgr,
  *                              DCD objects to be unregistered.
  *  Returns:
  *      0:                Success.
- *      -EACCES: Unable to find auto-registration section.
- *      -EACCES:       Unable to read object code section.
- *      -EACCES:       Unable to load code base.
+ *      -EACCES: Unable to find auto-registration/read/load section.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
@@ -255,10 +251,8 @@ extern dsp_status dcd_get_library_name(IN struct dcd_manager *hdcd_mgr,
  *                          union of various possible DCD object types.
  *  Returns:
  *      0: Success.
- *      -EACCES:  Unable to parse content of object code section.
- *      -EACCES:   Unable to read object code section.
- *      -EACCES:    Unable to access object code section.
- *      -EACCES:   Unable to load code base.
+ *      -EACCES: Unable to access/read/parse/load content of object code
+ *               section.
  *      -EPERM:          General failure.
  *      -EFAULT:        Invalid DCD_HMANAGER handle.
  *  Requires:
@@ -289,9 +283,8 @@ extern dsp_status dcd_get_object_def(IN struct dcd_manager *hdcd_mgr,
  *      handle:                 Handle to pass to callback.
  *  Returns:
  *      0:                Success.
- *      -EACCES: Unable to find .dcd_register section.
- *      -EACCES:       Unable to read object code section.
- *      -EACCES:       Unable to load code base.
+ *      -EACCES: Unable to access/read/parse/load content of object code
+ *               section.
  *      -EFAULT:            Invalid DCD_HMANAGER handle..
  *  Requires:
  *      DCD initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index e780e87..7b79207 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -385,9 +385,8 @@ typedef dsp_status(*dbll_load_sect_fxn) (struct dbll_library_obj *lib,
  *  Returns:
  *      0:            Success.
  *      -ENOMEM:        Memory allocation failure.
- *      -EBADF:         File open failure.
- *      -EBADF:         File read failure.
- *      -EBADF:   Unable to determine target type.
+ *      -EBADF:         File open/read failure.
+ *                      Unable to determine target type.
  *  Requires:
  *      DBL initialized.
  *      Valid target.
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index cf48c07..eb9ea39 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -492,8 +492,8 @@ extern dsp_status dev_get_node_manager(struct dev_object
  *  Returns:
  *      0:        Success.
  *      -EFAULT:    Invalid hdev_obj.
- *      -ESPIPE:  Symbols have not been loaded onto the board.
- *      -ESPIPE:   The symbol could not be found.
+ *      -ESPIPE: Symbols couldn not be found or have not been loaded onto
+ *               the board.
  *  Requires:
  *      pstrSym != NULL.
  *      pul_value != NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index c3c2e4d..2a52983 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -450,8 +450,7 @@ typedef dsp_status(*fxn_chnl_close) (struct chnl_object *chnl_obj);
  *      dw_arg:          A user argument that travels with the buffer.
  *  Returns:
  *      0:        Success;
- *      -EFAULT:    Invalid chnl_obj.
- *      -EFAULT:   pHostBuf is invalid.
+ *      -EFAULT: Invalid chnl_obj or pHostBuf.
  *      -EPERM:   User cannot mark EOS on an input channel.
  *      -ECANCELED: I/O has been cancelled on this channel.  No further
  *                      I/O is allowed.
@@ -491,8 +490,7 @@ typedef dsp_status(*fxn_chnl_addioreq) (struct chnl_object
  *      pIOC->status:   See chnldefs.h.
  *  Returns:
  *      0:        Success.
- *      -EFAULT:    Invalid chnl_obj.
- *      -EFAULT:   pIOC is invalid.
+ *      -EFAULT: Invalid chnl_obj or pIOC.
  *      -EREMOTEIO:   CHNL_IOCNOWAIT was specified as the dwTimeOut parameter
  *                      yet no I/O completions were queued.
  *  Requires:
@@ -555,8 +553,7 @@ typedef dsp_status(*fxn_chnl_flushio) (struct chnl_object *chnl_obj,
  *      pInfo:          Location to store channel info.
  *  Returns:
  *      0:        Success;
- *      -EFAULT:    Invalid chnl_obj.
- *      -EFAULT:   pInfo == NULL.
+ *      -EFAULT: Invalid chnl_obj or pInfo.
  *  Requires:
  *  Ensures:
  *      0:        pInfo points to a filled in chnl_info struct,
@@ -575,8 +572,7 @@ typedef dsp_status(*fxn_chnl_getinfo) (struct chnl_object *chnl_obj,
  *      pMgrInfo:           Location to store channel manager info.
  *  Returns:
  *      0:            Success;
- *      -EFAULT:        Invalid hchnl_mgr.
- *      -EFAULT:       pMgrInfo == NULL.
+ *      -EFAULT: Invalid hchnl_mgr or pMgrInfo.
  *      -ECHRNG:   Invalid channel ID.
  *  Requires:
  *  Ensures:
diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index 752786f..7ff2451 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -42,8 +42,8 @@
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
- *      -EINVAL: Invalid DSP word size.  Must be > 0.
- *      -EINVAL:  Invalid base address for DSP communications.
+ *      -EINVAL: Invalid DSP word size (must be > 0).
+ *               Invalid base address for DSP communications.
  *  Requires:
  *      io_init(void) called.
  *      phIOMgr != NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index ed83faf..ff2c673 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -100,13 +100,13 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
  *      -EDOM:         prio is out of range.
- *      -EPERM:      The specified node is not a task node.
+ *      -EPERM: The specified node is not a task node.
+ *              Unable to change node's runtime priority level.
  *      -EBADR:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
  *                          or NODE_RUNNING state.
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      DSP_ERESTART:       A critical error has occurred and the DSP is
  *                          being restarted.
- *      -EPERM:          Unable to change node's runtime priority level.
  *  Requires:
  *      node_init(void) called.
  *  Ensures:
@@ -382,9 +382,9 @@ extern dsp_status node_get_attr(struct node_object *hnode,
  *  Returns:
  *      0:        Success.
  *      -EFAULT:    Invalid hnode.
- *      -EPERM:  Cannot retrieve messages from this type of node.
+ *      -EPERM: Cannot retrieve messages from this type of node.
+ *              Error occurred while trying to retrieve a message.
  *      -ETIME:   Timeout occurred and no message is available.
- *      -EPERM:      Error occurred while trying to retrieve a message.
  *  Requires:
  *      node_init(void) called.
  *      message != NULL.
@@ -443,10 +443,10 @@ void node_on_exit(struct node_object *hnode, s32 nStatus);
  *  Returns:
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
- *      -EPERM:      Node is not a task or socket node.
+ *      -EPERM: Node is not a task or socket node.
+ *              Failed to pause node.
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_RUNNING state.
- *      -EPERM:          Failed to pause node.
  *  Requires:
  *      node_init(void) called.
  *  Ensures:
@@ -467,10 +467,10 @@ extern dsp_status node_pause(struct node_object *hnode);
  *  Returns:
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
- *      -EPERM:      Messages can't be sent to this type of node.
+ *      -EPERM: Messages can't be sent to this type of node.
+ *              Unable to send message.
  *      -ETIME:       Timeout occurred before message could be set.
  *      -EBADR:    Node is in invalid state for sending messages.
- *      -EPERM:          Unable to send message.
  *  Requires:
  *      node_init(void) called.
  *      pmsg != NULL.
@@ -517,11 +517,10 @@ extern dsp_status node_register_notify(struct node_object *hnode,
  *  Returns:
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
- *      -EPERM:      hnode doesn't represent a message, task or dais
- *                          socket node.
+ *      -EPERM: hnode doesn't represent a message, task or dais socket node.
+ *              Unable to start or resume execution.
  *      -ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_PAUSED or NODE_CREATED state.
- *      -EPERM:          Unable to start or resume execution.
  *      -ESPIPE:        Execute function not found in the COFF file.
  *  Requires:
  *      node_init(void) called.
@@ -543,9 +542,9 @@ extern dsp_status node_run(struct node_object *hnode);
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
  *      -ETIME:       A timeout occurred before the DSP responded.
- *      -EPERM:      Type of node specified cannot be terminated.
+ *      -EPERM: Type of node specified cannot be terminated.
+ *              Unable to terminate the node.
  *      -EBADR:    Operation not valid for the current node state.
- *      -EPERM:          Unable to terminate the node.
  *  Requires:
  *      node_init(void) called.
  *      pstatus != NULL.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index c4b1d91..5a8a922 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -259,10 +259,10 @@ extern dsp_status strm_issue(struct strm_object *hStrm, IN u8 * pbuf,
  *  Returns:
  *      0:        Success.
  *      -EFAULT:    Invalid hnode.
- *      -EPERM: Invalid dir.
+ *      -EPERM: Invalid direction.
+ *              hnode is not a task or DAIS socket node.
+ *              Unable to open stream.
  *      -EINVAL:     Invalid index.
- *      -EPERM:  hnode is not a task or DAIS socket node.
- *      -EPERM:      Unable to open stream.
  *  Requires:
  *      strm_init(void) called.
  *      phStrm != NULL.
diff --git a/drivers/dsp/bridge/core/chnl_sm.c b/drivers/dsp/bridge/core/chnl_sm.c
index 6a8bbf9..704f11a 100644
--- a/drivers/dsp/bridge/core/chnl_sm.c
+++ b/drivers/dsp/bridge/core/chnl_sm.c
@@ -107,9 +107,7 @@ dsp_status bridge_chnl_add_io_req(struct chnl_object *chnl_obj, void *pHostBuf,
 	is_eos = (byte_size == 0);
 
 	/* Validate args */
-	if (!pHostBuf) {
-		status = -EFAULT;
-	} else if (!pchnl) {
+	if (!pHostBuf || !pchnl) {
 		status = -EFAULT;
 	} else if (is_eos && CHNL_IS_INPUT(pchnl->chnl_mode)) {
 		status = -EPERM;
@@ -582,9 +580,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
 	struct dev_object *dev_obj;
 
 	/* Check args: */
-	if (pIOC == NULL) {
-		status = -EFAULT;
-	} else if (!pchnl) {
+	if (!pIOC || !pchnl) {
 		status = -EFAULT;
 	} else if (dwTimeOut == CHNL_IOCNOWAIT) {
 		if (LST_IS_EMPTY(pchnl->pio_completions))
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 6c90687..7f9ffea 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -602,8 +602,7 @@ func_cont:
 	DBC_ENSURE((DSP_SUCCEEDED(status) && *phStrm) ||
 		   (*phStrm == NULL && (status == -EFAULT ||
 					status == -EPERM
-					|| status == -EINVAL
-					|| status == -EPERM)));
+					|| status == -EINVAL)));
 
 	dev_dbg(bridge, "%s: hnode: %p dir: 0x%x index: 0x%x pattr: %p "
 		"phStrm: %p status: 0x%x\n", __func__,
-- 
1.7.1

