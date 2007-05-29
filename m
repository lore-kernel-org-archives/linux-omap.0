From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 6/11] Board file for OMAP3430 SDP
Date: Tue, 29 May 2007 12:19:02 +0530
Message-ID: <5d5443650705282349w22bb3692gf0637727731e2d11@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E32@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E32@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 5/29/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Adding new Board file for OMAP3430 SDP
>
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>
> Files Changed:
>  board-3430sdp.c |  304 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 304 insertions(+)
>
> =======================================================================
> diff -purN linux-omap/arch/arm/mach-omap2/board-3430sdp.c val_3430_GIT/arch/arm/mach-omap2/board-3430sdp.c
> --- linux-omap/arch/arm/mach-omap2/board-3430sdp.c      1969-12-31 18:00:00.000000000 -0600
> +++ val_3430_GIT/arch/arm/mach-omap2/board-3430sdp.c    2007-05-28 22:03:29.000000000 -0500
> @@ -0,0 +1,304 @@
> +/*
> + * linux/arch/arm/mach-omap3/board-3430sdp.c

should be mach-omap2 in the path instead.

> + *
> + * Copyright (C) 2007 Texas Instruments
> + *
> + * Modified from mach-omap2/board-generic.c
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
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/delay.h>
> +#include <linux/workqueue.h>
> +#include <linux/input.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +
> +#include <asm/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
> +
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/gpioexpander.h>

Are you using anything from gpioexpander?

> +#include <asm/arch/mux.h>
> +#include <asm/arch/usb.h>
> +#include <asm/arch/irda.h>

IrdA header?

> +#include <asm/arch/board.h>
> +#include <asm/arch/common.h>
> +#include <asm/arch/keypad.h>
> +#include <asm/arch/menelaus.h>

No menelaus on 3430SDP I believe. So please check all headers included
here are required or not.

> +#include <asm/arch/dma.h>
> +#include <asm/arch/gpmc.h>
> +
> +#include <asm/io.h>
> +#include <asm/delay.h>
> +


-- 
--Trilok Soni
