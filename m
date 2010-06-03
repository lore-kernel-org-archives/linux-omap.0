From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 38/40] DSPBRIDGE: removed unused error codes from comments
Date: Thu,  3 Jun 2010 00:47:51 -0500
Message-ID: <1275544073-20418-39-git-send-email-omar.ramirez@ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544Ab0FCF4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 01:56:22 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Ernesto Ramos <ernesto@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

Only removed error codes which now does not exist,
previously those were not used in the code.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/chnl.h     |    1 -
 arch/arm/plat-omap/include/dspbridge/cod.h      |    3 ---
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    2 --
 arch/arm/plat-omap/include/dspbridge/dev.h      |   14 --------------
 arch/arm/plat-omap/include/dspbridge/disp.h     |    3 ---
 arch/arm/plat-omap/include/dspbridge/dspdefs.h  |    4 ----
 arch/arm/plat-omap/include/dspbridge/io.h       |    1 -
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h |    1 -
 arch/arm/plat-omap/include/dspbridge/node.h     |    9 +--------
 arch/arm/plat-omap/include/dspbridge/proc.h     |   11 -----------
 arch/arm/plat-omap/include/dspbridge/strm.h     |    1 -
 11 files changed, 1 insertions(+), 49 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/chnl.h b/arch/arm/plat-omap/include/dspbridge/chnl.h
index ac9acd9..a166d1b 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnl.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnl.h
@@ -67,7 +67,6 @@ extern dsp_status chnl_close(struct chnl_object *chnl_obj);
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
  *      -ECHRNG:     This manager cannot handle this many channels.
- *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      -EEXIST:       Channel manager already exists for this device.
  *  Requires:
  *      chnl_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/cod.h b/arch/arm/plat-omap/include/dspbridge/cod.h
index e27f942..16e95c3 100644
--- a/arch/arm/plat-omap/include/dspbridge/cod.h
+++ b/arch/arm/plat-omap/include/dspbridge/cod.h
@@ -83,7 +83,6 @@ extern void cod_close(struct cod_libraryobj *lib);
  *                      will cause default attrs to be used.
  *  Returns:
  *      0:                Success.
- *      COD_E_NOZLFUNCTIONS:    Could not initialize ZL functions.
  *      -ESPIPE:   ZL_Create failed.
  *      -ENOSYS:           attrs was not NULL.  We don't yet support
  *                              non default values of attrs.
@@ -285,7 +284,6 @@ extern bool cod_init(void);
  *  Returns:
  *      0:                   Success.
  *      -EBADF:       Failed to open target code.
- *      COD_E_LOADFAILED:       Failed to load code onto target.
  *  Requires:
  *      COD module initialized.
  *      hmgr is valid.
