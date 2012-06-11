From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 4/9] ARM: OMAP2+: gpmc-tusb6010: Adapt to use gpmc driver
Date: Mon, 11 Jun 2012 20:29:33 +0530
Message-ID: <9c6c6b0298e37b1985a89e2cd99c35504521a1da.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33370 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab2FKPPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 11:15:13 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for tusb6010. As
gpmc driver is now present, populate details needed for the
driver to configure gpmc, gpmc driver would configure based
on this information. Old interface has been left as is so
that platforms can continue configuring gpmc using old
interface too. This is done so that driver conversion can
be done gradually without breaking any.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c     |  113 +++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/gpmc.h |    8 +++
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index db84a46..0e17337 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -22,9 +22,26 @@
 
 #include "mux.h"
 
+#define	CS_ASYNC_IDX	0
+#define	CS_SYNC_IDX	1
+#define	CS_NUM		2
+
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
+static struct resource tusb_resource = {
+	.name	= "mc",
+	.flags	= IORESOURCE_IRQ,
+};
+
+static struct gpmc_cs_data gpmc_tusb_cs_data[CS_NUM];
+
+static struct gpmc_device_pdata gpmc_tusb_data = {
+	.name		= "musb-tusb",
+	.id		= -1,
+	.per_res	= &tusb_resource,
+	.per_res_cnt	= 1,
+};
 
 /* t2_ps, when quantized to fclk units, must happen no earlier than
  * the clock after after t1_NS.
@@ -106,7 +123,14 @@ static int tusb_set_async_mode(unsigned sysclk_ps, unsigned fclk_ps)
 	tmp = t.cs_wr_off * 1000 + 7000 /* t_acsn_rdy_z */;
 	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
 
-	return gpmc_cs_set_timings(async_cs, &t);
+	/* gpmc driver interface */
+	if (gpmc_tusb_data.pdata != NULL) {
+		gpmc_tusb_cs_data[CS_ASYNC_IDX].time_ctrl.type = has_period;
+		gpmc_tusb_cs_data[CS_ASYNC_IDX].time_ctrl.timings = t;
+		return 0;
+	/* old interface */
+	} else
+		return gpmc_cs_set_timings(async_cs, &t);
 }
 
 static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
@@ -174,7 +198,16 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
 	tmp = t.cs_wr_off * 1000 + 7000 /* t_scsn_rdy_z */;
 	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
 
-	return gpmc_cs_set_timings(sync_cs, &t);
+	t.clk_activation = gpmc_ticks_to_ns(1);
+
+	/* gpmc driver interface */
+	if (gpmc_tusb_data.pdata != NULL) {
+		gpmc_tusb_cs_data[CS_SYNC_IDX].time_ctrl.type = has_period;
+		gpmc_tusb_cs_data[CS_SYNC_IDX].time_ctrl.timings = t;
+		return 0;
+	/* old interface */
+	} else
+		return gpmc_cs_set_timings(sync_cs, &t);
 }
 
 extern unsigned long gpmc_get_fclk_period(void);
@@ -348,3 +381,79 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 	}
 	return 0;
 }
