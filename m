From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] omap mailbox: platform_get_irq() error ignored
Date: Mon, 15 Jun 2009 12:30:11 +0300 (EEST)
Message-ID: <20090615.123011.173872570.Hiroshi.DOYU@nokia.com>
References: <1245057933-21380-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25614 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZFOJa3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 05:30:29 -0400
In-Reply-To: <1245057933-21380-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: roel.kluin@gmail.com, linux-omap@vger.kernel.org

From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Subject: [PATCH 1/1] omap mailbox: platform_get_irq() error ignored
Date: Mon, 15 Jun 2009 11:25:33 +0200

> From: ext Roel Kluin <roel.kluin@gmail.com>

Messed up with our mail server...use the following line instead...

  From: Roel Kluin <roel.kluin@gmail.com>

> 
> platform_get_irq may return -ENXIO. but struct omap_mbox mbox_dsp_info.irq
> is unsigned, so the error was not noticed.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index fd5b8a5..6f71f37 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -282,12 +282,12 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* DSP or IVA2 IRQ */
> -	mbox_dsp_info.irq = platform_get_irq(pdev, 0);
> -	if (mbox_dsp_info.irq < 0) {
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
>  		dev_err(&pdev->dev, "invalid irq resource\n");
> -		ret = -ENODEV;
>  		goto err_dsp;
>  	}
> +	mbox_dsp_info.irq = ret;
>  
>  	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
>  	if (ret)
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
