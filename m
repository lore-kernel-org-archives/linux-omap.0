From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix dependency on indirect header inclusion
Date: Fri, 16 Aug 2013 21:59:54 +0530
Message-ID: <520E5382.1090408@ti.com>
References: <1373548145-3833-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43537 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab3HPQaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 12:30:03 -0400
In-Reply-To: <1373548145-3833-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, a-bindra@ti.com, Tony Lindgren <tony@atomide.com>, ezequiel.garcia@free-electrons.com, nm@ti.com

On Thursday 11 July 2013 06:39 PM, Felipe Balbi wrote:
> omap_hsmmc.c depends on <linux/sizes.h> being
> included indirectly by another header. Once we
> enable COMPILE_TEST for this driver, we might
> compile under architectures which won't include
> <linux/sizes.h> for us. In fact, one such case
> is x86.
>
> In order to prevent compile breakages, let's
> explicitly include <linux/sizes.h>
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> This should be applied before http://marc.info/?l=linux-omap&m=137347241524118&w=2
> in order to maintain bisectability.
Thanks Felipe

Acked-by: Balaji T K <balajitk@ti.com>

>
> cheers
>
>   drivers/mmc/host/omap_hsmmc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1865321..c937ffc 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -21,6 +21,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/dmaengine.h>
>   #include <linux/seq_file.h>
> +#include <linux/sizes.h>
>   #include <linux/interrupt.h>
>   #include <linux/delay.h>
>   #include <linux/dma-mapping.h>
>

