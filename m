From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before
 judging omap_dma_reserve_channels
Date: Thu, 10 Jan 2013 16:18:39 +0530
Message-ID: <50EE9C87.6060407@ti.com>
References: <50EE9815.2080402@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34604 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3AJKr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 05:47:57 -0500
In-Reply-To: <50EE9815.2080402@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 10 January 2013 03:59 PM, Chen Gang wrote:
>
>    dma_lch_count is zero before 1st call of omap_system_dma_probe.
>    omap_dma_reserve_channels has value before 1st call of omap_system_dma_probe
>
>    when 1st call of omap_system_dma_probe
>      we need set dma_lch_count before use it for judging
>      or which will be failed for omap_dma_reserve_channels
>
>    additional info:
>      this patch is only for fixing bug, not touch the features.
>      so, not use d->lch_count instead of dma_lch_count for the statement:
>
>                          && (omap_dma_reserve_channels <= dma_lch_count))
>
Why not ? Infact thats the right fix as mentioned in the review.

>      at least, now, current fixing is equal to above.
>      in the future
>        maybe omap_dma_reserve_channels can be set by outside (such as from /proc)
>        dma_lch_count is a static global variable which has effect to all devices.
>        maybe the original author do not hope the newer is larger than the older
>
'omap_dma_reserve_channels' when used is suppose to be from command
line. Hence the proposed fix in the review is the right one.

Regards
santosh

