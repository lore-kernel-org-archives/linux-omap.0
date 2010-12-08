From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/11] OMAP2+: clockdomains: split the clkdm hwsup enable/disable function
Date: Wed, 08 Dec 2010 15:12:26 -0800
Message-ID: <871v5rg8px.fsf@deeprootsystems.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<20101208061838.30541.36426.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:51886 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab0LHXMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 18:12:30 -0500
Received: by pxi20 with SMTP id 20so526545pxi.10
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 15:12:29 -0800 (PST)
In-Reply-To: <20101208061838.30541.36426.stgit@twilight.localdomain> (Paul
	Walmsley's message of "Tue, 07 Dec 2010 23:18:39 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Split _omap2_clkdm_set_hwsup() into _disable_hwsup() and _enable_hwsup().
>
> While here, also document that the autodeps are deprecated and that they
> should be removed at the earliest opportunity.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
[...]

> @@ -222,28 +231,50 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
>  	}
>  }
>  
> -/*
> - * _omap2_clkdm_set_hwsup - set the hwsup idle transition bit
> +/**
> + * _enable_hwsup - set the hwsup idle transition bit
> + * @clkdm: struct clockdomain *
> + *
> + * XXX fix doco

hmm, 'doco' must be a new lingo I haven't learned yet.

> + * Internal helper for actually switching the bit that controls hwsup
> + * idle transitions for clkdm.
> + */
> +static void _enable_hwsup(struct clockdomain *clkdm)
> +{
> +	u32 bits, v;
> +
> +	if (cpu_is_omap24xx())
> +		bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
> +	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
> +		bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
> +	else
> +		BUG();
> +
> +	bits = bits << __ffs(clkdm->clktrctrl_mask);
> +
> +	v = __raw_readl(clkdm->clkstctrl_reg);
> +	v &= ~(clkdm->clktrctrl_mask);
> +	v |= bits;
> +	__raw_writel(v, clkdm->clkstctrl_reg);
> +
> +}
> +
> +/**
> + * _disable_hwsup - set the hwsup idle transition bit
>   * @clkdm: struct clockdomain *
> - * @enable: int 0 to disable, 1 to enable
>   *
> + * XXX fix doco

here too

Kevin
