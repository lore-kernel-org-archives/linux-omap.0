From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] Fix compile issues for DSP
Date: Mon, 17 Mar 2008 17:48:22 +0200
Message-ID: <20080317154822.GB4775@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39156 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYCQP7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 11:59:25 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2HFx1iU028144
	for <linux-omap@vger.kernel.org>; Mon, 17 Mar 2008 17:59:22 +0200
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

diff --git a/include/asm-arm/arch-omap/dsp_common.h b/include/asm-arm/arch-omap/dsp_common.h
index e515801..0c7565e 100644
--- a/include/asm-arm/arch-omap/dsp_common.h
+++ b/include/asm-arm/arch-omap/dsp_common.h
@@ -49,7 +49,7 @@ struct omap_dsp {
 	int			initialized;
 };
 
-if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
+#if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_OMAP_MMU_FWK)
 extern void omap_dsp_request_mpui(void);
 extern void omap_dsp_release_mpui(void);
 extern int omap_dsp_request_mem(void);


-- 
	- Balbi
