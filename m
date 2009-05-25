From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] ARM: OMAP2/3: Add generic onenand support when
	connected to GPMC, v2
Date: Mon, 25 May 2009 09:50:57 -0700
Message-ID: <20090525165056.GD29933@atomide.com>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234123.12760.11671.stgit@localhost> <20090525094345.GE28195@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56984 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZEYQvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 12:51:08 -0400
Content-Disposition: inline
In-Reply-To: <20090525094345.GE28195@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090525 02:43]:
> On Tue, May 19, 2009 at 04:41:23PM -0700, Tony Lindgren wrote:
> > +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> > +	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
> ...
> > +static void __init board_onenand_init(void)
> > +{
> > +	gpmc_onenand_init(&board_onenand_data);
> > +}
> > +
> > +#endif
> >  
> >  void __init rx51_peripherals_init(void)
> >  {
> > @@ -415,5 +466,6 @@ void __init rx51_peripherals_init(void)
> >  				ARRAY_SIZE(rx51_peripherals_devices));
> >  	rx51_i2c_init();
> >  	rx51_init_smc91x();
> > +	board_onenand_init();
> 
> This breaks without onenand support.
> 
> > diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> > new file mode 100644
> > index 0000000..712af59
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> > @@ -0,0 +1,340 @@
> > +/*
> > + * linux/arch/arm/mach-omap2/gpmc-onenand.c
> > + *
> > + * Copyright (C) 2006 - 2009 Nokia Corporation
> > + * Contacts:	Juha Yrjola
> > + *		Tony Lindgren
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <asm/mach/flash.h>
> > +#include <linux/mtd/onenand_regs.h>
> > +
> > +#include <linux/io.h>
> 
> linux/ includes together please (without asm/ includes mixed in).
> 
> > +static unsigned short omap2_onenand_readw(void __iomem *addr)
> > +{
> > +	return readw(addr);
> > +}
> > +
> > +static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
> > +{
> > +	writew(value, addr);
> > +}
> 
> These two are pointless.  Just use readw/writew directly.

Updated.
 
> > diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
> > index 4649d30..94cde73 100644
> > --- a/arch/arm/plat-omap/include/mach/onenand.h
> > +++ b/arch/arm/plat-omap/include/mach/onenand.h
> > @@ -9,8 +9,14 @@
> >   * published by the Free Software Foundation.
> >   */
> >  
> > +#include <linux/mtd/mtd.h>
> >  #include <linux/mtd/partitions.h>
> >  
> > +#ifndef __ASM_ARCH_OMAP_ONENAND_H__
> 
> This provides no protection against multiple includes on its own.  You're
> missing a #define of this symbol.

Removed, it should not be needed here.
 
