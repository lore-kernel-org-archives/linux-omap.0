From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 3/3] OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
Date: Wed, 21 Mar 2012 15:55:01 +0530
Message-ID: <1332325501-10467-4-git-send-email-govindraj.raja@ti.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Govindraj.R" <govindraj.raja@ti.com>

Minor cleanup, replace all omap34xx/omap44xx cpu checks with
cpu is not omap24xx check.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 330ee04..83ab5a2 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -377,8 +377,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->dev_attr = uart;
 
-	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
-			&& !uart_debug)
+	if ((!cpu_is_omap24xx() && bdata->pads)	&& !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 }
 
@@ -401,7 +400,7 @@ void __init omap_serial_board_init(struct omap_uart_port_info *info)
 		bdata.pads = NULL;
 		bdata.pads_cnt = 0;
 
-		if (cpu_is_omap44xx() || cpu_is_omap34xx())
+		if (!cpu_is_omap24xx())
 			omap_serial_fill_default_pads(&bdata);
 
 		if (!info)
-- 
1.7.5.4

