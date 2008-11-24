From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Please fix or remove OMAP2 onenand driver
Date: Mon, 24 Nov 2008 12:01:53 +0000
Message-ID: <20081124120153.GA5330@flint.arm.linux.org.uk>
References: <20081123165011.GB17438@flint.arm.linux.org.uk> <492A91E1.50305@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42675 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYKXMCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 07:02:08 -0500
Content-Disposition: inline
In-Reply-To: <492A91E1.50305@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org

On Mon, Nov 24, 2008 at 01:37:05PM +0200, Adrian Hunter wrote:
> From: Adrian Hunter <ext-adrian.hunter@nokia.com>
> Date: Mon, 24 Nov 2008 13:34:53 +0200
> Subject: [PATCH] MTD: OMAP: OneNAND: header file relocation
> 
> Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>

Thanks.  Only two comments (see below).

> ---
> drivers/mtd/onenand/omap2.c |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index e39b21d..28034ef 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -35,16 +35,16 @@
> 
> #include <asm/io.h>

Should be linux/io.h and should be with the other linux/ includes.

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
> #include <linux/dma-mapping.h>
> #include <asm/dma-mapping.h>

asm/dma-mapping.h should not be included - only linux/dma-mapping.h, and
that should be up with the other linux/ includes.

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
