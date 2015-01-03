From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH V2 2/2] ARM: l2c: AM437x: Introduce support for cache
 filter programming
Date: Sat, 3 Jan 2015 15:40:01 +0900
Message-ID: <CA+Ln22Epd8VpA9DQPFYBdjewUY3ejODhaRHgBSNZAQCYjx5saw@mail.gmail.com>
References: <1420220628-23742-1-git-send-email-nm@ti.com>
	<1420220628-23742-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420220628-23742-3-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Santosh <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

2015-01-03 2:43 GMT+09:00 Nishanth Menon <nm@ti.com>:
> AM437x generation of processors support programming the PL310 L2Cache
> controller's address filter start and end registers using a secure
> montior service.

typo: s/montior/monitor/

[snip]

> +               base = omap4_get_l2cache_base();
> +               filter_start = (reg == L310_ADDR_FILTER_START) ? val :
> +                              readl_relaxed(base + L310_ADDR_FILTER_START);
> +               filter_end = (reg == L310_ADDR_FILTER_END) ? val :
> +                              readl_relaxed(base + L310_ADDR_FILTER_END);
> +               omap_smc1_2(AM43X_MON_L2X0_SETFILTER_INDEX, filter_start,
> +                           filter_end);
> +               return;

I don't have any significant comments about this patch in particular,
but just noticed that you need to do read-backs here (and the typo
thanks to the spell checker of my mailing app). Maybe you should
consider switching to the .configure() API I introduced in my series?
This would let you get rid of the hardcoded static mapping.

Best regards,
Tomasz
