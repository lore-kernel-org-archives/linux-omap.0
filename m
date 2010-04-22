From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 7/7] DSPBRIDGE: Change imode type to u8
Date: Wed, 21 Apr 2010 20:38:05 -0500
Message-ID: <1271900285-28994-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36676 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594Ab0DVBUS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 21:20:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Shivananda Hebbar <x0hebbar@ti.com>

From: Shivananda Hebbar <x0hebbar@ti.com>

imode is used to represent channel input or output mode.
It can take value either 0, 1 or 2. Hence changing it to u8.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c               |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index aa4d0cf..e2e4848 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -111,7 +111,7 @@ void io_mbox_msg(u32 msg);
  */
 extern void io_request_chnl(struct io_mgr *hio_mgr,
 			    struct chnl_object *pchnl,
-			    u32 iMode, OUT u16 *pwMbVal);
+			    u8 iMode, OUT u16 *pwMbVal);
 
 /*
  *  ======== iosm_schedule ========
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 3274ad3..cba8366 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -128,16 +128,16 @@ struct io_mgr {
 
 /* Function Prototypes */
 static void io_dispatch_chnl(IN struct io_mgr *pio_mgr,
-			     IN OUT struct chnl_object *pchnl, u32 iMode);
+				IN OUT struct chnl_object *pchnl, u8 iMode);
 static void io_dispatch_msg(IN struct io_mgr *pio_mgr,
 			    struct msg_mgr *hmsg_mgr);
 static void io_dispatch_pm(struct io_mgr *pio_mgr);
 static void notify_chnl_complete(struct chnl_object *pchnl,
 				 struct chnl_irp *chnl_packet_obj);
 static void input_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
-		       u32 iMode);
+			u8 iMode);
 static void output_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
-			u32 iMode);
+			u8 iMode);
 static void input_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr);
 static void output_msg(struct io_mgr *pio_mgr, struct msg_mgr *hmsg_mgr);
 static u32 find_ready_output(struct chnl_mgr *chnl_mgr_obj,
@@ -840,7 +840,7 @@ func_end:
  *      Proc-copy chanl dispatch.
  */
 static void io_dispatch_chnl(IN struct io_mgr *pio_mgr,
-			     IN OUT struct chnl_object *pchnl, u32 iMode)
+				IN OUT struct chnl_object *pchnl, u8 iMode)
 {
 	if (!MEM_IS_VALID_HANDLE(pio_mgr, IO_MGRSIGNATURE))
 		goto func_end;
@@ -1011,7 +1011,7 @@ void io_mbox_msg(u32 msg)
  *      interrupts the DSP.
  */
 void io_request_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
-		     u32 iMode, OUT u16 *pwMbVal)
+			u8 iMode, OUT u16 *pwMbVal)
 {
 	struct chnl_mgr *chnl_mgr_obj;
 	struct shm *sm;
@@ -1113,7 +1113,7 @@ func_end:
  *      Dispatch a buffer on an input channel.
  */
 static void input_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
-		       u32 iMode)
+			u8 iMode)
 {
 	struct chnl_mgr *chnl_mgr_obj;
 	struct shm *sm;
@@ -1399,7 +1399,7 @@ func_end:
  *      Dispatch a buffer on an output channel.
  */
 static void output_chnl(struct io_mgr *pio_mgr, struct chnl_object *pchnl,
-			u32 iMode)
+			u8 iMode)
 {
 	struct chnl_mgr *chnl_mgr_obj;
 	struct shm *sm;
-- 
1.6.2.4

