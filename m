From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/4] omap-serial: Use default clock speed (48Mhz) if not specified
Date: Tue, 22 Nov 2011 19:14:14 +0530
Message-ID: <1321969456-24266-3-git-send-email-rnayak@ti.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Use a default clock speed of 48Mhz, instead of ending up with 0,
if platforms fail to specify a valid clock speed.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/tty/serial/omap-serial.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a02cc9f..f14b9c5 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -43,6 +43,8 @@
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 
+#define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
+
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -1386,6 +1388,11 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	up->port.flags = omap_up_info->flags;
 	up->port.uartclk = omap_up_info->uartclk;
+	if (!up->port.uartclk) {
+		up->port.uartclk = DEFAULT_CLK_SPEED;
+		dev_warn(&pdev->dev, "No clock speed specified: using default:"
+						"%d\n", DEFAULT_CLK_SPEED);
+	}
 	up->uart_dma.uart_base = mem->start;
 	up->errata = omap_up_info->errata;
 
-- 
1.7.1

