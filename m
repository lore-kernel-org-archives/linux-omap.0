Received: from mailkram.bugwerft.de (mailkram.bugwerft.de [95.216.200.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDE59B681
	for <linux-omap@vger.kernel.org>; Tue,  8 Sep 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.200.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892763; cv=none; b=kPBM4O198pNGYbuDrz1kJfC6tTnkIjYsp+1TzNO26UHNbkVlr1d79Fmw/r1nXFZv9a7fJZYTGhlCG8LHX3TifXu/pABQpNP83SUXjiIn55Il+/y7kkmBKjvo4x82JPiY1HuB++KH5LFrKy9mkaoYc29i+L44Rlt6ON+gCpxxPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892763; c=relaxed/simple;
	bh=CnEzzZCQoxvVOhx60g2g0Wco5tq/l6MytmbslRsrUks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJiIBvuBSKOwebqbP90AMToww/IG9xPtQ1GeG+uZagMlK+9Nh08gvDNO5/d5ENo9DtbneD9P+dr7FLYyGTS5R9ORD74AMtgWqChVS1wpuKlmw5uyR0rljQz2hBGT4hg40ioW69FvIOWiZmV3wRIdmgjocZSuxXTM0ei2NGTcS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zonque.org; spf=pass smtp.mailfrom=zonque.org; dkim=pass (1024-bit key) header.d=zonque.org header.i=@zonque.org header.b=Hrovq4rO; arc=none smtp.client-ip=95.216.200.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zonque.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zonque.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zonque.org header.i=@zonque.org header.b="Hrovq4rO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zonque.org; s=mail;
	t=1788892373; bh=CnEzzZCQoxvVOhx60g2g0Wco5tq/l6MytmbslRsrUks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hrovq4rOr7THXruNZ0fZ7eazu4Rn5mp1GesvRjuQ6bVVg/yMTjMuOLFpyhAqIgtFl
	 /e3JGhvMlelKhNxN6TIgUx3gke7jC7Ud/J8/KPL+1JKJIExZxgnKNE2sXsq+yMA7Le
	 ItwQ/05iIe7MWQN2gCEzGrGQYke9ad6h7OaUacCM=
Received: from [192.168.100.82] (p5de47f98.dip0.t-ipconnect.de [93.228.127.152])
	by mailkram.bugwerft.de (Postfix) with ESMTPSA id 3F0CD3E81A;
	Tue,  8 Sep 2026 18:32:50 +0000 (UTC)
Message-ID: <e75fb76b-bdb7-46f0-996f-df9da8e99dfe@zonque.org>
Date: Tue, 8 Sep 2026 20:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ARM: remove legacy pxa board files
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-5-arnd@kernel.org>
Content-Language: en-US
From: Daniel Mack <daniel@zonque.org>
In-Reply-To: <20260908152808.3928630-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.41

On 9/8/26 17:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The PXA platform supports devicetree based booting, but still has a
> few traditional board files, which were left as a starting point for a
> possible conversion to devicetree during the last mass purge of board
> files in 2022.
> 
> None of these boards were actually converted, so drop support for these
> now, along with the 'scoop' support chip that was used on some PDAs that
> are no longer usable now.
> 
> The only remaining board support is for the "Raumfeld" speaker system
> based on PXA300 SoC, though basic support for PXA250 and PXA270 is still
> there and may work with external dts files.
> 
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Daniel Mack <daniel@zonque.org>



> ---
>  arch/arm/boot/compressed/Makefile         |    4 -
>  arch/arm/boot/compressed/head-sharpsl.S   |  151 ---
>  arch/arm/common/Kconfig                   |    6 -
>  arch/arm/common/Makefile                  |    2 -
>  arch/arm/common/scoop.c                   |  269 -----
>  arch/arm/common/sharpsl_param.c           |   63 --
>  arch/arm/configs/am200epdkit_defconfig    |   91 --
>  arch/arm/configs/spitz_defconfig          |  237 -----
>  arch/arm/include/asm/hardware/scoop.h     |   67 --
>  arch/arm/include/asm/mach/sharpsl_param.h |   33 -
>  arch/arm/mach-pxa/Kconfig                 |   89 --
>  arch/arm/mach-pxa/Makefile                |    8 -
>  arch/arm/mach-pxa/am200epd.c              |  395 -------
>  arch/arm/mach-pxa/am300epd.c              |  296 ------
>  arch/arm/mach-pxa/devices.c               |  705 -------------
>  arch/arm/mach-pxa/devices.h               |   68 --
>  arch/arm/mach-pxa/generic.h               |    5 -
>  arch/arm/mach-pxa/gumstix.c               |  237 -----
>  arch/arm/mach-pxa/gumstix.h               |   89 --
>  arch/arm/mach-pxa/pxa25x.c                |   59 --
>  arch/arm/mach-pxa/pxa27x.c                |   77 --
>  arch/arm/mach-pxa/pxa300.c                |    1 -
>  arch/arm/mach-pxa/pxa320.c                |    1 -
>  arch/arm/mach-pxa/pxa3xx.c                |    6 -
>  arch/arm/mach-pxa/sharpsl_pm.c            |  941 -----------------
>  arch/arm/mach-pxa/sharpsl_pm.h            |  108 --
>  arch/arm/mach-pxa/spitz.c                 | 1174 ---------------------
>  arch/arm/mach-pxa/spitz.h                 |  185 ----
>  arch/arm/mach-pxa/spitz_pm.c              |  257 -----
>  29 files changed, 5624 deletions(-)
>  delete mode 100644 arch/arm/boot/compressed/head-sharpsl.S
>  delete mode 100644 arch/arm/common/scoop.c
>  delete mode 100644 arch/arm/common/sharpsl_param.c
>  delete mode 100644 arch/arm/configs/am200epdkit_defconfig
>  delete mode 100644 arch/arm/configs/spitz_defconfig
>  delete mode 100644 arch/arm/include/asm/hardware/scoop.h
>  delete mode 100644 arch/arm/include/asm/mach/sharpsl_param.h
>  delete mode 100644 arch/arm/mach-pxa/am200epd.c
>  delete mode 100644 arch/arm/mach-pxa/am300epd.c
>  delete mode 100644 arch/arm/mach-pxa/devices.h
>  delete mode 100644 arch/arm/mach-pxa/gumstix.c
>  delete mode 100644 arch/arm/mach-pxa/gumstix.h
>  delete mode 100644 arch/arm/mach-pxa/sharpsl_pm.c
>  delete mode 100644 arch/arm/mach-pxa/sharpsl_pm.h
>  delete mode 100644 arch/arm/mach-pxa/spitz.c
>  delete mode 100644 arch/arm/mach-pxa/spitz.h
>  delete mode 100644 arch/arm/mach-pxa/spitz_pm.c
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 32def10f5e03..232b646bfd26 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -29,10 +29,6 @@ ifeq ($(CONFIG_CPU_XSCALE),y)
>  OBJS		+= head-xscale.o
>  endif
>  
> -ifeq ($(CONFIG_PXA_SHARPSL_DETECT_MACH_ID),y)
> -OBJS		+= head-sharpsl.o
> -endif
> -
>  ifeq ($(CONFIG_CPU_ENDIAN_BE32),y)
>  ifeq ($(CONFIG_CPU_CP15),y)
>  OBJS		+= big-endian.o
> diff --git a/arch/arm/boot/compressed/head-sharpsl.S b/arch/arm/boot/compressed/head-sharpsl.S
> deleted file mode 100644
> index 992e784500fa..000000000000
> --- a/arch/arm/boot/compressed/head-sharpsl.S
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * linux/arch/arm/boot/compressed/head-sharpsl.S
> - *
> - * Copyright (C) 2004-2005 Richard Purdie <rpurdie@rpsys.net>
> - *
> - * Sharp's bootloader doesn't pass any kind of machine ID
> - * so we have to figure out the machine for ourselves...
> - *
> - * Support for Poodle, Corgi (SL-C700), Shepherd (SL-C750)
> - * Husky (SL-C760), Tosa (SL-C6000), Spitz (SL-C3000),
> - * Akita (SL-C1000) and Borzoi (SL-C3100).
> - *
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/mach-types.h>
> -
> -#ifndef CONFIG_PXA_SHARPSL
> -#error What am I doing here...
> -#endif
> -
> -		.section        ".start", "ax"
> -
> -__SharpSL_start:
> -
> -/* Check for TC6393 - if found we have a Tosa */
> -	ldr	r7, .TOSAID
> -	mov	r1, #0x10000000		@ Base address of TC6393 chip
> -	mov 	r6, #0x03
> -	ldrh	r3, [r1, #8]		@ Load TC6393XB Revison: This is 0x0003
> -	cmp	r6, r3
> -	beq	.SHARPEND		@ Success -> tosa
> -
> -/* Check for pxa270 - if found, branch */
> -	mrc p15, 0, r4, c0, c0		@ Get Processor ID
> -	and	r4, r4, #0xffffff00
> -	ldr	r3, .PXA270ID
> -	cmp	r4, r3
> -	beq	.PXA270
> -
> -/* Check for w100 - if not found we have a Poodle */
> -	ldr	r1, .W100ADDR		@ Base address of w100 chip + regs offset
> -
> -	mov r6, #0x31			@ Load Magic Init value
> -	str	r6, [r1, #0x280]	@ to SCRATCH_UMSK
> -	mov r5, #0x3000
> -.W100LOOP:
> -	subs r5, r5, #1
> -	bne .W100LOOP
> -	mov r6, #0x30			@ Load 2nd Magic Init value
> -	str	r6, [r1, #0x280]	@ to SCRATCH_UMSK
> -
> -	ldr	r6, [r1, #0]		@ Load Chip ID
> -	ldr	r3, .W100ID
> -	ldr	r7, .POODLEID
> -	cmp	r6, r3
> -	bne	.SHARPEND			@ We have no w100 - Poodle
> -
> -/* Check for pxa250 - if found we have a Corgi */
> -	ldr	r7, .CORGIID
> -	ldr	r3, .PXA255ID
> -	cmp	r4, r3
> -	blo	.SHARPEND			@ We have a PXA250 - Corgi
> -
> -/* Check for 64MiB flash - if found we have a Shepherd */
> -	bl	get_flash_ids
> -	ldr	r7, .SHEPHERDID
> -	cmp	r3, #0x76			@ 64MiB flash
> -	beq	.SHARPEND			@ We have Shepherd
> -
> -/* Must be a Husky */
> -	ldr	r7, .HUSKYID		@ Must be Husky
> -	b .SHARPEND
> -
> -.PXA270:
> -/* Check for 16MiB flash - if found we have Spitz */
> -	bl	get_flash_ids
> -	ldr	r7, .SPITZID
> -	cmp	r3, #0x73			@ 16MiB flash
> -	beq	.SHARPEND			@ We have Spitz
> -
> -/* Check for a second SCOOP chip - if found we have Borzoi */
> -	ldr	r1, .SCOOP2ADDR
> -	ldr	r7, .BORZOIID
> -	mov 	r6, #0x0140
> -	strh	r6, [r1]
> -	ldrh	r6, [r1]
> -	cmp	r6, #0x0140
> -	beq	.SHARPEND			@ We have Borzoi
> -
> -/* Must be Akita */
> -	ldr	r7, .AKITAID
> -	b	.SHARPEND			@ We have Borzoi
> -
> -.PXA255ID:
> -	.word	0x69052d00		@ PXA255 Processor ID
> -.PXA270ID:
> -	.word	0x69054100		@ PXA270 Processor ID
> -.W100ID:
> -	.word	0x57411002		@ w100 Chip ID
> -.W100ADDR:
> -	.word 	0x08010000		@ w100 Chip ID Reg Address
> -.SCOOP2ADDR:
> -	.word	0x08800040
> -.POODLEID:
> -	.word	MACH_TYPE_POODLE
> -.CORGIID:
> -	.word	MACH_TYPE_CORGI
> -.SHEPHERDID:
> -	.word	MACH_TYPE_SHEPHERD
> -.HUSKYID:
> -	.word	MACH_TYPE_HUSKY
> -.TOSAID:
> -	.word	MACH_TYPE_TOSA
> -.SPITZID:
> -	.word	MACH_TYPE_SPITZ
> -.AKITAID:
> -	.word	MACH_TYPE_AKITA
> -.BORZOIID:
> -	.word	MACH_TYPE_BORZOI
> -
> -/*
> - * Return: r2 - NAND Manufacturer ID
> - *         r3 - NAND Chip ID
> - * Corrupts: r1
> - */
> -get_flash_ids:
> -	mov	r1, #0x0c000000		@ Base address of NAND chip
> -	ldrb	r3, [r1, #24]		@ Load FLASHCTL
> -	bic	r3, r3, #0x11		@ SET NCE
> -	orr	r3, r3, #0x0a		@ SET CLR + FLWP
> -	strb	r3, [r1, #24]		@ Save to FLASHCTL
> -	mov 	r2, #0x90		@ Command "readid"
> -	strb	r2, [r1, #20]		@ Save to FLASHIO
> -	bic	r3, r3, #2		@ CLR CLE
> -	orr	r3, r3, #4		@ SET ALE
> -	strb	r3, [r1, #24]		@ Save to FLASHCTL
> -	mov	r2, #0			@ Address 0x00
> -	strb	r2, [r1, #20]		@ Save to FLASHIO
> -	bic	r3, r3, #4		@ CLR ALE
> -	strb	r3, [r1, #24]		@ Save to FLASHCTL
> -.fids1:
> -	ldrb	r3, [r1, #24]		@ Load FLASHCTL
> -	tst	r3, #32			@ Is chip ready?
> -	beq	.fids1
> -	ldrb	r2, [r1, #20]		@ NAND Manufacturer ID
> -	ldrb	r3, [r1, #20]		@ NAND Chip ID
> -	mov	pc, lr
> -
> -.SHARPEND:
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index d72dccf6f3c2..cf75be68d05c 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -1,9 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config KRAIT_L2_ACCESSORS
>  	bool
> -
> -config SHARP_PARAM
> -	bool
> -
> -config SHARP_SCOOP
> -	bool
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index e1bcc250874f..1935b23700b0 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -6,8 +6,6 @@
>  obj-y				+= firmware.o
>  
>  obj-$(CONFIG_KRAIT_L2_ACCESSORS) += krait-l2-accessors.o
> -obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
> -obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>  obj-$(CONFIG_CPU_V7)		+= secure_cntvoff.o
>  obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
>  CFLAGS_REMOVE_mcpm_entry.o	= -pg
> diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
> deleted file mode 100644
> index 90474994757c..000000000000
> --- a/arch/arm/common/scoop.c
> +++ /dev/null
> @@ -1,269 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Support code for the SCOOP interface found on various Sharp PDAs
> - *
> - * Copyright (c) 2004 Richard Purdie
> - *
> - *	Based on code written by Sharp/Lineo for 2.4 kernels
> - */
> -
> -#include <linux/device.h>
> -#include <linux/gpio/driver.h>
> -#include <linux/string.h>
> -#include <linux/slab.h>
> -#include <linux/platform_device.h>
> -#include <linux/export.h>
> -#include <linux/io.h>
> -#include <asm/hardware/scoop.h>
> -
> -/* PCMCIA to Scoop linkage
> -
> -   There is no easy way to link multiple scoop devices into one
> -   single entity for the pxa2xx_pcmcia device so this structure
> -   is used which is setup by the platform code.
> -
> -   This file is never modular so this symbol is always
> -   accessile to the board support files.
> -*/
> -struct scoop_pcmcia_config *platform_scoop_config;
> -EXPORT_SYMBOL(platform_scoop_config);
> -
> -struct  scoop_dev {
> -	void __iomem *base;
> -	struct gpio_chip gpio;
> -	spinlock_t scoop_lock;
> -	unsigned short suspend_clr;
> -	unsigned short suspend_set;
> -	u32 scoop_gpwr;
> -};
> -
> -void reset_scoop(struct device *dev)
> -{
> -	struct scoop_dev *sdev = dev_get_drvdata(dev);
> -
> -	iowrite16(0x0100, sdev->base + SCOOP_MCR);  /* 00 */
> -	iowrite16(0x0000, sdev->base + SCOOP_CDR);  /* 04 */
> -	iowrite16(0x0000, sdev->base + SCOOP_CCR);  /* 10 */
> -	iowrite16(0x0000, sdev->base + SCOOP_IMR);  /* 18 */
> -	iowrite16(0x00FF, sdev->base + SCOOP_IRM);  /* 14 */
> -	iowrite16(0x0000, sdev->base + SCOOP_ISR);  /* 1C */
> -	iowrite16(0x0000, sdev->base + SCOOP_IRM);
> -}
> -
> -static void __scoop_gpio_set(struct scoop_dev *sdev,
> -			unsigned offset, int value)
> -{
> -	unsigned short gpwr;
> -
> -	gpwr = ioread16(sdev->base + SCOOP_GPWR);
> -	if (value)
> -		gpwr |= 1 << (offset + 1);
> -	else
> -		gpwr &= ~(1 << (offset + 1));
> -	iowrite16(gpwr, sdev->base + SCOOP_GPWR);
> -}
> -
> -static int scoop_gpio_set(struct gpio_chip *chip, unsigned int offset,
> -			  int value)
> -{
> -	struct scoop_dev *sdev = gpiochip_get_data(chip);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&sdev->scoop_lock, flags);
> -
> -	__scoop_gpio_set(sdev, offset, value);
> -
> -	spin_unlock_irqrestore(&sdev->scoop_lock, flags);
> -
> -	return 0;
> -}
> -
> -static int scoop_gpio_get(struct gpio_chip *chip, unsigned offset)
> -{
> -	struct scoop_dev *sdev = gpiochip_get_data(chip);
> -
> -	/* XXX: I'm unsure, but it seems so */
> -	return !!(ioread16(sdev->base + SCOOP_GPRR) & (1 << (offset + 1)));
> -}
> -
> -static int scoop_gpio_direction_input(struct gpio_chip *chip,
> -			unsigned offset)
> -{
> -	struct scoop_dev *sdev = gpiochip_get_data(chip);
> -	unsigned long flags;
> -	unsigned short gpcr;
> -
> -	spin_lock_irqsave(&sdev->scoop_lock, flags);
> -
> -	gpcr = ioread16(sdev->base + SCOOP_GPCR);
> -	gpcr &= ~(1 << (offset + 1));
> -	iowrite16(gpcr, sdev->base + SCOOP_GPCR);
> -
> -	spin_unlock_irqrestore(&sdev->scoop_lock, flags);
> -
> -	return 0;
> -}
> -
> -static int scoop_gpio_direction_output(struct gpio_chip *chip,
> -			unsigned offset, int value)
> -{
> -	struct scoop_dev *sdev = gpiochip_get_data(chip);
> -	unsigned long flags;
> -	unsigned short gpcr;
> -
> -	spin_lock_irqsave(&sdev->scoop_lock, flags);
> -
> -	__scoop_gpio_set(sdev, offset, value);
> -
> -	gpcr = ioread16(sdev->base + SCOOP_GPCR);
> -	gpcr |= 1 << (offset + 1);
> -	iowrite16(gpcr, sdev->base + SCOOP_GPCR);
> -
> -	spin_unlock_irqrestore(&sdev->scoop_lock, flags);
> -
> -	return 0;
> -}
> -
> -unsigned short read_scoop_reg(struct device *dev, unsigned short reg)
> -{
> -	struct scoop_dev *sdev = dev_get_drvdata(dev);
> -	return ioread16(sdev->base + reg);
> -}
> -
> -void write_scoop_reg(struct device *dev, unsigned short reg, unsigned short data)
> -{
> -	struct scoop_dev *sdev = dev_get_drvdata(dev);
> -	iowrite16(data, sdev->base + reg);
> -}
> -
> -EXPORT_SYMBOL(reset_scoop);
> -EXPORT_SYMBOL(read_scoop_reg);
> -EXPORT_SYMBOL(write_scoop_reg);
> -
> -#ifdef CONFIG_PM
> -static void check_scoop_reg(struct scoop_dev *sdev)
> -{
> -	unsigned short mcr;
> -
> -	mcr = ioread16(sdev->base + SCOOP_MCR);
> -	if ((mcr & 0x100) == 0)
> -		iowrite16(0x0101, sdev->base + SCOOP_MCR);
> -}
> -
> -static int scoop_suspend(struct platform_device *dev, pm_message_t state)
> -{
> -	struct scoop_dev *sdev = platform_get_drvdata(dev);
> -
> -	check_scoop_reg(sdev);
> -	sdev->scoop_gpwr = ioread16(sdev->base + SCOOP_GPWR);
> -	iowrite16((sdev->scoop_gpwr & ~sdev->suspend_clr) | sdev->suspend_set, sdev->base + SCOOP_GPWR);
> -
> -	return 0;
> -}
> -
> -static int scoop_resume(struct platform_device *dev)
> -{
> -	struct scoop_dev *sdev = platform_get_drvdata(dev);
> -
> -	check_scoop_reg(sdev);
> -	iowrite16(sdev->scoop_gpwr, sdev->base + SCOOP_GPWR);
> -
> -	return 0;
> -}
> -#else
> -#define scoop_suspend	NULL
> -#define scoop_resume	NULL
> -#endif
> -
> -static int scoop_probe(struct platform_device *pdev)
> -{
> -	struct scoop_dev *devptr;
> -	struct scoop_config *inf;
> -	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	int ret;
> -
> -	if (!mem)
> -		return -EINVAL;
> -
> -	devptr = kzalloc_obj(struct scoop_dev);
> -	if (!devptr)
> -		return -ENOMEM;
> -
> -	spin_lock_init(&devptr->scoop_lock);
> -
> -	inf = pdev->dev.platform_data;
> -	devptr->base = ioremap(mem->start, resource_size(mem));
> -
> -	if (!devptr->base) {
> -		ret = -ENOMEM;
> -		goto err_ioremap;
> -	}
> -
> -	platform_set_drvdata(pdev, devptr);
> -
> -	printk("Sharp Scoop Device found at 0x%08x -> 0x%8p\n",(unsigned int)mem->start, devptr->base);
> -
> -	iowrite16(0x0140, devptr->base + SCOOP_MCR);
> -	reset_scoop(&pdev->dev);
> -	iowrite16(0x0000, devptr->base + SCOOP_CPR);
> -	iowrite16(inf->io_dir & 0xffff, devptr->base + SCOOP_GPCR);
> -	iowrite16(inf->io_out & 0xffff, devptr->base + SCOOP_GPWR);
> -
> -	devptr->suspend_clr = inf->suspend_clr;
> -	devptr->suspend_set = inf->suspend_set;
> -
> -	devptr->gpio.base = -1;
> -
> -	if (inf->gpio_base != 0) {
> -		devptr->gpio.label = dev_name(&pdev->dev);
> -		devptr->gpio.base = inf->gpio_base;
> -		devptr->gpio.ngpio = 12; /* PA11 = 0, PA12 = 1, etc. up to PA22 = 11 */
> -		devptr->gpio.set = scoop_gpio_set;
> -		devptr->gpio.get = scoop_gpio_get;
> -		devptr->gpio.direction_input = scoop_gpio_direction_input;
> -		devptr->gpio.direction_output = scoop_gpio_direction_output;
> -
> -		ret = gpiochip_add_data(&devptr->gpio, devptr);
> -		if (ret)
> -			goto err_gpio;
> -	}
> -
> -	return 0;
> -
> -err_gpio:
> -	platform_set_drvdata(pdev, NULL);
> -err_ioremap:
> -	iounmap(devptr->base);
> -	kfree(devptr);
> -
> -	return ret;
> -}
> -
> -static void scoop_remove(struct platform_device *pdev)
> -{
> -	struct scoop_dev *sdev = platform_get_drvdata(pdev);
> -
> -	if (sdev->gpio.base != -1)
> -		gpiochip_remove(&sdev->gpio);
> -
> -	platform_set_drvdata(pdev, NULL);
> -	iounmap(sdev->base);
> -	kfree(sdev);
> -}
> -
> -static struct platform_driver scoop_driver = {
> -	.probe		= scoop_probe,
> -	.remove		= scoop_remove,
> -	.suspend	= scoop_suspend,
> -	.resume		= scoop_resume,
> -	.driver		= {
> -		.name	= "sharp-scoop",
> -	},
> -};
> -
> -static int __init scoop_init(void)
> -{
> -	return platform_driver_register(&scoop_driver);
> -}
> -
> -subsys_initcall(scoop_init);
> diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
> deleted file mode 100644
> index 1ca26c063f80..000000000000
> --- a/arch/arm/common/sharpsl_param.c
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Hardware parameter area specific to Sharp SL series devices
> - *
> - * Copyright (c) 2005 Richard Purdie
> - *
> - * Based on Sharp's 2.4 kernel patches
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/string.h>
> -#include <asm/mach/sharpsl_param.h>
> -#include <asm/page.h>
> -
> -/*
> - * Certain hardware parameters determined at the time of device manufacture,
> - * typically including LCD parameters are loaded by the bootloader at the
> - * address PARAM_BASE. As the kernel will overwrite them, we need to store
> - * them early in the boot process, then pass them to the appropriate drivers.
> - * Not all devices use all parameters but the format is common to all.
> - */
> -#ifdef CONFIG_ARCH_SA1100
> -#define PARAM_BASE	0xe8ffc000
> -#define param_start(x)	(void *)(x)
> -#else
> -#define PARAM_BASE	0xa0000a00
> -#define param_start(x)	__va(x)
> -#endif
> -#define MAGIC_CHG(a,b,c,d) ( ( d << 24 ) | ( c << 16 )  | ( b << 8 ) | a )
> -
> -#define COMADJ_MAGIC	MAGIC_CHG('C','M','A','D')
> -#define UUID_MAGIC	MAGIC_CHG('U','U','I','D')
> -#define TOUCH_MAGIC	MAGIC_CHG('T','U','C','H')
> -#define AD_MAGIC	MAGIC_CHG('B','V','A','D')
> -#define PHAD_MAGIC	MAGIC_CHG('P','H','A','D')
> -
> -struct sharpsl_param_info sharpsl_param;
> -EXPORT_SYMBOL(sharpsl_param);
> -
> -void sharpsl_save_param(void)
> -{
> -	struct sharpsl_param_info *params = param_start(PARAM_BASE);
> -
> -	memcpy(&sharpsl_param, params, sizeof(*params));
> -
> -	if (sharpsl_param.comadj_keyword != COMADJ_MAGIC)
> -		sharpsl_param.comadj=-1;
> -
> -	if (sharpsl_param.phad_keyword != PHAD_MAGIC)
> -		sharpsl_param.phadadj=-1;
> -
> -	if (sharpsl_param.uuid_keyword != UUID_MAGIC)
> -		sharpsl_param.uuid[0]=-1;
> -
> -	if (sharpsl_param.touch_keyword != TOUCH_MAGIC)
> -		sharpsl_param.touch_xp=-1;
> -
> -	if (sharpsl_param.adadj_keyword != AD_MAGIC)
> -		sharpsl_param.adadj=-1;
> -}
> -
> -
> diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
> deleted file mode 100644
> index 61beac88e863..000000000000
> --- a/arch/arm/configs/am200epdkit_defconfig
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -CONFIG_LOCALVERSION="gum"
> -CONFIG_SYSVIPC=y
> -CONFIG_PREEMPT=y
> -CONFIG_EXPERT=y
> -# CONFIG_EPOLL is not set
> -# CONFIG_SHMEM is not set
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_PXA=y
> -CONFIG_ARCH_GUMSTIX=y
> -CONFIG_ATAGS=y
> -CONFIG_CMDLINE="console=ttyS0,115200n8 root=1f01 rootfstype=jffs2"
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_PARTITION_ADVANCED=y
> -# CONFIG_SWAP is not set
> -# CONFIG_VM_EVENT_COUNTERS is not set
> -CONFIG_NET=y
> -CONFIG_PACKET=m
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
> -# CONFIG_INET_DIAG is not set
> -# CONFIG_IPV6 is not set
> -CONFIG_BT=m
> -CONFIG_BT_RFCOMM=m
> -CONFIG_BT_RFCOMM_TTY=y
> -CONFIG_BT_BNEP=m
> -CONFIG_BT_HCIUART=m
> -CONFIG_BT_HCIUART_H4=y
> -CONFIG_PCCARD=y
> -CONFIG_MTD=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_CFI=y
> -CONFIG_MTD_CFI_ADV_OPTIONS=y
> -CONFIG_MTD_CFI_GEOMETRY=y
> -# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> -# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
> -# CONFIG_MTD_CFI_I2 is not set
> -CONFIG_MTD_CFI_INTELEXT=y
> -CONFIG_MTD_COMPLEX_MAPPINGS=y
> -CONFIG_MTD_PXA2XX=y
> -CONFIG_BLK_DEV_LOOP=m
> -CONFIG_BLK_DEV_SD=m
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_ATA=m
> -CONFIG_PATA_PCMCIA=m
> -CONFIG_NETDEVICES=y
> -CONFIG_SMC91X=m
> -# CONFIG_LEGACY_PTYS is not set
> -CONFIG_SERIAL_PXA=y
> -CONFIG_SERIAL_PXA_CONSOLE=y
> -# CONFIG_HW_RANDOM is not set
> -# CONFIG_HWMON is not set
> -CONFIG_WATCHDOG=y
> -CONFIG_SA1100_WATCHDOG=m
> -CONFIG_FB=y
> -CONFIG_FB_MODE_HELPERS=y
> -CONFIG_FB_TILEBLITTING=y
> -CONFIG_FB_PXA=y
> -CONFIG_FB_PXA_PARAMETERS=y
> -CONFIG_FB_MBX=m
> -CONFIG_FB_VIRTUAL=m
> -# CONFIG_VGA_CONSOLE is not set
> -CONFIG_SOUND=m
> -CONFIG_SND=m
> -CONFIG_SND_MIXER_OSS=m
> -CONFIG_SND_PCM_OSS=m
> -# CONFIG_SND_VERBOSE_PROCFS is not set
> -CONFIG_SND_PXA2XX_AC97=m
> -CONFIG_USB_GADGET=y
> -CONFIG_USB_ETH=m
> -CONFIG_MMC=y
> -CONFIG_MMC_PXA=y
> -# CONFIG_DNOTIFY is not set
> -CONFIG_VFAT_FS=y
> -CONFIG_JFFS2_FS=y
> -CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> -CONFIG_JFFS2_RUBIN=y
> -CONFIG_NLS_CODEPAGE_437=y
> -CONFIG_NLS_ISO8859_1=y
> -CONFIG_DEBUG_KERNEL=y
> -# CONFIG_DETECT_SOFTLOCKUP is not set
> -CONFIG_CRYPTO=y
> -CONFIG_CRYPTO_CBC=m
> -CONFIG_CRYPTO_ECB=m
> -CONFIG_CRYPTO_ARC4=m
> -# CONFIG_DEBUG_BUGVERBOSE is not set
> -# CONFIG_DEBUG_PREEMPT is not set
> -CONFIG_DEBUG_USER=y
> diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
> deleted file mode 100644
> index c7cf089001bf..000000000000
> --- a/arch/arm/configs/spitz_defconfig
> +++ /dev/null
> @@ -1,237 +0,0 @@
> -CONFIG_SYSVIPC=y
> -CONFIG_PREEMPT=y
> -CONFIG_BSD_PROCESS_ACCT=y
> -CONFIG_LOG_BUF_SHIFT=14
> -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> -CONFIG_EXPERT=y
> -CONFIG_PROFILING=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_PXA=y
> -CONFIG_PXA_SHARPSL=y
> -CONFIG_MACH_AKITA=y
> -CONFIG_MACH_BORZOI=y
> -CONFIG_ATAGS=y
> -CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_MODULE_FORCE_UNLOAD=y
> -CONFIG_PARTITION_ADVANCED=y
> -CONFIG_BINFMT_MISC=m
> -CONFIG_PM=y
> -CONFIG_NET=y
> -CONFIG_PACKET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -CONFIG_SYN_COOKIES=y
> -CONFIG_INET6_AH=m
> -CONFIG_INET6_ESP=m
> -CONFIG_INET6_IPCOMP=m
> -CONFIG_IPV6_TUNNEL=m
> -CONFIG_NETFILTER=y
> -CONFIG_IP_NF_IPTABLES=m
> -CONFIG_IP_NF_MATCH_ADDRTYPE=m
> -CONFIG_IP_NF_MATCH_ECN=m
> -CONFIG_IP_NF_MATCH_TTL=m
> -CONFIG_IP_NF_FILTER=m
> -CONFIG_IP_NF_TARGET_LOG=m
> -CONFIG_IP_NF_MANGLE=m
> -CONFIG_IP_NF_RAW=m
> -CONFIG_IP_NF_ARPTABLES=m
> -CONFIG_IP_NF_ARPFILTER=m
> -CONFIG_IP_NF_ARP_MANGLE=m
> -CONFIG_IP6_NF_IPTABLES=m
> -CONFIG_IP6_NF_MATCH_EUI64=m
> -CONFIG_IP6_NF_MATCH_FRAG=m
> -CONFIG_IP6_NF_MATCH_OPTS=m
> -CONFIG_IP6_NF_MATCH_HL=m
> -CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> -CONFIG_IP6_NF_MATCH_RT=m
> -CONFIG_IP6_NF_FILTER=m
> -CONFIG_IP6_NF_MANGLE=m
> -CONFIG_IP6_NF_RAW=m
> -CONFIG_BT=m
> -CONFIG_BT_RFCOMM=m
> -CONFIG_BT_RFCOMM_TTY=y
> -CONFIG_BT_BNEP=m
> -CONFIG_BT_BNEP_MC_FILTER=y
> -CONFIG_BT_BNEP_PROTO_FILTER=y
> -CONFIG_BT_HIDP=m
> -CONFIG_BT_HCIUART=m
> -CONFIG_BT_HCIUART_H4=y
> -CONFIG_BT_HCIUART_BCSP=y
> -CONFIG_BT_HCIBCM203X=m
> -CONFIG_BT_HCIBPA10X=m
> -CONFIG_BT_HCIBFUSB=m
> -CONFIG_BT_HCIBTUART=m
> -CONFIG_BT_HCIVHCI=m
> -CONFIG_PCCARD=y
> -CONFIG_PCMCIA_PXA2XX=y
> -CONFIG_MTD=y
> -CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_ROM=y
> -CONFIG_MTD_COMPLEX_MAPPINGS=y
> -CONFIG_MTD_RAW_NAND=y
> -CONFIG_MTD_NAND_SHARPSL=y
> -CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_SD=y
> -CONFIG_CHR_DEV_ST=m
> -CONFIG_CHR_DEV_OSST=m
> -CONFIG_BLK_DEV_SR=m
> -CONFIG_CHR_DEV_SG=m
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_ATA=y
> -CONFIG_PATA_PCMCIA=y
> -CONFIG_NETDEVICES=y
> -CONFIG_PCMCIA_PCNET=m
> -CONFIG_PPP=m
> -CONFIG_PPP_BSDCOMP=m
> -CONFIG_PPP_ASYNC=m
> -CONFIG_USB_CATC=m
> -CONFIG_USB_KAWETH=m
> -CONFIG_USB_PEGASUS=m
> -CONFIG_USB_RTL8150=m
> -CONFIG_USB_USBNET=m
> -# CONFIG_USB_NET_CDC_SUBSET is not set
> -CONFIG_NET_PCMCIA=y
> -CONFIG_INPUT_FF_MEMLESS=m
> -# CONFIG_INPUT_MOUSEDEV is not set
> -CONFIG_INPUT_EVDEV=y
> -# CONFIG_KEYBOARD_ATKBD is not set
> -# CONFIG_INPUT_MOUSE is not set
> -CONFIG_INPUT_TOUCHSCREEN=y
> -CONFIG_TOUCHSCREEN_ADS7846=y
> -CONFIG_INPUT_MISC=y
> -CONFIG_INPUT_UINPUT=m
> -# CONFIG_SERIO is not set
> -# CONFIG_LEGACY_PTYS is not set
> -CONFIG_SERIAL_8250=m
> -CONFIG_SERIAL_8250_CS=m
> -CONFIG_SERIAL_PXA=y
> -CONFIG_SERIAL_PXA_CONSOLE=y
> -CONFIG_SPI=y
> -CONFIG_SPI_PXA2XX=y
> -CONFIG_FB=y
> -CONFIG_FB_PXA=y
> -CONFIG_LCD_CLASS_DEVICE=y
> -CONFIG_LCD_CORGI=y
> -CONFIG_BACKLIGHT_CLASS_DEVICE=y
> -# CONFIG_VGA_CONSOLE is not set
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> -CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> -CONFIG_HID_A4TECH=m
> -CONFIG_HID_APPLE=m
> -CONFIG_HID_BELKIN=m
> -CONFIG_HID_CHERRY=m
> -CONFIG_HID_CHICONY=m
> -CONFIG_HID_CYPRESS=m
> -CONFIG_HID_EZKEY=m
> -CONFIG_HID_GYRATION=m
> -CONFIG_HID_LOGITECH=m
> -CONFIG_HID_MICROSOFT=m
> -CONFIG_HID_MONTEREY=m
> -CONFIG_HID_PANTHERLORD=m
> -CONFIG_HID_PETALYNX=m
> -CONFIG_HID_SAMSUNG=m
> -CONFIG_HID_SONY=m
> -CONFIG_HID_SUNPLUS=m
> -CONFIG_USB_KBD=m
> -CONFIG_USB_MOUSE=m
> -CONFIG_USB=m
> -CONFIG_USB_MON=m
> -CONFIG_USB_OHCI_HCD=m
> -CONFIG_USB_SL811_HCD=m
> -CONFIG_USB_SL811_CS=m
> -CONFIG_USB_ACM=m
> -CONFIG_USB_PRINTER=m
> -CONFIG_USB_STORAGE=m
> -CONFIG_USB_MDC800=m
> -CONFIG_USB_MICROTEK=m
> -CONFIG_USB_SERIAL=m
> -CONFIG_USB_SERIAL_GENERIC=y
> -CONFIG_USB_SERIAL_BELKIN=m
> -CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> -CONFIG_USB_SERIAL_CYPRESS_M8=m
> -CONFIG_USB_SERIAL_EMPEG=m
> -CONFIG_USB_SERIAL_FTDI_SIO=m
> -CONFIG_USB_SERIAL_VISOR=m
> -CONFIG_USB_SERIAL_IPAQ=m
> -CONFIG_USB_SERIAL_IR=m
> -CONFIG_USB_SERIAL_EDGEPORT=m
> -CONFIG_USB_SERIAL_EDGEPORT_TI=m
> -CONFIG_USB_SERIAL_GARMIN=m
> -CONFIG_USB_SERIAL_IPW=m
> -CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> -CONFIG_USB_SERIAL_KEYSPAN=m
> -CONFIG_USB_SERIAL_KLSI=m
> -CONFIG_USB_SERIAL_KOBIL_SCT=m
> -CONFIG_USB_SERIAL_MCT_U232=m
> -CONFIG_USB_SERIAL_PL2303=m
> -CONFIG_USB_SERIAL_SAFE=m
> -CONFIG_USB_SERIAL_TI=m
> -CONFIG_USB_SERIAL_CYBERJACK=m
> -CONFIG_USB_SERIAL_OMNINET=m
> -CONFIG_USB_EMI62=m
> -CONFIG_USB_EMI26=m
> -CONFIG_USB_LEGOTOWER=m
> -CONFIG_USB_LCD=m
> -CONFIG_USB_CYTHERM=m
> -CONFIG_USB_IDMOUSE=m
> -CONFIG_USB_GADGET=m
> -CONFIG_USB_GADGET_DUMMY_HCD=y
> -CONFIG_USB_ZERO=m
> -CONFIG_USB_ETH=m
> -CONFIG_USB_GADGETFS=m
> -CONFIG_USB_MASS_STORAGE=m
> -CONFIG_USB_G_SERIAL=m
> -CONFIG_MMC=y
> -CONFIG_MMC_PXA=y
> -CONFIG_EXT2_FS=y
> -CONFIG_EXT2_FS_XATTR=y
> -CONFIG_EXT2_FS_POSIX_ACL=y
> -CONFIG_EXT2_FS_SECURITY=y
> -CONFIG_EXT4_FS=y
> -# CONFIG_EXT4_FS_XATTR is not set
> -CONFIG_MSDOS_FS=y
> -CONFIG_VFAT_FS=y
> -CONFIG_TMPFS=y
> -CONFIG_JFFS2_FS=y
> -CONFIG_JFFS2_SUMMARY=y
> -CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> -CONFIG_JFFS2_RUBIN=y
> -CONFIG_CRAMFS=m
> -CONFIG_NFS_FS=m
> -CONFIG_NFS_V3=y
> -CONFIG_NFS_V4=y
> -CONFIG_SMB_FS=m
> -CONFIG_SMB_NLS_DEFAULT=y
> -CONFIG_NFS_V4=m
> -CONFIG_NLS_DEFAULT="cp437"
> -CONFIG_NLS_CODEPAGE_437=y
> -CONFIG_NLS_ISO8859_1=y
> -CONFIG_NLS_UTF8=y
> -CONFIG_DEBUG_KERNEL=y
> -CONFIG_CRYPTO_NULL=m
> -CONFIG_CRYPTO_BENCHMARK=m
> -CONFIG_CRYPTO_ECB=m
> -CONFIG_CRYPTO_SHA256=m
> -CONFIG_CRYPTO_AES=m
> -CONFIG_CRYPTO_ANUBIS=m
> -CONFIG_CRYPTO_ARC4=m
> -CONFIG_CRYPTO_BLOWFISH=m
> -CONFIG_CRYPTO_CAST5=m
> -CONFIG_CRYPTO_CAST6=m
> -CONFIG_CRYPTO_KHAZAD=m
> -CONFIG_CRYPTO_SERPENT=m
> -CONFIG_CRYPTO_TEA=m
> -CONFIG_CRYPTO_TWOFISH=m
> -CONFIG_CRYPTO_HMAC=y
> -CONFIG_CRYPTO_MD4=m
> -CONFIG_CRYPTO_SHA512=m
> -CONFIG_CRYPTO_WP512=m
> -CONFIG_FONTS=y
> -CONFIG_FONT_8x8=y
> -CONFIG_FONT_8x16=y
> -CONFIG_MAGIC_SYSRQ=y
> -# CONFIG_DEBUG_PREEMPT is not set
> -# CONFIG_FTRACE is not set
> diff --git a/arch/arm/include/asm/hardware/scoop.h b/arch/arm/include/asm/hardware/scoop.h
> deleted file mode 100644
> index 505453315287..000000000000
> --- a/arch/arm/include/asm/hardware/scoop.h
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  Definitions for the SCOOP interface found on various Sharp PDAs
> - *
> - *  Copyright (c) 2004 Richard Purdie
> - */
> -
> -#define SCOOP_MCR  0x00
> -#define SCOOP_CDR  0x04
> -#define SCOOP_CSR  0x08
> -#define SCOOP_CPR  0x0C
> -#define SCOOP_CCR  0x10
> -#define SCOOP_IRR  0x14
> -#define SCOOP_IRM  0x14
> -#define SCOOP_IMR  0x18
> -#define SCOOP_ISR  0x1C
> -#define SCOOP_GPCR 0x20
> -#define SCOOP_GPWR 0x24
> -#define SCOOP_GPRR 0x28
> -
> -#define SCOOP_CPR_OUT	(1 << 7)
> -#define SCOOP_CPR_SD_3V	(1 << 2)
> -#define SCOOP_CPR_CF_XV	(1 << 1)
> -#define SCOOP_CPR_CF_3V	(1 << 0)
> -
> -#define SCOOP_GPCR_PA22	(1 << 12)
> -#define SCOOP_GPCR_PA21	(1 << 11)
> -#define SCOOP_GPCR_PA20	(1 << 10)
> -#define SCOOP_GPCR_PA19	(1 << 9)
> -#define SCOOP_GPCR_PA18	(1 << 8)
> -#define SCOOP_GPCR_PA17	(1 << 7)
> -#define SCOOP_GPCR_PA16	(1 << 6)
> -#define SCOOP_GPCR_PA15	(1 << 5)
> -#define SCOOP_GPCR_PA14	(1 << 4)
> -#define SCOOP_GPCR_PA13	(1 << 3)
> -#define SCOOP_GPCR_PA12	(1 << 2)
> -#define SCOOP_GPCR_PA11	(1 << 1)
> -
> -struct scoop_config {
> -	unsigned short io_out;
> -	unsigned short io_dir;
> -	unsigned short suspend_clr;
> -	unsigned short suspend_set;
> -	int gpio_base;
> -};
> -
> -/* Structure for linking scoop devices to PCMCIA sockets */
> -struct scoop_pcmcia_dev {
> -	struct device *dev;     /* Pointer to this socket's scoop device */
> -	int	irq;                /* irq for socket */
> -	int cd_irq;
> -	const char *cd_irq_str;
> -	unsigned char keep_vs;
> -	unsigned char keep_rd;
> -};
> -
> -struct scoop_pcmcia_config {
> -	struct scoop_pcmcia_dev *devs;
> -	int num_devs;
> -	void (*power_ctrl)(struct device *scoop, unsigned short cpr, int nr);
> -};
> -
> -extern struct scoop_pcmcia_config *platform_scoop_config;
> -
> -void reset_scoop(struct device *dev);
> -unsigned short read_scoop_reg(struct device *dev, unsigned short reg);
> -void write_scoop_reg(struct device *dev, unsigned short reg, unsigned short data);
> diff --git a/arch/arm/include/asm/mach/sharpsl_param.h b/arch/arm/include/asm/mach/sharpsl_param.h
> deleted file mode 100644
> index 700a377c20bf..000000000000
> --- a/arch/arm/include/asm/mach/sharpsl_param.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Hardware parameter area specific to Sharp SL series devices
> - *
> - * Copyright (c) 2005 Richard Purdie
> - *
> - * Based on Sharp's 2.4 kernel patches
> - */
> -
> -struct sharpsl_param_info {
> -  unsigned int comadj_keyword;
> -  unsigned int comadj;
> -
> -  unsigned int uuid_keyword;
> -  unsigned char uuid[16];
> -
> -  unsigned int touch_keyword;
> -  unsigned int touch_xp;
> -  unsigned int touch_yp;
> -  unsigned int touch_xd;
> -  unsigned int touch_yd;
> -
> -  unsigned int adadj_keyword;
> -  unsigned int adadj;
> -
> -  unsigned int phad_keyword;
> -  unsigned int phadadj;
> -} __attribute__((packed));
> -
> -
> -extern struct sharpsl_param_info sharpsl_param;
> -extern void sharpsl_save_param(void);
> -
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 2fb29b9ef744..354e3dc17776 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -50,77 +50,6 @@ config MACH_PXA3XX_DT
>  	  the device tree. Needn't select any other machine while
>  	  MACH_PXA3XX_DT is enabled.
>  
> -if ATAGS
> -
> -comment "Legacy board files"
> -
> -config ARCH_GUMSTIX
> -	bool "Gumstix XScale 255 boards (DEPRECATED)"
> -	select PXA25x
> -	help
> -	  Say Y here if you intend to run this kernel on
> -	  Basix, Connex, ws-200ax, ws-400ax systems
> -
> -	  Support for this machine will go away in early 2027,
> -	  unless it gets converted to device tree.
> -
> -choice
> -	prompt "Gumstix Carrier/Expansion Board"
> -	depends on ARCH_GUMSTIX
> -
> -config GUMSTIX_AM200EPD
> -	bool "Enable AM200EPD board support"
> -
> -config GUMSTIX_AM300EPD
> -	bool "Enable AM300EPD board support"
> -
> -endchoice
> -
> -config PXA_SHARPSL
> -	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models (DEPRECATED)"
> -	select SHARP_PARAM
> -	select SHARP_SCOOP
> -	help
> -	  Say Y here if you intend to run this kernel on a
> -	  Sharp Zaurus SL-5600 (Poodle), SL-C700 (Corgi),
> -	  SL-C750 (Shepherd), SL-C760 (Husky), SL-C1000 (Akita),
> -	  SL-C3000 (Spitz), SL-C3100 (Borzoi) or SL-C6000x (Tosa)
> -	  handheld computer.
> -
> -	  Support for these machines will go away in early 2027,
> -	  unless they get converted to device tree.
> -
> -config PXA_SHARPSL_DETECT_MACH_ID
> -	bool "Detect machine ID at run-time in the decompressor"
> -	depends on PXA_SHARPSL
> -	help
> -	  Say Y here if you want the zImage decompressor to detect
> -	  the Zaurus machine ID at run-time. For latest kexec-based
> -	  boot loader, this is not necessary.
> -
> -config MACH_AKITA
> -	bool "Enable Sharp SL-1000 (Akita) Support"
> -	depends on PXA_SHARPSL
> -	select I2C
> -	select I2C_PXA
> -	select MACH_SPITZ
> -	select PXA27x
> -	select PXA_SHARP_Cxx00
> -
> -config MACH_SPITZ
> -	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
> -	depends on PXA_SHARPSL
> -	select PXA27x
> -	select PXA_SHARP_Cxx00
> -
> -config MACH_BORZOI
> -	bool "Enable Sharp Zaurus SL-3100 (Borzoi) Support"
> -	depends on PXA_SHARPSL
> -	select PXA27x
> -	select PXA_SHARP_Cxx00
> -
> -endif # ATAGS
> -
>  config PXA25x
>  	bool
>  	select CPU_XSCALE
> @@ -157,22 +86,4 @@ config CPU_PXA320
>  	help
>  	  PXA320 (codename Monahans-P)
>  
> -config PXA_SHARP_Cxx00
> -	bool
> -	select SHARPSL_PM
> -	help
> -	  Enable common support for Sharp Cxx00 models
> -
> -config SHARPSL_PM
> -	bool
> -	select APM_EMULATION
> -	select SHARPSL_PM_MAX1111
> -
> -config SHARPSL_PM_MAX1111
> -	bool
> -	select HWMON
> -	select SENSORS_MAX1111
> -	select SPI
> -	select SPI_MASTER
> -
>  endif
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index faccdd356482..3bc3b2e56afe 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -22,11 +22,3 @@ obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
>  obj-$(CONFIG_MACH_PXA25X_DT)	+= pxa-dt.o
>  obj-$(CONFIG_MACH_PXA27X_DT)	+= pxa-dt.o
>  obj-$(CONFIG_MACH_PXA3XX_DT)	+= pxa-dt.o
> -
> -# 3rd Party Dev Platforms
> -obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
> -obj-$(CONFIG_GUMSTIX_AM200EPD)	+= am200epd.o
> -obj-$(CONFIG_GUMSTIX_AM300EPD)	+= am300epd.o
> -
> -# End-user Products
> -obj-$(CONFIG_PXA_SHARP_Cxx00)	+= spitz.o sharpsl_pm.o spitz_pm.o
> diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
> deleted file mode 100644
> index 4814f3cfe775..000000000000
> --- a/arch/arm/mach-pxa/am200epd.c
> +++ /dev/null
> @@ -1,395 +0,0 @@
> -/*
> - * am200epd.c -- Platform device for AM200 EPD kit
> - *
> - * Copyright (C) 2008, Jaya Kumar
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License. See the file COPYING in the main directory of this archive for
> - * more details.
> - *
> - * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
> - *
> - * This work was made possible by help and equipment support from E-Ink
> - * Corporation. http://support.eink.com/community
> - *
> - * This driver is written to be used with the Metronome display controller.
> - * on the AM200 EPD prototype kit/development kit with an E-Ink 800x600
> - * Vizplex EPD on a Gumstix board using the Lyre interface board.
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/delay.h>
> -#include <linux/interrupt.h>
> -#include <linux/fb.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/irq.h>
> -#include <linux/gpio/legacy.h>
> -
> -#include "pxa25x.h"
> -#include "gumstix.h"
> -#include <linux/platform_data/video-pxafb.h>
> -
> -#include "generic.h"
> -
> -#include <video/metronomefb.h>
> -
> -static unsigned int panel_type = 6;
> -static struct platform_device *am200_device;
> -static struct metronome_board am200_board;
> -
> -static struct pxafb_mode_info am200_fb_mode_9inch7 = {
> -	.pixclock	= 40000,
> -	.xres		= 1200,
> -	.yres		= 842,
> -	.bpp		= 16,
> -	.hsync_len	= 2,
> -	.left_margin	= 2,
> -	.right_margin	= 2,
> -	.vsync_len	= 1,
> -	.upper_margin	= 2,
> -	.lower_margin	= 25,
> -	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -};
> -
> -static struct pxafb_mode_info am200_fb_mode_8inch = {
> -	.pixclock	= 40000,
> -	.xres		= 1088,
> -	.yres		= 791,
> -	.bpp		= 16,
> -	.hsync_len	= 28,
> -	.left_margin	= 8,
> -	.right_margin	= 30,
> -	.vsync_len	= 8,
> -	.upper_margin	= 10,
> -	.lower_margin	= 8,
> -	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -};
> -
> -static struct pxafb_mode_info am200_fb_mode_6inch = {
> -	.pixclock	= 40189,
> -	.xres		= 832,
> -	.yres		= 622,
> -	.bpp		= 16,
> -	.hsync_len	= 28,
> -	.left_margin	= 34,
> -	.right_margin	= 34,
> -	.vsync_len	= 25,
> -	.upper_margin	= 0,
> -	.lower_margin	= 2,
> -	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> -};
> -
> -static struct pxafb_mach_info am200_fb_info = {
> -	.modes		= &am200_fb_mode_6inch,
> -	.num_modes	= 1,
> -	.lcd_conn	= LCD_TYPE_COLOR_TFT | LCD_PCLK_EDGE_FALL |
> -			  LCD_AC_BIAS_FREQ(24),
> -};
> -
> -/* register offsets for gpio control */
> -#define LED_GPIO_PIN 51
> -#define STDBY_GPIO_PIN 48
> -#define RST_GPIO_PIN 49
> -#define RDY_GPIO_PIN 32
> -#define ERR_GPIO_PIN 17
> -#define PCBPWR_GPIO_PIN 16
> -static int gpios[] = { LED_GPIO_PIN , STDBY_GPIO_PIN , RST_GPIO_PIN,
> -			RDY_GPIO_PIN, ERR_GPIO_PIN, PCBPWR_GPIO_PIN };
> -static char *gpio_names[] = { "LED" , "STDBY" , "RST", "RDY", "ERR", "PCBPWR" };
> -
> -static int am200_init_gpio_regs(struct metronomefb_par *par)
> -{
> -	int i;
> -	int err;
> -
> -	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> -		err = gpio_request(gpios[i], gpio_names[i]);
> -		if (err) {
> -			dev_err(&am200_device->dev, "failed requesting "
> -				"gpio %s, err=%d\n", gpio_names[i], err);
> -			goto err_req_gpio;
> -		}
> -	}
> -
> -	gpio_direction_output(LED_GPIO_PIN, 0);
> -	gpio_direction_output(STDBY_GPIO_PIN, 0);
> -	gpio_direction_output(RST_GPIO_PIN, 0);
> -
> -	gpio_direction_input(RDY_GPIO_PIN);
> -	gpio_direction_input(ERR_GPIO_PIN);
> -
> -	gpio_direction_output(PCBPWR_GPIO_PIN, 0);
> -
> -	return 0;
> -
> -err_req_gpio:
> -	while (--i >= 0)
> -		gpio_free(gpios[i]);
> -
> -	return err;
> -}
> -
> -static void am200_cleanup(struct metronomefb_par *par)
> -{
> -	int i;
> -
> -	free_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), par);
> -
> -	for (i = 0; i < ARRAY_SIZE(gpios); i++)
> -		gpio_free(gpios[i]);
> -}
> -
> -static int am200_share_video_mem(struct fb_info *info)
> -{
> -	/* rough check if this is our desired fb and not something else */
> -	if ((info->var.xres != am200_fb_info.modes->xres)
> -		|| (info->var.yres != am200_fb_info.modes->yres))
> -		return 0;
> -
> -	/* we've now been notified that we have our new fb */
> -	am200_board.metromem = info->screen_base;
> -	am200_board.host_fbinfo = info;
> -
> -	/* try to refcount host drv since we are the consumer after this */
> -	if (!try_module_get(info->fbops->owner))
> -		return -ENODEV;
> -
> -	return 0;
> -}
> -
> -static int am200_unshare_video_mem(struct fb_info *info)
> -{
> -	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
> -
> -	if (info != am200_board.host_fbinfo)
> -		return 0;
> -
> -	module_put(am200_board.host_fbinfo->fbops->owner);
> -	return 0;
> -}
> -
> -static int am200_fb_notifier_callback(struct notifier_block *self,
> -				 unsigned long event, void *data)
> -{
> -	struct fb_event *evdata = data;
> -	struct fb_info *info = evdata->info;
> -
> -	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
> -
> -	if (event == FB_EVENT_FB_REGISTERED)
> -		return am200_share_video_mem(info);
> -	else if (event == FB_EVENT_FB_UNREGISTERED)
> -		return am200_unshare_video_mem(info);
> -
> -	return 0;
> -}
> -
> -static struct notifier_block am200_fb_notif = {
> -	.notifier_call = am200_fb_notifier_callback,
> -};
> -
> -/* this gets called as part of our init. these steps must be done now so
> - * that we can use pxa_set_fb_info */
> -static void __init am200_presetup_fb(void)
> -{
> -	int fw;
> -	int fh;
> -	int padding_size;
> -	int totalsize;
> -
> -	switch (panel_type) {
> -	case 6:
> -		am200_fb_info.modes = &am200_fb_mode_6inch;
> -		break;
> -	case 8:
> -		am200_fb_info.modes = &am200_fb_mode_8inch;
> -		break;
> -	case 97:
> -		am200_fb_info.modes = &am200_fb_mode_9inch7;
> -		break;
> -	default:
> -		dev_err(&am200_device->dev, "invalid panel_type selection,"
> -						" setting to 6\n");
> -		am200_fb_info.modes = &am200_fb_mode_6inch;
> -		break;
> -	}
> -
> -	/* the frame buffer is divided as follows:
> -	command | CRC | padding
> -	16kb waveform data | CRC | padding
> -	image data | CRC
> -	*/
> -
> -	fw = am200_fb_info.modes->xres;
> -	fh = am200_fb_info.modes->yres;
> -
> -	/* waveform must be 16k + 2 for checksum */
> -	am200_board.wfm_size = roundup(16*1024 + 2, fw);
> -
> -	padding_size = PAGE_SIZE + (4 * fw);
> -
> -	/* total is 1 cmd , 1 wfm, padding and image */
> -	totalsize = fw + am200_board.wfm_size + padding_size + (fw*fh);
> -
> -	/* save this off because we're manipulating fw after this and
> -	 * we'll need it when we're ready to setup the framebuffer */
> -	am200_board.fw = fw;
> -	am200_board.fh = fh;
> -
> -	/* the reason we do this adjustment is because we want to acquire
> -	 * more framebuffer memory without imposing custom awareness on the
> -	 * underlying pxafb driver */
> -	am200_fb_info.modes->yres = DIV_ROUND_UP(totalsize, fw);
> -
> -	/* we divide since we told the LCD controller we're 16bpp */
> -	am200_fb_info.modes->xres /= 2;
> -
> -	pxa_set_fb_info(NULL, &am200_fb_info);
> -
> -}
> -
> -/* this gets called by metronomefb as part of its init, in our case, we
> - * have already completed initial framebuffer init in presetup_fb so we
> - * can just setup the fb access pointers */
> -static int am200_setup_fb(struct metronomefb_par *par)
> -{
> -	int fw;
> -	int fh;
> -
> -	fw = am200_board.fw;
> -	fh = am200_board.fh;
> -
> -	/* metromem was set up by the notifier in share_video_mem so now
> -	 * we can use its value to calculate the other entries */
> -	par->metromem_cmd = (struct metromem_cmd *) am200_board.metromem;
> -	par->metromem_wfm = am200_board.metromem + fw;
> -	par->metromem_img = par->metromem_wfm + am200_board.wfm_size;
> -	par->metromem_img_csum = (u16 *) (par->metromem_img + (fw * fh));
> -	par->metromem_dma = am200_board.host_fbinfo->fix.smem_start;
> -
> -	return 0;
> -}
> -
> -static int am200_get_panel_type(void)
> -{
> -	return panel_type;
> -}
> -
> -static irqreturn_t am200_handle_irq(int irq, void *dev_id)
> -{
> -	struct metronomefb_par *par = dev_id;
> -
> -	wake_up_interruptible(&par->waitq);
> -	return IRQ_HANDLED;
> -}
> -
> -static int am200_setup_irq(struct fb_info *info)
> -{
> -	int ret;
> -
> -	ret = request_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), am200_handle_irq,
> -				IRQF_TRIGGER_FALLING, "AM200", info->par);
> -	if (ret)
> -		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static void am200_set_rst(struct metronomefb_par *par, int state)
> -{
> -	gpio_set_value(RST_GPIO_PIN, state);
> -}
> -
> -static void am200_set_stdby(struct metronomefb_par *par, int state)
> -{
> -	gpio_set_value(STDBY_GPIO_PIN, state);
> -}
> -
> -static int am200_wait_event(struct metronomefb_par *par)
> -{
> -	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
> -}
> -
> -static int am200_wait_event_intr(struct metronomefb_par *par)
> -{
> -	return wait_event_interruptible_timeout(par->waitq,
> -					gpio_get_value(RDY_GPIO_PIN), HZ);
> -}
> -
> -static struct metronome_board am200_board = {
> -	.owner			= THIS_MODULE,
> -	.setup_irq		= am200_setup_irq,
> -	.setup_io		= am200_init_gpio_regs,
> -	.setup_fb		= am200_setup_fb,
> -	.set_rst		= am200_set_rst,
> -	.set_stdby		= am200_set_stdby,
> -	.met_wait_event		= am200_wait_event,
> -	.met_wait_event_intr	= am200_wait_event_intr,
> -	.get_panel_type		= am200_get_panel_type,
> -	.cleanup		= am200_cleanup,
> -};
> -
> -static unsigned long am200_pin_config[] __initdata = {
> -	GPIO51_GPIO,
> -	GPIO49_GPIO,
> -	GPIO48_GPIO,
> -	GPIO32_GPIO,
> -	GPIO17_GPIO,
> -	GPIO16_GPIO,
> -};
> -
> -int __init am200_init(void)
> -{
> -	int ret;
> -
> -	/*
> -	 * Before anything else, we request notification for any fb
> -	 * creation events.
> -	 *
> -	 * FIXME: This is terrible and needs to be nuked. The notifier is used
> -	 * to get at the fb base address from the boot splash fb driver, which
> -	 * is then passed to metronomefb. Instaed of metronomfb or this board
> -	 * support file here figuring this out on their own.
> -	 *
> -	 * See also the #ifdef in fbmem.c.
> -	 */
> -	fb_register_client(&am200_fb_notif);
> -
> -	pxa2xx_mfp_config(ARRAY_AND_SIZE(am200_pin_config));
> -
> -	/* request our platform independent driver */
> -	request_module("metronomefb");
> -
> -	am200_device = platform_device_alloc("metronomefb", -1);
> -	if (!am200_device)
> -		return -ENOMEM;
> -
> -	/* the am200_board that will be seen by metronomefb is a copy */
> -	platform_device_add_data(am200_device, &am200_board,
> -					sizeof(am200_board));
> -
> -	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
> -	ret = platform_device_add(am200_device);
> -
> -	if (ret) {
> -		platform_device_put(am200_device);
> -		fb_unregister_client(&am200_fb_notif);
> -		return ret;
> -	}
> -
> -	am200_presetup_fb();
> -
> -	return 0;
> -}
> -
> -module_param(panel_type, uint, 0);
> -MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
> -
> -MODULE_DESCRIPTION("board driver for am200 metronome epd kit");
> -MODULE_AUTHOR("Jaya Kumar");
> -MODULE_LICENSE("GPL");
> diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
> deleted file mode 100644
> index 435fb72da7de..000000000000
> --- a/arch/arm/mach-pxa/am300epd.c
> +++ /dev/null
> @@ -1,296 +0,0 @@
> -/*
> - * am300epd.c -- Platform device for AM300 EPD kit
> - *
> - * Copyright (C) 2008, Jaya Kumar
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License. See the file COPYING in the main directory of this archive for
> - * more details.
> - *
> - * This work was made possible by help and equipment support from E-Ink
> - * Corporation. http://support.eink.com/community
> - *
> - * This driver is written to be used with the Broadsheet display controller.
> - * on the AM300 EPD prototype kit/development kit with an E-Ink 800x600
> - * Vizplex EPD on a Gumstix board using the Broadsheet interface board.
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/delay.h>
> -#include <linux/interrupt.h>
> -#include <linux/fb.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/irq.h>
> -#include <linux/gpio/legacy.h>
> -
> -#include "gumstix.h"
> -#include "mfp-pxa25x.h"
> -#include "irqs.h"
> -#include <linux/platform_data/video-pxafb.h>
> -
> -#include "generic.h"
> -
> -#include <video/broadsheetfb.h>
> -
> -static unsigned int panel_type = 6;
> -static struct platform_device *am300_device;
> -static struct broadsheet_board am300_board;
> -
> -static unsigned long am300_pin_config[] __initdata = {
> -	GPIO16_GPIO,
> -	GPIO17_GPIO,
> -	GPIO32_GPIO,
> -	GPIO48_GPIO,
> -	GPIO49_GPIO,
> -	GPIO51_GPIO,
> -	GPIO74_GPIO,
> -	GPIO75_GPIO,
> -	GPIO76_GPIO,
> -	GPIO77_GPIO,
> -
> -	/* this is the 16-bit hdb bus 58-73 */
> -	GPIO58_GPIO,
> -	GPIO59_GPIO,
> -	GPIO60_GPIO,
> -	GPIO61_GPIO,
> -
> -	GPIO62_GPIO,
> -	GPIO63_GPIO,
> -	GPIO64_GPIO,
> -	GPIO65_GPIO,
> -
> -	GPIO66_GPIO,
> -	GPIO67_GPIO,
> -	GPIO68_GPIO,
> -	GPIO69_GPIO,
> -
> -	GPIO70_GPIO,
> -	GPIO71_GPIO,
> -	GPIO72_GPIO,
> -	GPIO73_GPIO,
> -};
> -
> -/* register offsets for gpio control */
> -#define PWR_GPIO_PIN	16
> -#define CFG_GPIO_PIN	17
> -#define RDY_GPIO_PIN	32
> -#define DC_GPIO_PIN	48
> -#define RST_GPIO_PIN	49
> -#define LED_GPIO_PIN	51
> -#define RD_GPIO_PIN	74
> -#define WR_GPIO_PIN	75
> -#define CS_GPIO_PIN	76
> -#define IRQ_GPIO_PIN	77
> -
> -/* hdb bus */
> -#define DB0_GPIO_PIN	58
> -#define DB15_GPIO_PIN	73
> -
> -static int gpios[] = { PWR_GPIO_PIN, CFG_GPIO_PIN, RDY_GPIO_PIN, DC_GPIO_PIN,
> -			RST_GPIO_PIN, RD_GPIO_PIN, WR_GPIO_PIN, CS_GPIO_PIN,
> -			IRQ_GPIO_PIN, LED_GPIO_PIN };
> -static char *gpio_names[] = { "PWR", "CFG", "RDY", "DC", "RST", "RD", "WR",
> -				"CS", "IRQ", "LED" };
> -
> -static int am300_wait_event(struct broadsheetfb_par *par)
> -{
> -	/* todo: improve err recovery */
> -	wait_event(par->waitq, gpio_get_value(RDY_GPIO_PIN));
> -	return 0;
> -}
> -
> -static int am300_init_gpio_regs(struct broadsheetfb_par *par)
> -{
> -	int i;
> -	int err;
> -	char dbname[8];
> -
> -	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> -		err = gpio_request(gpios[i], gpio_names[i]);
> -		if (err) {
> -			dev_err(&am300_device->dev, "failed requesting "
> -				"gpio %s, err=%d\n", gpio_names[i], err);
> -			goto err_req_gpio;
> -		}
> -	}
> -
> -	/* we also need to take care of the hdb bus */
> -	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++) {
> -		sprintf(dbname, "DB%d", i);
> -		err = gpio_request(i, dbname);
> -		if (err) {
> -			dev_err(&am300_device->dev, "failed requesting "
> -				"gpio %d, err=%d\n", i, err);
> -			goto err_req_gpio2;
> -		}
> -	}
> -
> -	/* setup the outputs and init values */
> -	gpio_direction_output(PWR_GPIO_PIN, 0);
> -	gpio_direction_output(CFG_GPIO_PIN, 1);
> -	gpio_direction_output(DC_GPIO_PIN, 0);
> -	gpio_direction_output(RD_GPIO_PIN, 1);
> -	gpio_direction_output(WR_GPIO_PIN, 1);
> -	gpio_direction_output(CS_GPIO_PIN, 1);
> -	gpio_direction_output(RST_GPIO_PIN, 0);
> -
> -	/* setup the inputs */
> -	gpio_direction_input(RDY_GPIO_PIN);
> -	gpio_direction_input(IRQ_GPIO_PIN);
> -
> -	/* start the hdb bus as an input */
> -	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
> -		gpio_direction_output(i, 0);
> -
> -	/* go into command mode */
> -	gpio_set_value(CFG_GPIO_PIN, 1);
> -	gpio_set_value(RST_GPIO_PIN, 0);
> -	msleep(10);
> -	gpio_set_value(RST_GPIO_PIN, 1);
> -	msleep(10);
> -	am300_wait_event(par);
> -
> -	return 0;
> -
> -err_req_gpio2:
> -	while (--i >= DB0_GPIO_PIN)
> -		gpio_free(i);
> -	i = ARRAY_SIZE(gpios);
> -err_req_gpio:
> -	while (--i >= 0)
> -		gpio_free(gpios[i]);
> -
> -	return err;
> -}
> -
> -static int am300_init_board(struct broadsheetfb_par *par)
> -{
> -	return am300_init_gpio_regs(par);
> -}
> -
> -static void am300_cleanup(struct broadsheetfb_par *par)
> -{
> -	int i;
> -
> -	free_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), par);
> -
> -	for (i = 0; i < ARRAY_SIZE(gpios); i++)
> -		gpio_free(gpios[i]);
> -
> -	for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
> -		gpio_free(i);
> -
> -}
> -
> -static u16 am300_get_hdb(struct broadsheetfb_par *par)
> -{
> -	u16 res = 0;
> -	int i;
> -
> -	for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
> -		res |= (gpio_get_value(DB0_GPIO_PIN + i)) ? (1 << i) : 0;
> -
> -	return res;
> -}
> -
> -static void am300_set_hdb(struct broadsheetfb_par *par, u16 data)
> -{
> -	int i;
> -
> -	for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
> -		gpio_set_value(DB0_GPIO_PIN + i, (data >> i) & 0x01);
> -}
> -
> -
> -static void am300_set_ctl(struct broadsheetfb_par *par, unsigned char bit,
> -				u8 state)
> -{
> -	switch (bit) {
> -	case BS_CS:
> -		gpio_set_value(CS_GPIO_PIN, state);
> -		break;
> -	case BS_DC:
> -		gpio_set_value(DC_GPIO_PIN, state);
> -		break;
> -	case BS_WR:
> -		gpio_set_value(WR_GPIO_PIN, state);
> -		break;
> -	}
> -}
> -
> -static int am300_get_panel_type(void)
> -{
> -	return panel_type;
> -}
> -
> -static irqreturn_t am300_handle_irq(int irq, void *dev_id)
> -{
> -	struct broadsheetfb_par *par = dev_id;
> -
> -	wake_up(&par->waitq);
> -	return IRQ_HANDLED;
> -}
> -
> -static int am300_setup_irq(struct fb_info *info)
> -{
> -	int ret;
> -	struct broadsheetfb_par *par = info->par;
> -
> -	ret = request_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), am300_handle_irq,
> -				IRQF_TRIGGER_RISING, "AM300", par);
> -	if (ret)
> -		dev_err(&am300_device->dev, "request_irq failed: %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static struct broadsheet_board am300_board = {
> -	.owner			= THIS_MODULE,
> -	.init			= am300_init_board,
> -	.cleanup		= am300_cleanup,
> -	.set_hdb		= am300_set_hdb,
> -	.get_hdb		= am300_get_hdb,
> -	.set_ctl		= am300_set_ctl,
> -	.wait_for_rdy		= am300_wait_event,
> -	.get_panel_type		= am300_get_panel_type,
> -	.setup_irq		= am300_setup_irq,
> -};
> -
> -int __init am300_init(void)
> -{
> -	int ret;
> -
> -	pxa2xx_mfp_config(ARRAY_AND_SIZE(am300_pin_config));
> -
> -	/* request our platform independent driver */
> -	request_module("broadsheetfb");
> -
> -	am300_device = platform_device_alloc("broadsheetfb", -1);
> -	if (!am300_device)
> -		return -ENOMEM;
> -
> -	/* the am300_board that will be seen by broadsheetfb is a copy */
> -	platform_device_add_data(am300_device, &am300_board,
> -					sizeof(am300_board));
> -
> -	ret = platform_device_add(am300_device);
> -
> -	if (ret) {
> -		platform_device_put(am300_device);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -module_param(panel_type, uint, 0);
> -MODULE_PARM_DESC(panel_type, "Select the panel type: 37, 6, 97");
> -
> -MODULE_DESCRIPTION("board driver for am300 epd kit");
> -MODULE_AUTHOR("Jaya Kumar");
> -MODULE_LICENSE("GPL");
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> index edad956a1483..c2a2469a003a 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c
> @@ -1,715 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/clkdev.h>
> -#include <linux/clk-provider.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/dmaengine.h>
> -#include <linux/gpio-pxa.h>
> -#include <linux/platform_data/i2c-pxa.h>
> -#include <linux/soc/pxa/cpu.h>
>  
> -#include <linux/platform_data/video-pxafb.h>
> -#include <linux/platform_data/mmc-pxamci.h>
>  #include "irqs.h"
> -#include <linux/platform_data/usb-ohci-pxa27x.h>
> -#include <linux/platform_data/mmp_dma.h>
> -
> -#include "mfp-pxa2xx.h"
>  #include "regs-ost.h"
>  #include "reset.h"
> -#include "devices.h"
> -#include "generic.h"
> -
> -void __init pxa_register_device(struct platform_device *dev, void *data)
> -{
> -	int ret;
> -
> -	dev->dev.platform_data = data;
> -
> -	ret = platform_device_register(dev);
> -	if (ret)
> -		dev_err(&dev->dev, "unable to register device: %d\n", ret);
> -}
> -
> -static struct resource pxa_resource_pmu = {
> -	.start	= IRQ_PMU,
> -	.end	= IRQ_PMU,
> -	.flags	= IORESOURCE_IRQ,
> -};
> -
> -struct platform_device pxa_device_pmu = {
> -	.name		= "xscale-pmu",
> -	.id		= -1,
> -	.resource	= &pxa_resource_pmu,
> -	.num_resources	= 1,
> -};
> -
> -static const struct resource pxamci_resources[] = {
> -	[0] = {
> -		.start	= 0x41100000,
> -		.end	= 0x41100fff,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_MMC,
> -		.end	= IRQ_MMC,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -void __init pxa_set_mci_info(const struct pxamci_platform_data *info,
> -			     const struct property_entry *props)
> -{
> -	const struct platform_device_info mci_info = {
> -		.name		= "pxa2xx-mci",
> -		.id		= 0,
> -		.res		= pxamci_resources,
> -		.num_res	= ARRAY_SIZE(pxamci_resources),
> -		.data		= info,
> -		.size_data	= sizeof(*info),
> -		.dma_mask	= 0xffffffffUL,
> -		.properties	= props,
> -	};
> -	struct platform_device *mci_dev;
> -	int err;
> -
> -	mci_dev = platform_device_register_full(&mci_info);
> -	err = PTR_ERR_OR_ZERO(mci_dev);
> -	if (err)
> -		pr_err("Unable to create mci device: %d\n", err);
> -}
> -
> -static struct resource pxa2xx_udc_resources[] = {
> -	[0] = {
> -		.start	= 0x40600000,
> -		.end	= 0x4060ffff,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_USB,
> -		.end	= IRQ_USB,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static u64 udc_dma_mask = ~(u32)0;
> -
> -struct platform_device pxa25x_device_udc = {
> -	.name		= "pxa25x-udc",
> -	.id		= -1,
> -	.resource	= pxa2xx_udc_resources,
> -	.num_resources	= ARRAY_SIZE(pxa2xx_udc_resources),
> -	.dev		=  {
> -		.dma_mask	= &udc_dma_mask,
> -	}
> -};
> -
> -struct platform_device pxa27x_device_udc = {
> -	.name		= "pxa27x-udc",
> -	.id		= -1,
> -	.resource	= pxa2xx_udc_resources,
> -	.num_resources	= ARRAY_SIZE(pxa2xx_udc_resources),
> -	.dev		=  {
> -		.dma_mask	= &udc_dma_mask,
> -	}
> -};
> -
> -static struct resource pxafb_resources[] = {
> -	[0] = {
> -		.start	= 0x44000000,
> -		.end	= 0x4400ffff,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_LCD,
> -		.end	= IRQ_LCD,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static u64 fb_dma_mask = ~(u64)0;
> -
> -struct platform_device pxa_device_fb = {
> -	.name		= "pxa2xx-fb",
> -	.id		= -1,
> -	.dev		= {
> -		.dma_mask	= &fb_dma_mask,
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(pxafb_resources),
> -	.resource	= pxafb_resources,
> -};
> -
> -void __init pxa_set_fb_info(struct device *parent, struct pxafb_mach_info *info)
> -{
> -	pxa_device_fb.dev.parent = parent;
> -	pxa_register_device(&pxa_device_fb, info);
> -}
> -
> -static struct resource pxa_resource_ffuart[] = {
> -	{
> -		.start	= 0x40100000,
> -		.end	= 0x40100023,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_FFUART,
> -		.end	= IRQ_FFUART,
> -		.flags	= IORESOURCE_IRQ,
> -	}
> -};
> -
> -struct platform_device pxa_device_ffuart = {
> -	.name		= "pxa2xx-uart",
> -	.id		= 0,
> -	.resource	= pxa_resource_ffuart,
> -	.num_resources	= ARRAY_SIZE(pxa_resource_ffuart),
> -};
> -
> -void __init pxa_set_ffuart_info(void *info)
> -{
> -	pxa_register_device(&pxa_device_ffuart, info);
> -}
> -
> -static struct resource pxa_resource_btuart[] = {
> -	{
> -		.start	= 0x40200000,
> -		.end	= 0x40200023,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_BTUART,
> -		.end	= IRQ_BTUART,
> -		.flags	= IORESOURCE_IRQ,
> -	}
> -};
> -
> -struct platform_device pxa_device_btuart = {
> -	.name		= "pxa2xx-uart",
> -	.id		= 1,
> -	.resource	= pxa_resource_btuart,
> -	.num_resources	= ARRAY_SIZE(pxa_resource_btuart),
> -};
> -
> -void __init pxa_set_btuart_info(void *info)
> -{
> -	pxa_register_device(&pxa_device_btuart, info);
> -}
> -
> -static struct resource pxa_resource_stuart[] = {
> -	{
> -		.start	= 0x40700000,
> -		.end	= 0x40700023,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_STUART,
> -		.end	= IRQ_STUART,
> -		.flags	= IORESOURCE_IRQ,
> -	}
> -};
> -
> -struct platform_device pxa_device_stuart = {
> -	.name		= "pxa2xx-uart",
> -	.id		= 2,
> -	.resource	= pxa_resource_stuart,
> -	.num_resources	= ARRAY_SIZE(pxa_resource_stuart),
> -};
> -
> -void __init pxa_set_stuart_info(void *info)
> -{
> -	pxa_register_device(&pxa_device_stuart, info);
> -}
> -
> -static struct resource pxa_resource_hwuart[] = {
> -	{
> -		.start	= 0x41600000,
> -		.end	= 0x4160002F,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_HWUART,
> -		.end	= IRQ_HWUART,
> -		.flags	= IORESOURCE_IRQ,
> -	}
> -};
> -
> -struct platform_device pxa_device_hwuart = {
> -	.name		= "pxa2xx-uart",
> -	.id		= 3,
> -	.resource	= pxa_resource_hwuart,
> -	.num_resources	= ARRAY_SIZE(pxa_resource_hwuart),
> -};
> -
> -void __init pxa_set_hwuart_info(void *info)
> -{
> -	if (cpu_is_pxa255())
> -		pxa_register_device(&pxa_device_hwuart, info);
> -	else
> -		pr_info("UART: Ignoring attempt to register HWUART on non-PXA255 hardware");
> -}
> -
> -static struct resource pxai2c_resources[] = {
> -	{
> -		.start	= 0x40301680,
> -		.end	= 0x403016a3,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_I2C,
> -		.end	= IRQ_I2C,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa_device_i2c = {
> -	.name		= "pxa2xx-i2c",
> -	.id		= 0,
> -	.resource	= pxai2c_resources,
> -	.num_resources	= ARRAY_SIZE(pxai2c_resources),
> -};
> -
> -void __init pxa_set_i2c_info(struct i2c_pxa_platform_data *info)
> -{
> -	pxa_register_device(&pxa_device_i2c, info);
> -}
> -
> -#ifdef CONFIG_PXA27x
> -static struct resource pxa27x_resources_i2c_power[] = {
> -	{
> -		.start	= 0x40f00180,
> -		.end	= 0x40f001a3,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_PWRI2C,
> -		.end	= IRQ_PWRI2C,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_i2c_power = {
> -	.name		= "pxa2xx-i2c",
> -	.id		= 1,
> -	.resource	= pxa27x_resources_i2c_power,
> -	.num_resources	= ARRAY_SIZE(pxa27x_resources_i2c_power),
> -};
> -#endif
> -
> -static struct resource pxai2s_resources[] = {
> -	{
> -		.start	= 0x40400000,
> -		.end	= 0x40400083,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_I2S,
> -		.end	= IRQ_I2S,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa_device_i2s = {
> -	.name		= "pxa2xx-i2s",
> -	.id		= -1,
> -	.resource	= pxai2s_resources,
> -	.num_resources	= ARRAY_SIZE(pxai2s_resources),
> -};
> -
> -struct platform_device pxa_device_asoc_ssp1 = {
> -	.name		= "pxa-ssp-dai",
> -	.id		= 0,
> -};
> -
> -struct platform_device pxa_device_asoc_ssp2= {
> -	.name		= "pxa-ssp-dai",
> -	.id		= 1,
> -};
> -
> -struct platform_device pxa_device_asoc_ssp3 = {
> -	.name		= "pxa-ssp-dai",
> -	.id		= 2,
> -};
> -
> -struct platform_device pxa_device_asoc_ssp4 = {
> -	.name		= "pxa-ssp-dai",
> -	.id		= 3,
> -};
> -
> -struct platform_device pxa_device_asoc_platform = {
> -	.name		= "pxa-pcm-audio",
> -	.id		= -1,
> -};
> -
> -static struct resource pxa_rtc_resources[] = {
> -	[0] = {
> -		.start  = 0x40900000,
> -		.end	= 0x40900000 + 0x3b,
> -		.flags  = IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start  = IRQ_RTC1Hz,
> -		.end    = IRQ_RTC1Hz,
> -		.name	= "rtc 1Hz",
> -		.flags  = IORESOURCE_IRQ,
> -	},
> -	[2] = {
> -		.start  = IRQ_RTCAlrm,
> -		.end    = IRQ_RTCAlrm,
> -		.name	= "rtc alarm",
> -		.flags  = IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa_device_rtc = {
> -	.name		= "pxa-rtc",
> -	.id		= -1,
> -	.num_resources  = ARRAY_SIZE(pxa_rtc_resources),
> -	.resource       = pxa_rtc_resources,
> -};
> -
> -struct platform_device sa1100_device_rtc = {
> -	.name		= "sa1100-rtc",
> -	.id		= -1,
> -	.num_resources  = ARRAY_SIZE(pxa_rtc_resources),
> -	.resource       = pxa_rtc_resources,
> -};
> -
> -#ifdef CONFIG_PXA25x
> -
> -static struct resource pxa25x_resource_pwm0[] = {
> -	[0] = {
> -		.start	= 0x40b00000,
> -		.end	= 0x40b0000f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -struct platform_device pxa25x_device_pwm0 = {
> -	.name		= "pxa25x-pwm",
> -	.id		= 0,
> -	.resource	= pxa25x_resource_pwm0,
> -	.num_resources	= ARRAY_SIZE(pxa25x_resource_pwm0),
> -};
> -
> -static struct resource pxa25x_resource_pwm1[] = {
> -	[0] = {
> -		.start	= 0x40c00000,
> -		.end	= 0x40c0000f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -struct platform_device pxa25x_device_pwm1 = {
> -	.name		= "pxa25x-pwm",
> -	.id		= 1,
> -	.resource	= pxa25x_resource_pwm1,
> -	.num_resources	= ARRAY_SIZE(pxa25x_resource_pwm1),
> -};
> -
> -static u64 pxa25x_ssp_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa25x_resource_ssp[] = {
> -	[0] = {
> -		.start	= 0x41000000,
> -		.end	= 0x4100001f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_SSP,
> -		.end	= IRQ_SSP,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa25x_device_ssp = {
> -	.name		= "pxa25x-ssp",
> -	.id		= 0,
> -	.dev		= {
> -		.dma_mask = &pxa25x_ssp_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.resource	= pxa25x_resource_ssp,
> -	.num_resources	= ARRAY_SIZE(pxa25x_resource_ssp),
> -};
> -
> -static u64 pxa25x_nssp_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa25x_resource_nssp[] = {
> -	[0] = {
> -		.start	= 0x41400000,
> -		.end	= 0x4140002f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_NSSP,
> -		.end	= IRQ_NSSP,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa25x_device_nssp = {
> -	.name		= "pxa25x-nssp",
> -	.id		= 1,
> -	.dev		= {
> -		.dma_mask = &pxa25x_nssp_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.resource	= pxa25x_resource_nssp,
> -	.num_resources	= ARRAY_SIZE(pxa25x_resource_nssp),
> -};
> -
> -static u64 pxa25x_assp_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa25x_resource_assp[] = {
> -	[0] = {
> -		.start	= 0x41500000,
> -		.end	= 0x4150002f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_ASSP,
> -		.end	= IRQ_ASSP,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa25x_device_assp = {
> -	/* ASSP is basically equivalent to NSSP */
> -	.name		= "pxa25x-nssp",
> -	.id		= 2,
> -	.dev		= {
> -		.dma_mask = &pxa25x_assp_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.resource	= pxa25x_resource_assp,
> -	.num_resources	= ARRAY_SIZE(pxa25x_resource_assp),
> -};
> -#endif /* CONFIG_PXA25x */
> -
> -#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
> -static u64 pxa27x_ohci_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa27x_resource_ohci[] = {
> -	[0] = {
> -		.start  = 0x4C000000,
> -		.end    = 0x4C00ff6f,
> -		.flags  = IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start  = IRQ_USBH1,
> -		.end    = IRQ_USBH1,
> -		.flags  = IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_ohci = {
> -	.name		= "pxa27x-ohci",
> -	.id		= -1,
> -	.dev		= {
> -		.dma_mask = &pxa27x_ohci_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.num_resources  = ARRAY_SIZE(pxa27x_resource_ohci),
> -	.resource       = pxa27x_resource_ohci,
> -};
> -
> -void __init pxa_set_ohci_info(struct pxaohci_platform_data *info)
> -{
> -	pxa_register_device(&pxa27x_device_ohci, info);
> -}
> -#endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
> -
> -#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
> -static u64 pxa27x_ssp1_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa27x_resource_ssp1[] = {
> -	[0] = {
> -		.start	= 0x41000000,
> -		.end	= 0x4100003f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_SSP,
> -		.end	= IRQ_SSP,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_ssp1 = {
> -	.name		= "pxa27x-ssp",
> -	.id		= 0,
> -	.dev		= {
> -		.dma_mask = &pxa27x_ssp1_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.resource	= pxa27x_resource_ssp1,
> -	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp1),
> -};
> -
> -static u64 pxa27x_ssp2_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa27x_resource_ssp2[] = {
> -	[0] = {
> -		.start	= 0x41700000,
> -		.end	= 0x4170003f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_SSP2,
> -		.end	= IRQ_SSP2,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_ssp2 = {
> -	.name		= "pxa27x-ssp",
> -	.id		= 1,
> -	.dev		= {
> -		.dma_mask = &pxa27x_ssp2_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.resource	= pxa27x_resource_ssp2,
> -	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp2),
> -};
> -
> -static u64 pxa27x_ssp3_dma_mask = DMA_BIT_MASK(32);
> -
> -static struct resource pxa27x_resource_ssp3[] = {
> -	[0] = {
> -		.start	= 0x41900000,
> -		.end	= 0x4190003f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_SSP3,
> -		.end	= IRQ_SSP3,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_ssp3 = {
> -	.name		= "pxa27x-ssp",
> -	.id		= 2,
> -	.dev		= {
> -		.dma_mask = &pxa27x_ssp3_dma_mask,
> -		.coherent_dma_mask = DMA_BIT_MASK(32),
> -	},
> -	.resource	= pxa27x_resource_ssp3,
> -	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp3),
> -};
> -
> -static struct resource pxa27x_resource_pwm0[] = {
> -	[0] = {
> -		.start	= 0x40b00000,
> -		.end	= 0x40b0001f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_pwm0 = {
> -	.name		= "pxa27x-pwm",
> -	.id		= 0,
> -	.resource	= pxa27x_resource_pwm0,
> -	.num_resources	= ARRAY_SIZE(pxa27x_resource_pwm0),
> -};
> -
> -static struct resource pxa27x_resource_pwm1[] = {
> -	[0] = {
> -		.start	= 0x40c00000,
> -		.end	= 0x40c0001f,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_pwm1 = {
> -	.name		= "pxa27x-pwm",
> -	.id		= 1,
> -	.resource	= pxa27x_resource_pwm1,
> -	.num_resources	= ARRAY_SIZE(pxa27x_resource_pwm1),
> -};
> -#endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
> -
> -#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
> -const struct software_node pxa2xx_gpiochip_node = {
> -	.name	= "gpio-pxa",
> -};
> -
> -struct resource pxa_resource_gpio[] = {
> -	{
> -		.start	= 0x40e00000,
> -		.end	= 0x40e0ffff,
> -		.flags	= IORESOURCE_MEM,
> -	}, {
> -		.start	= IRQ_GPIO0,
> -		.end	= IRQ_GPIO0,
> -		.name	= "gpio0",
> -		.flags	= IORESOURCE_IRQ,
> -	}, {
> -		.start	= IRQ_GPIO1,
> -		.end	= IRQ_GPIO1,
> -		.name	= "gpio1",
> -		.flags	= IORESOURCE_IRQ,
> -	}, {
> -		.start	= IRQ_GPIO_2_x,
> -		.end	= IRQ_GPIO_2_x,
> -		.name	= "gpio_mux",
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct pxa_gpio_platform_data pxa2xx_gpio_info = {
> -	.irq_base	= PXA_GPIO_TO_IRQ(0),
> -	.gpio_set_wake	= gpio_set_wake,
> -};
> -
> -struct platform_device pxa25x_device_gpio = {
> -	.name		= "pxa25x-gpio",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
> -	.resource	= pxa_resource_gpio,
> -	.dev		= {
> -		.platform_data	= &pxa2xx_gpio_info,
> -	},
> -};
> -
> -struct platform_device pxa27x_device_gpio = {
> -	.name		= "pxa27x-gpio",
> -	.id		= -1,
> -	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
> -	.resource	= pxa_resource_gpio,
> -	.dev		= {
> -		.platform_data	= &pxa2xx_gpio_info,
> -	},
> -};
> -#endif /* CONFIG_PXA25x || CONFIG_PXA27x */
> -
> -static struct resource pxa_dma_resource[] = {
> -	[0] = {
> -		.start	= 0x40000000,
> -		.end	= 0x4000ffff,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= IRQ_DMA,
> -		.end	= IRQ_DMA,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static u64 pxadma_dmamask = 0xffffffffUL;
> -
> -static struct platform_device pxa2xx_pxa_dma = {
> -	.name		= "pxa-dma",
> -	.id		= 0,
> -	.dev		= {
> -		.dma_mask = &pxadma_dmamask,
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources	= ARRAY_SIZE(pxa_dma_resource),
> -	.resource	= pxa_dma_resource,
> -};
> -
> -void __init pxa2xx_set_dmac_info(struct mmp_dma_platdata *dma_pdata)
> -{
> -	pxa_register_device(&pxa2xx_pxa_dma, dma_pdata);
> -}
>  
>  void __init pxa_register_wdt(unsigned int reset_status)
>  {
> diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
> deleted file mode 100644
> index 72c556ff67db..000000000000
> --- a/arch/arm/mach-pxa/devices.h
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#define PDMA_FILTER_PARAM(_prio, _requestor) (&(struct pxad_param) { \
> -	.prio = PXAD_PRIO_##_prio, .drcmr = _requestor })
> -struct mmp_dma_platdata;
> -
> -extern struct platform_device pxa_device_pmu;
> -extern struct platform_device pxa3xx_device_mci2;
> -extern struct platform_device pxa3xx_device_mci3;
> -extern struct platform_device pxa25x_device_udc;
> -extern struct platform_device pxa27x_device_udc;
> -extern struct platform_device pxa_device_fb;
> -extern struct platform_device pxa_device_ffuart;
> -extern struct platform_device pxa_device_btuart;
> -extern struct platform_device pxa_device_stuart;
> -extern struct platform_device pxa_device_hwuart;
> -extern struct platform_device pxa_device_i2c;
> -extern struct platform_device pxa_device_i2s;
> -extern struct platform_device sa1100_device_rtc;
> -extern struct platform_device pxa_device_rtc;
> -extern struct platform_device pxa_device_ac97;
> -
> -extern struct platform_device pxa27x_device_i2c_power;
> -extern struct platform_device pxa27x_device_ohci;
> -extern struct platform_device pxa27x_device_keypad;
> -
> -extern struct platform_device pxa25x_device_ssp;
> -extern struct platform_device pxa25x_device_nssp;
> -extern struct platform_device pxa25x_device_assp;
> -extern struct platform_device pxa27x_device_ssp1;
> -extern struct platform_device pxa27x_device_ssp2;
> -extern struct platform_device pxa27x_device_ssp3;
> -extern struct platform_device pxa3xx_device_ssp1;
> -extern struct platform_device pxa3xx_device_ssp2;
> -extern struct platform_device pxa3xx_device_ssp3;
> -extern struct platform_device pxa3xx_device_ssp4;
> -
> -extern struct platform_device pxa25x_device_pwm0;
> -extern struct platform_device pxa25x_device_pwm1;
> -extern struct platform_device pxa27x_device_pwm0;
> -extern struct platform_device pxa27x_device_pwm1;
> -
> -extern struct platform_device pxa3xx_device_nand;
> -extern struct platform_device pxa3xx_device_i2c_power;
> -
> -extern struct platform_device pxa3xx_device_gcu;
> -
> -extern struct platform_device pxa_device_asoc_platform;
> -extern struct platform_device pxa_device_asoc_ssp1;
> -extern struct platform_device pxa_device_asoc_ssp2;
> -extern struct platform_device pxa_device_asoc_ssp3;
> -extern struct platform_device pxa_device_asoc_ssp4;
> -
> -extern struct platform_device pxa25x_device_gpio;
> -extern struct platform_device pxa27x_device_gpio;
> -
> -extern const struct software_node pxa2xx_gpiochip_node;
> -
> -void __init pxa_register_device(struct platform_device *dev, void *data);
> -void __init pxa2xx_set_dmac_info(struct mmp_dma_platdata *dma_pdata);
> -
> -struct i2c_pxa_platform_data;
> -extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
> -#ifdef CONFIG_PXA27x
> -extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
> -#endif
> -#ifdef CONFIG_PXA3xx
> -extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
> -#endif
> diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
> index caad4fca8de3..239d1b4119cc 100644
> --- a/arch/arm/mach-pxa/generic.h
> +++ b/arch/arm/mach-pxa/generic.h
> @@ -38,11 +38,6 @@ extern struct syscore pxa_irq_syscore;
>  extern struct syscore pxa2xx_mfp_syscore;
>  extern struct syscore pxa3xx_mfp_syscore;
>  
> -void __init pxa_set_ffuart_info(void *info);
> -void __init pxa_set_btuart_info(void *info);
> -void __init pxa_set_stuart_info(void *info);
> -void __init pxa_set_hwuart_info(void *info);
> -
>  void pxa_restart(enum reboot_mode, const char *);
>  
>  #if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
> diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
> deleted file mode 100644
> index 7ab0cb015d1b..000000000000
> --- a/arch/arm/mach-pxa/gumstix.c
> +++ /dev/null
> @@ -1,237 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/mach-pxa/gumstix.c
> - *
> - *  Support for the Gumstix motherboards.
> - *
> - *  Original Author:	Craig Hughes
> - *  Created:	Feb 14, 2008
> - *  Copyright:	Craig Hughes
> - *
> - *  Implemented based on lubbock.c by Nicolas Pitre and code from Craig
> - *  Hughes
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/gpio/property.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/err.h>
> -#include <linux/clk.h>
> -
> -#include <asm/setup.h>
> -#include <asm/page.h>
> -#include <asm/mach-types.h>
> -#include <asm/irq.h>
> -#include <linux/sizes.h>
> -
> -#include <asm/mach/arch.h>
> -#include <asm/mach/map.h>
> -#include <asm/mach/irq.h>
> -#include <asm/mach/flash.h>
> -
> -#include "pxa25x.h"
> -#include <linux/platform_data/mmc-pxamci.h>
> -#include "gumstix.h"
> -#include "devices.h"
> -
> -#include "generic.h"
> -
> -static struct resource flash_resource = {
> -	.start	= 0x00000000,
> -	.end	= SZ_64M - 1,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -static struct mtd_partition gumstix_partitions[] = {
> -	{
> -		.name =		"Bootloader",
> -		.size =		0x00040000,
> -		.offset =	0,
> -		.mask_flags =	MTD_WRITEABLE  /* force read-only */
> -	} , {
> -		.name =		"rootfs",
> -		.size =		MTDPART_SIZ_FULL,
> -		.offset =	MTDPART_OFS_APPEND
> -	}
> -};
> -
> -static struct flash_platform_data gumstix_flash_data = {
> -	.map_name	= "cfi_probe",
> -	.parts		= gumstix_partitions,
> -	.nr_parts	= ARRAY_SIZE(gumstix_partitions),
> -	.width		= 2,
> -};
> -
> -static struct platform_device gumstix_flash_device = {
> -	.name		= "pxa2xx-flash",
> -	.id		= 0,
> -	.dev = {
> -		.platform_data = &gumstix_flash_data,
> -	},
> -	.resource = &flash_resource,
> -	.num_resources = 1,
> -};
> -
> -static struct platform_device *devices[] __initdata = {
> -	&gumstix_flash_device,
> -};
> -
> -#ifdef CONFIG_MMC_PXA
> -static struct pxamci_platform_data gumstix_mci_platform_data = {
> -	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
> -};
> -
> -static void __init gumstix_mmc_init(void)
> -{
> -	pxa_set_mci_info(&gumstix_mci_platform_data, NULL);
> -}
> -#else
> -static void __init gumstix_mmc_init(void)
> -{
> -	pr_debug("Gumstix mmc disabled\n");
> -}
> -#endif
> -
> -#if IS_ENABLED(CONFIG_USB_PXA25X)
> -static const struct property_entry gumstix_vbus_props[] __initconst = {
> -	PROPERTY_ENTRY_GPIO("vbus-gpios", &pxa2xx_gpiochip_node,
> -			    GPIO_GUMSTIX_USB_GPIOn, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_GPIO("pullup-gpios", &pxa2xx_gpiochip_node,
> -			    GPIO_GUMSTIX_USB_GPIOx, GPIO_ACTIVE_HIGH),
> -	{ }
> -};
> -
> -static const struct platform_device_info gumstix_gpio_vbus_info __initconst = {
> -	.name		= "gpio-vbus",
> -	.id		= PLATFORM_DEVID_NONE,
> -	.properties	= gumstix_vbus_props,
> -};
> -
> -static void __init gumstix_udc_init(void)
> -{
> -	platform_device_register_full(&gumstix_gpio_vbus_info);
> -}
> -#else
> -static void gumstix_udc_init(void)
> -{
> -	pr_debug("Gumstix udc is disabled\n");
> -}
> -#endif
> -
> -#ifdef CONFIG_BT
> -/* Normally, the bootloader would have enabled this 32kHz clock but many
> -** boards still have u-boot 1.1.4 so we check if it has been turned on and
> -** if not, we turn it on with a warning message. */
> -static void gumstix_setup_bt_clock(void)
> -{
> -	int timeout = 500;
> -
> -	if (!(readl(OSCC) & OSCC_OOK))
> -		pr_warn("32kHz clock was not on. Bootloader may need to be updated\n");
> -	else
> -		return;
> -
> -	writel(readl(OSCC) | OSCC_OON, OSCC);
> -	do {
> -		if (readl(OSCC) & OSCC_OOK)
> -			break;
> -		udelay(1);
> -	} while (--timeout);
> -	if (!timeout)
> -		pr_err("Failed to start 32kHz clock\n");
> -}
> -
> -static void __init gumstix_bluetooth_init(void)
> -{
> -	int err;
> -
> -	gumstix_setup_bt_clock();
> -
> -	err = gpio_request(GPIO_GUMSTIX_BTRESET, "BTRST");
> -	if (err) {
> -		pr_err("gumstix: failed request gpio for bluetooth reset\n");
> -		return;
> -	}
> -
> -	err = gpio_direction_output(GPIO_GUMSTIX_BTRESET, 1);
> -	if (err) {
> -		pr_err("gumstix: can't reset bluetooth\n");
> -		return;
> -	}
> -	gpio_set_value(GPIO_GUMSTIX_BTRESET, 0);
> -	udelay(100);
> -	gpio_set_value(GPIO_GUMSTIX_BTRESET, 1);
> -}
> -#else
> -static void gumstix_bluetooth_init(void)
> -{
> -	pr_debug("Gumstix Bluetooth is disabled\n");
> -}
> -#endif
> -
> -static unsigned long gumstix_pin_config[] __initdata = {
> -	GPIO12_32KHz,
> -	/* BTUART */
> -	GPIO42_HWUART_RXD,
> -	GPIO43_HWUART_TXD,
> -	GPIO44_HWUART_CTS,
> -	GPIO45_HWUART_RTS,
> -	/* MMC */
> -	GPIO6_MMC_CLK,
> -	GPIO53_MMC_CLK,
> -	GPIO8_MMC_CS0,
> -};
> -
> -int __attribute__((weak)) am200_init(void)
> -{
> -	return 0;
> -}
> -
> -int __attribute__((weak)) am300_init(void)
> -{
> -	return 0;
> -}
> -
> -static void __init carrier_board_init(void)
> -{
> -	/*
> -	 * put carrier/expansion board init here if
> -	 * they cannot be detected programatically
> -	 */
> -	am200_init();
> -	am300_init();
> -}
> -
> -static void __init gumstix_init(void)
> -{
> -	pxa2xx_mfp_config(ARRAY_AND_SIZE(gumstix_pin_config));
> -
> -	pxa_set_ffuart_info(NULL);
> -	pxa_set_btuart_info(NULL);
> -	pxa_set_stuart_info(NULL);
> -	pxa_set_hwuart_info(NULL);
> -
> -	gumstix_bluetooth_init();
> -	gumstix_udc_init();
> -	gumstix_mmc_init();
> -	(void) platform_add_devices(devices, ARRAY_SIZE(devices));
> -	carrier_board_init();
> -}
> -
> -MACHINE_START(GUMSTIX, "Gumstix")
> -	.atag_offset	= 0x100, /* match u-boot bi_boot_params */
> -	.map_io		= pxa25x_map_io,
> -	.nr_irqs	= PXA_NR_IRQS,
> -	.init_irq	= pxa25x_init_irq,
> -	.init_time	= pxa_timer_init,
> -	.init_machine	= gumstix_init,
> -	.restart	= pxa_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-pxa/gumstix.h b/arch/arm/mach-pxa/gumstix.h
> deleted file mode 100644
> index 9005b3c0aabd..000000000000
> --- a/arch/arm/mach-pxa/gumstix.h
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-pxa/include/mach/gumstix.h
> - */
> -
> -#include "irqs.h" /* PXA_GPIO_TO_IRQ */
> -
> -/* BTRESET - Reset line to Bluetooth module, active low signal. */
> -#define GPIO_GUMSTIX_BTRESET          7
> -#define GPIO_GUMSTIX_BTRESET_MD		(GPIO_GUMSTIX_BTRESET | GPIO_OUT)
> -
> -
> -/*
> -GPIOn - Input from MAX823 (or equiv), normalizing USB +5V into a clean
> -interrupt signal for determining cable presence. On the gumstix F,
> -this moves to GPIO17 and GPIO37. */
> -
> -/* GPIOx - Connects to USB D+ and used as a pull-up after GPIOn
> -has detected a cable insertion; driven low otherwise. */
> -
> -#define GPIO_GUMSTIX_USB_GPIOn		35
> -#define GPIO_GUMSTIX_USB_GPIOx		41
> -
> -/* usb state change */
> -#define GUMSTIX_USB_INTR_IRQ		PXA_GPIO_TO_IRQ(GPIO_GUMSTIX_USB_GPIOn)
> -
> -#define GPIO_GUMSTIX_USB_GPIOn_MD	(GPIO_GUMSTIX_USB_GPIOn | GPIO_IN)
> -#define GPIO_GUMSTIX_USB_GPIOx_CON_MD	(GPIO_GUMSTIX_USB_GPIOx | GPIO_OUT)
> -#define GPIO_GUMSTIX_USB_GPIOx_DIS_MD	(GPIO_GUMSTIX_USB_GPIOx | GPIO_IN)
> -
> -/*
> - * SD/MMC definitions
> - */
> -#define GUMSTIX_GPIO_nSD_WP		22 /* SD Write Protect */
> -#define GUMSTIX_GPIO_nSD_DETECT		11 /* MMC/SD Card Detect */
> -#define GUMSTIX_IRQ_GPIO_nSD_DETECT	PXA_GPIO_TO_IRQ(GUMSTIX_GPIO_nSD_DETECT)
> -
> -/*
> - * SMC Ethernet definitions
> - * ETH_RST provides a hardware reset line to the ethernet chip
> - * ETH is the IRQ line in from the ethernet chip to the PXA
> - */
> -#define GPIO_GUMSTIX_ETH0_RST		80
> -#define GPIO_GUMSTIX_ETH0_RST_MD	(GPIO_GUMSTIX_ETH0_RST | GPIO_OUT)
> -#define GPIO_GUMSTIX_ETH1_RST		52
> -#define GPIO_GUMSTIX_ETH1_RST_MD	(GPIO_GUMSTIX_ETH1_RST | GPIO_OUT)
> -
> -#define GPIO_GUMSTIX_ETH0		36
> -#define GPIO_GUMSTIX_ETH0_MD		(GPIO_GUMSTIX_ETH0 | GPIO_IN)
> -#define GUMSTIX_ETH0_IRQ		PXA_GPIO_TO_IRQ(GPIO_GUMSTIX_ETH0)
> -#define GPIO_GUMSTIX_ETH1		27
> -#define GPIO_GUMSTIX_ETH1_MD		(GPIO_GUMSTIX_ETH1 | GPIO_IN)
> -#define GUMSTIX_ETH1_IRQ		PXA_GPIO_TO_IRQ(GPIO_GUMSTIX_ETH1)
> -
> -
> -/* CF reset line */
> -#define GPIO8_RESET			8
> -
> -/* CF slot 0 */
> -#define GPIO4_nBVD1			4
> -#define GPIO4_nSTSCHG			GPIO4_nBVD1
> -#define GPIO11_nCD			11
> -#define GPIO26_PRDY_nBSY		26
> -#define GUMSTIX_S0_nSTSCHG_IRQ		PXA_GPIO_TO_IRQ(GPIO4_nSTSCHG)
> -#define GUMSTIX_S0_nCD_IRQ		PXA_GPIO_TO_IRQ(GPIO11_nCD)
> -#define GUMSTIX_S0_PRDY_nBSY_IRQ	PXA_GPIO_TO_IRQ(GPIO26_PRDY_nBSY)
> -
> -/* CF slot 1 */
> -#define GPIO18_nBVD1			18
> -#define GPIO18_nSTSCHG			GPIO18_nBVD1
> -#define GPIO36_nCD			36
> -#define GPIO27_PRDY_nBSY		27
> -#define GUMSTIX_S1_nSTSCHG_IRQ		PXA_GPIO_TO_IRQ(GPIO18_nSTSCHG)
> -#define GUMSTIX_S1_nCD_IRQ		PXA_GPIO_TO_IRQ(GPIO36_nCD)
> -#define GUMSTIX_S1_PRDY_nBSY_IRQ	PXA_GPIO_TO_IRQ(GPIO27_PRDY_nBSY)
> -
> -/* CF GPIO line modes */
> -#define GPIO4_nSTSCHG_MD		(GPIO4_nSTSCHG | GPIO_IN)
> -#define GPIO8_RESET_MD			(GPIO8_RESET | GPIO_OUT)
> -#define GPIO11_nCD_MD			(GPIO11_nCD | GPIO_IN)
> -#define GPIO18_nSTSCHG_MD		(GPIO18_nSTSCHG | GPIO_IN)
> -#define GPIO26_PRDY_nBSY_MD		(GPIO26_PRDY_nBSY | GPIO_IN)
> -#define GPIO27_PRDY_nBSY_MD		(GPIO27_PRDY_nBSY | GPIO_IN)
> -#define GPIO36_nCD_MD			(GPIO36_nCD | GPIO_IN)
> -
> -/* for expansion boards that can't be programatically detected */
> -extern int am200_init(void);
> -extern int am300_init(void);
> -
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index a273f0af095e..de6a306cf0e2 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -25,7 +25,6 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> -#include <linux/platform_data/mmp_dma.h>
>  #include <linux/soc/pxa/cpu.h>
>  #include <linux/soc/pxa/smemc.h>
>  
> @@ -39,7 +38,6 @@
>  #include "smemc.h"
>  
>  #include "generic.h"
> -#include "devices.h"
>  
>  /*
>   * Various clock factors driven by the CCCR register.
> @@ -178,53 +176,6 @@ void __init pxa25x_map_io(void)
>  	pxa25x_get_clk_frequency_khz(1);
>  }
>  
> -static struct platform_device *pxa25x_devices[] __initdata = {
> -	&pxa25x_device_gpio,
> -	&pxa25x_device_udc,
> -	&pxa_device_pmu,
> -	&pxa_device_i2s,
> -	&sa1100_device_rtc,
> -	&pxa25x_device_ssp,
> -	&pxa25x_device_nssp,
> -	&pxa25x_device_assp,
> -	&pxa25x_device_pwm0,
> -	&pxa25x_device_pwm1,
> -	&pxa_device_asoc_platform,
> -};
> -
> -static const struct dma_slave_map pxa25x_slave_map[] = {
> -	/* PXA25x, PXA27x and PXA3xx common entries */
> -	{ "pxa2xx-ac97", "pcm_pcm_mic_mono", PDMA_FILTER_PARAM(LOWEST, 8) },
> -	{ "pxa2xx-ac97", "pcm_pcm_aux_mono_in", PDMA_FILTER_PARAM(LOWEST, 9) },
> -	{ "pxa2xx-ac97", "pcm_pcm_aux_mono_out",
> -	  PDMA_FILTER_PARAM(LOWEST, 10) },
> -	{ "pxa2xx-ac97", "pcm_pcm_stereo_in", PDMA_FILTER_PARAM(LOWEST, 11) },
> -	{ "pxa2xx-ac97", "pcm_pcm_stereo_out", PDMA_FILTER_PARAM(LOWEST, 12) },
> -	{ "pxa-ssp-dai.1", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> -	{ "pxa-ssp-dai.1", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> -	{ "pxa-ssp-dai.2", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> -	{ "pxa-ssp-dai.2", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> -	{ "pxa2xx-ir", "rx", PDMA_FILTER_PARAM(LOWEST, 17) },
> -	{ "pxa2xx-ir", "tx", PDMA_FILTER_PARAM(LOWEST, 18) },
> -	{ "pxa2xx-mci.0", "rx", PDMA_FILTER_PARAM(LOWEST, 21) },
> -	{ "pxa2xx-mci.0", "tx", PDMA_FILTER_PARAM(LOWEST, 22) },
> -
> -	/* PXA25x specific map */
> -	{ "pxa25x-ssp.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> -	{ "pxa25x-ssp.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> -	{ "pxa25x-nssp.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> -	{ "pxa25x-nssp.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> -	{ "pxa25x-nssp.2", "rx", PDMA_FILTER_PARAM(LOWEST, 23) },
> -	{ "pxa25x-nssp.2", "tx", PDMA_FILTER_PARAM(LOWEST, 24) },
> -};
> -
> -static struct mmp_dma_platdata pxa25x_dma_pdata = {
> -	.dma_channels	= 16,
> -	.nb_requestors	= 40,
> -	.slave_map	= pxa25x_slave_map,
> -	.slave_map_cnt	= ARRAY_SIZE(pxa25x_slave_map),
> -};
> -
>  static int __init pxa25x_init(void)
>  {
>  	int ret = 0;
> @@ -237,16 +188,6 @@ static int __init pxa25x_init(void)
>  
>  		register_syscore(&pxa_irq_syscore);
>  		register_syscore(&pxa2xx_mfp_syscore);
> -
> -		if (!of_have_populated_dt()) {
> -			software_node_register(&pxa2xx_gpiochip_node);
> -			pxa25x_device_gpio.dev.fwnode = software_node_fwnode(
> -								&pxa2xx_gpiochip_node);
> -
> -			pxa2xx_set_dmac_info(&pxa25x_dma_pdata);
> -			ret = platform_add_devices(pxa25x_devices,
> -						   ARRAY_SIZE(pxa25x_devices));
> -		}
>  	}
>  
>  	return ret;
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 814e0a12f38a..617af225628b 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -21,8 +21,6 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> -#include <linux/platform_data/i2c-pxa.h>
> -#include <linux/platform_data/mmp_dma.h>
>  #include <linux/soc/pxa/cpu.h>
>  #include <linux/soc/pxa/smemc.h>
>  
> @@ -33,14 +31,12 @@
>  #include "pxa27x.h"
>  #include "reset.h"
>  #include <linux/platform_data/pxa2xx_udc.h>
> -#include <linux/platform_data/usb-ohci-pxa27x.h>
>  #include <linux/platform_data/asoc-pxa.h>
>  #include "pm.h"
>  #include "addr-map.h"
>  #include "smemc.h"
>  
>  #include "generic.h"
> -#include "devices.h"
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
>  
> @@ -272,90 +268,17 @@ void __init pxa27x_map_io(void)
>  	pxa27x_get_clk_frequency_khz(1);
>  }
>  
> -/*
> - * device registration specific to PXA27x.
> - */
> -void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
> -{
> -	local_irq_disable();
> -	PCFR |= PCFR_PI2CEN;
> -	local_irq_enable();
> -	pxa_register_device(&pxa27x_device_i2c_power, info);
> -}
> -
> -static struct platform_device *devices[] __initdata = {
> -	&pxa27x_device_gpio,
> -	&pxa27x_device_udc,
> -	&pxa_device_pmu,
> -	&pxa_device_i2s,
> -	&pxa_device_asoc_ssp1,
> -	&pxa_device_asoc_ssp2,
> -	&pxa_device_asoc_ssp3,
> -	&pxa_device_asoc_platform,
> -	&pxa_device_rtc,
> -	&pxa27x_device_ssp1,
> -	&pxa27x_device_ssp2,
> -	&pxa27x_device_ssp3,
> -	&pxa27x_device_pwm0,
> -	&pxa27x_device_pwm1,
> -};
> -
> -static const struct dma_slave_map pxa27x_slave_map[] = {
> -	/* PXA25x, PXA27x and PXA3xx common entries */
> -	{ "pxa2xx-ac97", "pcm_pcm_mic_mono", PDMA_FILTER_PARAM(LOWEST, 8) },
> -	{ "pxa2xx-ac97", "pcm_pcm_aux_mono_in", PDMA_FILTER_PARAM(LOWEST, 9) },
> -	{ "pxa2xx-ac97", "pcm_pcm_aux_mono_out",
> -	  PDMA_FILTER_PARAM(LOWEST, 10) },
> -	{ "pxa2xx-ac97", "pcm_pcm_stereo_in", PDMA_FILTER_PARAM(LOWEST, 11) },
> -	{ "pxa2xx-ac97", "pcm_pcm_stereo_out", PDMA_FILTER_PARAM(LOWEST, 12) },
> -	{ "pxa-ssp-dai.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> -	{ "pxa-ssp-dai.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> -	{ "pxa-ssp-dai.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> -	{ "pxa-ssp-dai.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> -	{ "pxa2xx-ir", "rx", PDMA_FILTER_PARAM(LOWEST, 17) },
> -	{ "pxa2xx-ir", "tx", PDMA_FILTER_PARAM(LOWEST, 18) },
> -	{ "pxa2xx-mci.0", "rx", PDMA_FILTER_PARAM(LOWEST, 21) },
> -	{ "pxa2xx-mci.0", "tx", PDMA_FILTER_PARAM(LOWEST, 22) },
> -	{ "pxa-ssp-dai.2", "rx", PDMA_FILTER_PARAM(LOWEST, 66) },
> -	{ "pxa-ssp-dai.2", "tx", PDMA_FILTER_PARAM(LOWEST, 67) },
> -
> -	/* PXA27x specific map */
> -	{ "pxa2xx-i2s", "rx", PDMA_FILTER_PARAM(LOWEST, 2) },
> -	{ "pxa2xx-i2s", "tx", PDMA_FILTER_PARAM(LOWEST, 3) },
> -	{ "pxa27x-camera.0", "CI_Y", PDMA_FILTER_PARAM(HIGHEST, 68) },
> -	{ "pxa27x-camera.0", "CI_U", PDMA_FILTER_PARAM(HIGHEST, 69) },
> -	{ "pxa27x-camera.0", "CI_V", PDMA_FILTER_PARAM(HIGHEST, 70) },
> -};
> -
> -static struct mmp_dma_platdata pxa27x_dma_pdata = {
> -	.dma_channels	= 32,
> -	.nb_requestors	= 75,
> -	.slave_map	= pxa27x_slave_map,
> -	.slave_map_cnt	= ARRAY_SIZE(pxa27x_slave_map),
> -};
> -
>  static int __init pxa27x_init(void)
>  {
>  	int ret = 0;
>  
>  	if (cpu_is_pxa27x()) {
> -
>  		pxa_register_wdt(RCSR);
>  
>  		pxa27x_init_pm();
>  
>  		register_syscore(&pxa_irq_syscore);
>  		register_syscore(&pxa2xx_mfp_syscore);
> -
> -		if (!of_have_populated_dt()) {
> -			software_node_register(&pxa2xx_gpiochip_node);
> -			pxa27x_device_gpio.dev.fwnode = software_node_fwnode(
> -								&pxa2xx_gpiochip_node);
> -
> -			pxa2xx_set_dmac_info(&pxa27x_dma_pdata);
> -			ret = platform_add_devices(devices,
> -						   ARRAY_SIZE(devices));
> -		}
>  	}
>  
>  	return ret;
> diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
> index f77ec118d5b9..0022bf235114 100644
> --- a/arch/arm/mach-pxa/pxa300.c
> +++ b/arch/arm/mach-pxa/pxa300.c
> @@ -19,7 +19,6 @@
>  #include "pxa300.h"
>  
>  #include "generic.h"
> -#include "devices.h"
>  
>  static struct mfp_addr_map pxa300_mfp_addr_map[] __initdata = {
>  
> diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
> index e372e6c118de..2e84afd94467 100644
> --- a/arch/arm/mach-pxa/pxa320.c
> +++ b/arch/arm/mach-pxa/pxa320.c
> @@ -19,7 +19,6 @@
>  #include "pxa320.h"
>  
>  #include "generic.h"
> -#include "devices.h"
>  
>  static struct mfp_addr_map pxa320_mfp_addr_map[] __initdata = {
>  
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index 06c578ea658e..46f4efdfb514 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -10,11 +10,9 @@
>   *             initial version
>   */
>  #include <linux/dmaengine.h>
> -#include <linux/dma/pxa-dma.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/gpio-pxa.h>
>  #include <linux/pm.h>
>  #include <linux/platform_device.h>
>  #include <linux/irq.h>
> @@ -22,8 +20,6 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/syscore_ops.h>
> -#include <linux/platform_data/i2c-pxa.h>
> -#include <linux/platform_data/mmp_dma.h>
>  #include <linux/soc/pxa/cpu.h>
>  #include <linux/clk/pxa.h>
>  
> @@ -31,14 +27,12 @@
>  #include <asm/suspend.h>
>  #include "pxa3xx-regs.h"
>  #include "reset.h"
> -#include <linux/platform_data/usb-ohci-pxa27x.h>
>  #include "pm.h"
>  #include "addr-map.h"
>  #include "smemc.h"
>  #include "irqs.h"
>  
>  #include "generic.h"
> -#include "devices.h"
>  
>  #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
>  #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
> deleted file mode 100644
> index a611eea70e5a..000000000000
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ /dev/null
> @@ -1,941 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Battery and Power Management code for the Sharp SL-C7xx and SL-Cxx00
> - * series of PDAs
> - *
> - * Copyright (c) 2004-2005 Richard Purdie
> - *
> - * Based on code written by Sharp for 2.4 kernels
> - */
> -
> -#undef DEBUG
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/apm-emulation.h>
> -#include <linux/timer.h>
> -#include <linux/delay.h>
> -#include <linux/leds.h>
> -#include <linux/suspend.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/io.h>
> -
> -#include <asm/mach-types.h>
> -#include "pm.h"
> -#include "pxa2xx-regs.h"
> -#include "regs-rtc.h"
> -#include "sharpsl_pm.h"
> -
> -/*
> - * Constants
> - */
> -#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (secs_to_jiffies(60))
> -#define SHARPSL_CHARGE_FINISH_TIME             (secs_to_jiffies(10*60))
> -#define SHARPSL_BATCHK_TIME                    (secs_to_jiffies(15))
> -#define SHARPSL_BATCHK_TIME_SUSPEND            (60*10) /* 10 min */
> -
> -#define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
> -#define SHARPSL_WAIT_DISCHARGE_ON              100 /* 100 msec */
> -#define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
> -#define SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT   10  /* 10 msec */
> -#define SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN   10  /* 10 msec */
> -#define SHARPSL_CHARGE_WAIT_TIME               15  /* 15 msec */
> -#define SHARPSL_CHARGE_CO_CHECK_TIME           5   /* 5 msec */
> -#define SHARPSL_CHARGE_RETRY_CNT               1   /* eqv. 10 min */
> -
> -/*
> - * Prototypes
> - */
> -#ifdef CONFIG_PM
> -static int sharpsl_off_charge_battery(void);
> -static int sharpsl_check_battery_voltage(void);
> -#endif
> -static int sharpsl_check_battery_temp(void);
> -static int sharpsl_ac_check(void);
> -static int sharpsl_average_value(int ad);
> -static void sharpsl_average_clear(void);
> -static void sharpsl_charge_toggle(struct work_struct *private_);
> -static void sharpsl_battery_thread(struct work_struct *private_);
> -
> -
> -/*
> - * Variables
> - */
> -struct sharpsl_pm_status sharpsl_pm;
> -static DECLARE_DELAYED_WORK(toggle_charger, sharpsl_charge_toggle);
> -static DECLARE_DELAYED_WORK(sharpsl_bat, sharpsl_battery_thread);
> -DEFINE_LED_TRIGGER(sharpsl_charge_led_trigger);
> -
> -
> -
> -struct battery_thresh sharpsl_battery_levels_acin[] = {
> -	{ 213, 100},
> -	{ 212,  98},
> -	{ 211,  95},
> -	{ 210,  93},
> -	{ 209,  90},
> -	{ 208,  88},
> -	{ 207,  85},
> -	{ 206,  83},
> -	{ 205,  80},
> -	{ 204,  78},
> -	{ 203,  75},
> -	{ 202,  73},
> -	{ 201,  70},
> -	{ 200,  68},
> -	{ 199,  65},
> -	{ 198,  63},
> -	{ 197,  60},
> -	{ 196,  58},
> -	{ 195,  55},
> -	{ 194,  53},
> -	{ 193,  50},
> -	{ 192,  48},
> -	{ 192,  45},
> -	{ 191,  43},
> -	{ 191,  40},
> -	{ 190,  38},
> -	{ 190,  35},
> -	{ 189,  33},
> -	{ 188,  30},
> -	{ 187,  28},
> -	{ 186,  25},
> -	{ 185,  23},
> -	{ 184,  20},
> -	{ 183,  18},
> -	{ 182,  15},
> -	{ 181,  13},
> -	{ 180,  10},
> -	{ 179,   8},
> -	{ 178,   5},
> -	{   0,   0},
> -};
> -
> -struct battery_thresh sharpsl_battery_levels_noac[] = {
> -	{ 213, 100},
> -	{ 212,  98},
> -	{ 211,  95},
> -	{ 210,  93},
> -	{ 209,  90},
> -	{ 208,  88},
> -	{ 207,  85},
> -	{ 206,  83},
> -	{ 205,  80},
> -	{ 204,  78},
> -	{ 203,  75},
> -	{ 202,  73},
> -	{ 201,  70},
> -	{ 200,  68},
> -	{ 199,  65},
> -	{ 198,  63},
> -	{ 197,  60},
> -	{ 196,  58},
> -	{ 195,  55},
> -	{ 194,  53},
> -	{ 193,  50},
> -	{ 192,  48},
> -	{ 191,  45},
> -	{ 190,  43},
> -	{ 189,  40},
> -	{ 188,  38},
> -	{ 187,  35},
> -	{ 186,  33},
> -	{ 185,  30},
> -	{ 184,  28},
> -	{ 183,  25},
> -	{ 182,  23},
> -	{ 181,  20},
> -	{ 180,  18},
> -	{ 179,  15},
> -	{ 178,  13},
> -	{ 177,  10},
> -	{ 176,   8},
> -	{ 175,   5},
> -	{   0,   0},
> -};
> -
> -/* MAX1111 Commands */
> -#define MAXCTRL_PD0      (1u << 0)
> -#define MAXCTRL_PD1      (1u << 1)
> -#define MAXCTRL_SGL      (1u << 2)
> -#define MAXCTRL_UNI      (1u << 3)
> -#define MAXCTRL_SEL_SH   4
> -#define MAXCTRL_STR      (1u << 7)
> -
> -extern int max1111_read_channel(int);
> -/*
> - * Read MAX1111 ADC
> - */
> -int sharpsl_pm_pxa_read_max1111(int channel)
> -{
> -	/* max1111 accepts channels from 0-3, however,
> -	 * it is encoded from 0-7 here in the code.
> -	 */
> -	return max1111_read_channel(channel >> 1);
> -}
> -
> -static int get_percentage(int voltage)
> -{
> -	int i = sharpsl_pm.machinfo->bat_levels - 1;
> -	int bl_status = sharpsl_pm.machinfo->backlight_get_status ? sharpsl_pm.machinfo->backlight_get_status() : 0;
> -	struct battery_thresh *thresh;
> -
> -	if (sharpsl_pm.charge_mode == CHRG_ON)
> -		thresh = bl_status ? sharpsl_pm.machinfo->bat_levels_acin_bl : sharpsl_pm.machinfo->bat_levels_acin;
> -	else
> -		thresh = bl_status ? sharpsl_pm.machinfo->bat_levels_noac_bl : sharpsl_pm.machinfo->bat_levels_noac;
> -
> -	while (i > 0 && (voltage > thresh[i].voltage))
> -		i--;
> -
> -	return thresh[i].percentage;
> -}
> -
> -static int get_apm_status(int voltage)
> -{
> -	int low_thresh, high_thresh;
> -
> -	if (sharpsl_pm.charge_mode == CHRG_ON) {
> -		high_thresh = sharpsl_pm.machinfo->status_high_acin;
> -		low_thresh = sharpsl_pm.machinfo->status_low_acin;
> -	} else {
> -		high_thresh = sharpsl_pm.machinfo->status_high_noac;
> -		low_thresh = sharpsl_pm.machinfo->status_low_noac;
> -	}
> -
> -	if (voltage >= high_thresh)
> -		return APM_BATTERY_STATUS_HIGH;
> -	if (voltage >= low_thresh)
> -		return APM_BATTERY_STATUS_LOW;
> -	return APM_BATTERY_STATUS_CRITICAL;
> -}
> -
> -void sharpsl_battery_kick(void)
> -{
> -	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
> -}
> -
> -static void sharpsl_battery_thread(struct work_struct *private_)
> -{
> -	int voltage, percent, apm_status, i;
> -
> -	if (!sharpsl_pm.machinfo)
> -		return;
> -
> -	sharpsl_pm.battstat.ac_status = (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN) ? APM_AC_ONLINE : APM_AC_OFFLINE);
> -
> -	/* Corgi cannot confirm when battery fully charged so periodically kick! */
> -	if (!sharpsl_pm.machinfo->batfull_irq && (sharpsl_pm.charge_mode == CHRG_ON)
> -			&& time_after(jiffies, sharpsl_pm.charge_start_time +  SHARPSL_CHARGE_ON_TIME_INTERVAL))
> -		schedule_delayed_work(&toggle_charger, 0);
> -
> -	for (i = 0; i < 5; i++) {
> -		voltage = sharpsl_pm.machinfo->read_devdata(SHARPSL_BATT_VOLT);
> -		if (voltage > 0)
> -			break;
> -	}
> -	if (voltage <= 0) {
> -		voltage = sharpsl_pm.machinfo->bat_levels_noac[0].voltage;
> -		dev_warn(sharpsl_pm.dev, "Warning: Cannot read main battery!\n");
> -	}
> -
> -	voltage = sharpsl_average_value(voltage);
> -	apm_status = get_apm_status(voltage);
> -	percent = get_percentage(voltage);
> -
> -	/* At low battery voltages, the voltage has a tendency to start
> -	   creeping back up so we try to avoid this here */
> -	if ((sharpsl_pm.battstat.ac_status == APM_AC_ONLINE)
> -	    || (apm_status == APM_BATTERY_STATUS_HIGH)
> -	    || percent <= sharpsl_pm.battstat.mainbat_percent) {
> -		sharpsl_pm.battstat.mainbat_voltage = voltage;
> -		sharpsl_pm.battstat.mainbat_status = apm_status;
> -		sharpsl_pm.battstat.mainbat_percent = percent;
> -	}
> -
> -	dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %ld\n", voltage,
> -			sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
> -
> -	/* Suspend if critical battery level */
> -	if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
> -	     && (sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL)
> -	     && !(sharpsl_pm.flags & SHARPSL_APM_QUEUED)) {
> -		sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
> -		dev_err(sharpsl_pm.dev, "Fatal Off\n");
> -		apm_queue_event(APM_CRITICAL_SUSPEND);
> -	}
> -
> -	schedule_delayed_work(&sharpsl_bat, SHARPSL_BATCHK_TIME);
> -}
> -
> -void sharpsl_pm_led(int val)
> -{
> -	if (val == SHARPSL_LED_ERROR) {
> -		dev_err(sharpsl_pm.dev, "Charging Error!\n");
> -	} else if (val == SHARPSL_LED_ON) {
> -		dev_dbg(sharpsl_pm.dev, "Charge LED On\n");
> -		led_trigger_event(sharpsl_charge_led_trigger, LED_FULL);
> -	} else {
> -		dev_dbg(sharpsl_pm.dev, "Charge LED Off\n");
> -		led_trigger_event(sharpsl_charge_led_trigger, LED_OFF);
> -	}
> -}
> -
> -static void sharpsl_charge_on(void)
> -{
> -	dev_dbg(sharpsl_pm.dev, "Turning Charger On\n");
> -
> -	sharpsl_pm.full_count = 0;
> -	sharpsl_pm.charge_mode = CHRG_ON;
> -	schedule_delayed_work(&toggle_charger, msecs_to_jiffies(250));
> -	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(500));
> -}
> -
> -static void sharpsl_charge_off(void)
> -{
> -	dev_dbg(sharpsl_pm.dev, "Turning Charger Off\n");
> -
> -	sharpsl_pm.machinfo->charge(0);
> -	sharpsl_pm_led(SHARPSL_LED_OFF);
> -	sharpsl_pm.charge_mode = CHRG_OFF;
> -
> -	schedule_delayed_work(&sharpsl_bat, 0);
> -}
> -
> -static void sharpsl_charge_error(void)
> -{
> -	sharpsl_pm_led(SHARPSL_LED_ERROR);
> -	sharpsl_pm.machinfo->charge(0);
> -	sharpsl_pm.charge_mode = CHRG_ERROR;
> -}
> -
> -static void sharpsl_charge_toggle(struct work_struct *private_)
> -{
> -	dev_dbg(sharpsl_pm.dev, "Toggling Charger at time: %lx\n", jiffies);
> -
> -	if (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
> -		sharpsl_charge_off();
> -		return;
> -	} else if ((sharpsl_check_battery_temp() < 0) || (sharpsl_ac_check() < 0)) {
> -		sharpsl_charge_error();
> -		return;
> -	}
> -
> -	sharpsl_pm_led(SHARPSL_LED_ON);
> -	sharpsl_pm.machinfo->charge(0);
> -	mdelay(SHARPSL_CHARGE_WAIT_TIME);
> -	sharpsl_pm.machinfo->charge(1);
> -
> -	sharpsl_pm.charge_start_time = jiffies;
> -}
> -
> -static void sharpsl_ac_timer(struct timer_list *unused)
> -{
> -	int acin = sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN);
> -
> -	dev_dbg(sharpsl_pm.dev, "AC Status: %d\n", acin);
> -
> -	sharpsl_average_clear();
> -	if (acin && (sharpsl_pm.charge_mode != CHRG_ON))
> -		sharpsl_charge_on();
> -	else if (sharpsl_pm.charge_mode == CHRG_ON)
> -		sharpsl_charge_off();
> -
> -	schedule_delayed_work(&sharpsl_bat, 0);
> -}
> -
> -
> -static irqreturn_t sharpsl_ac_isr(int irq, void *dev_id)
> -{
> -	/* Delay the event slightly to debounce */
> -	/* Must be a smaller delay than the chrg_full_isr below */
> -	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static void sharpsl_chrg_full_timer(struct timer_list *unused)
> -{
> -	dev_dbg(sharpsl_pm.dev, "Charge Full at time: %lx\n", jiffies);
> -
> -	sharpsl_pm.full_count++;
> -
> -	if (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
> -		dev_dbg(sharpsl_pm.dev, "Charge Full: AC removed - stop charging!\n");
> -		if (sharpsl_pm.charge_mode == CHRG_ON)
> -			sharpsl_charge_off();
> -	} else if (sharpsl_pm.full_count < 2) {
> -		dev_dbg(sharpsl_pm.dev, "Charge Full: Count too low\n");
> -		schedule_delayed_work(&toggle_charger, 0);
> -	} else if (time_after(jiffies, sharpsl_pm.charge_start_time + SHARPSL_CHARGE_FINISH_TIME)) {
> -		dev_dbg(sharpsl_pm.dev, "Charge Full: Interrupt generated too slowly - retry.\n");
> -		schedule_delayed_work(&toggle_charger, 0);
> -	} else {
> -		sharpsl_charge_off();
> -		sharpsl_pm.charge_mode = CHRG_DONE;
> -		dev_dbg(sharpsl_pm.dev, "Charge Full: Charging Finished\n");
> -	}
> -}
> -
> -/* Charging Finished Interrupt (Not present on Corgi) */
> -/* Can trigger at the same time as an AC status change so
> -   delay until after that has been processed */
> -static irqreturn_t sharpsl_chrg_full_isr(int irq, void *dev_id)
> -{
> -	if (sharpsl_pm.flags & SHARPSL_SUSPENDED)
> -		return IRQ_HANDLED;
> -
> -	/* delay until after any ac interrupt */
> -	mod_timer(&sharpsl_pm.chrg_full_timer, jiffies + msecs_to_jiffies(500));
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t sharpsl_fatal_isr(int irq, void *dev_id)
> -{
> -	int is_fatal = 0;
> -
> -	if (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) {
> -		dev_err(sharpsl_pm.dev, "Battery now Unlocked! Suspending.\n");
> -		is_fatal = 1;
> -	}
> -
> -	if (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_FATAL)) {
> -		dev_err(sharpsl_pm.dev, "Fatal Batt Error! Suspending.\n");
> -		is_fatal = 1;
> -	}
> -
> -	if (!(sharpsl_pm.flags & SHARPSL_APM_QUEUED) && is_fatal) {
> -		sharpsl_pm.flags |= SHARPSL_APM_QUEUED;
> -		apm_queue_event(APM_CRITICAL_SUSPEND);
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/*
> - * Maintain an average of the last 10 readings
> - */
> -#define SHARPSL_CNV_VALUE_NUM    10
> -static int sharpsl_ad_index;
> -
> -static void sharpsl_average_clear(void)
> -{
> -	sharpsl_ad_index = 0;
> -}
> -
> -static int sharpsl_average_value(int ad)
> -{
> -	int i, ad_val = 0;
> -	static int sharpsl_ad[SHARPSL_CNV_VALUE_NUM+1];
> -
> -	if (sharpsl_pm.battstat.mainbat_status != APM_BATTERY_STATUS_HIGH) {
> -		sharpsl_ad_index = 0;
> -		return ad;
> -	}
> -
> -	sharpsl_ad[sharpsl_ad_index] = ad;
> -	sharpsl_ad_index++;
> -	if (sharpsl_ad_index >= SHARPSL_CNV_VALUE_NUM) {
> -		for (i = 0; i < (SHARPSL_CNV_VALUE_NUM-1); i++)
> -			sharpsl_ad[i] = sharpsl_ad[i+1];
> -		sharpsl_ad_index = SHARPSL_CNV_VALUE_NUM - 1;
> -	}
> -	for (i = 0; i < sharpsl_ad_index; i++)
> -		ad_val += sharpsl_ad[i];
> -
> -	return ad_val / sharpsl_ad_index;
> -}
> -
> -/*
> - * Take an array of 5 integers, remove the maximum and minimum values
> - * and return the average.
> - */
> -static int get_select_val(int *val)
> -{
> -	int i, j, k, temp, sum = 0;
> -
> -	/* Find MAX val */
> -	temp = val[0];
> -	j = 0;
> -	for (i = 1; i < 5; i++) {
> -		if (temp < val[i]) {
> -			temp = val[i];
> -			j = i;
> -		}
> -	}
> -
> -	/* Find MIN val */
> -	temp = val[4];
> -	k = 4;
> -	for (i = 3; i >= 0; i--) {
> -		if (temp > val[i]) {
> -			temp = val[i];
> -			k = i;
> -		}
> -	}
> -
> -	for (i = 0; i < 5; i++)
> -		if (i != j && i != k)
> -			sum += val[i];
> -
> -	dev_dbg(sharpsl_pm.dev, "Average: %d from values: %d, %d, %d, %d, %d\n", sum/3, val[0], val[1], val[2], val[3], val[4]);
> -
> -	return sum/3;
> -}
> -
> -static int sharpsl_check_battery_temp(void)
> -{
> -	int val, i, buff[5];
> -
> -	/* Check battery temperature */
> -	for (i = 0; i < 5; i++) {
> -		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
> -		sharpsl_pm.machinfo->measure_temp(1);
> -		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP);
> -		buff[i] = sharpsl_pm.machinfo->read_devdata(SHARPSL_BATT_TEMP);
> -		sharpsl_pm.machinfo->measure_temp(0);
> -	}
> -
> -	val = get_select_val(buff);
> -
> -	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
> -	if (val > sharpsl_pm.machinfo->charge_on_temp) {
> -		printk(KERN_WARNING "Not charging: temperature out of limits.\n");
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PM
> -static int sharpsl_check_battery_voltage(void)
> -{
> -	int val, i, buff[5];
> -
> -	/* disable charge, enable discharge */
> -	sharpsl_pm.machinfo->charge(0);
> -	sharpsl_pm.machinfo->discharge(1);
> -	mdelay(SHARPSL_WAIT_DISCHARGE_ON);
> -
> -	if (sharpsl_pm.machinfo->discharge1)
> -		sharpsl_pm.machinfo->discharge1(1);
> -
> -	/* Check battery voltage */
> -	for (i = 0; i < 5; i++) {
> -		buff[i] = sharpsl_pm.machinfo->read_devdata(SHARPSL_BATT_VOLT);
> -		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT);
> -	}
> -
> -	if (sharpsl_pm.machinfo->discharge1)
> -		sharpsl_pm.machinfo->discharge1(0);
> -
> -	sharpsl_pm.machinfo->discharge(0);
> -
> -	val = get_select_val(buff);
> -	dev_dbg(sharpsl_pm.dev, "Battery Voltage: %d\n", val);
> -
> -	if (val < sharpsl_pm.machinfo->charge_on_volt)
> -		return -1;
> -
> -	return 0;
> -}
> -#endif
> -
> -static int sharpsl_ac_check(void)
> -{
> -	int temp, i, buff[5];
> -
> -	for (i = 0; i < 5; i++) {
> -		buff[i] = sharpsl_pm.machinfo->read_devdata(SHARPSL_ACIN_VOLT);
> -		mdelay(SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN);
> -	}
> -
> -	temp = get_select_val(buff);
> -	dev_dbg(sharpsl_pm.dev, "AC Voltage: %d\n", temp);
> -
> -	if ((temp > sharpsl_pm.machinfo->charge_acin_high) || (temp < sharpsl_pm.machinfo->charge_acin_low)) {
> -		dev_err(sharpsl_pm.dev, "Error: AC check failed: voltage %d.\n", temp);
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_PM
> -static int sharpsl_pm_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -	sharpsl_pm.flags |= SHARPSL_SUSPENDED;
> -	flush_delayed_work(&toggle_charger);
> -	flush_delayed_work(&sharpsl_bat);
> -
> -	if (sharpsl_pm.charge_mode == CHRG_ON)
> -		sharpsl_pm.flags |= SHARPSL_DO_OFFLINE_CHRG;
> -	else
> -		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
> -
> -	return 0;
> -}
> -
> -static int sharpsl_pm_resume(struct platform_device *pdev)
> -{
> -	/* Clear the reset source indicators as they break the bootloader upon reboot */
> -	RCSR = 0x0f;
> -	sharpsl_average_clear();
> -	sharpsl_pm.flags &= ~SHARPSL_APM_QUEUED;
> -	sharpsl_pm.flags &= ~SHARPSL_SUSPENDED;
> -
> -	return 0;
> -}
> -
> -static void corgi_goto_sleep(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
> -{
> -	dev_dbg(sharpsl_pm.dev, "Time is: %08x\n", RCNR);
> -
> -	dev_dbg(sharpsl_pm.dev, "Offline Charge Activate = %d\n", sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG);
> -	/* not charging and AC-IN! */
> -
> -	if ((sharpsl_pm.flags & SHARPSL_DO_OFFLINE_CHRG) && (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN))) {
> -		dev_dbg(sharpsl_pm.dev, "Activating Offline Charger...\n");
> -		sharpsl_pm.charge_mode = CHRG_OFF;
> -		sharpsl_pm.flags &= ~SHARPSL_DO_OFFLINE_CHRG;
> -		sharpsl_off_charge_battery();
> -	}
> -
> -	sharpsl_pm.machinfo->presuspend();
> -
> -	PEDR = 0xffffffff; /* clear it */
> -
> -	sharpsl_pm.flags &= ~SHARPSL_ALARM_ACTIVE;
> -	if ((sharpsl_pm.charge_mode == CHRG_ON) && ((alarm_enable && ((alarm_time - RCNR) > (SHARPSL_BATCHK_TIME_SUSPEND + 30))) || !alarm_enable)) {
> -		RTSR &= RTSR_ALE;
> -		RTAR = RCNR + SHARPSL_BATCHK_TIME_SUSPEND;
> -		dev_dbg(sharpsl_pm.dev, "Charging alarm at: %08x\n", RTAR);
> -		sharpsl_pm.flags |= SHARPSL_ALARM_ACTIVE;
> -	} else if (alarm_enable) {
> -		RTSR &= RTSR_ALE;
> -		RTAR = alarm_time;
> -		dev_dbg(sharpsl_pm.dev, "User alarm at: %08x\n", RTAR);
> -	} else {
> -		dev_dbg(sharpsl_pm.dev, "No alarms set.\n");
> -	}
> -
> -	pxa_pm_enter(state);
> -
> -	sharpsl_pm.machinfo->postsuspend();
> -
> -	dev_dbg(sharpsl_pm.dev, "Corgi woken up from suspend: %08x\n", PEDR);
> -}
> -
> -static int corgi_enter_suspend(unsigned long alarm_time, unsigned int alarm_enable, suspend_state_t state)
> -{
> -	if (!sharpsl_pm.machinfo->should_wakeup(!(sharpsl_pm.flags & SHARPSL_ALARM_ACTIVE) && alarm_enable)) {
> -		if (!(sharpsl_pm.flags & SHARPSL_ALARM_ACTIVE)) {
> -			dev_dbg(sharpsl_pm.dev, "No user triggered wakeup events and not charging. Strange. Suspend.\n");
> -			corgi_goto_sleep(alarm_time, alarm_enable, state);
> -			return 1;
> -		}
> -		if (sharpsl_off_charge_battery()) {
> -			dev_dbg(sharpsl_pm.dev, "Charging. Suspend...\n");
> -			corgi_goto_sleep(alarm_time, alarm_enable, state);
> -			return 1;
> -		}
> -		dev_dbg(sharpsl_pm.dev, "User triggered wakeup in offline charger.\n");
> -	}
> -
> -	if ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) ||
> -	    (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_FATAL)))	{
> -		dev_err(sharpsl_pm.dev, "Fatal condition. Suspend.\n");
> -		corgi_goto_sleep(alarm_time, alarm_enable, state);
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
> -static int corgi_pxa_pm_enter(suspend_state_t state)
> -{
> -	unsigned long alarm_time = RTAR;
> -	unsigned int alarm_status = ((RTSR & RTSR_ALE) != 0);
> -
> -	dev_dbg(sharpsl_pm.dev, "SharpSL suspending for first time.\n");
> -
> -	corgi_goto_sleep(alarm_time, alarm_status, state);
> -
> -	while (corgi_enter_suspend(alarm_time, alarm_status, state))
> -		{}
> -
> -	if (sharpsl_pm.machinfo->earlyresume)
> -		sharpsl_pm.machinfo->earlyresume();
> -
> -	dev_dbg(sharpsl_pm.dev, "SharpSL resuming...\n");
> -
> -	return 0;
> -}
> -
> -static int sharpsl_off_charge_error(void)
> -{
> -	dev_err(sharpsl_pm.dev, "Offline Charger: Error occurred.\n");
> -	sharpsl_pm.machinfo->charge(0);
> -	sharpsl_pm_led(SHARPSL_LED_ERROR);
> -	sharpsl_pm.charge_mode = CHRG_ERROR;
> -	return 1;
> -}
> -
> -/*
> - * Charging Control while suspended
> - * Return 1 - go straight to sleep
> - * Return 0 - sleep or wakeup depending on other factors
> - */
> -static int sharpsl_off_charge_battery(void)
> -{
> -	int time;
> -
> -	dev_dbg(sharpsl_pm.dev, "Charge Mode: %d\n", sharpsl_pm.charge_mode);
> -
> -	if (sharpsl_pm.charge_mode == CHRG_OFF) {
> -		dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 1\n");
> -
> -		/* AC Check */
> -		if ((sharpsl_ac_check() < 0) || (sharpsl_check_battery_temp() < 0))
> -			return sharpsl_off_charge_error();
> -
> -		/* Start Charging */
> -		sharpsl_pm_led(SHARPSL_LED_ON);
> -		sharpsl_pm.machinfo->charge(0);
> -		mdelay(SHARPSL_CHARGE_WAIT_TIME);
> -		sharpsl_pm.machinfo->charge(1);
> -
> -		sharpsl_pm.charge_mode = CHRG_ON;
> -		sharpsl_pm.full_count = 0;
> -
> -		return 1;
> -	} else if (sharpsl_pm.charge_mode != CHRG_ON) {
> -		return 1;
> -	}
> -
> -	if (sharpsl_pm.full_count == 0) {
> -		int time;
> -
> -		dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 2\n");
> -
> -		if ((sharpsl_check_battery_temp() < 0) || (sharpsl_check_battery_voltage() < 0))
> -			return sharpsl_off_charge_error();
> -
> -		sharpsl_pm.machinfo->charge(0);
> -		mdelay(SHARPSL_CHARGE_WAIT_TIME);
> -		sharpsl_pm.machinfo->charge(1);
> -		sharpsl_pm.charge_mode = CHRG_ON;
> -
> -		mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
> -
> -		time = RCNR;
> -		while (1) {
> -			/* Check if any wakeup event had occurred */
> -			if (sharpsl_pm.machinfo->charger_wakeup())
> -				return 0;
> -			/* Check for timeout */
> -			if ((RCNR - time) > SHARPSL_WAIT_CO_TIME)
> -				return 1;
> -			if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_CHRGFULL)) {
> -				dev_dbg(sharpsl_pm.dev, "Offline Charger: Charge full occurred. Retrying to check\n");
> -				sharpsl_pm.full_count++;
> -				sharpsl_pm.machinfo->charge(0);
> -				mdelay(SHARPSL_CHARGE_WAIT_TIME);
> -				sharpsl_pm.machinfo->charge(1);
> -				return 1;
> -			}
> -		}
> -	}
> -
> -	dev_dbg(sharpsl_pm.dev, "Offline Charger: Step 3\n");
> -
> -	mdelay(SHARPSL_CHARGE_CO_CHECK_TIME);
> -
> -	time = RCNR;
> -	while (1) {
> -		/* Check if any wakeup event had occurred */
> -		if (sharpsl_pm.machinfo->charger_wakeup())
> -			return 0;
> -		/* Check for timeout */
> -		if ((RCNR-time) > SHARPSL_WAIT_CO_TIME) {
> -			if (sharpsl_pm.full_count > SHARPSL_CHARGE_RETRY_CNT) {
> -				dev_dbg(sharpsl_pm.dev, "Offline Charger: Not charged sufficiently. Retrying.\n");
> -				sharpsl_pm.full_count = 0;
> -			}
> -			sharpsl_pm.full_count++;
> -			return 1;
> -		}
> -		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_CHRGFULL)) {
> -			dev_dbg(sharpsl_pm.dev, "Offline Charger: Charging complete.\n");
> -			sharpsl_pm_led(SHARPSL_LED_OFF);
> -			sharpsl_pm.machinfo->charge(0);
> -			sharpsl_pm.charge_mode = CHRG_DONE;
> -			return 1;
> -		}
> -	}
> -}
> -#else
> -#define sharpsl_pm_suspend	NULL
> -#define sharpsl_pm_resume	NULL
> -#endif
> -
> -static ssize_t battery_percentage_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "%d\n", sharpsl_pm.battstat.mainbat_percent);
> -}
> -
> -static ssize_t battery_voltage_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "%d\n", sharpsl_pm.battstat.mainbat_voltage);
> -}
> -
> -static DEVICE_ATTR_RO(battery_percentage);
> -static DEVICE_ATTR_RO(battery_voltage);
> -
> -extern void (*apm_get_power_status)(struct apm_power_info *);
> -
> -static void sharpsl_apm_get_power_status(struct apm_power_info *info)
> -{
> -	info->ac_line_status = sharpsl_pm.battstat.ac_status;
> -
> -	if (sharpsl_pm.charge_mode == CHRG_ON)
> -		info->battery_status = APM_BATTERY_STATUS_CHARGING;
> -	else
> -		info->battery_status = sharpsl_pm.battstat.mainbat_status;
> -
> -	info->battery_flag = (1 << info->battery_status);
> -	info->battery_life = sharpsl_pm.battstat.mainbat_percent;
> -}
> -
> -#ifdef CONFIG_PM
> -static const struct platform_suspend_ops sharpsl_pm_ops = {
> -	.prepare	= pxa_pm_prepare,
> -	.finish		= pxa_pm_finish,
> -	.enter		= corgi_pxa_pm_enter,
> -	.valid		= suspend_valid_only_mem,
> -};
> -#endif
> -
> -static int sharpsl_pm_probe(struct platform_device *pdev)
> -{
> -	int ret, irq;
> -
> -	if (!pdev->dev.platform_data)
> -		return -EINVAL;
> -
> -	sharpsl_pm.dev = &pdev->dev;
> -	sharpsl_pm.machinfo = pdev->dev.platform_data;
> -	sharpsl_pm.charge_mode = CHRG_OFF;
> -	sharpsl_pm.flags = 0;
> -
> -	timer_setup(&sharpsl_pm.ac_timer, sharpsl_ac_timer, 0);
> -
> -	timer_setup(&sharpsl_pm.chrg_full_timer, sharpsl_chrg_full_timer, 0);
> -
> -	led_trigger_register_simple("sharpsl-charge", &sharpsl_charge_led_trigger);
> -
> -	sharpsl_pm.machinfo->init();
> -
> -	gpio_request(sharpsl_pm.machinfo->gpio_acin, "AC IN");
> -	gpio_direction_input(sharpsl_pm.machinfo->gpio_acin);
> -	gpio_request(sharpsl_pm.machinfo->gpio_batfull, "Battery Full");
> -	gpio_direction_input(sharpsl_pm.machinfo->gpio_batfull);
> -	gpio_request(sharpsl_pm.machinfo->gpio_batlock, "Battery Lock");
> -	gpio_direction_input(sharpsl_pm.machinfo->gpio_batlock);
> -
> -	/* Register interrupt handlers */
> -	irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_acin);
> -	if (request_irq(irq, sharpsl_ac_isr, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
> -		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
> -	}
> -
> -	irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock);
> -	if (request_irq(irq, sharpsl_fatal_isr, IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
> -		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
> -	}
> -
> -	if (sharpsl_pm.machinfo->gpio_fatal) {
> -		irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal);
> -		if (request_irq(irq, sharpsl_fatal_isr, IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
> -			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
> -		}
> -	}
> -
> -	if (sharpsl_pm.machinfo->batfull_irq) {
> -		/* Register interrupt handler. */
> -		irq = gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull);
> -		if (request_irq(irq, sharpsl_chrg_full_isr, IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
> -			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", irq);
> -		}
> -	}
> -
> -	ret = device_create_file(&pdev->dev, &dev_attr_battery_percentage);
> -	ret |= device_create_file(&pdev->dev, &dev_attr_battery_voltage);
> -	if (ret != 0)
> -		dev_warn(&pdev->dev, "Failed to register attributes (%d)\n", ret);
> -
> -	apm_get_power_status = sharpsl_apm_get_power_status;
> -
> -#ifdef CONFIG_PM
> -	suspend_set_ops(&sharpsl_pm_ops);
> -#endif
> -
> -	mod_timer(&sharpsl_pm.ac_timer, jiffies + msecs_to_jiffies(250));
> -
> -	return 0;
> -}
> -
> -static void sharpsl_pm_remove(struct platform_device *pdev)
> -{
> -	suspend_set_ops(NULL);
> -
> -	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
> -	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
> -
> -	led_trigger_unregister_simple(sharpsl_charge_led_trigger);
> -
> -	free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
> -	free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
> -
> -	if (sharpsl_pm.machinfo->gpio_fatal)
> -		free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
> -
> -	if (sharpsl_pm.machinfo->batfull_irq)
> -		free_irq(gpio_to_irq(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
> -
> -	gpio_free(sharpsl_pm.machinfo->gpio_batlock);
> -	gpio_free(sharpsl_pm.machinfo->gpio_batfull);
> -	gpio_free(sharpsl_pm.machinfo->gpio_acin);
> -
> -	if (sharpsl_pm.machinfo->exit)
> -		sharpsl_pm.machinfo->exit();
> -
> -	timer_delete_sync(&sharpsl_pm.chrg_full_timer);
> -	timer_delete_sync(&sharpsl_pm.ac_timer);
> -}
> -
> -static struct platform_driver sharpsl_pm_driver = {
> -	.probe		= sharpsl_pm_probe,
> -	.remove		= sharpsl_pm_remove,
> -	.suspend	= sharpsl_pm_suspend,
> -	.resume		= sharpsl_pm_resume,
> -	.driver		= {
> -		.name		= "sharpsl-pm",
> -	},
> -};
> -
> -static int sharpsl_pm_init(void)
> -{
> -	return platform_driver_register(&sharpsl_pm_driver);
> -}
> -
> -static void sharpsl_pm_exit(void)
> -{
> -	platform_driver_unregister(&sharpsl_pm_driver);
> -}
> -
> -late_initcall(sharpsl_pm_init);
> -module_exit(sharpsl_pm_exit);
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.h b/arch/arm/mach-pxa/sharpsl_pm.h
> deleted file mode 100644
> index 623167f30ec2..000000000000
> --- a/arch/arm/mach-pxa/sharpsl_pm.h
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * SharpSL Battery/PM Driver
> - *
> - * Copyright (c) 2004-2005 Richard Purdie
> - */
> -#ifndef _MACH_SHARPSL_PM
> -#define _MACH_SHARPSL_PM
> -
> -struct sharpsl_charger_machinfo {
> -	void (*init)(void);
> -	void (*exit)(void);
> -	int gpio_acin;
> -	int gpio_batfull;
> -	int batfull_irq;
> -	int gpio_batlock;
> -	int gpio_fatal;
> -	void (*discharge)(int);
> -	void (*discharge1)(int);
> -	void (*charge)(int);
> -	void (*measure_temp)(int);
> -	void (*presuspend)(void);
> -	void (*postsuspend)(void);
> -	void (*earlyresume)(void);
> -	unsigned long (*read_devdata)(int);
> -#define SHARPSL_BATT_VOLT       1
> -#define SHARPSL_BATT_TEMP       2
> -#define SHARPSL_ACIN_VOLT       3
> -#define SHARPSL_STATUS_ACIN     4
> -#define SHARPSL_STATUS_LOCK     5
> -#define SHARPSL_STATUS_CHRGFULL 6
> -#define SHARPSL_STATUS_FATAL    7
> -	bool (*charger_wakeup)(void);
> -	int (*should_wakeup)(unsigned int resume_on_alarm);
> -	void (*backlight_limit)(int);
> -	int (*backlight_get_status) (void);
> -	int charge_on_volt;
> -	int charge_on_temp;
> -	int charge_acin_high;
> -	int charge_acin_low;
> -	int fatal_acin_volt;
> -	int fatal_noacin_volt;
> -	int bat_levels;
> -	struct battery_thresh *bat_levels_noac;
> -	struct battery_thresh *bat_levels_acin;
> -	struct battery_thresh *bat_levels_noac_bl;
> -	struct battery_thresh *bat_levels_acin_bl;
> -	int status_high_acin;
> -	int status_low_acin;
> -	int status_high_noac;
> -	int status_low_noac;
> -};
> -
> -struct battery_thresh {
> -	int voltage;
> -	int percentage;
> -};
> -
> -struct battery_stat {
> -	int ac_status;         /* APM AC Present/Not Present */
> -	int mainbat_status;    /* APM Main Battery Status */
> -	int mainbat_percent;   /* Main Battery Percentage Charge */
> -	int mainbat_voltage;   /* Main Battery Voltage */
> -};
> -
> -struct sharpsl_pm_status {
> -	struct device *dev;
> -	struct timer_list ac_timer;
> -	struct timer_list chrg_full_timer;
> -
> -	int charge_mode;
> -#define CHRG_ERROR    (-1)
> -#define CHRG_OFF      (0)
> -#define CHRG_ON       (1)
> -#define CHRG_DONE     (2)
> -
> -	unsigned int flags;
> -#define SHARPSL_SUSPENDED       (1 << 0)  /* Device is Suspended */
> -#define SHARPSL_ALARM_ACTIVE    (1 << 1)  /* Alarm is for charging event (not user) */
> -#define SHARPSL_BL_LIMIT        (1 << 2)  /* Backlight Intensity Limited */
> -#define SHARPSL_APM_QUEUED      (1 << 3)  /* APM Event Queued */
> -#define SHARPSL_DO_OFFLINE_CHRG (1 << 4)  /* Trigger the offline charger */
> -
> -	int full_count;
> -	unsigned long charge_start_time;
> -	struct sharpsl_charger_machinfo *machinfo;
> -	struct battery_stat battstat;
> -};
> -
> -extern struct sharpsl_pm_status sharpsl_pm;
> -
> -extern struct battery_thresh sharpsl_battery_levels_acin[];
> -extern struct battery_thresh sharpsl_battery_levels_noac[];
> -
> -#define SHARPSL_LED_ERROR  2
> -#define SHARPSL_LED_ON     1
> -#define SHARPSL_LED_OFF    0
> -
> -void sharpsl_battery_kick(void);
> -void sharpsl_pm_led(int val);
> -
> -/* MAX1111 Channel Definitions */
> -#define MAX1111_BATT_VOLT   4u
> -#define MAX1111_BATT_TEMP   2u
> -#define MAX1111_ACIN_VOLT   6u
> -int sharpsl_pm_pxa_read_max1111(int channel);
> -
> -#endif
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> deleted file mode 100644
> index 5eaf38243b9e..000000000000
> --- a/arch/arm/mach-pxa/spitz.c
> +++ /dev/null
> @@ -1,1174 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Support for Sharp SL-Cxx00 Series of PDAs
> - * Models: SL-C3000 (Spitz), SL-C1000 (Akita) and SL-C3100 (Borzoi)
> - *
> - * Copyright (c) 2005 Richard Purdie
> - *
> - * Based on Sharp's 2.4 kernel patches/lubbock.c
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/delay.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio/machine.h>
> -#include <linux/gpio/property.h>
> -#include <linux/leds.h>
> -#include <linux/i2c.h>
> -#include <linux/platform_data/i2c-pxa.h>
> -#include <linux/platform_data/pca953x.h>
> -#include <linux/property.h>
> -#include <linux/spi/spi.h>
> -#include <linux/spi/ads7846.h>
> -#include <linux/spi/corgi_lcd.h>
> -#include <linux/mtd/sharpsl.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/input-event-codes.h>
> -#include <linux/input/matrix_keypad.h>
> -#include <linux/regulator/machine.h>
> -#include <linux/io.h>
> -#include <linux/property.h>
> -#include <linux/reboot.h>
> -#include <linux/memblock.h>
> -
> -#include <asm/setup.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/sharpsl_param.h>
> -#include <asm/hardware/scoop.h>
> -
> -#include "pxa27x.h"
> -#include "pxa27x-udc.h"
> -#include "reset.h"
> -#include <linux/platform_data/mmc-pxamci.h>
> -#include <linux/platform_data/usb-ohci-pxa27x.h>
> -#include <linux/platform_data/video-pxafb.h>
> -#include "spitz.h"
> -#include "sharpsl_pm.h"
> -#include "smemc.h"
> -
> -#include "generic.h"
> -#include "devices.h"
> -
> -/******************************************************************************
> - * Pin configuration
> - ******************************************************************************/
> -static unsigned long spitz_pin_config[] __initdata = {
> -	/* Chip Selects */
> -	GPIO78_nCS_2,	/* SCOOP #2 */
> -	GPIO79_nCS_3,	/* NAND */
> -	GPIO80_nCS_4,	/* SCOOP #1 */
> -
> -	/* LCD - 16bpp Active TFT */
> -	GPIOxx_LCD_TFT_16BPP,
> -
> -	/* PC Card */
> -	GPIO48_nPOE,
> -	GPIO49_nPWE,
> -	GPIO50_nPIOR,
> -	GPIO51_nPIOW,
> -	GPIO85_nPCE_1,
> -	GPIO54_nPCE_2,
> -	GPIO55_nPREG,
> -	GPIO56_nPWAIT,
> -	GPIO57_nIOIS16,
> -	GPIO104_PSKTSEL,
> -
> -	/* I2S */
> -	GPIO28_I2S_BITCLK_OUT,
> -	GPIO29_I2S_SDATA_IN,
> -	GPIO30_I2S_SDATA_OUT,
> -	GPIO31_I2S_SYNC,
> -
> -	/* MMC */
> -	GPIO32_MMC_CLK,
> -	GPIO112_MMC_CMD,
> -	GPIO92_MMC_DAT_0,
> -	GPIO109_MMC_DAT_1,
> -	GPIO110_MMC_DAT_2,
> -	GPIO111_MMC_DAT_3,
> -
> -	/* GPIOs */
> -	GPIO9_GPIO,	/* SPITZ_GPIO_nSD_DETECT */
> -	GPIO16_GPIO,	/* SPITZ_GPIO_SYNC */
> -	GPIO81_GPIO,	/* SPITZ_GPIO_nSD_WP */
> -	GPIO41_GPIO,	/* SPITZ_GPIO_USB_CONNECT */
> -	GPIO37_GPIO,	/* SPITZ_GPIO_USB_HOST */
> -	GPIO35_GPIO,	/* SPITZ_GPIO_USB_DEVICE */
> -	GPIO22_GPIO,	/* SPITZ_GPIO_HSYNC */
> -	GPIO94_GPIO,	/* SPITZ_GPIO_CF_CD */
> -	GPIO105_GPIO,	/* SPITZ_GPIO_CF_IRQ */
> -	GPIO106_GPIO,	/* SPITZ_GPIO_CF2_IRQ */
> -
> -	/* GPIO matrix keypad */
> -	GPIO88_GPIO,	/* column 0 */
> -	GPIO23_GPIO,	/* column 1 */
> -	GPIO24_GPIO,	/* column 2 */
> -	GPIO25_GPIO,	/* column 3 */
> -	GPIO26_GPIO,	/* column 4 */
> -	GPIO27_GPIO,	/* column 5 */
> -	GPIO52_GPIO,	/* column 6 */
> -	GPIO103_GPIO,	/* column 7 */
> -	GPIO107_GPIO,	/* column 8 */
> -	GPIO108_GPIO,	/* column 9 */
> -	GPIO114_GPIO,	/* column 10 */
> -	GPIO12_GPIO,	/* row 0 */
> -	GPIO17_GPIO,	/* row 1 */
> -	GPIO91_GPIO,	/* row 2 */
> -	GPIO34_GPIO,	/* row 3 */
> -	GPIO36_GPIO,	/* row 4 */
> -	GPIO38_GPIO,	/* row 5 */
> -	GPIO39_GPIO,	/* row 6 */
> -
> -	/* I2C */
> -	GPIO117_I2C_SCL,
> -	GPIO118_I2C_SDA,
> -
> -	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,	/* SPITZ_GPIO_KEY_INT */
> -	GPIO1_GPIO | WAKEUP_ON_EDGE_FALL,	/* SPITZ_GPIO_RESET */
> -};
> -
> -static const struct software_node spitz_scoop_1_gpiochip_node = {
> -	.name = "sharp-scoop.0",
> -};
> -
> -/* Only on Spitz */
> -static const struct software_node spitz_scoop_2_gpiochip_node = {
> -	.name = "sharp-scoop.1",
> -};
> -
> -/* Only on Akita */
> -static const struct software_node akita_max7310_gpiochip_node = {
> -	.name = "i2c-max7310",
> -};
> -
> -/******************************************************************************
> - * Scoop GPIO expander
> - ******************************************************************************/
> -#if defined(CONFIG_SHARP_SCOOP) || defined(CONFIG_SHARP_SCOOP_MODULE)
> -/* SCOOP Device #1 */
> -static struct resource spitz_scoop_1_resources[] = {
> -	[0] = {
> -		.start		= 0x10800000,
> -		.end		= 0x10800fff,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct scoop_config spitz_scoop_1_setup = {
> -	.io_dir		= SPITZ_SCP_IO_DIR,
> -	.io_out		= SPITZ_SCP_IO_OUT,
> -	.suspend_clr	= SPITZ_SCP_SUS_CLR,
> -	.suspend_set	= SPITZ_SCP_SUS_SET,
> -	.gpio_base	= SPITZ_SCP_GPIO_BASE,
> -};
> -
> -static struct platform_device spitz_scoop_1_device = {
> -	.name		= "sharp-scoop",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &spitz_scoop_1_setup,
> -	},
> -	.num_resources	= ARRAY_SIZE(spitz_scoop_1_resources),
> -	.resource	= spitz_scoop_1_resources,
> -};
> -
> -/* SCOOP Device #2 */
> -static struct resource spitz_scoop_2_resources[] = {
> -	[0] = {
> -		.start		= 0x08800040,
> -		.end		= 0x08800fff,
> -		.flags		= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct scoop_config spitz_scoop_2_setup = {
> -	.io_dir		= SPITZ_SCP2_IO_DIR,
> -	.io_out		= SPITZ_SCP2_IO_OUT,
> -	.suspend_clr	= SPITZ_SCP2_SUS_CLR,
> -	.suspend_set	= SPITZ_SCP2_SUS_SET,
> -	.gpio_base	= SPITZ_SCP2_GPIO_BASE,
> -};
> -
> -static struct platform_device spitz_scoop_2_device = {
> -	.name		= "sharp-scoop",
> -	.id		= 1,
> -	.dev		= {
> -		.platform_data	= &spitz_scoop_2_setup,
> -	},
> -	.num_resources	= ARRAY_SIZE(spitz_scoop_2_resources),
> -	.resource	= spitz_scoop_2_resources,
> -};
> -
> -static void __init spitz_scoop_init(void)
> -{
> -	spitz_scoop_1_device.dev.fwnode = software_node_fwnode(&spitz_scoop_1_gpiochip_node);
> -	platform_device_register(&spitz_scoop_1_device);
> -
> -	/* Akita doesn't have the second SCOOP chip */
> -	if (!machine_is_akita()) {
> -		spitz_scoop_2_device.dev.fwnode = software_node_fwnode(
> -							&spitz_scoop_2_gpiochip_node);
> -		platform_device_register(&spitz_scoop_2_device);
> -	}
> -}
> -
> -/* Power control is shared with between one of the CF slots and SD */
> -static void __maybe_unused spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr)
> -{
> -	unsigned short cpr;
> -	unsigned long flags;
> -
> -	if (new_cpr & 0x7) {
> -		gpio_set_value(SPITZ_GPIO_CF_POWER, 1);
> -		mdelay(5);
> -	}
> -
> -	local_irq_save(flags);
> -
> -	cpr = read_scoop_reg(&spitz_scoop_1_device.dev, SCOOP_CPR);
> -
> -	if (enable & new_cpr)
> -		cpr |= new_cpr;
> -	else
> -		cpr &= ~enable;
> -
> -	write_scoop_reg(&spitz_scoop_1_device.dev, SCOOP_CPR, cpr);
> -
> -	local_irq_restore(flags);
> -
> -	if (!(cpr & 0x7)) {
> -		mdelay(1);
> -		gpio_set_value(SPITZ_GPIO_CF_POWER, 0);
> -	}
> -}
> -
> -#else
> -static inline void spitz_scoop_init(void) {}
> -static inline void spitz_card_pwr_ctrl(uint8_t enable, uint8_t new_cpr) {}
> -#endif
> -
> -/******************************************************************************
> - * PCMCIA
> - ******************************************************************************/
> -#if defined(CONFIG_PCMCIA_PXA2XX) || defined(CONFIG_PCMCIA_PXA2XX_MODULE)
> -static void spitz_pcmcia_pwr(struct device *scoop, uint16_t cpr, int nr)
> -{
> -	/* Only need to override behaviour for slot 0 */
> -	if (nr == 0)
> -		spitz_card_pwr_ctrl(
> -			cpr & (SCOOP_CPR_CF_3V | SCOOP_CPR_CF_XV), cpr);
> -	else
> -		write_scoop_reg(scoop, SCOOP_CPR, cpr);
> -}
> -
> -static struct scoop_pcmcia_dev spitz_pcmcia_scoop[] = {
> -	{
> -		.dev		= &spitz_scoop_1_device.dev,
> -		.irq		= SPITZ_IRQ_GPIO_CF_IRQ,
> -		.cd_irq		= SPITZ_IRQ_GPIO_CF_CD,
> -		.cd_irq_str	= "PCMCIA0 CD",
> -	}, {
> -		.dev		= &spitz_scoop_2_device.dev,
> -		.irq		= SPITZ_IRQ_GPIO_CF2_IRQ,
> -		.cd_irq		= -1,
> -	},
> -};
> -
> -static struct scoop_pcmcia_config spitz_pcmcia_config = {
> -	.devs		= &spitz_pcmcia_scoop[0],
> -	.num_devs	= 2,
> -	.power_ctrl	= spitz_pcmcia_pwr,
> -};
> -
> -static void __init spitz_pcmcia_init(void)
> -{
> -	/* Akita has only one PCMCIA slot used */
> -	if (machine_is_akita())
> -		spitz_pcmcia_config.num_devs = 1;
> -
> -	platform_scoop_config = &spitz_pcmcia_config;
> -}
> -#else
> -static inline void spitz_pcmcia_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * GPIO keyboard
> - ******************************************************************************/
> -#if defined(CONFIG_KEYBOARD_MATRIX) || defined(CONFIG_KEYBOARD_MATRIX_MODULE)
> -
> -#define SPITZ_KEY_CALENDAR	KEY_F1
> -#define SPITZ_KEY_ADDRESS	KEY_F2
> -#define SPITZ_KEY_FN		KEY_F3
> -#define SPITZ_KEY_CANCEL	KEY_F4
> -#define SPITZ_KEY_EXOK		KEY_F5
> -#define SPITZ_KEY_EXCANCEL	KEY_F6
> -#define SPITZ_KEY_EXJOGDOWN	KEY_F7
> -#define SPITZ_KEY_EXJOGUP	KEY_F8
> -#define SPITZ_KEY_JAP1		KEY_LEFTALT
> -#define SPITZ_KEY_JAP2		KEY_RIGHTCTRL
> -#define SPITZ_KEY_SYNC		KEY_F9
> -#define SPITZ_KEY_MAIL		KEY_F10
> -#define SPITZ_KEY_OK		KEY_F11
> -#define SPITZ_KEY_MENU		KEY_F12
> -
> -static const uint32_t spitz_keymap[] = {
> -	KEY(0, 0, KEY_LEFTCTRL),
> -	KEY(0, 1, KEY_1),
> -	KEY(0, 2, KEY_3),
> -	KEY(0, 3, KEY_5),
> -	KEY(0, 4, KEY_6),
> -	KEY(0, 5, KEY_7),
> -	KEY(0, 6, KEY_9),
> -	KEY(0, 7, KEY_0),
> -	KEY(0, 8, KEY_BACKSPACE),
> -	KEY(0, 9, SPITZ_KEY_EXOK),	/* EXOK */
> -	KEY(0, 10, SPITZ_KEY_EXCANCEL),	/* EXCANCEL */
> -	KEY(1, 1, KEY_2),
> -	KEY(1, 2, KEY_4),
> -	KEY(1, 3, KEY_R),
> -	KEY(1, 4, KEY_Y),
> -	KEY(1, 5, KEY_8),
> -	KEY(1, 6, KEY_I),
> -	KEY(1, 7, KEY_O),
> -	KEY(1, 8, KEY_P),
> -	KEY(1, 9, SPITZ_KEY_EXJOGDOWN),	/* EXJOGDOWN */
> -	KEY(1, 10, SPITZ_KEY_EXJOGUP),	/* EXJOGUP */
> -	KEY(2, 0, KEY_TAB),
> -	KEY(2, 1, KEY_Q),
> -	KEY(2, 2, KEY_E),
> -	KEY(2, 3, KEY_T),
> -	KEY(2, 4, KEY_G),
> -	KEY(2, 5, KEY_U),
> -	KEY(2, 6, KEY_J),
> -	KEY(2, 7, KEY_K),
> -	KEY(3, 0, SPITZ_KEY_ADDRESS),	/* ADDRESS */
> -	KEY(3, 1, KEY_W),
> -	KEY(3, 2, KEY_S),
> -	KEY(3, 3, KEY_F),
> -	KEY(3, 4, KEY_V),
> -	KEY(3, 5, KEY_H),
> -	KEY(3, 6, KEY_M),
> -	KEY(3, 7, KEY_L),
> -	KEY(3, 9, KEY_RIGHTSHIFT),
> -	KEY(4, 0, SPITZ_KEY_CALENDAR),	/* CALENDAR */
> -	KEY(4, 1, KEY_A),
> -	KEY(4, 2, KEY_D),
> -	KEY(4, 3, KEY_C),
> -	KEY(4, 4, KEY_B),
> -	KEY(4, 5, KEY_N),
> -	KEY(4, 6, KEY_DOT),
> -	KEY(4, 8, KEY_ENTER),
> -	KEY(4, 9, KEY_LEFTSHIFT),
> -	KEY(5, 0, SPITZ_KEY_MAIL),	/* MAIL */
> -	KEY(5, 1, KEY_Z),
> -	KEY(5, 2, KEY_X),
> -	KEY(5, 3, KEY_MINUS),
> -	KEY(5, 4, KEY_SPACE),
> -	KEY(5, 5, KEY_COMMA),
> -	KEY(5, 7, KEY_UP),
> -	KEY(5, 10, SPITZ_KEY_FN),	/* FN */
> -	KEY(6, 0, KEY_SYSRQ),
> -	KEY(6, 1, SPITZ_KEY_JAP1),	/* JAP1 */
> -	KEY(6, 2, SPITZ_KEY_JAP2),	/* JAP2 */
> -	KEY(6, 3, SPITZ_KEY_CANCEL),	/* CANCEL */
> -	KEY(6, 4, SPITZ_KEY_OK),	/* OK */
> -	KEY(6, 5, SPITZ_KEY_MENU),	/* MENU */
> -	KEY(6, 6, KEY_LEFT),
> -	KEY(6, 7, KEY_DOWN),
> -	KEY(6, 8, KEY_RIGHT),
> -};
> -
> -static const struct software_node_ref_args spitz_mkp_row_gpios[] = {
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 12, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 17, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 91, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 34, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 36, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 38, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 39, GPIO_ACTIVE_HIGH),
> -};
> -
> -static const struct software_node_ref_args spitz_mkp_col_gpios[] = {
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 88, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 23, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 24, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 25, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 26, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 27, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 52, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 103, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 107, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 108, GPIO_ACTIVE_HIGH),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, 114, GPIO_ACTIVE_HIGH),
> -};
> -
> -static const struct property_entry spitz_mkp_properties[] = {
> -	PROPERTY_ENTRY_U32_ARRAY("linux,keymap", spitz_keymap),
> -	PROPERTY_ENTRY_REF_ARRAY("row-gpios", spitz_mkp_row_gpios),
> -	PROPERTY_ENTRY_REF_ARRAY("col-gpios", spitz_mkp_col_gpios),
> -	PROPERTY_ENTRY_U32("col-scan-delay-us", 10),
> -	PROPERTY_ENTRY_U32("debounce-delay-ms", 10),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	{ }
> -};
> -
> -static const struct platform_device_info spitz_mkp_info __initconst = {
> -	.name		= "matrix-keypad",
> -	.id		= PLATFORM_DEVID_NONE,
> -	.properties	= spitz_mkp_properties,
> -};
> -
> -
> -static void __init spitz_mkp_init(void)
> -{
> -	struct platform_device *pd;
> -	int err;
> -
> -	pd = platform_device_register_full(&spitz_mkp_info);
> -	err = PTR_ERR_OR_ZERO(pd);
> -	if (err)
> -		pr_err("failed to create keypad device: %d\n", err);
> -}
> -#else
> -static inline void spitz_mkp_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * GPIO keys
> - ******************************************************************************/
> -#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> -static const struct software_node spitz_gpio_keys_node = {
> -	.name = "spitz-gpio-keys",
> -};
> -
> -static const struct property_entry spitz_suspend_key_props[] = {
> -	PROPERTY_ENTRY_U32("linux,input-type", EV_PWR),
> -	PROPERTY_ENTRY_U32("linux,code", KEY_SUSPEND),
> -	PROPERTY_ENTRY_GPIO("gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_ON_KEY, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_STRING("label", "On Off"),
> -	PROPERTY_ENTRY_BOOL("wakeup-source"),
> -	{ }
> -};
> -
> -static const struct software_node spitz_suspend_key_node = {
> -	.parent = &spitz_gpio_keys_node,
> -	.properties = spitz_suspend_key_props,
> -};
> -
> -static const struct property_entry spitz_sw1_props[] = {
> -	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
> -	PROPERTY_ENTRY_U32("linux,code", 0),
> -	PROPERTY_ENTRY_GPIO("gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_SWA, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_STRING("label", "Display Down"),
> -	{ }
> -};
> -
> -static const struct software_node spitz_sw1_node = {
> -	.parent = &spitz_gpio_keys_node,
> -	.properties = spitz_sw1_props,
> -};
> -
> -static const struct property_entry spitz_sw2_props[] = {
> -	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
> -	PROPERTY_ENTRY_U32("linux,code", 1),
> -	PROPERTY_ENTRY_GPIO("gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_SWB, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_STRING("label", "Lid Closed"),
> -	{ }
> -};
> -
> -static const struct software_node spitz_sw2_node = {
> -	.parent = &spitz_gpio_keys_node,
> -	.properties = spitz_sw2_props,
> -};
> -
> -static const struct software_node *spitz_gpio_keys_swnodes[] = {
> -	&spitz_gpio_keys_node,
> -	&spitz_suspend_key_node,
> -	&spitz_sw1_node,
> -	&spitz_sw2_node,
> -	NULL
> -};
> -
> -static void __init spitz_keys_init(void)
> -{
> -	struct platform_device_info keys_info = {
> -		.name	= "gpio-keys",
> -		.id	= PLATFORM_DEVID_NONE,
> -	};
> -	struct platform_device *pd;
> -	int err;
> -
> -	err = software_node_register_node_group(spitz_gpio_keys_swnodes);
> -	if (err) {
> -		pr_err("failed to register gpio-keys software nodes: %d\n", err);
> -		return;
> -	}
> -
> -	keys_info.fwnode = software_node_fwnode(&spitz_gpio_keys_node);
> -
> -	pd = platform_device_register_full(&keys_info);
> -	err = PTR_ERR_OR_ZERO(pd);
> -	if (err)
> -		pr_err("failed to create gpio-keys device: %d\n", err);
> -}
> -#else
> -static inline void spitz_keys_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * LEDs
> - ******************************************************************************/
> -#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> -static const struct software_node spitz_gpio_leds_node = {
> -	.name = "spitz-leds",
> -};
> -
> -static const struct property_entry spitz_orange_led_props[] = {
> -	PROPERTY_ENTRY_STRING("linux,default-trigger", "sharpsl-charge"),
> -	PROPERTY_ENTRY_GPIO("gpios",
> -			    &spitz_scoop_1_gpiochip_node, 6, GPIO_ACTIVE_HIGH),
> -	{ }
> -};
> -
> -static const struct software_node spitz_orange_led_node = {
> -	.name = "spitz:amber:charge",
> -	.parent = &spitz_gpio_leds_node,
> -	.properties = spitz_orange_led_props,
> -};
> -
> -static const struct property_entry spitz_green_led_props[] = {
> -	PROPERTY_ENTRY_STRING("linux,default-trigger", "disk-activity"),
> -	PROPERTY_ENTRY_GPIO("gpios",
> -			    &spitz_scoop_1_gpiochip_node, 0, GPIO_ACTIVE_HIGH),
> -	{ }
> -};
> -
> -static const struct software_node spitz_green_led_node = {
> -	.name = "spitz:green:hddactivity",
> -	.parent = &spitz_gpio_leds_node,
> -	.properties = spitz_green_led_props,
> -};
> -
> -static const struct software_node *spitz_gpio_leds_swnodes[] = {
> -	&spitz_gpio_leds_node,
> -	&spitz_orange_led_node,
> -	&spitz_green_led_node,
> -	NULL
> -};
> -
> -static void __init spitz_leds_init(void)
> -{
> -	struct platform_device_info led_info = {
> -		.name	= "leds-gpio",
> -		.id	= PLATFORM_DEVID_NONE,
> -	};
> -	struct platform_device *led_dev;
> -	int err;
> -
> -	err = software_node_register_node_group(spitz_gpio_leds_swnodes);
> -	if (err) {
> -		pr_err("failed to register LED software nodes: %d\n", err);
> -		return;
> -	}
> -
> -	led_info.fwnode = software_node_fwnode(&spitz_gpio_leds_node);
> -
> -	led_dev = platform_device_register_full(&led_info);
> -	err = PTR_ERR_OR_ZERO(led_dev);
> -	if (err)
> -		pr_err("failed to create LED device: %d\n", err);
> -}
> -#else
> -static inline void spitz_leds_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * SSP Devices
> - ******************************************************************************/
> -#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
> -
> -static const struct property_entry spitz_ads7846_props[] = {
> -	PROPERTY_ENTRY_STRING("compatible", "ti,ads7846"),
> -	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 1024),
> -	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 419),
> -	PROPERTY_ENTRY_U16("ti,y-plate-ohms", 486),
> -	PROPERTY_ENTRY_U16("ti,vref-delay-usecs", 100),
> -	PROPERTY_ENTRY_GPIO("pendown-gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_TP_INT, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_GPIO("ti,hsync-gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_HSYNC, GPIO_ACTIVE_LOW),
> -	{ }
> -};
> -
> -static const struct software_node spitz_ads7846_swnode = {
> -	.name = "ads7846",
> -	.properties = spitz_ads7846_props,
> -};
> -
> -static const struct property_entry spitz_lcdcon_props[] = {
> -	PROPERTY_ENTRY_GPIO("BL_CONT-gpios",
> -			    &spitz_scoop_2_gpiochip_node, 6, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_GPIO("BL_ON-gpios",
> -			    &spitz_scoop_2_gpiochip_node, 7, GPIO_ACTIVE_HIGH),
> -	{ }
> -};
> -
> -static const struct property_entry akita_lcdcon_props[] = {
> -	PROPERTY_ENTRY_GPIO("BL_ON-gpios",
> -			    &akita_max7310_gpiochip_node, 3, GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_GPIO("BL_CONT-gpios",
> -			    &akita_max7310_gpiochip_node, 4, GPIO_ACTIVE_LOW),
> -	{ }
> -};
> -
> -static struct software_node spitz_lcdcon_node = {
> -	.name = "spitz-lcdcon",
> -};
> -
> -static struct corgi_lcd_platform_data spitz_lcdcon_info = {
> -	.init_mode		= CORGI_LCD_MODE_VGA,
> -	.max_intensity		= 0x2f,
> -	.default_intensity	= 0x1f,
> -	.limit_mask		= 0x0b,
> -	.kick_battery		= sharpsl_battery_kick,
> -};
> -
> -static struct spi_board_info spitz_spi_devices[] = {
> -	{
> -		.modalias		= "ads7846",
> -		.max_speed_hz		= 1200000,
> -		.bus_num		= 2,
> -		.chip_select		= 0,
> -		.swnode			= &spitz_ads7846_swnode,
> -		.irq			= PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT),
> -	}, {
> -		.modalias		= "corgi-lcd",
> -		.max_speed_hz		= 50000,
> -		.bus_num		= 2,
> -		.chip_select		= 1,
> -		.platform_data		= &spitz_lcdcon_info,
> -		.swnode			= &spitz_lcdcon_node,
> -	}, {
> -		.modalias		= "max1111",
> -		.max_speed_hz		= 450000,
> -		.bus_num		= 2,
> -		.chip_select		= 2,
> -	},
> -};
> -
> -static const struct software_node_ref_args spitz_spi_gpio_refs[] = {
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, SPITZ_GPIO_ADS7846_CS,
> -				GPIO_ACTIVE_LOW),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, SPITZ_GPIO_LCDCON_CS,
> -				GPIO_ACTIVE_LOW),
> -	SOFTWARE_NODE_REFERENCE(&pxa2xx_gpiochip_node, SPITZ_GPIO_MAX1111_CS,
> -				GPIO_ACTIVE_LOW),
> -};
> -
> -static const struct property_entry spitz_spi_properties[] = {
> -	PROPERTY_ENTRY_REF_ARRAY("gpios", spitz_spi_gpio_refs),
> -	{ }
> -};
> -
> -static const struct platform_device_info spitz_spi_device_info = {
> -	.name = "pxa2xx-spi",
> -	/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1 */
> -	.id = 2,
> -	.properties = spitz_spi_properties,
> -};
> -
> -static void __init spitz_spi_init(void)
> -{
> -	struct platform_device *pd;
> -	int err;
> -
> -	pd = platform_device_register_full(&spitz_spi_device_info);
> -	err = PTR_ERR_OR_ZERO(pd);
> -	if (err)
> -		pr_err("pxa2xx-spi: failed to instantiate SPI controller: %d\n",
> -		       err);
> -
> -	spitz_lcdcon_node.properties = machine_is_akita() ?
> -					akita_lcdcon_props : spitz_lcdcon_props;
> -	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
> -}
> -#else
> -static inline void spitz_spi_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * SD/MMC card controller
> - ******************************************************************************/
> -#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> -/*
> - * NOTE: The card detect interrupt isn't debounced so we delay it by 250ms to
> - * give the card a chance to fully insert/eject.
> - */
> -static int spitz_mci_setpower(struct device *dev, unsigned int vdd)
> -{
> -	struct pxamci_platform_data* p_d = dev->platform_data;
> -
> -	if ((1 << vdd) & p_d->ocr_mask)
> -		spitz_card_pwr_ctrl(SCOOP_CPR_SD_3V, SCOOP_CPR_SD_3V);
> -	else
> -		spitz_card_pwr_ctrl(SCOOP_CPR_SD_3V, 0x0);
> -
> -	return 0;
> -}
> -
> -static struct pxamci_platform_data spitz_mci_platform_data = {
> -	.detect_delay_ms	= 250,
> -	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
> -	.setpower		= spitz_mci_setpower,
> -};
> -
> -static const struct property_entry spitz_mci_props[] __initconst = {
> -	PROPERTY_ENTRY_GPIO("cd-gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_nSD_DETECT, GPIO_ACTIVE_LOW),
> -	PROPERTY_ENTRY_GPIO("wp-gpios", &pxa2xx_gpiochip_node,
> -			    SPITZ_GPIO_nSD_WP, GPIO_ACTIVE_LOW),
> -	{ }
> -};
> -
> -static void __init spitz_mmc_init(void)
> -{
> -	pxa_set_mci_info(&spitz_mci_platform_data, spitz_mci_props);
> -}
> -#else
> -static inline void spitz_mmc_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * USB Host
> - ******************************************************************************/
> -#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> -static int spitz_ohci_init(struct device *dev)
> -{
> -	int err;
> -
> -	err = gpio_request(SPITZ_GPIO_USB_HOST, "USB_HOST");
> -	if (err)
> -		return err;
> -
> -	/* Only Port 2 is connected, setup USB Port 2 Output Control Register */
> -	UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
> -
> -	return gpio_direction_output(SPITZ_GPIO_USB_HOST, 1);
> -}
> -
> -static void spitz_ohci_exit(struct device *dev)
> -{
> -	gpio_free(SPITZ_GPIO_USB_HOST);
> -}
> -
> -static struct pxaohci_platform_data spitz_ohci_platform_data = {
> -	.port_mode	= PMM_NPS_MODE,
> -	.init		= spitz_ohci_init,
> -	.exit		= spitz_ohci_exit,
> -	.flags		= ENABLE_PORT_ALL | NO_OC_PROTECTION,
> -	.power_budget	= 150,
> -};
> -
> -static void __init spitz_uhc_init(void)
> -{
> -	pxa_set_ohci_info(&spitz_ohci_platform_data);
> -}
> -#else
> -static inline void spitz_uhc_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * Framebuffer
> - ******************************************************************************/
> -#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> -static struct pxafb_mode_info spitz_pxafb_modes[] = {
> -	{
> -		.pixclock       = 19231,
> -		.xres           = 480,
> -		.yres           = 640,
> -		.bpp            = 16,
> -		.hsync_len      = 40,
> -		.left_margin    = 46,
> -		.right_margin   = 125,
> -		.vsync_len      = 3,
> -		.upper_margin   = 1,
> -		.lower_margin   = 0,
> -		.sync           = 0,
> -	}, {
> -		.pixclock       = 134617,
> -		.xres           = 240,
> -		.yres           = 320,
> -		.bpp            = 16,
> -		.hsync_len      = 20,
> -		.left_margin    = 20,
> -		.right_margin   = 46,
> -		.vsync_len      = 2,
> -		.upper_margin   = 1,
> -		.lower_margin   = 0,
> -		.sync           = 0,
> -	},
> -};
> -
> -static struct pxafb_mach_info spitz_pxafb_info = {
> -	.modes          = spitz_pxafb_modes,
> -	.num_modes      = ARRAY_SIZE(spitz_pxafb_modes),
> -	.fixed_modes    = 1,
> -	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_ALTERNATE_MAPPING,
> -};
> -
> -static void __init spitz_lcd_init(void)
> -{
> -	pxa_set_fb_info(NULL, &spitz_pxafb_info);
> -}
> -#else
> -static inline void spitz_lcd_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * NAND Flash
> - ******************************************************************************/
> -#if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
> -static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
> -
> -static struct nand_bbt_descr spitz_nand_bbt = {
> -	.options	= 0,
> -	.offs		= 4,
> -	.len		= 2,
> -	.pattern	= scan_ff_pattern
> -};
> -
> -static int akita_ooblayout_ecc(struct mtd_info *mtd, int section,
> -			       struct mtd_oob_region *oobregion)
> -{
> -	if (section > 12)
> -		return -ERANGE;
> -
> -	switch (section % 3) {
> -	case 0:
> -		oobregion->offset = 5;
> -		oobregion->length = 1;
> -		break;
> -
> -	case 1:
> -		oobregion->offset = 1;
> -		oobregion->length = 3;
> -		break;
> -
> -	case 2:
> -		oobregion->offset = 6;
> -		oobregion->length = 2;
> -		break;
> -	}
> -
> -	oobregion->offset += (section / 3) * 0x10;
> -
> -	return 0;
> -}
> -
> -static int akita_ooblayout_free(struct mtd_info *mtd, int section,
> -				struct mtd_oob_region *oobregion)
> -{
> -	if (section)
> -		return -ERANGE;
> -
> -	oobregion->offset = 8;
> -	oobregion->length = 9;
> -
> -	return 0;
> -}
> -
> -static const struct mtd_ooblayout_ops akita_ooblayout_ops = {
> -	.ecc = akita_ooblayout_ecc,
> -	.free = akita_ooblayout_free,
> -};
> -
> -static const char * const probes[] = {
> -	"cmdlinepart",
> -	"ofpart",
> -	"sharpslpart",
> -	NULL,
> -};
> -
> -static struct sharpsl_nand_platform_data spitz_nand_pdata = {
> -	.badblock_pattern	= &spitz_nand_bbt,
> -	.part_parsers		= probes,
> -};
> -
> -static struct resource spitz_nand_resources[] = {
> -	{
> -		.start	= PXA_CS3_PHYS,
> -		.end	= PXA_CS3_PHYS + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct platform_device spitz_nand_device = {
> -	.name		= "sharpsl-nand",
> -	.id		= -1,
> -	.resource	= spitz_nand_resources,
> -	.num_resources	= ARRAY_SIZE(spitz_nand_resources),
> -	.dev		= {
> -		.platform_data	= &spitz_nand_pdata,
> -	}
> -};
> -
> -static void __init spitz_nand_init(void)
> -{
> -	if (machine_is_akita() || machine_is_borzoi()) {
> -		spitz_nand_bbt.len = 1;
> -		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
> -	}
> -
> -	platform_device_register(&spitz_nand_device);
> -}
> -#else
> -static inline void spitz_nand_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * NOR Flash
> - ******************************************************************************/
> -#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
> -static struct mtd_partition spitz_rom_parts[] = {
> -	{
> -		.name	="Boot PROM Filesystem",
> -		.offset	= 0x00140000,
> -		.size	= MTDPART_SIZ_FULL,
> -	},
> -};
> -
> -static struct physmap_flash_data spitz_rom_data = {
> -	.width		= 2,
> -	.nr_parts	= ARRAY_SIZE(spitz_rom_parts),
> -	.parts		= spitz_rom_parts,
> -};
> -
> -static struct resource spitz_rom_resources[] = {
> -	{
> -		.start	= PXA_CS0_PHYS,
> -		.end	= PXA_CS0_PHYS + SZ_8M - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct platform_device spitz_rom_device = {
> -	.name		= "physmap-flash",
> -	.id		= -1,
> -	.resource	= spitz_rom_resources,
> -	.num_resources	= ARRAY_SIZE(spitz_rom_resources),
> -	.dev		= {
> -		.platform_data	= &spitz_rom_data,
> -	},
> -};
> -
> -static void __init spitz_nor_init(void)
> -{
> -	platform_device_register(&spitz_rom_device);
> -}
> -#else
> -static inline void spitz_nor_init(void) {}
> -#endif
> -
> -/******************************************************************************
> - * I2C devices
> - ******************************************************************************/
> -#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
> -static struct pca953x_platform_data akita_pca953x_pdata = {
> -	.gpio_base		= AKITA_IOEXP_GPIO_BASE,
> -};
> -
> -static struct i2c_board_info spitz_i2c_devs[] = {
> -	{
> -		.type		= "wm8750",
> -		.addr		= 0x1b,
> -	}, {
> -		.type		= "max7310",
> -		.addr		= 0x18,
> -		.platform_data	= &akita_pca953x_pdata,
> -		.swnode		= &akita_max7310_gpiochip_node,
> -	},
> -};
> -
> -static struct regulator_consumer_supply isl6271a_consumers[] = {
> -	REGULATOR_SUPPLY("vcc_core", NULL),
> -};
> -
> -static struct regulator_init_data isl6271a_info[] = {
> -	{
> -		.constraints = {
> -			.name		= "vcc_core range",
> -			.min_uV		= 850000,
> -			.max_uV		= 1600000,
> -			.always_on	= 1,
> -			.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
> -		},
> -	.consumer_supplies	= isl6271a_consumers,
> -	.num_consumer_supplies	= ARRAY_SIZE(isl6271a_consumers),
> -	}
> -};
> -
> -static struct i2c_board_info spitz_pi2c_devs[] = {
> -	{
> -		.type		= "isl6271a",
> -		.addr		= 0x0c,
> -		.platform_data	= &isl6271a_info,
> -	},
> -};
> -
> -static void __init spitz_i2c_init(void)
> -{
> -	int size = ARRAY_SIZE(spitz_i2c_devs);
> -
> -	/* Only Akita has the max7310 chip */
> -	if (!machine_is_akita())
> -		size--;
> -
> -	pxa_set_i2c_info(NULL);
> -	pxa27x_set_i2c_power_info(NULL);
> -	i2c_register_board_info(0, spitz_i2c_devs, size);
> -	i2c_register_board_info(1, ARRAY_AND_SIZE(spitz_pi2c_devs));
> -}
> -#else
> -static inline void spitz_i2c_init(void) {}
> -#endif
> -
> -static const struct property_entry spitz_audio_props[] = {
> -	PROPERTY_ENTRY_GPIO("mute-l-gpios", &spitz_scoop_1_gpiochip_node, 3,
> -			    GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_GPIO("mute-r-gpios", &spitz_scoop_1_gpiochip_node, 4,
> -			    GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_GPIO("mic-gpios", &spitz_scoop_2_gpiochip_node, 8,
> -			    GPIO_ACTIVE_HIGH),
> -	{ }
> -};
> -
> -static const struct property_entry akita_audio_props[] = {
> -	PROPERTY_ENTRY_GPIO("mute-l-gpios", &spitz_scoop_1_gpiochip_node, 3,
> -			    GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_GPIO("mute-r-gpios", &spitz_scoop_1_gpiochip_node, 4,
> -			    GPIO_ACTIVE_HIGH),
> -	PROPERTY_ENTRY_GPIO("mic-gpios", &akita_max7310_gpiochip_node, 2,
> -			    GPIO_ACTIVE_HIGH),
> -	{ }
> -};
> -
> -/******************************************************************************
> - * Audio devices
> - ******************************************************************************/
> -static inline void spitz_audio_init(void)
> -{
> -	struct platform_device_info audio_info = {
> -		.name = "spitz-audio",
> -		.id = PLATFORM_DEVID_NONE,
> -		.properties = machine_is_akita() ?
> -				akita_audio_props : spitz_audio_props,
> -	};
> -
> -	platform_device_register_full(&audio_info);
> -}
> -
> -/******************************************************************************
> - * Machine init
> - ******************************************************************************/
> -static void spitz_poweroff(void)
> -{
> -	pxa_restart(REBOOT_GPIO, NULL);
> -}
> -
> -static void spitz_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	uint32_t msc0 = __raw_readl(MSC0);
> -	/* Bootloader magic for a reboot */
> -	if ((msc0 & 0xffff0000) == 0x7ff00000)
> -		__raw_writel((msc0 & 0xffff) | 0x7ee00000, MSC0);
> -
> -	spitz_poweroff();
> -}
> -
> -static void __init spitz_init(void)
> -{
> -	software_node_register(&spitz_scoop_1_gpiochip_node);
> -	if (machine_is_akita())
> -		software_node_register(&akita_max7310_gpiochip_node);
> -	else
> -		software_node_register(&spitz_scoop_2_gpiochip_node);
> -
> -	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
> -	register_platform_power_off(spitz_poweroff);
> -
> -	PMCR = 0x00;
> -
> -	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
> -	PCFR |= PCFR_OPDE;
> -
> -	pxa2xx_mfp_config(ARRAY_AND_SIZE(spitz_pin_config));
> -
> -	pxa_set_ffuart_info(NULL);
> -	pxa_set_btuart_info(NULL);
> -	pxa_set_stuart_info(NULL);
> -
> -	spitz_spi_init();
> -	spitz_scoop_init();
> -	spitz_mkp_init();
> -	spitz_keys_init();
> -	spitz_leds_init();
> -	spitz_mmc_init();
> -	spitz_pcmcia_init();
> -	spitz_uhc_init();
> -	spitz_lcd_init();
> -	spitz_nor_init();
> -	spitz_nand_init();
> -	spitz_i2c_init();
> -	spitz_audio_init();
> -
> -	regulator_has_full_constraints();
> -}
> -
> -static void __init spitz_fixup(struct tag *tags, char **cmdline)
> -{
> -	sharpsl_save_param();
> -	memblock_add(0xa0000000, SZ_64M);
> -}
> -
> -#ifdef CONFIG_MACH_SPITZ
> -MACHINE_START(SPITZ, "SHARP Spitz")
> -	.fixup		= spitz_fixup,
> -	.map_io		= pxa27x_map_io,
> -	.nr_irqs	= PXA_NR_IRQS,
> -	.init_irq	= pxa27x_init_irq,
> -	.init_machine	= spitz_init,
> -	.init_time	= pxa_timer_init,
> -	.restart	= spitz_restart,
> -MACHINE_END
> -#endif
> -
> -#ifdef CONFIG_MACH_BORZOI
> -MACHINE_START(BORZOI, "SHARP Borzoi")
> -	.fixup		= spitz_fixup,
> -	.map_io		= pxa27x_map_io,
> -	.nr_irqs	= PXA_NR_IRQS,
> -	.init_irq	= pxa27x_init_irq,
> -	.init_machine	= spitz_init,
> -	.init_time	= pxa_timer_init,
> -	.restart	= spitz_restart,
> -MACHINE_END
> -#endif
> -
> -#ifdef CONFIG_MACH_AKITA
> -MACHINE_START(AKITA, "SHARP Akita")
> -	.fixup		= spitz_fixup,
> -	.map_io		= pxa27x_map_io,
> -	.nr_irqs	= PXA_NR_IRQS,
> -	.init_irq	= pxa27x_init_irq,
> -	.init_machine	= spitz_init,
> -	.init_time	= pxa_timer_init,
> -	.restart	= spitz_restart,
> -MACHINE_END
> -#endif
> diff --git a/arch/arm/mach-pxa/spitz.h b/arch/arm/mach-pxa/spitz.h
> deleted file mode 100644
> index 04828d8918aa..000000000000
> --- a/arch/arm/mach-pxa/spitz.h
> +++ /dev/null
> @@ -1,185 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Hardware specific definitions for SL-Cx000 series of PDAs
> - *
> - * Copyright (c) 2005 Alexander Wykes
> - * Copyright (c) 2005 Richard Purdie
> - *
> - * Based on Sharp's 2.4 kernel patches
> - */
> -#ifndef __ASM_ARCH_SPITZ_H
> -#define __ASM_ARCH_SPITZ_H  1
> -#endif
> -
> -#include "irqs.h" /* PXA_NR_BUILTIN_GPIO, PXA_GPIO_TO_IRQ */
> -#include <linux/fb.h>
> -
> -/* Spitz/Akita GPIOs */
> -
> -#define SPITZ_GPIO_KEY_INT         (0) /* Key Interrupt */
> -#define SPITZ_GPIO_RESET           (1)
> -#define SPITZ_GPIO_nSD_DETECT      (9)
> -#define SPITZ_GPIO_TP_INT          (11) /* Touch Panel interrupt */
> -#define SPITZ_GPIO_AK_INT          (13) /* Remote Control */
> -#define SPITZ_GPIO_ADS7846_CS      (14)
> -#define SPITZ_GPIO_SYNC            (16)
> -#define SPITZ_GPIO_MAX1111_CS      (20)
> -#define SPITZ_GPIO_FATAL_BAT       (21)
> -#define SPITZ_GPIO_HSYNC           (22)
> -#define SPITZ_GPIO_nSD_CLK         (32)
> -#define SPITZ_GPIO_USB_DEVICE      (35)
> -#define SPITZ_GPIO_USB_HOST        (37)
> -#define SPITZ_GPIO_USB_CONNECT     (41)
> -#define SPITZ_GPIO_LCDCON_CS       (53)
> -#define SPITZ_GPIO_nPCE            (54)
> -#define SPITZ_GPIO_nSD_WP          (81)
> -#define SPITZ_GPIO_ON_RESET        (89)
> -#define SPITZ_GPIO_BAT_COVER       (90)
> -#define SPITZ_GPIO_CF_CD           (94)
> -#define SPITZ_GPIO_ON_KEY          (95)
> -#define SPITZ_GPIO_SWA             (97)
> -#define SPITZ_GPIO_SWB             (96)
> -#define SPITZ_GPIO_CHRG_FULL       (101)
> -#define SPITZ_GPIO_CO              (101)
> -#define SPITZ_GPIO_CF_IRQ          (105)
> -#define SPITZ_GPIO_AC_IN           (115)
> -#define SPITZ_GPIO_HP_IN           (116)
> -
> -/* Spitz Only GPIOs */
> -
> -#define SPITZ_GPIO_CF2_IRQ         (106) /* CF slot1 Ready */
> -#define SPITZ_GPIO_CF2_CD          (93)
> -
> -
> -/* Spitz/Akita Keyboard Definitions */
> -
> -#define SPITZ_KEY_STROBE_NUM         (11)
> -#define SPITZ_KEY_SENSE_NUM          (7)
> -#define SPITZ_GPIO_G0_STROBE_BIT     0x0f800000
> -#define SPITZ_GPIO_G1_STROBE_BIT     0x00100000
> -#define SPITZ_GPIO_G2_STROBE_BIT     0x01000000
> -#define SPITZ_GPIO_G3_STROBE_BIT     0x00041880
> -#define SPITZ_GPIO_G0_SENSE_BIT      0x00021000
> -#define SPITZ_GPIO_G1_SENSE_BIT      0x000000d4
> -#define SPITZ_GPIO_G2_SENSE_BIT      0x08000000
> -#define SPITZ_GPIO_G3_SENSE_BIT      0x00000000
> -
> -#define SPITZ_GPIO_KEY_STROBE0       88
> -#define SPITZ_GPIO_KEY_STROBE1       23
> -#define SPITZ_GPIO_KEY_STROBE2       24
> -#define SPITZ_GPIO_KEY_STROBE3       25
> -#define SPITZ_GPIO_KEY_STROBE4       26
> -#define SPITZ_GPIO_KEY_STROBE5       27
> -#define SPITZ_GPIO_KEY_STROBE6       52
> -#define SPITZ_GPIO_KEY_STROBE7       103
> -#define SPITZ_GPIO_KEY_STROBE8       107
> -#define SPITZ_GPIO_KEY_STROBE9       108
> -#define SPITZ_GPIO_KEY_STROBE10      114
> -
> -#define SPITZ_GPIO_KEY_SENSE0        12
> -#define SPITZ_GPIO_KEY_SENSE1        17
> -#define SPITZ_GPIO_KEY_SENSE2        91
> -#define SPITZ_GPIO_KEY_SENSE3        34
> -#define SPITZ_GPIO_KEY_SENSE4        36
> -#define SPITZ_GPIO_KEY_SENSE5        38
> -#define SPITZ_GPIO_KEY_SENSE6        39
> -
> -
> -/* Spitz Scoop Device (No. 1) GPIOs */
> -/* Suspend States in comments */
> -#define SPITZ_SCP_LED_GREEN     SCOOP_GPCR_PA11  /* Keep */
> -#define SPITZ_SCP_JK_B          SCOOP_GPCR_PA12  /* Keep */
> -#define SPITZ_SCP_CHRG_ON       SCOOP_GPCR_PA13  /* Keep */
> -#define SPITZ_SCP_MUTE_L        SCOOP_GPCR_PA14  /* Low */
> -#define SPITZ_SCP_MUTE_R        SCOOP_GPCR_PA15  /* Low */
> -#define SPITZ_SCP_CF_POWER      SCOOP_GPCR_PA16  /* Keep */
> -#define SPITZ_SCP_LED_ORANGE    SCOOP_GPCR_PA17  /* Keep */
> -#define SPITZ_SCP_JK_A          SCOOP_GPCR_PA18  /* Low */
> -#define SPITZ_SCP_ADC_TEMP_ON   SCOOP_GPCR_PA19  /* Low */
> -
> -#define SPITZ_SCP_IO_DIR      (SPITZ_SCP_JK_B | SPITZ_SCP_CHRG_ON | \
> -                               SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | \
> -                               SPITZ_SCP_CF_POWER | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
> -#define SPITZ_SCP_IO_OUT      (SPITZ_SCP_CHRG_ON | SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R)
> -#define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
> -#define SPITZ_SCP_SUS_SET     0
> -
> -#define SPITZ_SCP_GPIO_BASE	(PXA_NR_BUILTIN_GPIO)
> -#define SPITZ_GPIO_LED_GREEN	(SPITZ_SCP_GPIO_BASE + 0)
> -#define SPITZ_GPIO_JK_B		(SPITZ_SCP_GPIO_BASE + 1)
> -#define SPITZ_GPIO_CHRG_ON	(SPITZ_SCP_GPIO_BASE + 2)
> -#define SPITZ_GPIO_MUTE_L	(SPITZ_SCP_GPIO_BASE + 3)
> -#define SPITZ_GPIO_MUTE_R	(SPITZ_SCP_GPIO_BASE + 4)
> -#define SPITZ_GPIO_CF_POWER	(SPITZ_SCP_GPIO_BASE + 5)
> -#define SPITZ_GPIO_LED_ORANGE	(SPITZ_SCP_GPIO_BASE + 6)
> -#define SPITZ_GPIO_JK_A		(SPITZ_SCP_GPIO_BASE + 7)
> -#define SPITZ_GPIO_ADC_TEMP_ON	(SPITZ_SCP_GPIO_BASE + 8)
> -
> -/* Spitz Scoop Device (No. 2) GPIOs */
> -/* Suspend States in comments */
> -#define SPITZ_SCP2_IR_ON           SCOOP_GPCR_PA11  /* High */
> -#define SPITZ_SCP2_AKIN_PULLUP     SCOOP_GPCR_PA12  /* Keep */
> -#define SPITZ_SCP2_RESERVED_1      SCOOP_GPCR_PA13  /* High */
> -#define SPITZ_SCP2_RESERVED_2      SCOOP_GPCR_PA14  /* Low */
> -#define SPITZ_SCP2_RESERVED_3      SCOOP_GPCR_PA15  /* Low */
> -#define SPITZ_SCP2_RESERVED_4      SCOOP_GPCR_PA16  /* Low */
> -#define SPITZ_SCP2_BACKLIGHT_CONT  SCOOP_GPCR_PA17  /* Low */
> -#define SPITZ_SCP2_BACKLIGHT_ON    SCOOP_GPCR_PA18  /* Low */
> -#define SPITZ_SCP2_MIC_BIAS        SCOOP_GPCR_PA19  /* Low */
> -
> -#define SPITZ_SCP2_IO_DIR (SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1 | \
> -                           SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
> -                           SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
> -
> -#define SPITZ_SCP2_IO_OUT   (SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1)
> -#define SPITZ_SCP2_SUS_CLR  (SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
> -                             SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
> -#define SPITZ_SCP2_SUS_SET  (SPITZ_SCP2_IR_ON | SPITZ_SCP2_RESERVED_1)
> -
> -#define SPITZ_SCP2_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
> -#define SPITZ_GPIO_IR_ON		(SPITZ_SCP2_GPIO_BASE + 0)
> -#define SPITZ_GPIO_AKIN_PULLUP		(SPITZ_SCP2_GPIO_BASE + 1)
> -#define SPITZ_GPIO_RESERVED_1		(SPITZ_SCP2_GPIO_BASE + 2)
> -#define SPITZ_GPIO_RESERVED_2		(SPITZ_SCP2_GPIO_BASE + 3)
> -#define SPITZ_GPIO_RESERVED_3		(SPITZ_SCP2_GPIO_BASE + 4)
> -#define SPITZ_GPIO_RESERVED_4		(SPITZ_SCP2_GPIO_BASE + 5)
> -#define SPITZ_GPIO_BACKLIGHT_CONT	(SPITZ_SCP2_GPIO_BASE + 6)
> -#define SPITZ_GPIO_BACKLIGHT_ON		(SPITZ_SCP2_GPIO_BASE + 7)
> -#define SPITZ_GPIO_MIC_BIAS		(SPITZ_SCP2_GPIO_BASE + 8)
> -
> -/* Akita IO Expander GPIOs */
> -#define AKITA_IOEXP_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
> -#define AKITA_GPIO_RESERVED_0		(AKITA_IOEXP_GPIO_BASE + 0)
> -#define AKITA_GPIO_RESERVED_1		(AKITA_IOEXP_GPIO_BASE + 1)
> -#define AKITA_GPIO_MIC_BIAS		(AKITA_IOEXP_GPIO_BASE + 2)
> -#define AKITA_GPIO_BACKLIGHT_ON		(AKITA_IOEXP_GPIO_BASE + 3)
> -#define AKITA_GPIO_BACKLIGHT_CONT	(AKITA_IOEXP_GPIO_BASE + 4)
> -#define AKITA_GPIO_AKIN_PULLUP		(AKITA_IOEXP_GPIO_BASE + 5)
> -#define AKITA_GPIO_IR_ON		(AKITA_IOEXP_GPIO_BASE + 6)
> -#define AKITA_GPIO_RESERVED_7		(AKITA_IOEXP_GPIO_BASE + 7)
> -
> -/* Spitz IRQ Definitions */
> -
> -#define SPITZ_IRQ_GPIO_KEY_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_KEY_INT)
> -#define SPITZ_IRQ_GPIO_AC_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_AC_IN)
> -#define SPITZ_IRQ_GPIO_AK_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_AK_INT)
> -#define SPITZ_IRQ_GPIO_HP_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_HP_IN)
> -#define SPITZ_IRQ_GPIO_TP_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT)
> -#define SPITZ_IRQ_GPIO_SYNC           PXA_GPIO_TO_IRQ(SPITZ_GPIO_SYNC)
> -#define SPITZ_IRQ_GPIO_ON_KEY         PXA_GPIO_TO_IRQ(SPITZ_GPIO_ON_KEY)
> -#define SPITZ_IRQ_GPIO_SWA            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWA)
> -#define SPITZ_IRQ_GPIO_SWB            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWB)
> -#define SPITZ_IRQ_GPIO_BAT_COVER      PXA_GPIO_TO_IRQ(SPITZ_GPIO_BAT_COVER)
> -#define SPITZ_IRQ_GPIO_FATAL_BAT      PXA_GPIO_TO_IRQ(SPITZ_GPIO_FATAL_BAT)
> -#define SPITZ_IRQ_GPIO_CO             PXA_GPIO_TO_IRQ(SPITZ_GPIO_CO)
> -#define SPITZ_IRQ_GPIO_CF_IRQ         PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_IRQ)
> -#define SPITZ_IRQ_GPIO_CF_CD          PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_CD)
> -#define SPITZ_IRQ_GPIO_CF2_IRQ        PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF2_IRQ)
> -#define SPITZ_IRQ_GPIO_nSD_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_INT)
> -#define SPITZ_IRQ_GPIO_nSD_DETECT     PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_DETECT)
> -
> -/*
> - * Shared data structures
> - */
> -extern struct platform_device spitzssp_device;
> -extern struct sharpsl_charger_machinfo spitz_pm_machinfo;
> diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
> deleted file mode 100644
> index 806847c36549..000000000000
> --- a/arch/arm/mach-pxa/spitz_pm.c
> +++ /dev/null
> @@ -1,257 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Battery and Power Management code for the Sharp SL-Cxx00
> - *
> - * Copyright (c) 2005 Richard Purdie
> - */
> -
> -#include <linux/module.h>
> -#include <linux/stat.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/delay.h>
> -#include <linux/gpio/legacy.h>
> -#include <linux/gpio-pxa.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/apm-emulation.h>
> -#include <linux/spi/corgi_lcd.h>
> -
> -#include <asm/irq.h>
> -#include <asm/mach-types.h>
> -
> -#include "spitz.h"
> -#include "pxa27x.h"
> -#include "sharpsl_pm.h"
> -
> -#include "generic.h"
> -
> -#define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
> -#define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
> -#define SHARPSL_CHARGE_ON_ACIN_HIGH    0x9b  /* 6V */
> -#define SHARPSL_CHARGE_ON_ACIN_LOW     0x34  /* 2V */
> -#define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
> -#define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
> -
> -static int spitz_last_ac_status;
> -
> -static void spitz_charger_init(void)
> -{
> -	gpio_request(SPITZ_GPIO_KEY_INT, "Keyboard Interrupt");
> -	gpio_direction_input(SPITZ_GPIO_KEY_INT);
> -	gpio_request(SPITZ_GPIO_SYNC, "Sync");
> -	gpio_direction_input(SPITZ_GPIO_SYNC);
> -	gpio_request(SPITZ_GPIO_AC_IN, "Charger Detection");
> -	gpio_direction_input(SPITZ_GPIO_AC_IN);
> -	gpio_request(SPITZ_GPIO_ADC_TEMP_ON, "ADC Temp On");
> -	gpio_direction_output(SPITZ_GPIO_ADC_TEMP_ON, 0);
> -	gpio_request(SPITZ_GPIO_JK_B, "JK B");
> -	gpio_direction_output(SPITZ_GPIO_JK_B, 0);
> -	gpio_request(SPITZ_GPIO_CHRG_ON, "Charger On");
> -	gpio_direction_output(SPITZ_GPIO_CHRG_ON, 0);
> -}
> -
> -static void spitz_measure_temp(int on)
> -{
> -	gpio_set_value(SPITZ_GPIO_ADC_TEMP_ON, on);
> -}
> -
> -static void spitz_charge(int on)
> -{
> -	if (on) {
> -		if (sharpsl_pm.flags & SHARPSL_SUSPENDED) {
> -			gpio_set_value(SPITZ_GPIO_JK_B, 1);
> -			gpio_set_value(SPITZ_GPIO_CHRG_ON, 0);
> -		} else {
> -			gpio_set_value(SPITZ_GPIO_JK_B, 0);
> -			gpio_set_value(SPITZ_GPIO_CHRG_ON, 0);
> -		}
> -	} else {
> -		gpio_set_value(SPITZ_GPIO_JK_B, 0);
> -		gpio_set_value(SPITZ_GPIO_CHRG_ON, 1);
> -	}
> -}
> -
> -static void spitz_discharge(int on)
> -{
> -	gpio_set_value(SPITZ_GPIO_JK_A, on);
> -}
> -
> -/* HACK - For unknown reasons, accurate voltage readings are only made with a load
> -   on the power bus which the green led on spitz provides */
> -static void spitz_discharge1(int on)
> -{
> -	gpio_set_value(SPITZ_GPIO_LED_GREEN, on);
> -}
> -
> -static unsigned long gpio18_config = GPIO18_GPIO;
> -
> -static void spitz_presuspend(void)
> -{
> -	spitz_last_ac_status = sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN);
> -
> -	/* GPIO Sleep Register */
> -	PGSR0 = 0x00144018;
> -	PGSR1 = 0x00EF0000;
> -	if (machine_is_akita()) {
> -		PGSR2 = 0x2121C000;
> -		PGSR3 = 0x00600400;
> -	} else {
> -		PGSR2 = 0x0121C000;
> -		PGSR3 = 0x00600000;
> -	}
> -
> -	PGSR0 &= ~SPITZ_GPIO_G0_STROBE_BIT;
> -	PGSR1 &= ~SPITZ_GPIO_G1_STROBE_BIT;
> -	PGSR2 &= ~SPITZ_GPIO_G2_STROBE_BIT;
> -	PGSR3 &= ~SPITZ_GPIO_G3_STROBE_BIT;
> -	PGSR2 |= GPIO_bit(SPITZ_GPIO_KEY_STROBE0);
> -
> -	pxa2xx_mfp_config(&gpio18_config, 1);
> -	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, "Unknown");
> -	gpio_free(18);
> -
> -	PRER = GPIO_bit(SPITZ_GPIO_KEY_INT);
> -	PFER = GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET);
> -	PWER = GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET) | PWER_RTC;
> -	PKWR = GPIO_bit(SPITZ_GPIO_SYNC) | GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET);
> -	PKSR = 0xffffffff; /* clear */
> -
> -	/* nRESET_OUT Disable */
> -	PSLR |= PSLR_SL_ROD;
> -
> -	/* Stop 3.6MHz and drive HIGH to PCMCIA and CS */
> -	PCFR = PCFR_GPR_EN | PCFR_OPDE;
> -}
> -
> -static void spitz_postsuspend(void)
> -{
> -}
> -
> -static int spitz_should_wakeup(unsigned int resume_on_alarm)
> -{
> -	int is_resume = 0;
> -	int acin = sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN);
> -
> -	if (spitz_last_ac_status != acin) {
> -		if (acin) {
> -			/* charge on */
> -			sharpsl_pm.flags |= SHARPSL_DO_OFFLINE_CHRG;
> -			dev_dbg(sharpsl_pm.dev, "AC Inserted\n");
> -		} else {
> -			/* charge off */
> -			dev_dbg(sharpsl_pm.dev, "AC Removed\n");
> -			sharpsl_pm_led(SHARPSL_LED_OFF);
> -			sharpsl_pm.machinfo->charge(0);
> -			sharpsl_pm.charge_mode = CHRG_OFF;
> -		}
> -		spitz_last_ac_status = acin;
> -		/* Return to suspend as this must be what we were woken for */
> -		return 0;
> -	}
> -
> -	if (PEDR & GPIO_bit(SPITZ_GPIO_KEY_INT))
> -		is_resume |= GPIO_bit(SPITZ_GPIO_KEY_INT);
> -
> -	if (PKSR & GPIO_bit(SPITZ_GPIO_SYNC))
> -		is_resume |= GPIO_bit(SPITZ_GPIO_SYNC);
> -
> -	if (resume_on_alarm && (PEDR & PWER_RTC))
> -		is_resume |= PWER_RTC;
> -
> -	dev_dbg(sharpsl_pm.dev, "is_resume: %x\n", is_resume);
> -	return is_resume;
> -}
> -
> -static bool spitz_charger_wakeup(void)
> -{
> -	return !gpio_get_value(SPITZ_GPIO_KEY_INT) ||
> -		gpio_get_value(SPITZ_GPIO_SYNC);
> -}
> -
> -static unsigned long spitzpm_read_devdata(int type)
> -{
> -	switch (type) {
> -	case SHARPSL_STATUS_ACIN:
> -		return !gpio_get_value(SPITZ_GPIO_AC_IN);
> -	case SHARPSL_STATUS_LOCK:
> -		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
> -	case SHARPSL_STATUS_CHRGFULL:
> -		return gpio_get_value(sharpsl_pm.machinfo->gpio_batfull);
> -	case SHARPSL_STATUS_FATAL:
> -		return gpio_get_value(sharpsl_pm.machinfo->gpio_fatal);
> -	case SHARPSL_ACIN_VOLT:
> -		return sharpsl_pm_pxa_read_max1111(MAX1111_ACIN_VOLT);
> -	case SHARPSL_BATT_TEMP:
> -		return sharpsl_pm_pxa_read_max1111(MAX1111_BATT_TEMP);
> -	case SHARPSL_BATT_VOLT:
> -	default:
> -		return sharpsl_pm_pxa_read_max1111(MAX1111_BATT_VOLT);
> -	}
> -}
> -
> -struct sharpsl_charger_machinfo spitz_pm_machinfo = {
> -	.init             = spitz_charger_init,
> -	.exit             = NULL,
> -	.gpio_batlock     = SPITZ_GPIO_BAT_COVER,
> -	.gpio_acin        = SPITZ_GPIO_AC_IN,
> -	.gpio_batfull     = SPITZ_GPIO_CHRG_FULL,
> -	.batfull_irq	  = 1,
> -	.gpio_fatal       = SPITZ_GPIO_FATAL_BAT,
> -	.discharge        = spitz_discharge,
> -	.discharge1       = spitz_discharge1,
> -	.charge           = spitz_charge,
> -	.measure_temp     = spitz_measure_temp,
> -	.presuspend       = spitz_presuspend,
> -	.postsuspend      = spitz_postsuspend,
> -	.read_devdata     = spitzpm_read_devdata,
> -	.charger_wakeup   = spitz_charger_wakeup,
> -	.should_wakeup    = spitz_should_wakeup,
> -#if defined(CONFIG_LCD_CORGI)
> -	.backlight_limit = corgi_lcd_limit_intensity,
> -#endif
> -	.charge_on_volt	  = SHARPSL_CHARGE_ON_VOLT,
> -	.charge_on_temp	  = SHARPSL_CHARGE_ON_TEMP,
> -	.charge_acin_high = SHARPSL_CHARGE_ON_ACIN_HIGH,
> -	.charge_acin_low  = SHARPSL_CHARGE_ON_ACIN_LOW,
> -	.fatal_acin_volt  = SHARPSL_FATAL_ACIN_VOLT,
> -	.fatal_noacin_volt= SHARPSL_FATAL_NOACIN_VOLT,
> -	.bat_levels       = 40,
> -	.bat_levels_noac  = sharpsl_battery_levels_noac,
> -	.bat_levels_acin  = sharpsl_battery_levels_acin,
> -	.status_high_acin = 188,
> -	.status_low_acin  = 178,
> -	.status_high_noac = 185,
> -	.status_low_noac  = 175,
> -};
> -
> -static struct platform_device *spitzpm_device;
> -
> -static int spitzpm_init(void)
> -{
> -	int ret;
> -
> -	if (!machine_is_spitz() && !machine_is_akita()
> -			&& !machine_is_borzoi())
> -		return -ENODEV;
> -
> -	spitzpm_device = platform_device_alloc("sharpsl-pm", -1);
> -	if (!spitzpm_device)
> -		return -ENOMEM;
> -
> -	spitzpm_device->dev.platform_data = &spitz_pm_machinfo;
> -	ret = platform_device_add(spitzpm_device);
> -
> -	if (ret)
> -		platform_device_put(spitzpm_device);
> -
> -	return ret;
> -}
> -
> -static void spitzpm_exit(void)
> -{
> -	platform_device_unregister(spitzpm_device);
> -}
> -
> -module_init(spitzpm_init);
> -module_exit(spitzpm_exit);

