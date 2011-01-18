From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 7/7] arm: mach-omap1: board-voiceblue: add missing include
Date: Tue, 18 Jan 2011 09:52:45 +0200
Message-ID: <1295337165-22934-8-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:44488 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab1ARHwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:37 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Eliminates the following sparse warnings:

	arch/arm/mach-omap1/board-voiceblue.c:253:6: warning: symbol 'voiceblue_wdt_enable' was not declared. Should it be static?
	arch/arm/mach-omap1/board-voiceblue.c:261:6: warning: symbol 'voiceblue_wdt_disable' was not declared. Should it be static?
	arch/arm/mach-omap1/board-voiceblue.c:269:6: warning: symbol 'voiceblue_wdt_ping' was not declared. Should it be static?
	arch/arm/mach-omap1/board-voiceblue.c:278:6: warning: symbol 'voiceblue_reset' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-voiceblue.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 815a69c..9c1af41 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -30,6 +30,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/board-voiceblue.h>
 #include <plat/common.h>
 #include <mach/gpio.h>
 #include <plat/flash.h>
-- 
1.5.6.5

