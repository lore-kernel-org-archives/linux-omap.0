From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/14] omap: mailbox: 2420 should be detected at run-time
Date: Sat, 22 May 2010 20:14:15 +0300
Message-ID: <1274548465-20208-5-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57665 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab0EVROn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:14:43 -0400
Received: by bwz7 with SMTP id 7so383738bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:14:41 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

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

