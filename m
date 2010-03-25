From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 13/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ETIMEOUT -> ETIME)
Date: Fri, 26 Mar 2010 01:36:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB29@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37031 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:10 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 3ee3b989bd4607e80f4eab52ac4e338f25ffc5d3 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 11:55:35 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ETIMEOUT -> ETIME).

This patch replaces DSP_ETIMEOUT with ETIME

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/disp.h    |    8 ++++----
 arch/arm/plat-omap/include/dspbridge/errbase.h |    4 ----
 arch/arm/plat-omap/include/dspbridge/mgr.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/node.h    |   16 ++++++++--------
 arch/arm/plat-omap/include/dspbridge/proc.h    |    4 ++--
 arch/arm/plat-omap/include/dspbridge/pwr.h     |    8 ++++----
 arch/arm/plat-omap/include/dspbridge/strm.h    |    6 +++---
 arch/arm/plat-omap/include/dspbridge/wmd.h     |    4 ++--
 drivers/dsp/bridge/rmgr/disp.c                 |    4 ++--
 drivers/dsp/bridge/rmgr/node.c                 |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                 |    6 +++---
 drivers/dsp/bridge/services/sync.c             |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c               |    2 +-
 13 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/disp.h b/arch/arm/plat-omap/include/dspbridge/disp.h
index 81b6b38..4188a1e 100644
--- a/arch/arm/plat-omap/include/dspbridge/disp.h
+++ b/arch/arm/plat-omap/include/dspbridge/disp.h
@@ -105,7 +105,7 @@ extern bool disp_init(void);
  *      prio:              New priority level to set node's priority to.
  *  Returns:
  *      DSP_SOK:                Success.
- *      DSP_ETIMEOUT:           A timeout occurred before the DSP responded.
+ *      ETIME:           A timeout occurred before the DSP responded.
  *  Requires:
  *      disp_init(void) called.
  *      Valid hDispObject.
