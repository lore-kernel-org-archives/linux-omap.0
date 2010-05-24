From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Mon, 24 May 2010 18:14:28 +0300 (EEST)
Message-ID: <20100524.181428.176650885.Hiroshi.DOYU@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29574 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab0EXPOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 11:14:48 -0400
In-Reply-To: <1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Sat, 22 May 2010 19:14:24 +0200

> No need to dynamically register mailboxes one by one.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap1/mailbox.c             |   25 ++------
>  arch/arm/mach-omap2/mailbox.c             |   22 ++-----
>  arch/arm/plat-omap/include/plat/mailbox.h |    5 +-
>  arch/arm/plat-omap/mailbox.c              |   95 +++++++++++------------------
>  4 files changed, 50 insertions(+), 97 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index 4210896..e50b3c2 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -29,8 +29,6 @@
>  
>  static void __iomem *mbox_base;
>  
> -static struct omap_mbox **list;
> -
>  struct omap_mbox1_fifo {
>  	unsigned long cmd;
>  	unsigned long data;
> @@ -151,38 +149,29 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  	int i;
> +	struct omap_mbox **list;
>  
>  	res = pdev->resource;
>  
>  	list = omap1_mboxes;
> -
>  	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>  
>  	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; list[i]; i++) {
> -		ret = omap_mbox_register(&pdev->dev, list[i]);
> -		if (ret)
> -			goto err_out;
> +	ret = omap_mbox_register(&pdev->dev, list);
> +	if (ret) {
> +		iounmap(mbox_base);
> +		return ret;
>  	}
> -	return 0;
>  
> -err_out:
> -	while (i--)
> -		omap_mbox_unregister(list[i]);
> -	iounmap(mbox_base);
> -	return ret;
> +	return 0;
>  }
>  
>  static int __devexit omap1_mbox_remove(struct platform_device *pdev)
>  {
> -	int i;
> -
> -	for (i = 0; list[i]; i++)
> -		omap_mbox_unregister(list[i]);
> -
> +	omap_mbox_unregister();
>  	iounmap(mbox_base);
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index a433ca7..66d366d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -54,8 +54,6 @@
>  
>  static void __iomem *mbox_base;
>  
> -static struct omap_mbox **list;
> -
>  struct omap_mbox2_fifo {
>  	unsigned long msg;
>  	unsigned long fifo_stat;
> @@ -393,7 +391,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	int ret;
> -	int i;
> +	struct omap_mbox **list;
>  
>  	res = pdev->resource;
>  
> @@ -430,27 +428,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; list[i]; i++) {
> -		ret = omap_mbox_register(&pdev->dev, list[i]);
> -		if (ret)
> -			goto err_out;
> +	ret = omap_mbox_register(&pdev->dev, list);
> +	if (ret) {
> +		iounmap(mbox_base);
> +		return ret;
>  	}
>  	return 0;
>  
> -err_out:
> -	while (i--)
> -		omap_mbox_unregister(list[i]);
> -	iounmap(mbox_base);
>  	return ret;
>  }

The above result in:

    ....
	ret = omap_mbox_register(&pdev->dev, list);
	if (ret) {
		iounmap(mbox_base);
		return ret;
	}
	return 0;

	return ret;
}


