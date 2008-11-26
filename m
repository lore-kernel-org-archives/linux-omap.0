From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Please fix or remove OMAP2 onenand driver
Date: Wed, 26 Nov 2008 09:57:27 +0000
Message-ID: <20081126095726.GA7422@flint.arm.linux.org.uk>
References: <20081123165011.GB17438@flint.arm.linux.org.uk> <492A91E1.50305@nokia.com> <20081124120153.GA5330@flint.arm.linux.org.uk> <492AA1B4.9030803@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37102 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYKZKCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 05:02:49 -0500
Content-Disposition: inline
In-Reply-To: <492AA1B4.9030803@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>, dwmw2@infradead.org
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

On Mon, Nov 24, 2008 at 02:44:36PM +0200, Adrian Hunter wrote:
> From: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Date: Mon, 24 Nov 2008 13:34:53 +0200
> Subject: [PATCH] MTD: OMAP: OneNAND: header file relocation
> 
> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>

Great.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

David, can you merge this patch for 2.6.28 please?

> ---
> drivers/mtd/onenand/omap2.c |   17 ++++++++---------
> 1 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index e39b21d..a7e4d98 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -32,19 +32,18 @@
> #include <linux/platform_device.h>
> #include <linux/interrupt.h>
> #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> 
> -#include <asm/io.h>
> #include <asm/mach/flash.h>
> -#include <asm/arch/gpmc.h>
> -#include <asm/arch/onenand.h>
> -#include <asm/arch/gpio.h>
> -#include <asm/arch/pm.h>
> +#include <mach/gpmc.h>
> +#include <mach/onenand.h>
> +#include <mach/gpio.h>
> +#include <mach/pm.h>
> 
> -#include <linux/dma-mapping.h>
> -#include <asm/dma-mapping.h>
> -#include <asm/arch/dma.h>
> +#include <mach/dma.h>
> 
> -#include <asm/arch/board.h>
> +#include <mach/board.h>
> 
> #define DRIVER_NAME "omap2-onenand"
> 
> -- 
> 1.5.4.3