@@ -134,7 +134,7 @@ extern dsp_status disp_node_change_priority(struct disp_object
  *      DSP_SOK:        Success.
  *      DSP_ETASK:      Unable to create the node's task or process on the DSP.
  *      DSP_ESTREAM:    Stream creation failure on the DSP.
- *      DSP_ETIMEOUT:   A timeout occurred before the DSP responded.
+ *      ETIME:   A timeout occurred before the DSP responded.
  *      DSP_EUSER:      A user-defined failure occurred.
  *      DSP_EFAIL:      A failure occurred, unable to create node.
  *  Requires:
@@ -166,7 +166,7 @@ extern dsp_status disp_node_create(struct disp_object *hDispObject,
  *      node_env:        Address of node's environment structure.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_ETIMEOUT:   A timeout occurred before the DSP responded.
+ *      ETIME:   A timeout occurred before the DSP responded.
  *  Requires:
  *      disp_init(void) called.
  *      Valid hDispObject.
@@ -192,7 +192,7 @@ extern dsp_status disp_node_delete(struct disp_object *hDispObject,
  *      node_env:        Address of node's environment structure.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_ETIMEOUT:   A timeout occurred before the DSP responded.
+ *      ETIME:   A timeout occurred before the DSP responded.
  *  Requires:
  *      disp_init(void) called.
  *      Valid hDispObject.
diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 87667a6..874054c 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -105,10 +105,6 @@
 /* A task creation failure occurred on the DSP. */
 #define DSP_ETASK                   (DSP_EBASE + 0x16)

-/* A timeout occurred before the requested operation could complete. */
-
-#define DSP_ETIMEOUT                (DSP_EBASE + 0x17)
-
 /* A data truncation occurred, e.g., when requesting a descriptive error
  * string, not enough space was allocated for the complete error message. */

diff --git a/arch/arm/plat-omap/include/dspbridge/mgr.h b/arch/arm/plat-omap/include/dspbridge/mgr.h
index c2e841c..f616ef5 100644
--- a/arch/arm/plat-omap/include/dspbridge/mgr.h
+++ b/arch/arm/plat-omap/include/dspbridge/mgr.h
@@ -34,7 +34,7 @@
  *      utimeout        : timeout interval in milliseocnds
  *  Returns:
  *      DSP_SOK         : Success.
- *      DSP_ETIMEOUT    : Wait timed out. *pu_index is undetermined.
+ *      ETIME    : Wait timed out. *pu_index is undetermined.
  *  Details:
  */

diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index aff4493..abd9f36 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -103,7 +103,7 @@ extern dsp_status node_alloc_msg_buf(struct node_object *hnode,
  *      EPERM:      The specified node is not a task node.
  *      DSP_EWRONGSTATE:    Node is not in the NODE_ALLOCATED, NODE_PAUSED,
  *                          or NODE_RUNNING state.
- *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
+ *      ETIME:       A timeout occurred before the DSP responded.
  *      DSP_ERESTART:       A critical error has occurred and the DSP is
  *                          being restarted.
  *      DSP_EFAIL:          Unable to change node's runtime priority level.
@@ -204,7 +204,7 @@ extern dsp_status node_connect(struct node_object *hNode1,
  *      ENOMEM:        Memory allocation failure on the DSP.
  *      DSP_ETASK:          Unable to create node's task or process on the DSP.
  *      DSP_ESTREAM:        Stream creation failure on the DSP.
- *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
+ *      ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EUSER1-16:      A user-defined failure occurred on the DSP.
  *      DSP_EFAIL:          A failure occurred, unable to create node.
  *  Requires:
@@ -251,7 +251,7 @@ extern dsp_status node_create_mgr(OUT struct node_mgr **phNodeMgr,
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
- *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
+ *      ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EDELETE:        A deletion failure occurred.
  *      DSP_EUSER1-16:      Node specific failure occurred on the DSP.
  *      DSP_EFAIL:          A failure occurred in deleting the node.
@@ -383,7 +383,7 @@ extern dsp_status node_get_attr(struct node_object *hnode,
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hnode.
  *      EPERM:  Cannot retrieve messages from this type of node.
- *      DSP_ETIMEOUT:   Timeout occurred and no message is available.
+ *      ETIME:   Timeout occurred and no message is available.
  *      DSP_EFAIL:      Error occurred while trying to retrieve a message.
  *  Requires:
  *      node_init(void) called.
@@ -444,7 +444,7 @@ void node_on_exit(struct node_object *hnode, s32 nStatus);
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
  *      EPERM:      Node is not a task or socket node.
- *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
+ *      ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_RUNNING state.
  *      DSP_EFAIL:          Failed to pause node.
  *  Requires:
@@ -468,7 +468,7 @@ extern dsp_status node_pause(struct node_object *hnode);
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
  *      EPERM:      Messages can't be sent to this type of node.
- *      DSP_ETIMEOUT:       Timeout occurred before message could be set.
+ *      ETIME:       Timeout occurred before message could be set.
  *      DSP_EWRONGSTATE:    Node is in invalid state for sending messages.
  *      DSP_EFAIL:          Unable to send message.
  *  Requires:
@@ -519,7 +519,7 @@ extern dsp_status node_register_notify(struct node_object *hnode,
  *      EFAULT:        Invalid hnode.
  *      EPERM:      hnode doesn't represent a message, task or dais
  *                          socket node.
- *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
+ *      ETIME:       A timeout occurred before the DSP responded.
  *      DSP_EWRONGSTSATE:   Node is not in NODE_PAUSED or NODE_CREATED state.
  *      DSP_EFAIL:          Unable to start or resume execution.
  *      DSP_ESYMBOL:        Execute function not found in the COFF file.
@@ -542,7 +542,7 @@ extern dsp_status node_run(struct node_object *hnode);
  *  Returns:
  *      DSP_SOK:            Success.
  *      EFAULT:        Invalid hnode.
- *      DSP_ETIMEOUT:       A timeout occurred before the DSP responded.
+ *      ETIME:       A timeout occurred before the DSP responded.
  *      EPERM:      Type of node specified cannot be terminated.
  *      DSP_EWRONGSTATE:    Operation not valid for the current node state.
  *      DSP_EFAIL:          Unable to terminate the node.
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 307f1fd..f77fa9a 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -87,7 +87,7 @@ extern dsp_status proc_auto_start(struct cfg_devnode *dev_node_obj,
  *  Returns:
  *      DSP_SOK     :       SUCCESS
  *      EFAULT :       Invalid processor handle.
- *      DSP_ETIMEOUT:       A Timeout Occured before the Control information
+ *      ETIME:       A Timeout Occured before the Control information
  *                       could be sent.
  *      DSP_EACCESSDENIED:  Client does not have the access rights required
  *                       to call this function.
@@ -171,7 +171,7 @@ extern dsp_status proc_enum_nodes(void *hprocessor,
  *      DSP_SOK     :       Success.
  *      EFAULT :       Invalid processor handle.
  *      DSP_EWRONGSTATE:    The processor is not in the PROC_RUNNING state.
- *      DSP_ETIMEOUT:       A timeout occured before the DSP responded to the
+ *      ETIME:       A timeout occured before the DSP responded to the
  *                       querry.
  *      DSP_ERESTART:       A Critical error has occured and the DSP is being
  *                       restarted.
diff --git a/arch/arm/plat-omap/include/dspbridge/pwr.h b/arch/arm/plat-omap/include/dspbridge/pwr.h
index f753833..3f0f54a 100644
--- a/arch/arm/plat-omap/include/dspbridge/pwr.h
+++ b/arch/arm/plat-omap/include/dspbridge/pwr.h
@@ -41,7 +41,7 @@
  *      DSP_SOK:            Success.
  *      DSP_SALREADYASLEEP: Success, but the DSP was already asleep.
  *      EINVAL:    The specified sleepCode is not supported.
- *      DSP_ETIMEOUT:       A timeout occured while waiting for DSP sleep
+ *      ETIME:       A timeout occured while waiting for DSP sleep
  *                          confirmation.
  *      DSP_EFAIL:          General failure, unable to send sleep command to
  *                          the DSP.
@@ -62,7 +62,7 @@ extern dsp_status pwr_sleep_dsp(IN CONST u32 sleepCode, IN CONST u32 timeout);
  *  Returns:
  *      DSP_SOK:            Success.
  *      DSP_SALREADYAWAKE:  Success, but the DSP was already awake.
- *      DSP_ETIMEOUT:       A timeout occured while waiting for wake
+ *      ETIME:       A timeout occured while waiting for wake
  *                          confirmation.
  *      DSP_EFAIL:          General failure, unable to send wake command to
  *                          the DSP.
@@ -80,7 +80,7 @@ extern dsp_status pwr_wake_dsp(IN CONST u32 timeout);
  *  Returns:
  *      DSP_SOK:            Success.
  *      DSP_SALREADYAWAKE:  Success, but the DSP was already awake.
- *      DSP_ETIMEOUT:       A timeout occured while waiting for wake
+ *      ETIME:       A timeout occured while waiting for wake
  *                          confirmation.
  *      DSP_EFAIL:          General failure, unable to send wake command to
  *                          the DSP.
@@ -98,7 +98,7 @@ extern dsp_status pwr_pm_pre_scale(IN u16 voltage_domain, u32 level);
  *  Returns:
  *      DSP_SOK:            Success.
  *      DSP_SALREADYAWAKE:  Success, but the DSP was already awake.
- *      DSP_ETIMEOUT:       A timeout occured while waiting for wake
+ *      ETIME:       A timeout occured while waiting for wake
  *                          confirmation.
  *      DSP_EFAIL:          General failure, unable to send wake command to
  *                          the DSP.
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index c598366..225f694 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -200,7 +200,7 @@ extern dsp_status strm_get_info(struct strm_object *hStrm,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hStrm.
- *      DSP_ETIMEOUT:   A timeout occurred before the stream could be idled.
+ *      ETIME:   A timeout occurred before the stream could be idled.
  *      DSP_ERESTART:   A critical error occurred, DSP is being restarted.
  *      DSP_EFAIL:      Unable to idle stream.
  *  Requires:
@@ -312,7 +312,7 @@ extern dsp_status strm_prepare_buffer(struct strm_object *hStrm,
  *  Returns:
  *      DSP_SOK:        Success.
  *      EFAULT:    Invalid hStrm.
- *      DSP_ETIMEOUT:   A timeout occurred before a buffer could be
+ *      ETIME:   A timeout occurred before a buffer could be
  *                      retrieved.
  *      DSP_EFAIL:      Failure occurred, unable to reclaim buffer.
  *  Requires:
@@ -366,7 +366,7 @@ extern dsp_status strm_register_notify(struct strm_object *hStrm,
  *      EDOM:     nStrms out of range.

  *      EFAULT:    Invalid stream handle in array.
- *      DSP_ETIMEOUT:   A timeout occurred before a stream became ready.
+ *      ETIME:   A timeout occurred before a stream became ready.
  *      DSP_EFAIL:      Failure occurred, unable to select a stream.
  *  Requires:
  *      strm_init(void) called.
diff --git a/arch/arm/plat-omap/include/dspbridge/wmd.h b/arch/arm/plat-omap/include/dspbridge/wmd.h
index 8624538..4f8b57f 100644
--- a/arch/arm/plat-omap/include/dspbridge/wmd.h
+++ b/arch/arm/plat-omap/include/dspbridge/wmd.h
@@ -961,7 +961,7 @@ typedef void (*fxn_msg_deletequeue) (struct msg_queue *msg_queue_obj);
  *      utimeout:      Timeout to wait for a message.
  *  Returns:
  *      DSP_SOK:       Success.
- *      DSP_ETIMEOUT:  Timeout occurred.
+ *      ETIME:  Timeout occurred.
  *      DSP_EFAIL:     No frames available for message (max_msgs too
  *                     small).
  *  Requires:
@@ -983,7 +983,7 @@ typedef dsp_status(*fxn_msg_get) (struct msg_queue *msg_queue_obj,
  *      utimeout:       Timeout to wait for a message.
  *  Returns:
  *      DSP_SOK:        Success.
- *      DSP_ETIMEOUT:   Timeout occurred.
+ *      ETIME:   Timeout occurred.
  *      DSP_EFAIL:      No frames available for message (max_msgs too
  *                      small).
  *  Requires:
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 2bf176c..c99c6cd 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -721,7 +721,7 @@ static dsp_status send_message(struct disp_object *disp_obj, u32 dwTimeout,
        if (DSP_SUCCEEDED(status)) {
                if (!CHNL_IS_IO_COMPLETE(chnl_ioc_obj)) {
                        if (CHNL_IS_TIMED_OUT(chnl_ioc_obj))
-                               status = DSP_ETIMEOUT;
+                               status = ETIME;
                        else
                                status = DSP_EFAIL;
                }
@@ -741,7 +741,7 @@ static dsp_status send_message(struct disp_object *disp_obj, u32 dwTimeout,
            (*intf_fxns->pfn_chnl_get_ioc) (chnl_obj, dwTimeout, &chnl_ioc_obj);
        if (DSP_SUCCEEDED(status)) {
                if (CHNL_IS_TIMED_OUT(chnl_ioc_obj)) {
-                       status = DSP_ETIMEOUT;
+                       status = ETIME;
                } else if (chnl_ioc_obj.byte_size < ul_bytes) {
                        /* Did not get all of the reply from the RMS */
                        status = DSP_EFAIL;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 5b44566..5c866e8 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2475,7 +2475,7 @@ dsp_status node_terminate(struct node_object *hnode, OUT dsp_status *pstatus)
                        status = sync_wait_on_event(hnode->sync_done,
                                                    kill_time_out / 2);
                        if (DSP_FAILED(status)) {
-                               if (status == DSP_ETIMEOUT) {
+                               if (status == ETIME) {
                                        status = (*intf_fxns->pfn_msg_put)
                                            (hnode->msg_queue_obj, &killmsg,
                                             hnode->utimeout);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 2c0dbbd..0a34abb 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -658,7 +658,7 @@ dsp_status strm_reclaim(struct strm_object *hStrm, OUT u8 ** buf_ptr,
                *pdw_arg = chnl_ioc_obj.dw_arg;
                if (!CHNL_IS_IO_COMPLETE(chnl_ioc_obj)) {
                        if (CHNL_IS_TIMED_OUT(chnl_ioc_obj)) {
-                               status = DSP_ETIMEOUT;
+                               status = ETIME;
                        } else {
                                /* Allow reclaims after idle to succeed */
                                if (!CHNL_IS_IO_CANCELLED(chnl_ioc_obj))
@@ -696,7 +696,7 @@ dsp_status strm_reclaim(struct strm_object *hStrm, OUT u8 ** buf_ptr,
 func_end:
        /* ensure we return a documented return code */
        DBC_ENSURE(DSP_SUCCEEDED(status) || status == EFAULT ||
-                  status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
+                  status == ETIME || status == DSP_ETRANSLATE ||
                   status == DSP_EFAIL);

        dev_dbg(bridge, "%s: hStrm: %p buf_ptr: %p pulBytes: %p pdw_arg: %p "
@@ -741,7 +741,7 @@ dsp_status strm_register_notify(struct strm_object *hStrm, u32 event_mask,
        }
        /* ensure we return a documented return code */
        DBC_ENSURE(DSP_SUCCEEDED(status) || status == EFAULT ||
-                  status == DSP_ETIMEOUT || status == DSP_ETRANSLATE ||
+                  status == ETIME || status == DSP_ETRANSLATE ||
                   status == ENOSYS || status == DSP_EFAIL);
        return status;
 }
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 6d095c6..00363aa 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -302,7 +302,7 @@ dsp_status sync_wait_on_multiple_events(struct sync_object **sync_events,

        }
        if (wp->signalling_event == NULL && DSP_SUCCEEDED(status))
-               status = DSP_ETIMEOUT;
+               status = ETIME;
        kfree(wp);
        return status;
 }
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 96488b9..7bcaaac 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -614,7 +614,7 @@ dsp_status bridge_chnl_get_ioc(struct chnl_object *chnl_obj, u32 dwTimeOut,
                        dwTimeOut = SYNC_INFINITE;

                stat_sync = sync_wait_on_event(pchnl->sync_event, dwTimeOut);
-               if (stat_sync == DSP_ETIMEOUT) {
+               if (stat_sync == ETIME) {
                        /* No response from DSP */
                        ioc.status |= CHNL_IOCSTATTIMEOUT;
                        dequeue_ioc = false;
--
1.6.0.4