+
+struct gpmc_device_pdata *
+__init gpmc_tusb6010_update(struct musb_hdrc_platform_data *data,
+		unsigned ps_refclk, unsigned waitpin,
+		unsigned async, unsigned sync,
+		unsigned irq, unsigned dmachan)
+{
+	int ret;
+
+	if (!data) {
+		pr_err("error: %s: data: NULL\n", __func__);
+		return NULL;
+	}
+
+	gpmc_tusb_data.pdata = data;
+	gpmc_tusb_data.pdata_size = sizeof(*data);
+
+	/* ASYNC region, primarily for PIO */
+	gpmc_tusb_cs_data[CS_ASYNC_IDX].cs = async;
+	gpmc_tusb_cs_data[CS_ASYNC_IDX].mem_size = 0x1000;
+
+	async_cs = async;
+
+	gpmc_tusb_cs_data[CS_ASYNC_IDX].have_config = true;
+	gpmc_tusb_cs_data[CS_ASYNC_IDX].config = waitpin |
+		GPMC_CONFIG1_DEVICESIZE_16 | GPMC_CONFIG1_WAIT_READ_MON |
+		GPMC_CONFIG1_WAIT_WRITE_MON | GPMC_CONFIG1_READTYPE_ASYNC |
+		GPMC_CONFIG1_WRITETYPE_ASYNC | GPMC_CONFIG1_DEVICETYPE_NOR |
+		GPMC_CONFIG1_MUXADDDATA | GPMC_CONFIG1_PAGE_LEN_16;
+
+	/* SYNC region, primarily for DMA */
+	gpmc_tusb_cs_data[CS_SYNC_IDX].cs = sync;
+	gpmc_tusb_cs_data[CS_SYNC_IDX].mem_size	= 0x1000;
+
+	sync_cs = sync;
+
+	gpmc_tusb_cs_data[CS_SYNC_IDX].have_config = true;
+	gpmc_tusb_cs_data[CS_SYNC_IDX].config = waitpin |
+		GPMC_CONFIG1_DEVICESIZE_16 | GPMC_CONFIG1_WAIT_READ_MON |
+		GPMC_CONFIG1_WAIT_WRITE_MON | GPMC_CONFIG1_READTYPE_SYNC |
+		GPMC_CONFIG1_WRITETYPE_SYNC | GPMC_CONFIG1_DEVICETYPE_NOR |
+		GPMC_CONFIG1_MUXADDDATA | GPMC_CONFIG1_READMULTIPLE_SUPP |
+		GPMC_CONFIG1_WRITEMULTIPLE_SUPP | GPMC_CONFIG1_PAGE_LEN_16;
+
+	/* IRQ */
+	ret = gpio_request_one(irq, GPIOF_IN, "TUSB6010 irq");
+	if (ret < 0) {
+		pr_err("error: %s: gpio_request_one: %d\n", __func__, ret);
+		return NULL;
+	}
+	tusb_resource.start = irq + IH_GPIO_BASE;
+
+	if (!ps_refclk) {
+		pr_err("error: %s: ps_refclk: 0\n", __func__);
+		return NULL;
+	}
+	refclk_psec = ps_refclk;
+	tusb6010_platform_retime(1);
+
+	if (dmachan) {
+		if (dmachan & (1 << 0))
+			omap_mux_init_signal("sys_ndmareq0", 0);
+		if (dmachan & (1 << 1))
+			omap_mux_init_signal("sys_ndmareq1", 0);
+		if (dmachan & (1 << 2))
+			omap_mux_init_signal("sys_ndmareq2", 0);
+		if (dmachan & (1 << 3))
+			omap_mux_init_signal("sys_ndmareq3", 0);
+		if (dmachan & (1 << 4))
+			omap_mux_init_signal("sys_ndmareq4", 0);
+		if (dmachan & (1 << 5))
+			omap_mux_init_signal("sys_ndmareq5", 0);
+	}
+
+	return &gpmc_tusb_data;
+}
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 32d7f3d..25fb27d 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -11,6 +11,8 @@
 #ifndef __OMAP2_GPMC_H
 #define __OMAP2_GPMC_H
 
+#include <linux/usb/musb.h>
+
 /* Maximum Number of Chip Selects */
 #define GPMC_CS_NUM		8
 
@@ -250,6 +252,12 @@ extern int gpmc_nand_write(int cs, int cmd, int wval);
 
 extern int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *c);
 
+/* A better place would have been musb.h, but as it is now in include/linux/
+ */
+extern struct gpmc_device_pdata *
+gpmc_tusb6010_update(struct musb_hdrc_platform_data *data, unsigned ps_refclk,
+				unsigned waitpin, unsigned async, unsigned sync,
+				unsigned irq, unsigned dmachan);
 int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size);
 int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code);
 
-- 
1.7.10.2

