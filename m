From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/14] omap: mailbox: 2420 should be detected at run-time
Date: Fri, 11 Jun 2010 18:51:39 +0300
Message-ID: <1276271509-11983-5-git-send-email-felipe.contreras@gmail.com>
References: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60624 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565Ab0FKPw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 11:52:29 -0400
Received: by mail-wy0-f174.google.com with SMTP id 40so896647wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Jun 2010 08:52:28 -0700 (PDT)
In-Reply-To: <1276271509-11983-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index edcfec6..f67cb2c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -455,7 +455,8 @@ err_dsp:
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
 #if defined(CONFIG_ARCH_OMAP2420)
-	omap_mbox_unregister(&mbox_iva_info);
+	if (cpu_is_omap2420())
+		omap_mbox_unregister(&mbox_iva_info);
 #endif
 
 	if (cpu_is_omap44xx()) {
-- 
1.7.1

