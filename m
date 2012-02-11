From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP: serial: Release the claimed memory region in remove
Date: Sat, 11 Feb 2012 13:03:27 +0530
Message-ID: <1328945607-4025-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently the memory region is not released the folowing error is
observed.

/testsuites # insmod omap-serial.ko
[  130.746917] omap_uart omap_uart.0: memory region already claimed
[  130.753143] omap_uart: probe of omap_uart.0 failed with error -16
[  130.759338] omap_uart omap_uart.1: memory region already claimed
[  130.765380] omap_uart: probe of omap_uart.1 failed with error -16
[  130.771606] omap_uart omap_uart.2: memory region already claimed
[  130.777679] omap_uart: probe of omap_uart.2 failed with error -16
[  130.783905] omap_uart omap_uart.3: memory region already claimed
[  130.789947] omap_uart: probe of omap_uart.3 failed with error -16

Fix it by releasing the memory region.

Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
changes from the rfc version - 
move the release after the unmap.

 drivers/tty/serial/omap-serial.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 8c6f137..16aa4f0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1480,9 +1480,12 @@ do_release_region:
 static int serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
+	struct resource		*r;
 
 	if (up) {
 		iounmap(up->port.membase);
+		r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+		release_mem_region(r->start, resource_size(r));
 		pm_runtime_disable(&up->pdev->dev);
 		uart_remove_one_port(&serial_omap_reg, &up->port);
 		pm_qos_remove_request(&up->pm_qos_request);
-- 
1.7.1

