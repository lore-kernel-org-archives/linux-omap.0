From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] arm: omap: clockdomain: fix compile error
Date: Thu, 13 Jan 2011 13:41:08 +0200
Message-ID: <1294918868-16263-5-git-send-email-balbi@ti.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44968 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932891Ab1AMLle (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:41:34 -0500
Received: by mail-gw0-f46.google.com with SMTP id 20so632262gwj.33
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:41:34 -0800 (PST)
In-Reply-To: <1294918868-16263-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

If building OMAP4-only kernel, we will see
the following compile error:

arch/arm/mach-omap2/clockdomain.c: In function '_enable_hwsup':
arch/arm/mach-omap2/clockdomain.c:251:18: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:254:18: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function '_disable_hwsup':
arch/arm/mach-omap2/clockdomain.c:277:12: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:280:12: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_sleep':
arch/arm/mach-omap2/clockdomain.c:744:17: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_wakeup':
arch/arm/mach-omap2/clockdomain.c:789:18: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_clk_enable':
arch/arm/mach-omap2/clockdomain.c:922:13: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:926:15: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function
'omap2_clkdm_clk_disable':
arch/arm/mach-omap2/clockdomain.c:994:13: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:998:15: error: 'struct clockdomain'
has no member named 'clktrctrl_mask'
make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1

Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clockdomain.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index de3faa2..092256d 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -103,7 +103,8 @@ struct clockdomain {
 		const char *name;
 		struct powerdomain *ptr;
 	} pwrdm;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 	const u16 clktrctrl_mask;
 #endif
 	const u8 flags;
-- 
1.7.3.4.598.g85356

