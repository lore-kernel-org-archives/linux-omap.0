From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: OMAP2+: Use pdata quirks for wl12xx legacy
 init
Date: Wed, 25 Sep 2013 16:26:59 -0700
Message-ID: <20130925232658.GD8949@atomide.com>
References: <20130920173310.2584.24522.stgit@localhost>
 <20130920173821.2584.1124.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54671 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756481Ab3IYX1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 19:27:01 -0400
Content-Disposition: inline
In-Reply-To: <20130920173821.2584.1124.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [130920 10:46]:
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> +#if IS_ENABLED(CONFIG_WL12XX)
> +
> +static struct wl12xx_platform_data wl12xx __initdata;
> +
> +static void __init __used legacy_init_wl12xx(unsigned ref_clock,
> +					     unsigned tcxo_clock,
> +					     int gpio)
> +{
> +	int res;
> +
> +	wl12xx.board_ref_clock = ref_clock;
> +	wl12xx.board_tcxo_clock = tcxo_clock;
> +	wl12xx.irq = gpio_to_irq(gpio);
> +
> +	res = wl12xx_set_platform_data(&wl12xx);
> +	if (res) {
> +		pr_err("error setting wl12xx data: %d\n", res);
> +		return;
> +	}
> +}
> +#else
> +static inline void omap_init_wl12xx_of(void)
> +{
> +}
> +#endif
> +

This should be legacy_init_wl12xx(unsigned ref_clock,
unsigned tcxo_clock, int gpio) instead of just
omap_init_wl12xx_of(void).

I've updated the patch and pushed this series to
omap-for-v3.13/quirk.

Regards,

Tony
