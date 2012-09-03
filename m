From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] gpio/omap: fix possible memory leak in
	omap2_gpio_dev_init()
Date: Mon, 3 Sep 2012 12:11:06 +0100
Message-ID: <20120903111106.GA24189@n2100.arm.linux.org.uk>
References: <CAPgLHd9A0-Esqt8D87RunMWFFG7uTCERksia26DSO1xw8OUfmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50537 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2ICLLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 07:11:23 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd9A0-Esqt8D87RunMWFFG7uTCERksia26DSO1xw8OUfmg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tony@atomide.com, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Mon, Sep 03, 2012 at 06:13:33PM +0800, Wei Yongjun wrote:
> @@ -130,6 +132,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  
>  	pdev = omap_device_build(name, id - 1, oh, pdata,
>  				sizeof(*pdata),	NULL, 0, false);
> +	kfree(pdata->regs);
>  	kfree(pdata);

This one looks wrong.  pdata is copied by the internals of
omap_device_build(), which includes the 'regs' pointer, so it should not
be freed after a successful call to omap_device_build().  (It should,
however, be freed after an unsuccessful call.)

BTW, you want to copy Paul Walmsley with this patch (address in Cc).
