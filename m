From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] arm/omap: use const char properly
Date: Thu,  6 Jun 2013 15:24:38 +0200
Message-ID: <1370525079-22195-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40706 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3FFNYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 09:24:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The itention was probably to make both pointers const but as it is now,
it is just const used twice.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1272c41..54e4c16 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -601,7 +601,7 @@ void __init omap2_set_globals_tap(u32 class, void __iomem *tap)
 
 #ifdef CONFIG_SOC_BUS
 
-static const char const *omap_types[] = {
+static const char * const omap_types[] = {
 	[OMAP2_DEVICE_TYPE_TEST]	= "TST",
 	[OMAP2_DEVICE_TYPE_EMU]		= "EMU",
 	[OMAP2_DEVICE_TYPE_SEC]		= "HS",
-- 
1.7.10.4

