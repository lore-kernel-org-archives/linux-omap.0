From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 16/20] OMAP2+: UART: remove temporary variable used to count uart instance
Date: Fri, 11 Nov 2011 15:31:49 +0530
Message-ID: <1321005712-21871-2-git-send-email-govindraj.raja@ti.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Reuse the num_uarts variable itself to count number of uarts.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5c6c48f..4d65d00 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -266,15 +266,13 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
 
 static int __init omap_serial_early_init(void)
 {
-	int i = 0;
-
 	do {
 		char oh_name[MAX_UART_HWMOD_NAME_LEN];
 		struct omap_hwmod *oh;
 		struct omap_uart_state *uart;
 
 		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
-			 "uart%d", i + 1);
+			 "uart%d", num_uarts + 1);
 		oh = omap_hwmod_lookup(oh_name);
 		if (!oh)
 			break;
@@ -284,9 +282,8 @@ static int __init omap_serial_early_init(void)
 			return -ENODEV;
 
 		uart->oh = oh;
-		uart->num = i++;
+		uart->num = num_uarts++;
 		list_add_tail(&uart->node, &uart_list);
-		num_uarts++;
 
 		/*
 		 * NOTE: omap_hwmod_setup*() has not yet been called,
-- 
1.7.4.1

