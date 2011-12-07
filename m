From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omap: rx51: initialize isp1704 properly
Date: Wed,  7 Dec 2011 21:56:56 +0200
Message-ID: <1323287816-2809-1-git-send-email-felipe.contreras@gmail.com>
References: <20111207193141.GG31337@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111207193141.GG31337@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Heikki Krogerus <krohei@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Heikki Krogerus <krohei@gmail.com>

Without this USB networking doesn't work as the link is never detected.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index a1d0257..faac1fc 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -193,7 +193,7 @@ static struct platform_device rx51_charger_device = {
 static void __init rx51_charger_init(void)
 {
 	WARN_ON(gpio_request_one(RX51_USB_TRANSCEIVER_RST_GPIO,
-		GPIOF_OUT_INIT_LOW, "isp1704_reset"));
+		GPIOF_OUT_INIT_HIGH, "isp1704_reset"));
 
 	platform_device_register(&rx51_charger_device);
 }
-- 
1.7.8.rc1.14.g248db
