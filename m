From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 3/4] omap: move detection of NAND CS to common-board-devices
Date: Wed, 4 May 2011 00:10:56 -0400
Message-ID: <44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il> <e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il> <724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: multipart/mixed; boundary=Apple-Mail-46--242458343
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:45933 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab1EDELM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 00:11:12 -0400
In-Reply-To: <724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--Apple-Mail-46--242458343
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Ok, so here's a simple patch to save everyone trouble, I guess.

Though on the other hand I can imagine that perhaps including this =
generic common-board-devices.c
might not be desirable for people that don't use anything from that =
file.
Would it be a better idea to split it to a file-per-feature?


--Apple-Mail-46--242458343
Content-Disposition: attachment;
	filename=compile-fix.diff
Content-Type: application/octet-stream;
	name="compile-fix.diff"
Content-Transfer-Encoding: 7bit

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index d57c71d..6660279 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -50,6 +50,9 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
@@ -105,7 +108,9 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
+#endif
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 static struct omap_nand_platform_data nand_data = {
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
 };
@@ -146,3 +151,4 @@ void __init omap_nand_flash_init(int options, struct mtd_partition *parts,
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
+#endif

--Apple-Mail-46--242458343--
