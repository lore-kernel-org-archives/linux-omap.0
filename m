From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] DSP: Fix dsp_common.c compile breakage
Date: Mon, 17 Mar 2008 21:50:49 +0200
Message-ID: <1205783450-16673-2-git-send-email-me@felipebalbi.com>
References: <1205783450-16673-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37136 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbYCQTsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 15:48:43 -0400
In-Reply-To: <1205783450-16673-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>

Recent changes broke compilation for omap1.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/dsp/dspgateway/dsp_common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/dspgateway/dsp_common.c b/drivers/dsp/dspgateway/dsp_common.c
index af97ce1..aeeadf4 100644
--- a/drivers/dsp/dspgateway/dsp_common.c
+++ b/drivers/dsp/dspgateway/dsp_common.c
@@ -478,7 +478,7 @@ void dsp_cpustat_set_icrmask(u16 mask)
 	mutex_unlock(&cpustat.lock);
 }
 
-#ifdef CONFIG_ARCH_OMAP1
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
 void omap_dsp_request_mpui(void)
 {
 	mutex_lock(&cpustat.lock);
@@ -594,7 +594,7 @@ void dsp_unregister_mem_cb(void) { }
 
 arch_initcall(omap_dsp_init);
 
-#ifdef CONFIG_ARCH_OMAP1
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
 EXPORT_SYMBOL(omap_dsp_request_mpui);
 EXPORT_SYMBOL(omap_dsp_release_mpui);
 EXPORT_SYMBOL(omap_dsp_request_mem);
-- 
1.5.4.3.447.gc95b3

