From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 10/11] OMAP: DMA: Use DMA device attributes
Date: Fri, 03 Sep 2010 13:45:48 -0700
Message-ID: <874oe6wo77.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-11-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60599 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab0ICUpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 16:45:52 -0400
Received: by pzk9 with SMTP id 9so674428pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 13:45:51 -0700 (PDT)
In-Reply-To: <1282647866-6918-11-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Tue, 24 Aug 2010 16:34:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> Existing DMA API's are using cpu_is_xxxx checks for differenciating
> omap1 and omap2plus code.
>
> This patch replaces cpu_is_xxxx checks with DMA device attributes and
> also moves API's which are OMAP1 and OMAP2plus specific into respective
> mach-omap dma driver files.
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

[...]

>  int omap_request_dma(int dev_id, const char *dev_name,
>  		     void (*callback)(int lch, u16 ch_status, void *data),
>  		     void *data, int *dma_ch_out)
> @@ -754,14 +459,12 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	chan = dma_chan + free_ch;
>  	chan->dev_id = dev_id;
>  
> -	pm_runtime_get_sync(&ddev->dev);
> -
> -	if (cpu_class_is_omap1())
> -		clear_lch_regs(free_ch);
> -
> -	if (cpu_class_is_omap2())
> +	if (p->clear_lch_regs)
> +		p->clear_lch_regs(free_ch);
> +	else
>  		omap_clear_dma(free_ch);

You access HW registers here.

> +	pm_runtime_get_sync(&ddev->dev);

But don't actually enable HW until here.  

IOW, you need to have the 'get' before you access the HW.

Kevin
