From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] arm: omap: io: fix compile warning
Date: Thu, 13 Jan 2011 13:41:06 +0200
Message-ID: <1294918868-16263-3-git-send-email-balbi@ti.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34105 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932891Ab1AMLlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:41:24 -0500
Received: by mail-gy0-f169.google.com with SMTP id 10so693212gyd.14
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:41:23 -0800 (PST)
In-Reply-To: <1294918868-16263-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

if building a kernel without MULTI_OMAP
support, we will see a warning such as:

arch/arm/mach-omap2/io.c: In function 'omap_irq_base_init':
arch/arm/mach-omap2/io.c:322:23: warning: unused variable 'omap_irq_base'

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..6e81223 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -319,9 +319,9 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
  */
 static inline void omap_irq_base_init(void)
 {
+#ifdef MULTI_OMAP2
 	extern void __iomem *omap_irq_base;
 
-#ifdef MULTI_OMAP2
 	if (cpu_is_omap24xx())
 		omap_irq_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
 	else if (cpu_is_omap34xx())
-- 
1.7.3.4.598.g85356