@@ -356,7 +354,6 @@ extern dsp_status cod_open_base(struct cod_manager *hmgr, IN char *pszCoffPath,
  *  Returns:
  *      0: on success, error code on failure
  *      -ESPIPE:  Symbols have not been loaded onto the board.
- *      COD_E_READFAILED: Failed to read content of code section.
  *  Requires:
  *      COD module initialized.
  *      valid cod_mgr_obj.
diff --git a/arch/arm/plat-omap/include/dspbridge/dblldefs.h b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
index 7b79207..e1a0364 100644
--- a/arch/arm/plat-omap/include/dspbridge/dblldefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dblldefs.h
@@ -338,7 +338,6 @@ typedef bool(*dbll_init_fxn) (void);
  *  Returns:
  *      0:        Success.
  *      -EBADF:     File read failed.
- *      DSP_EFWRITE:    Write to target failed.
  *      -EILSEQ:   Failure in dynamic loader library.
  *  Requires:
  *      DBL initialized.
@@ -360,7 +359,6 @@ typedef dsp_status(*dbll_load_fxn) (struct dbll_library_obj *lib,
  *  Returns:
  *      0:        Success.
  *      -ENXIO:    Section not found.
- *      DSP_EFWRITE:    Write function failed.
  *      -ENOSYS:   Function not implemented.
  *  Requires:
  *      Valid lib.
diff --git a/arch/arm/plat-omap/include/dspbridge/dev.h b/arch/arm/plat-omap/include/dspbridge/dev.h
index eb9ea39..b4350de 100644
--- a/arch/arm/plat-omap/include/dspbridge/dev.h
+++ b/arch/arm/plat-omap/include/dspbridge/dev.h
@@ -76,14 +76,7 @@ extern u32 dev_brd_write_fxn(void *pArb,
  *  Returns:
  *      0:            Module is loaded, device object has been created
  *      -ENOMEM:        Insufficient memory to create needed resources.
- *      DEV_E_NEWWMD:       The WMD was compiled for a newer version of WCD.
- *      DEV_E_NULLWMDINTF:  WMD passed back a NULL fxn Interface Struct Ptr
- *      DEV_E_NOCODMODULE:  No ZL file name was specified in the registry
- *                          for this dev_node_obj.
- *      LDR_E_FILEUNABLETOOPEN: Unable to open the specified WMD.
- *      LDR_E_NOMEMORY:         PELDR is out of resources.
  *      -EPERM:              Unable to find WMD entry point function.
- *      COD_E_NOZLFUNCTIONS:    One or more ZL functions exports not found.
  *      -ESPIPE:   Unable to load ZL DLL.
  *  Requires:
  *      DEV Initialized.
@@ -118,14 +111,7 @@ extern dsp_status dev_create_device(OUT struct dev_object
  *  Returns:
  *      0:            Module is loaded, device object has been created
  *      -ENOMEM:        Insufficient memory to create needed resources.
- *      DEV_E_NEWWMD:       The WMD was compiled for a newer version of WCD.
- *      DEV_E_NULLWMDINTF:  WMD passed back a NULL fxn Interface Struct Ptr
- *      DEV_E_NOCODMODULE:  No ZL file name was specified in the registry
- *                          for this dev_node_obj.
- *      LDR_E_FILEUNABLETOOPEN: Unable to open the specified WMD.
- *      LDR_E_NOMEMORY:         PELDR is out of resources.
  *      -EPERM:              Unable to find WMD entry point function.
- *      COD_E_NOZLFUNCTIONS:    One or more ZL functions exports not found.
  *      -ESPIPE:   Unable to load ZL DLL.
  *  Requires:
  *      DEV Initialized.
diff --git a/arch/arm/plat-omap/include/dspbridge/disp.h b/arch/arm/plat-omap/include/dspbridge/disp.h
index 22f3b63..c34e08c 100644
--- a/arch/arm/plat-omap/include/dspbridge/disp.h
+++ b/arch/arm/plat-omap/include/dspbridge/disp.h
@@ -132,10 +132,7 @@ extern dsp_status disp_node_change_priority(struct disp_object
  *                      output.
  *  Returns:
  *      0:        Success.
- *      DSP_ETASK:      Unable to create the node's task or process on the DSP.
- *      DSP_ESTREAM:    Stream creation failure on the DSP.
  *      -ETIME:   A timeout occurred before the DSP responded.
- *      DSP_EUSER:      A user-defined failure occurred.
  *      -EPERM:      A failure occurred, unable to create node.
  *  Requires:
  *      disp_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/dspdefs.h b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
index 2a52983..7436539 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdefs.h
@@ -58,7 +58,6 @@ struct bridge_dev_context;
  *      hDevContext:    Handle to mini-driver defined device context.
  *  Returns:
  *      0:        Success.
- *      WMD_E_HARDWARE: A test of hardware assumptions/integrity failed.
  *      -ETIMEDOUT:  Timeout occured waiting for a response from hardware.
  *      -EPERM:      Other, unspecified error.
  *  Requires:
@@ -656,9 +655,6 @@ typedef dsp_status(*fxn_chnl_registernotify)
  *  Returns:
  *      0:            Success.
  *      -ENOMEM:        Unable to allocate memory for device context.
- *      WMD_E_BADCONFIG:    One or more of the host or DSP configuration
- *                          parameters did not satisfy hardware assumptions
- *                          made by this WMD.
  *  Requires:
  *      phDevContext != NULL;
  *      hdev_obj != NULL;
diff --git a/arch/arm/plat-omap/include/dspbridge/io.h b/arch/arm/plat-omap/include/dspbridge/io.h
index 7ff2451..6c248ce 100644
--- a/arch/arm/plat-omap/include/dspbridge/io.h
+++ b/arch/arm/plat-omap/include/dspbridge/io.h
@@ -41,7 +41,6 @@
  *      0:                Success;
  *      -ENOMEM:            Insufficient memory for requested resources.
  *      -EIO:             Unable to plug channel ISR for configured IRQ.
- *      CHNL_E_INVALIDIRQ:      Invalid IRQ number. Must be 0 <= birq <= 15.
  *      -EINVAL: Invalid DSP word size (must be > 0).
  *               Invalid base address for DSP communications.
  *  Requires:
diff --git a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
index 9ab99d3..440d831 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldrdefs.h
@@ -250,7 +250,6 @@ typedef bool(*nldr_initfxn) (void);
  *      -ENXIO:     Can't overlay phase because overlay memory
  *                              is already in use.
  *      -EILSEQ:           Failure in dynamic loader library.
- *      DSP_EFWRITE:            Failed to write phase's code or date to target.
  *  Requires:
  *      nldr_init(void) called.
  *      Valid nldr_node_obj.
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index ff2c673..d5764b7 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -105,8 +105,6 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *      -EBADR:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
  *                          or NODE_RUNNING state.
  *      -ETIME:       A timeout occurred before the DSP responded.
- *      DSP_ERESTART:       A critical error has occurred and the DSP is
- *                          being restarted.
  *  Requires:
  *      node_init(void) called.
  *  Ensures:
@@ -202,10 +200,7 @@ extern dsp_status node_connect(struct node_object *hNode1,
  *      -ESPIPE:        Create function not found in the COFF file.
  *      -EBADR:    Node is not in the NODE_ALLOCATED state.
  *      -ENOMEM:        Memory allocation failure on the DSP.
- *      DSP_ETASK:          Unable to create node's task or process on the DSP.
- *      DSP_ESTREAM:        Stream creation failure on the DSP.
  *      -ETIME:       A timeout occurred before the DSP responded.
- *      DSP_EUSER1-16:      A user-defined failure occurred on the DSP.
  *      -EPERM:          A failure occurred, unable to create node.
  *  Requires:
  *      node_init(void) called.
@@ -252,8 +247,6 @@ extern dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
  *      -ETIME:       A timeout occurred before the DSP responded.
- *      DSP_EDELETE:        A deletion failure occurred.
- *      DSP_EUSER1-16:      Node specific failure occurred on the DSP.
  *      -EPERM:          A failure occurred in deleting the node.
  *      -ESPIPE:        Delete function not found in the COFF file.
  *  Requires:
@@ -537,7 +530,7 @@ extern dsp_status node_run(struct node_object *hnode);
  *      hnode:              Node object representing a node currently
  *                          running on the DSP.
  *      pstatus:            Location to store execute-phase function return
- *                          value (DSP_EUSER1-16).
+ *                          value.
  *  Returns:
  *      0:            Success.
  *      -EFAULT:        Invalid hnode.
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 561842e..5da3ac2 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -91,10 +91,6 @@ extern dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
  *      -EFAULT :       Invalid processor handle.
  *      -ETIME:       A Timeout Occured before the Control information
  *			  could be sent.
- *      DSP_EACCESSDENIED:  Client does not have the access rights required
- *			  to call this function.
- *      DSP_ERESTART:       A Critical error has occured and the DSP is being
- *			  restarted.
  *      -EPERM   :       General Failure.
  *  Requires:
  *      PROC Initialized.
@@ -175,8 +171,6 @@ extern dsp_status proc_enum_nodes(void *hprocessor,
  *      -EBADR:    The processor is not in the PROC_RUNNING state.
  *      -ETIME:       A timeout occured before the DSP responded to the
  *			  querry.
- *      DSP_ERESTART:       A Critical error has occured and the DSP is being
- *			  restarted.
  *      -EPERM   :       Unable to get Resource Information
  *  Requires:
  *      resource_info is not NULL.
@@ -322,11 +316,6 @@ extern dsp_status proc_get_trace(void *hprocessor, u8 * pbuf, u32 max_size);
  *      0:       Success.
  *      -ENOENT:       The DSP Execuetable was not found.
  *      -EFAULT:       Invalid processor handle.
- *      DSP_ECORRUTFILE:    Unable to Parse the DSP Execuetable
- *      DSP_EATTACHED:      Abort because a GPP Client is attached to the
- *			  specified Processor
- *      DSP_EACCESSDENIED:  Client does not have the required access rights
- *			  to reset and load the Processor
  *      -EPERM   :       Unable to Load the Processor
  *  Requires:
  *      user_args is not NULL
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index 5a8a922..13de4b7 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -201,7 +201,6 @@ extern dsp_status strm_get_info(struct strm_object *hStrm,
  *      0:        Success.
  *      -EFAULT:    Invalid hStrm.
  *      -ETIME:   A timeout occurred before the stream could be idled.
- *      DSP_ERESTART:   A critical error occurred, DSP is being restarted.
  *      -EPERM:      Unable to idle stream.
  *  Requires:
  *      strm_init(void) called.
-- 
1.7.1

