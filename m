From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: drop explicit selection of HAVE_CLK and CLKDEV_LOOKUP
Date: Wed, 25 Sep 2013 09:20:24 +0200
Message-ID: <52428EB8.9010607@atmel.com>
References: <1380044515-3173-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380044515-3173-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 24/09/2013 19:41, Uwe Kleine-K=C3=B6nig :
> CLKDEV_LOOKUP selects HAVE_CLK and COMMON_CLK selects CLKDEV_LOOKUP. =
So
> all symbols that select at least two of these symbols can be simplifi=
ed.
>
> For imx, omap2 and ux500 some rearrangements were necessary before th=
e
> simplification.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>   arch/arm/Kconfig               | 12 ------------
>   arch/arm/mach-highbank/Kconfig |  1 -
>   arch/arm/mach-imx/Kconfig      | 10 +---------
>   arch/arm/mach-omap2/Kconfig    |  9 +--------
>   arch/arm/mach-socfpga/Kconfig  |  1 -
>   arch/arm/mach-spear/Kconfig    |  2 --
>   arch/arm/mach-tegra/Kconfig    |  2 --
>   arch/arm/mach-u300/Kconfig     |  1 -
>   arch/arm/mach-ux500/Kconfig    | 29 ++++++++++++-----------------
>   arch/arm/mach-vexpress/Kconfig |  2 --
>   arch/arm/mach-vt8500/Kconfig   |  1 -
>   11 files changed, 14 insertions(+), 56 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3230f4c..66164a0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -360,7 +360,6 @@ config ARCH_AT91
>   	bool "Atmel AT91"
>   	select ARCH_REQUIRE_GPIOLIB
>   	select CLKDEV_LOOKUP
> -	select HAVE_CLK

=46or AT91:

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>


>   	select IRQ_DOMAIN
>   	select NEED_MACH_GPIO_H
>   	select NEED_MACH_IO_H if PCCARD

[..]

Thanks Uwe, bye,
--=20
Nicolas Ferre