> > +
> > +#define ONENAND_SYNC_READ	(1 << 0)
> > +#define ONENAND_SYNC_READWRITE	(1 << 1)
> > +
> >  struct omap_onenand_platform_data {
> >  	int			cs;
> >  	int			gpio_irq;
> > @@ -18,8 +24,27 @@ struct omap_onenand_platform_data {
> >  	int			nr_parts;
> >  	int                     (*onenand_setup)(void __iomem *, int freq);
> >  	int			dma_channel;
> > +	u8			flags;
> >  };
> >  
> > -int omap2_onenand_rephase(void);
> > -
> >  #define ONENAND_MAX_PARTITIONS 8
> > +
> > +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> > +	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
> > +
> > +extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
> > +
> > +#else
> > +
> > +#define board_onenand_data	NULL
> > +
> > +static inline void board_onenand_init(void)
> > +{
> > +}
> 
> Eww, you put it in a different file.  Disgusting.  Please put it in the
> _same_ file as the place it's used.
> 
> > +
> > +static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
> > +{
> > +}
> > +
> > +#endif
> > +#endif

Moved so it's local to each board-*.c file.

Updated patch below.

Regards,

Tony

--kXdP64Ggrk/fb43R
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gpmc-onenand-v2.patch"

>From 1cea2b823fffd69d4e1d7d9686e489bc5410ae0e Mon Sep 17 00:00:00 2001
From: Juha Yrjola <juha.yrjola@solidboot.com>
Date: Thu, 21 May 2009 09:11:32 -0700
Subject: [PATCH] ARM: OMAP2/3: Add generic onenand support when connected to GPMC

Add generic onenand support when connected to GPMC and make the
boards to use it.

The patch has been modified to make it more generic to support all
the boards with GPMC. The patch also remove unused prototype for
omap2_onenand_rephase(void).

Note that board-apollon.c is currently using the MTD_ONENAND_GENERIC
and setting the GPMC timings in the bootloader. Setting the GPMC
timings in the bootloader will not allow supporting frequency
scaling for the onenand source clock.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 593102d..eb2cb31 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -282,7 +282,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=4 root=ubi0:rootfs rootfstype=ubifs rw console=ttyMTD5"
+CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=tty0"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bf3827a..11f7f66 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -58,3 +58,6 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 ifeq ($(CONFIG_USB_MUSB_SOC),y)
 obj-y					+= usb-musb.o
 endif
+
+onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
+obj-y					+= $(onenand-m) $(onenand-y)
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index a738172..ca18ae9 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -27,6 +27,7 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/keypad.h>
+#include <mach/onenand.h>
 
 #include "mmc-twl4030.h"
 
@@ -408,6 +409,62 @@ static int __init rx51_i2c_init(void)
 	return 0;
 }
 
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition onenand_partitions[] = {
+	{
+		.name           = "bootloader",
+		.offset         = 0,
+		.size           = 0x20000,
+		.mask_flags     = MTD_WRITEABLE,	/* Force read-only */
+	},
+	{
+		.name           = "config",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x60000,
+	},
+	{
+		.name           = "log",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x40000,
+	},
+	{
+		.name           = "kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "initfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 0,
+	.gpio_irq	= 65,
+	.parts		= onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+};
+
+static void __init board_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#else
+
+static inline void board_onenand_init(void)
+{
+}
+
+#endif
 
 void __init rx51_peripherals_init(void)
 {
@@ -415,5 +472,6 @@ void __init rx51_peripherals_init(void)
 				ARRAY_SIZE(rx51_peripherals_devices));
 	rx51_i2c_init();
 	rx51_init_smc91x();
+	board_onenand_init();
 }
 
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
new file mode 100644
index 0000000..2fd22f9
--- /dev/null
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -0,0 +1,330 @@
+/*
+ * linux/arch/arm/mach-omap2/gpmc-onenand.c
+ *
+ * Copyright (C) 2006 - 2009 Nokia Corporation
+ * Contacts:	Juha Yrjola
+ *		Tony Lindgren
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/onenand_regs.h>
+#include <linux/io.h>
+
+#include <asm/mach/flash.h>
+
+#include <mach/onenand.h>
+#include <mach/board.h>
+#include <mach/gpmc.h>
+
+static struct omap_onenand_platform_data *gpmc_onenand_data;
+
+static struct platform_device gpmc_onenand_device = {
+	.name		= "omap2-onenand",
+	.id		= -1,
+};
+
+static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
+{
+	struct gpmc_timings t;
+
+	const int t_cer = 15;
+	const int t_avdp = 12;
+	const int t_aavdh = 7;
+	const int t_ce = 76;
+	const int t_aa = 76;
+	const int t_oe = 20;
+	const int t_cez = 20; /* max of t_cez, t_oez */
+	const int t_ds = 30;
+	const int t_wpl = 40;
+	const int t_wph = 30;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = 0;
+	t.cs_on = 0;
+	t.adv_on = 0;
+
+	/* Read */
+	t.adv_rd_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
+	t.oe_on  = t.adv_rd_off + gpmc_round_ns_to_ticks(t_aavdh);
+	t.access = t.adv_on + gpmc_round_ns_to_ticks(t_aa);
+	t.access = max_t(int, t.access, t.cs_on + gpmc_round_ns_to_ticks(t_ce));
+	t.access = max_t(int, t.access, t.oe_on + gpmc_round_ns_to_ticks(t_oe));
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle  = t.cs_rd_off + gpmc_round_ns_to_ticks(t_cez);
+
+	/* Write */
+	t.adv_wr_off = t.adv_rd_off;
+	t.we_on  = t.oe_on;
+	if (cpu_is_omap34xx()) {
+		t.wr_data_mux_bus = t.we_on;
+		t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
+	}
+	t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
+	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
+	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+
+	/* Configure GPMC for asynchronous read */
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
+static void set_onenand_cfg(void __iomem *onenand_base, int latency,
+				int sync_read, int sync_write, int hf)
+{
+	u32 reg;
+
+	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_BL_16;
+	if (sync_read)
+		reg |= ONENAND_SYS_CFG1_SYNC_READ;
+	else
+		reg &= ~ONENAND_SYS_CFG1_SYNC_READ;
+	if (sync_write)
+		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
+	else
+		reg &= ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	if (hf)
+		reg |= ONENAND_SYS_CFG1_HF;
+	else
+		reg &= ~ONENAND_SYS_CFG1_HF;
+	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+}
+
+static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
+					void __iomem *onenand_base,
+					int freq)
+{
+	struct gpmc_timings t;
+	const int t_cer  = 15;
+	const int t_avdp = 12;
+	const int t_cez  = 20; /* max of t_cez, t_oez */
+	const int t_ds   = 30;
+	const int t_wpl  = 40;
+	const int t_wph  = 30;
+	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
+	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
+	int first_time = 0, hf = 0, sync_read = 0, sync_write = 0;
+	int err, ticks_cez;
+	int cs = cfg->cs;
+	u32 reg;
+
+	if (cfg->flags & ONENAND_SYNC_READ) {
+		sync_read = 1;
+	} else if (cfg->flags & ONENAND_SYNC_READWRITE) {
+		sync_read = 1;
+		sync_write = 1;
+	}
+
+	if (!freq) {
+		/* Very first call freq is not known */
+		err = omap2_onenand_set_async_mode(cs, onenand_base);
+		if (err)
+			return err;
+		reg = readw(onenand_base + ONENAND_REG_VERSION_ID);
+		switch ((reg >> 4) & 0xf) {
+		case 0:
+			freq = 40;
+			break;
+		case 1:
+			freq = 54;
+			break;
+		case 2:
+			freq = 66;
+			break;
+		case 3:
+			freq = 83;
+			break;
+		case 4:
+			freq = 104;
+			break;
+		default:
+			freq = 54;
+			break;
+		}
+		first_time = 1;
+	}
+
+	switch (freq) {
+	case 83:
+		min_gpmc_clk_period = 12; /* 83 MHz */
+		t_ces   = 5;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 9;
+		break;
+	case 66:
+		min_gpmc_clk_period = 15; /* 66 MHz */
+		t_ces   = 6;
+		t_avds  = 5;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 11;
+		break;
+	default:
+		min_gpmc_clk_period = 18; /* 54 MHz */
+		t_ces   = 7;
+		t_avds  = 7;
+		t_avdh  = 7;
+		t_ach   = 9;
+		t_aavdh = 7;
+		t_rdyo  = 15;
+		sync_write = 0;
+		break;
+	}
+
+	tick_ns = gpmc_ticks_to_ns(1);
+	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
+	gpmc_clk_ns = gpmc_ticks_to_ns(div);
+	if (gpmc_clk_ns < 15) /* >66Mhz */
+		hf = 1;
+	if (hf)
+		latency = 6;
+	else if (gpmc_clk_ns >= 25) /* 40 MHz*/
+		latency = 3;
+	else
+		latency = 4;
+
+	if (first_time)
+		set_onenand_cfg(onenand_base, latency,
+					sync_read, sync_write, hf);
+
+	if (div == 1) {
+		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
+		reg |= (1 << 7);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
+		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
+		reg |= (1 << 7);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, reg);
+		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
+		reg |= (1 << 7);
+		reg |= (1 << 23);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
+	} else {
+		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
+		reg &= ~(1 << 7);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
+		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
+		reg &= ~(1 << 7);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, reg);
+		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
+		reg &= ~(1 << 7);
+		reg &= ~(1 << 23);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
+	}
+
+	/* Set synchronous read timings */
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = min_gpmc_clk_period;
+	t.cs_on = 0;
+	t.adv_on = 0;
+	fclk_offset_ns = gpmc_round_ns_to_ticks(max_t(int, t_ces, t_avds));
+	fclk_offset = gpmc_ns_to_ticks(fclk_offset_ns);
+	t.page_burst_access = gpmc_clk_ns;
+
+	/* Read */
+	t.adv_rd_off = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_avdh));
+	t.oe_on = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_ach));
+	t.access = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div);
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	ticks_cez = ((gpmc_ns_to_ticks(t_cez) + div - 1) / div) * div;
+	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
+		     ticks_cez);
+
+	/* Write */
+	if (sync_write) {
+		t.adv_wr_off = t.adv_rd_off;
+		t.we_on  = 0;
+		t.we_off = t.cs_rd_off;
+		t.cs_wr_off = t.cs_rd_off;
+		t.wr_cycle  = t.rd_cycle;
+		if (cpu_is_omap34xx()) {
+			t.wr_data_mux_bus = gpmc_ticks_to_ns(fclk_offset +
+					gpmc_ns_to_ticks(min_gpmc_clk_period +
+					t_rdyo));
+			t.wr_access = t.access;
+		}
+	} else {
+		t.adv_wr_off = gpmc_round_ns_to_ticks(max_t(int,
+							t_avdp, t_cer));
+		t.we_on  = t.adv_wr_off + gpmc_round_ns_to_ticks(t_aavdh);
+		t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
+		t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
+		t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+		if (cpu_is_omap34xx()) {
+			t.wr_data_mux_bus = t.we_on;
+			t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
+		}
+	}
+
+	/* Configure GPMC for synchronous read */
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_WRAPBURST_SUPP |
+			  GPMC_CONFIG1_READMULTIPLE_SUPP |
+			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
+			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
+			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
+			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
+			  GPMC_CONFIG1_PAGE_LEN(2) |
+			  (cpu_is_omap34xx() ? 0 :
+				(GPMC_CONFIG1_WAIT_READ_MON |
+				 GPMC_CONFIG1_WAIT_PIN_SEL(0))) |
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	err = gpmc_cs_set_timings(cs, &t);
+	if (err)
+		return err;
+
+	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf);
+
+	return 0;
+}
+
+static int gpmc_onenand_setup(void __iomem *onenand_base, int freq)
+{
+	struct device *dev = &gpmc_onenand_device.dev;
+
+	/* Set sync timings in GPMC */
+	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
+			freq) < 0) {
+		dev_err(dev, "Unable to set synchronous mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
+{
+	gpmc_onenand_data = _onenand_data;
+	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
+	gpmc_onenand_device.dev.platform_data = gpmc_onenand_data;
+
+	if (cpu_is_omap24xx() &&
+			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
+		printk(KERN_ERR "Onenand using only SYNC_READ on 24xx\n");
+		gpmc_onenand_data->flags &= ~ONENAND_SYNC_READWRITE;
+		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
+	}
+
+	if (platform_device_register(&gpmc_onenand_device) < 0) {
+		printk(KERN_ERR "Unable to register OneNAND device\n");
+		return;
+	}
+}
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index 4649d30..72f433d 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -9,8 +9,12 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#define ONENAND_SYNC_READ	(1 << 0)
+#define ONENAND_SYNC_READWRITE	(1 << 1)
+
 struct omap_onenand_platform_data {
 	int			cs;
 	int			gpio_irq;
@@ -18,8 +22,22 @@ struct omap_onenand_platform_data {
 	int			nr_parts;
 	int                     (*onenand_setup)(void __iomem *, int freq);
 	int			dma_channel;
+	u8			flags;
 };
 
-int omap2_onenand_rephase(void);
-
 #define ONENAND_MAX_PARTITIONS 8
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
+
+#else
+
+#define board_onenand_data	NULL
+
+static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
+{
+}
+
+#endif

--kXdP64Ggrk/fb43R--
