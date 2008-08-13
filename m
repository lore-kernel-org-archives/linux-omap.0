From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [2/2]
Date: Wed, 13 Aug 2008 16:58:09 +0300
Message-ID: <20080813135808.GD27446@atomide.com>
References: <7B4574D56E4ADF438756313E9A172A870D5F0E59@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62602 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYHMNz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 09:55:56 -0400
Content-Disposition: inline
In-Reply-To: <7B4574D56E4ADF438756313E9A172A870D5F0E59@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hunter, Jon <jon-hunter@ti.com> [080813 06:08]:
> Corrected header file path in file sound/arm/omap/omap-alsa-dma.c.

Thanks, pushing today.

Tony


> 
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  sound/arm/omap/omap-alsa-dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/arm/omap/omap-alsa-dma.c b/sound/arm/omap/omap-alsa-dma.c
> index d263933..baafacf 100644
> --- a/sound/arm/omap/omap-alsa-dma.c
> +++ b/sound/arm/omap/omap-alsa-dma.c
> @@ -64,9 +64,9 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> +#include <linux/semaphore.h>
> 
>  #include <asm/hardware.h>
> -#include <asm/semaphore.h>
>  #include <asm/arch/dma.h>
>  #include <asm/arch/mcbsp.h>
>  #include <asm/arch/omap-alsa.h>
> --
> 1.4.4.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
