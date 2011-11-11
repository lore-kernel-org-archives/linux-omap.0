From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 05/20] OMAP2+: UART: Remove mapbase/membase fields from pdata.
Date: Fri, 11 Nov 2011 15:27:22 +0530
Message-ID: <1321005446-21741-6-git-send-email-govindraj.raja@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab1KKJ6l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 04:58:41 -0500
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

The mapbase (start_address), membase(io_remap cookie) part of
pdata struct omap_uart_port_info are removed as this should be
derived within driver.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    2 --
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 --
 drivers/tty/serial/omap-serial.c              |   10 ++++++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0de1a56..beb46e8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -605,8 +605,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	omap_up.dma_enabled = uart->dma_enabled;
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
-	omap_up.mapbase = oh->slaves[0]->addr->pa_start;
-	omap_up.membase = omap_hwmod_get_mpu_rt_va(oh);
 	omap_up.flags = UPF_BOOT_AUTOCONF;
 
 	pdata = &omap_up;
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 307cd6f..db9bda9 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -59,8 +59,6 @@
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
-	void __iomem		*membase;	/* ioremap cookie or NULL */
-	resource_size_t		mapbase;	/* resource base */
 	upf_t			flags;		/* UPF_* flags */
 };
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index be368cf7..31f0cbf 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1275,8 +1275,14 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.ops = &serial_omap_pops;
 	up->port.line = pdev->id;
 
-	up->port.membase = omap_up_info->membase;
-	up->port.mapbase = omap_up_info->mapbase;
+	up->port.mapbase = mem->start;
+	up->port.membase = ioremap(mem->start, resource_size(mem));
+	if (!up->port.membase) {
+		dev_err(&pdev->dev, "can't ioremap UART\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	up->port.flags = omap_up_info->flags;
 	up->port.uartclk = omap_up_info->uartclk;
 	up->uart_dma.uart_base = mem->start;
-- 
1.7.4.1

