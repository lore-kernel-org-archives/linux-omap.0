From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [RFC PATCH 02/10] ZOOM: QUART: Request reset GPIO
Date: Mon, 16 May 2011 17:11:36 +0530
Message-ID: <1305546104-1511-3-git-send-email-tarun.kanti@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48338 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab1EPLlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 07:41:53 -0400
In-Reply-To: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

From: Charulatha V <charu@ti.com>

Reset GPIO (OMAP_GPIO_152) for QUART in zoom2/zoom3 debug-board is
not requested at all. This would lead to problems if this GPIO is
wrongly requested. Hence request OMAP GPIO 152 for QUART RESET but
do not apply a reset pulse as it would reset QUART and
disturb the QUART settings.

Signed-off-by: Charulatha V <charu@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index 007ebdc..a5f62f8 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -22,6 +22,7 @@
 #define ZOOM_SMSC911X_GPIO	158
 #define ZOOM_QUADUART_CS	3
 #define ZOOM_QUADUART_GPIO	102
+#define ZOOM_QUADUART_RST_GPIO	152
 #define QUART_CLK		1843200
 #define DEBUG_BASE		0x08000000
 #define ZOOM_ETHR_START	DEBUG_BASE
@@ -110,6 +111,14 @@ static inline void __init zoom_init_quaduart(void)
 	unsigned long cs_mem_base;
 	int quart_gpio = 0;
 
+	if (gpio_request_one(ZOOM_QUADUART_RST_GPIO,
+				GPIOF_OUT_INIT_LOW,
+				"TL16CP754C GPIO") < 0) {
+		pr_err("Failed to request GPIO%d for TL16CP754C\n",
+			ZOOM_QUADUART_RST_GPIO);
+		return;
+	}
+
 	quart_cs = ZOOM_QUADUART_CS;
 
 	if (gpmc_cs_request(quart_cs, SZ_1M, &cs_mem_base) < 0) {
-- 
1.7.1
