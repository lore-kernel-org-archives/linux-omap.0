From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] arm: mach-omap2: potential NULL dereference
Date: Tue, 01 Feb 2011 14:22:19 -0800
Message-ID: <87lj1zpf8k.fsf@ti.com>
References: <1295258922-31242-1-git-send-email-segoon@openwall.com>
	<4D341C35.80506@bfs.de> <20110119125721.GA9203@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54227 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751708Ab1BAWWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 17:22:24 -0500
In-Reply-To: <20110119125721.GA9203@albatros> (Vasiliy Kulikov's message of
	"Wed, 19 Jan 2011 15:57:22 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: linux-kernel@vger.kernel.org, walter harms <wharms@bfs.de>, kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vasiliy Kulikov <segoon@openwall.com> writes:

> kzalloc() may fail, if so return -ENOMEM.  Also Walter Harms suggested
> to use kasprintf() instead of kzalloc+strcpy+strcat.
>
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile this driver, so it is not tested at all.

Boot tested on 3430/n900 and 3630/Zoom3.

Queueing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin

>  arch/arm/mach-omap2/smartreflex.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 77ecebf..697d8d4 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -260,9 +260,11 @@ static int sr_late_init(struct omap_sr *sr_info)
>  	if (sr_class->class_type == SR_CLASS2 &&
>  		sr_class->notify_flags && sr_info->irq) {
>  
> -		name = kzalloc(SMARTREFLEX_NAME_LEN + 1, GFP_KERNEL);
> -		strcpy(name, "sr_");
> -		strcat(name, sr_info->voltdm->name);
> +		name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
> +		if (name == NULL) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>  		ret = request_irq(sr_info->irq, sr_interrupt,
>  				0, name, (void *)sr_info);
>  		if (ret)
