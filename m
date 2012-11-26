From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: Conditionally compile counter_32k
Date: Mon, 26 Nov 2012 14:02:21 +0200
Message-ID: <50B35A4D.8080501@compulab.co.il>
References: <1353922083-1094-1-git-send-email-alessio.bogani@elettra.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:58991 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754473Ab2KZMC2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 07:02:28 -0500
In-Reply-To: <1353922083-1094-1-git-send-email-alessio.bogani@elettra.trieste.it>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/26/12 11:28, Alessio Igor Bogani wrote:
> The 32K timer isn't available on all OMAP devices.
> 
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
> ---
>  arch/arm/plat-omap/Makefile |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 8d88584..b1b321c 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -3,11 +3,13 @@
>  #
>  
>  # Common support
> -obj-y := sram.o dma.o fb.o counter_32k.o
> +obj-y := sram.o dma.o fb.o
>  obj-m :=
>  obj-n :=
>  obj-  :=
>  
> +obj-$(CONFIG_OMAP_32K_TIMER) += counter_32k.o

We are moving away from this config option in favor of runtime detection,
so I don't think this patch is appropriate.

Why do you need this?

> +
>  # omap_device support (OMAP2+ only at the moment)
>  
>  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o

-- 
Regards,
Igor.
