From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] ARM: OMAP2: Remove defines and resource init for
	OMAP24XX EAC
Date: Tue, 14 Apr 2009 14:55:41 -0700
Message-ID: <20090414215541.9878.60638.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61298 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZDNVzt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:55:49 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

There is no anymore legacy driver for OMAP24XX Enhanced Audio Controller
in linux-omap and it was newer in mainline so cleanup these unneeded
defines and initialization code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c         |   33 -----------
 arch/arm/plat-omap/include/mach/eac.h |  100 ---------------------------------
 2 files changed, 0 insertions(+), 133 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/eac.h

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d6b4b2f..496983a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,7 +25,6 @@
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
-#include <mach/eac.h>
 #include <mach/mmc.h>
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
@@ -366,38 +365,6 @@ static void omap_init_mcspi(void)
 static inline void omap_init_mcspi(void) {}
 #endif
 
-#ifdef CONFIG_SND_OMAP24XX_EAC
-
-#define OMAP2_EAC_BASE			0x48090000
-
-static struct resource omap2_eac_resources[] = {
-	{
-		.start		= OMAP2_EAC_BASE,
-		.end		= OMAP2_EAC_BASE + 0x109,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap2_eac_device = {
-	.name		= "omap24xx-eac",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(omap2_eac_resources),
-	.resource	= omap2_eac_resources,
-	.dev = {
-		.platform_data = NULL,
-	},
-};
-
-void omap_init_eac(struct eac_platform_data *pdata)
-{
-	omap2_eac_device.dev.platform_data = pdata;
-	platform_device_register(&omap2_eac_device);
-}
-
-#else
-void omap_init_eac(struct eac_platform_data *pdata) {}
-#endif
-
 #ifdef CONFIG_OMAP_SHA1_MD5
 static struct resource sha1_md5_resources[] = {
 	{
diff --git a/arch/arm/plat-omap/include/mach/eac.h b/arch/arm/plat-omap/include/mach/eac.h
deleted file mode 100644
index 9e62cf0..0000000
--- a/arch/arm/plat-omap/include/mach/eac.h
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach2/eac.h
- *
- * Defines for Enhanced Audio Controller
- *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
- *
- * Copyright (C) 2006 Nokia Corporation
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __ASM_ARM_ARCH_OMAP2_EAC_H
-#define __ASM_ARM_ARCH_OMAP2_EAC_H
-
-#include <mach/io.h>
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <sound/core.h>
-
-/* master codec clock source */
-#define EAC_MCLK_EXT_MASK	0x100
-enum eac_mclk_src {
-	EAC_MCLK_INT_11290000, /* internal 96 MHz / 8.5 = 11.29 Mhz */
-	EAC_MCLK_EXT_11289600 = EAC_MCLK_EXT_MASK,
-	EAC_MCLK_EXT_12288000,
-	EAC_MCLK_EXT_2x11289600,
-	EAC_MCLK_EXT_2x12288000,
-};
-
-/* codec port interface mode */
-enum eac_codec_mode {
-	EAC_CODEC_PCM,
-	EAC_CODEC_AC97,
-	EAC_CODEC_I2S_MASTER, /* codec port, I.e. EAC is the master */
-	EAC_CODEC_I2S_SLAVE,
-};
-
-/* configuration structure for I2S mode */
-struct eac_i2s_conf {
-	/* if enabled, then first data slot (left channel) is signaled as
-	 * positive level of frame sync EAC.AC_FS */
-	unsigned	polarity_changed_mode:1;
-	/* if enabled, then serial data starts one clock cycle after the
-	 * of EAC.AC_FS for first audio slot */
-	unsigned	sync_delay_enable:1;
-};
-
-/* configuration structure for EAC codec port */
-struct eac_codec {
-	enum eac_mclk_src	mclk_src;
-
-	enum eac_codec_mode	codec_mode;
-	union {
-		struct eac_i2s_conf	i2s;
-	} codec_conf;
-
-	int		default_rate; /* audio sampling rate */
-
-	int		(* set_power)(void *private_data, int dac, int adc);
-	int		(* register_controls)(void *private_data,
-					      struct snd_card *card);
-	const char 	*short_name;
-
-	void		*private_data;
-};
-
-/* structure for passing platform dependent data to the EAC driver */
-struct eac_platform_data {
-        int	(* init)(struct device *eac_dev);
-	void	(* cleanup)(struct device *eac_dev);
-	/* these callbacks are used to configure & control external MCLK
-	 * source. NULL if not used */
-	int	(* enable_ext_clocks)(struct device *eac_dev);
-	void	(* disable_ext_clocks)(struct device *eac_dev);
-};
-
-extern void omap_init_eac(struct eac_platform_data *pdata);
-
-extern int eac_register_codec(struct device *eac_dev, struct eac_codec *codec);
-extern void eac_unregister_codec(struct device *eac_dev);
-
-extern int eac_set_mode(struct device *eac_dev, int play, int rec);
-
-#endif /* __ASM_ARM_ARCH_OMAP2_EAC_H */

