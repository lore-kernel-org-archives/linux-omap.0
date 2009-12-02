From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFT/RFC/PATCH 02/10] arm: omap: n770: make it build again
Date: Thu,  3 Dec 2009 00:28:24 +0200
Message-ID: <1259792912-11328-3-git-send-email-felipe.balbi@nokia.com>
References: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47881 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbZLBW2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 17:28:50 -0500
In-Reply-To: <1259792912-11328-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

there's no <plat/omapfb.h> it's now under <linux/omapfb.h>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index af4d719..db9a1de 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -20,6 +20,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
+#include <linux/omapfb.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -33,7 +34,6 @@
 #include <plat/keypad.h>
 #include <plat/common.h>
 #include <plat/dsp_common.h>
-#include <plat/omapfb.h>
 #include <plat/hwa742.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
-- 
1.6.6.rc0

