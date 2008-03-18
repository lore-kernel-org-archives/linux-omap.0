From: David Brownell <david-b@pacbell.net>
Subject: another dsp build fix ...
Date: Mon, 17 Mar 2008 20:41:12 -0800
Message-ID: <200803172141.12298.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:33449 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752560AbYCRElO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2008 00:41:14 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Another compile fix for DSP code ... these symbols are defined
as NOPs in a header.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/dsp/dspgateway/dsp_common.c |    4 ++++
 1 files changed, 4 insertions(+)

--- osk2.orig/drivers/dsp/dspgateway/dsp_common.c	2008-03-17 21:03:13.000000000 -0700
+++ osk2/drivers/dsp/dspgateway/dsp_common.c	2008-03-17 21:03:16.000000000 -0700
@@ -502,6 +502,7 @@ void omap_dsp_release_mpui(void)
 	mutex_unlock(&cpustat.lock);
 }
 
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
 int omap_dsp_request_mem(void)
 {
 	int ret = 0;
@@ -564,6 +565,7 @@ int omap_dsp_release_mem(void)
 
 	return 0;
 }
+#endif
 
 void dsp_register_mem_cb(int (*req_cb)(void), void (*rel_cb)(void))
 {
@@ -597,8 +599,10 @@ arch_initcall(omap_dsp_init);
 #ifdef CONFIG_ARCH_OMAP1
 EXPORT_SYMBOL(omap_dsp_request_mpui);
 EXPORT_SYMBOL(omap_dsp_release_mpui);
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
 EXPORT_SYMBOL(omap_dsp_request_mem);
 EXPORT_SYMBOL(omap_dsp_release_mem);
+#endif
 #endif /* CONFIG_ARCH_OMAP1 */
 
 #ifdef CONFIG_OMAP_DSP_MODULE
