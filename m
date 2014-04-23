From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 11/13] tty: serial: omap: remove unneeded singlethread workqueue
Date: Wed, 23 Apr 2014 09:58:35 -0500
Message-ID: <1398265117-11793-11-git-send-email-balbi@ti.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398265117-11793-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, grant.likely@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

it wasn't used by anything, just remove it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6654682..ab22dab 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -180,8 +180,6 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 /* Forward declaration of functions */
 static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
 
-static struct workqueue_struct *serial_omap_uart_wq;
-
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
 	offset <<= up->port.regshift;
@@ -1701,7 +1699,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->calc_latency = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
 	pm_qos_add_request(&up->pm_qos_request,
 		PM_QOS_CPU_DMA_LATENCY, up->latency);
-	serial_omap_uart_wq = create_singlethread_workqueue(up->name);
 	INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
 
 	platform_set_drvdata(pdev, up);
-- 
1.9.2.459.g68773ac
