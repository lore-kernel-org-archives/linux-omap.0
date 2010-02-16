From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 16/18] DSPBRIDGE: print dsp trace buffer by default
Date: Tue, 16 Feb 2010 02:42:26 -0600
Message-ID: <1266309748-11714-17-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-13-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-14-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-15-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-16-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59995 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497Ab0BPIaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:06 -0500
In-Reply-To: <1266309748-11714-16-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Print to console if the contents of the dsp trace buffer.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 3471ed5..e9de3fc 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -2010,8 +2010,7 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 			if (DSP_SUCCEEDED(status)) {
 				/* Pack and do newline conversion */
 				PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
-				GT_1trace(dsp_trace_mask, GT_1CLASS,
-					"DSP Trace Buffer:\n%s\n", pszBuf);
+				pr_info("%s:\n%s\n", __func__, pszBuf);
 			}
 			kfree(pszBuf);
 			kfree(lpszBuf);
-- 
1.6.2.4

