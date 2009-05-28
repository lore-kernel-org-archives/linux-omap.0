From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 7/8] ARM: OMAP3: Add omap3 EVM support
Date: Thu, 28 May 2009 17:06:32 +0100
Message-ID: <20090528160632.GF20736@n2100.arm.linux.org.uk>
References: <20090525174517.19679.18805.stgit@localhost> <20090525175618.19679.45155.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47706 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZE1QGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 12:06:43 -0400
Content-Disposition: inline
In-Reply-To: <20090525175618.19679.45155.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Mohammed Khasim <khasim@ti.com>

On Mon, May 25, 2009 at 10:56:18AM -0700, Tony Lindgren wrote:
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> new file mode 100644
> index 0000000..6ce2f32
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -0,0 +1,329 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-omap3evm.c
> + *
> + * Copyright (C) 2008 Texas Instruments
> + *
> + * Modified from mach-omap2/board-3430sdp.c
> + *
> + * Initial code: Syed Mohammed Khasim
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/input.h>
> +#include <linux/leds.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/ads7846.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/gpio.h>

linux/gpio.h please.
