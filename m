From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/4] arm: plat-omap: add DT support for ti,dm816-timer
Date: Fri, 13 Nov 2015 17:30:02 +0100
Message-ID: <5646100A.6050701@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

Adds ti,dm816-timer to the dmtimer OF match table.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/plat-omap/dmtimer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8ca94d3..28a6550 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -943,6 +943,10 @@ static const struct of_device_id omap_timer_match[] = {
 		.compatible = "ti,am335x-timer-1ms",
 		.data = &omap3plus_pdata,
 	},
+	{
+		.compatible = "ti,dm816-timer",
+		.data = &omap3plus_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
-- 
1.9.1
