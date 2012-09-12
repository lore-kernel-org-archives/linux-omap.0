From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] SPI: OMAP: remove unnecessary includes of plat/clock.h
Date: Wed, 12 Sep 2012 10:58:04 +0530
Message-ID: <50501D64.3030707@ti.com>
References: <alpine.DEB.2.00.1209112330290.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50115 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029Ab2ILF2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 01:28:11 -0400
Received: by obbuo13 with SMTP id uo13so2068356obb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 22:28:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209112330290.9444@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 12 September 2012 05:01 AM, Paul Walmsley wrote:
> Remove unnecessary includes of plat/clock.h from the OMAP SPI
> controller drivers.  These need to be removed to build multi-subarch
> ARM kernels which include these drivers.
Looks good to me
Acked-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/spi/spi-omap-100k.c   |    2 --
>  drivers/spi/spi-omap2-mcspi.c |    1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> index 9bd1c92..dfb4b7f 100644
> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -37,8 +37,6 @@
>  
>  #include <linux/spi/spi.h>
>  
> -#include <plat/clock.h>
> -
>  #define OMAP1_SPI100K_MAX_FREQ          48000000
>  
>  #define ICR_SPITAS      (OMAP7XX_ICR_BASE + 0x12)
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index b2fb141..b5d6994 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -41,7 +41,6 @@
>  
>  #include <linux/spi/spi.h>
>  
> -#include <plat/clock.h>
>  #include <plat/mcspi.h>
>  
>  #define OMAP2_MCSPI_MAX_FREQ		48000000

