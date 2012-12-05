From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3 04/23] mfd: omap-usb-tll: Use devm_kzalloc/ioremap
 and clean up error path
Date: Wed, 05 Dec 2012 18:08:22 +0400
Message-ID: <50BF5556.4020500@mvista.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com> <1354630396-24545-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32768 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab2LEOJx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 09:09:53 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so4319702lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Dec 2012 06:09:51 -0800 (PST)
In-Reply-To: <1354630396-24545-5-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 04-12-2012 18:12, Roger Quadros wrote:

> Use devm_ variants of kzalloc() and ioremap(). Simplify the error path.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/mfd/omap-usb-tll.c |   37 +++++++++++--------------------------
>   1 files changed, 11 insertions(+), 26 deletions(-)

> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index e67cafc..828207f 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
[...]
> @@ -230,28 +229,21 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
>   	if (IS_ERR(tll->usbtll_p1_fck)) {
>   		ret = PTR_ERR(tll->usbtll_p1_fck);
>   		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
> -		goto err_tll;
> +		return ret;
>   	}
>
>   	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
>   	if (IS_ERR(tll->usbtll_p2_fck)) {
>   		ret = PTR_ERR(tll->usbtll_p2_fck);
>   		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
> -		goto err_usbtll_p1_fck;
> +		goto err_p2_fck;
>   	}
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "usb tll get resource failed\n");
> -		ret = -ENODEV;
> -		goto err_usbtll_p2_fck;
> -	}

    Not clear why you removed the error check...

> -
> -	base = ioremap(res->start, resource_size(res));
> +	base = devm_request_and_ioremap(dev, res);
>   	if (!base) {
> -		dev_err(dev, "TLL ioremap failed\n");
> -		ret = -ENOMEM;
> -		goto err_usbtll_p2_fck;
> +		ret = -EADDRNOTAVAIL;

    Why you changed this from ENOMEM?

WBR, Sergei

