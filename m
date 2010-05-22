From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/14] omap: mailbox: use correct config for omap1
Date: Sat, 22 May 2010 20:14:16 +0300
Message-ID: <1274548465-20208-6-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab0EVROn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:14:43 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so383709bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:14:43 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

CONFIG_OMAP_DSP is not in mainline, CONFIG_OMAP_MBOX_FWK is.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 462b59c..da796f2 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -63,7 +63,7 @@ static void omap_init_rtc(void)
 static inline void omap_init_rtc(void) {}
 #endif
 
-#if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
+#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
 #if defined(CONFIG_ARCH_OMAP15XX)
 #  define OMAP1_MBOX_SIZE	0x23
-- 
1.7.1

