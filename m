From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] arm: mach-omap2: potential NULL dereference
Date: Mon, 17 Jan 2011 11:38:45 +0100
Message-ID: <4D341C35.80506@bfs.de>
References: <1295258922-31242-1-git-send-email-segoon@openwall.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295258922-31242-1-git-send-email-segoon@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



Am 17.01.2011 11:08, schrieb Vasiliy Kulikov:
> kzalloc() may fail, if so return -ENOMEM.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile this driver, so it is not tested at all.
> 
>  arch/arm/mach-omap2/smartreflex.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 77ecebf..871bca9 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -260,7 +260,10 @@ static int sr_late_init(struct omap_sr *sr_info)
>  	if (sr_class->class_type == SR_CLASS2 &&
>  		sr_class->notify_flags && sr_info->irq) {
>  
> +		ret = -ENOMEM;
>  		name = kzalloc(SMARTREFLEX_NAME_LEN + 1, GFP_KERNEL);
> +		if (name == NULL)
> +			goto error;
>  		strcpy(name, "sr_");
>  		strcat(name, sr_info->voltdm->name);
>  		ret = request_irq(sr_info->irq, sr_interrupt,

maybe it is more readable to use:
	kasprint(&name,"sr_%s",sr_info->voltdm->name);

re,
 wh
