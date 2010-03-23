From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/10] dsp-bridge: deh: improve logging stuff
Date: Tue, 23 Mar 2010 23:25:36 +0200
Message-ID: <1269379542-11892-5-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46268 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0CWV0L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:11 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292192bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:10 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Get rid of printk, use dev_foo, and prettify the output.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |   33 ++++++++++++---------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index fae036f..0c29442 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -182,9 +182,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			&resources);
 
 	if (MEM_IS_VALID_HANDLE(deh_mgr_obj, SIGNATURE)) {
-		printk(KERN_INFO
-				"bridge_deh_notify: ********** DEVICE EXCEPTION "
-				"**********\n");
+		dev_info(bridge, "%s: device exception\n", __func__);
 		dev_context =
 			(struct wmd_dev_context *)deh_mgr_obj->hwmd_context;
 
@@ -196,9 +194,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			deh_mgr_obj->err_info.dw_val2 = 0L;
 			deh_mgr_obj->err_info.dw_val3 = 0L;
 			deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
-			printk(KERN_ERR
-					"bridge_deh_notify: DSP_SYSERROR, err_info "
-					"= 0x%x\n", dwErrInfo);
+			dev_err(bridge, "%s: %s, err_info = 0x%x\n",
+					__func__, "DSP_SYSERROR", dwErrInfo);
 			break;
 		case DSP_MMUFAULT:
 			/*
@@ -206,18 +203,13 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			 * structure.
 			 */
 			deh_mgr_obj->err_info.dw_err_mask = DSP_MMUFAULT;
-			printk(KERN_INFO "bridge_deh_notify: DSP_MMUFAULT,"
-					"err_info = 0x%x\n", dwErrInfo);
-			printk(KERN_INFO
-					"bridge_deh_notify: DSP_MMUFAULT, High "
-					"Address = 0x%x\n",
-					(unsigned int)deh_mgr_obj->err_info.dw_val1);
-			printk(KERN_INFO "bridge_deh_notify: DSP_MMUFAULT, Low "
-					"Address = 0x%x\n",
-					(unsigned int)deh_mgr_obj->err_info.dw_val2);
-			printk(KERN_INFO
-					"bridge_deh_notify: DSP_MMUFAULT, fault "
-					"address = 0x%x\n", (unsigned int)fault_addr);
+			dev_info(bridge, "%s: %s, err_info = 0x%x\n",
+					__func__, "DSP_MMUFAULT", dwErrInfo);
+			dev_info(bridge, "%s: %s, high=0x%x, low=0x%x, fault=0x%x\n",
+					__func__, "DSP_MMUFAULT",
+					(unsigned int) deh_mgr->err_info.dw_val1,
+					(unsigned int) deh_mgr->err_info.dw_val2,
+					(unsigned int) fault_addr);
 			dummy_va_addr =
 				(u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
 			mem_physical =
@@ -257,9 +249,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			deh_mgr_obj->err_info.dw_val2 = 0L;
 			deh_mgr_obj->err_info.dw_val3 = 0L;
 			deh_mgr_obj->err_info.dw_val1 = dwErrInfo;
-			printk(KERN_ERR
-					"bridge_deh_notify: DSP_PWRERROR, err_info "
-					"= 0x%x\n", dwErrInfo);
+			dev_err(bridge, "%s: %s, err_info = 0x%x\n",
+					__func__, "DSP_PWRERROR", dwErrInfo);
 			break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
 		default:
-- 
1.7.0.3

