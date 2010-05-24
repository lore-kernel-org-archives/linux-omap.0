From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 10/14] omap: mailbox: reorganize registering
Date: Mon, 24 May 2010 18:24:07 +0300 (EEST)
Message-ID: <20100524.182407.67910029.Hiroshi.DOYU@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46314 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062Ab0EXPYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 11:24:19 -0400
In-Reply-To: <1274548465-20208-11-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
Date: Sat, 22 May 2010 19:14:21 +0200

> platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (unlikely(!res)) {
> -		dev_err(&pdev->dev, "invalid mem resource\n");
> -		return -ENODEV;
> -	}
> +	res = pdev->resource;

why not?

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +
> +	list = omap1_mboxes;
>  
> -	mbox_base = ioremap(res->start, resource_size(res));
> +	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
> +
> +	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	/* DSP IRQ */
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(!res)) {
> -		dev_err(&pdev->dev, "invalid irq resource\n");
> -		ret = -ENODEV;
> -		goto err_out;
> +	for (i = 0; list[i]; i++) {
> +		ret = omap_mbox_register(&pdev->dev, list[i]);
> +		if (ret)
> +			goto err_out;
>  	}
> -	mbox_dsp_info.irq = res->start;
> -
> -	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
> -	if (ret)
> -		goto err_out;
>  	return 0;
>  
>  err_out:
> +	while (i--)
> +		omap_mbox_unregister(list[i]);
>  	iounmap(mbox_base);
>  	return ret;
