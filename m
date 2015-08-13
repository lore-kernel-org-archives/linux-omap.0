From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to clk_hw_get_name(hw)
Date: Thu, 13 Aug 2015 09:57:24 +0200
Message-ID: <1489587.uKDjVe3x3J@diego>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org> <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TasMV2rI37PzA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Am Mittwoch, 12. August 2015, 16:12:41 schrieb Stephen Boyd:
> Use the provider based method to get a clock's name so that we
> can get rid of the clk member in struct clk_hw one day. Mostly
> converted with the following coccinelle script.
> 
> @@
> struct clk_hw *E;
> @@
> 
> -__clk_get_name(E->clk)
> +clk_hw_get_name(E)
> 

For the Rockchip part
Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>


Heiko

> diff --git a/drivers/clk/rockchip/clk-inverter.c
> b/drivers/clk/rockchip/clk-inverter.c index 8054fdb5effb..7cbf43beb3c6
> 100644
> --- a/drivers/clk/rockchip/clk-inverter.c
> +++ b/drivers/clk/rockchip/clk-inverter.c
> @@ -50,7 +50,7 @@ static int rockchip_inv_set_phase(struct clk_hw *hw, int
> degrees) val = !!degrees;
>  	} else {
>  		pr_err("%s: unsupported phase %d for %s\n",
> -		       __func__, degrees, __clk_get_name(hw->clk));
> +		       __func__, degrees, clk_hw_get_name(hw));
>  		return -EINVAL;
>  	}
> 
> diff --git a/drivers/clk/rockchip/clk-mmc-phase.c
> b/drivers/clk/rockchip/clk-mmc-phase.c index 77e19097bdc7..9b613426e968
> 100644
> --- a/drivers/clk/rockchip/clk-mmc-phase.c
> +++ b/drivers/clk/rockchip/clk-mmc-phase.c
> @@ -108,7 +108,7 @@ static int rockchip_mmc_set_phase(struct clk_hw *hw, int
> degrees) writel(HIWORD_UPDATE(raw_value, 0x07ff, mmc_clock->shift),
> mmc_clock->reg);
> 
>  	pr_debug("%s->set_phase(%d) delay_nums=%u reg[0x%p]=0x%03x
> actual_degrees=%d\n", -		__clk_get_name(hw->clk), degrees, delay_num,
> +		clk_hw_get_name(hw), degrees, delay_num,
>  		mmc_clock->reg, raw_value>>(mmc_clock->shift),
>  		rockchip_mmc_get_phase(hw)
>  	);
