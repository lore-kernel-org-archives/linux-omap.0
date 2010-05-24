From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 11/14] omap: mailbox: only compile for configured
 archs
Date: Mon, 24 May 2010 17:42:05 +0300 (EEST)
Message-ID: <20100524.174205.22049047.Hiroshi.DOYU@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22292 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab0EXOmh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 10:42:37 -0400
In-Reply-To: <1274548465-20208-12-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 11/14] omap: mailbox: only compile for configured archs
Date: Sat, 22 May 2010 19:14:22 +0200

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index f55fa84..1f0c5cd 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -286,6 +286,7 @@ static struct omap_mbox_ops omap2_mbox_ops = {
>  
>  /* FIXME: the following structs should be filled automatically by the user id */
>  
> +#if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP2420)
>  /* DSP */
>  static struct omap_mbox2_priv omap2_mbox_dsp_priv = {
>  	.tx_fifo = {
> @@ -308,11 +309,13 @@ struct omap_mbox mbox_dsp_info = {
>  	.ops	= &omap2_mbox_ops,
>  	.priv	= &omap2_mbox_dsp_priv,
>  };
> +#endif
>  
> +#if defined(CONFIG_ARCH_OMAP3430)
>  struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
> +#endif
>  
>  #if defined(CONFIG_ARCH_OMAP2420)
> -
>  /* IVA */
>  static struct omap_mbox2_priv omap2_mbox_iva_priv = {
>  	.tx_fifo = {
> @@ -339,6 +342,7 @@ static struct omap_mbox mbox_iva_info = {
>  struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
>  #endif
>  
> +#if defined(CONFIG_ARCH_OMAP4)
>  /* OMAP4 */
>  static struct omap_mbox2_priv omap2_mbox_1_priv = {
>  	.tx_fifo = {
> @@ -385,6 +389,7 @@ struct omap_mbox mbox_2_info = {
>  };
>  
>  struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
> +#endif
>  
>  static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  {
> @@ -394,11 +399,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  
>  	res = pdev->resource;
>  
> -	if (cpu_is_omap3430()) {
> +	if (false);

nitpcik:
The above may look better as below:

	if (false)
		;

"checkpatch.pl" also doesn't complain.

> +#if defined(CONFIG_ARCH_OMAP3430)
> +	else if (cpu_is_omap3430()) {
>  		list = omap3_mboxes;
>  
>  		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>  	}
> +#endif
>  #if defined(CONFIG_ARCH_OMAP2420)
>  	else if (cpu_is_omap2420()) {
>  		list = omap2_mboxes;
> @@ -407,12 +415,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		list[1]->irq = platform_get_irq_byname(pdev, "iva");
>  	}
>  #endif
> +#if defined(CONFIG_ARCH_OMAP4)
>  	else if (cpu_is_omap44xx()) {
>  		list = omap4_mboxes;
>  
>  		list[0]->irq = list[1]->irq =
>  			platform_get_irq_byname(pdev, "mbox");

For checkpatch.pl,

  		list[0]->irq =
  			platform_get_irq_byname(pdev, "mbox");
  		list[1]->irq = list[0]->irq;

>  	}
> +#endif
>  	else {
>  		pr_err("%s: platform not supported\n", __func__);
>  		return -ENODEV;
> -- 
> 1.7.1
> 
