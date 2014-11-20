From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/15] clk: divider: replace bitfield width with mask
Date: Thu, 20 Nov 2014 13:19:47 +0200
Message-ID: <546DCE53.8020004@ti.com>
References: <1416438943-11429-1-git-send-email-james.hogan@imgtec.com> <1416438943-11429-2-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416438943-11429-2-git-send-email-james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/20/2014 01:15 AM, James Hogan wrote:
> From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> The forthcoming Device Tree binding for the divider clock type will u=
se
> a bitfield mask instead of bitfield width, which is what the current
> basic divider implementation uses.
>
> This patch replaces the u8 width in struct clk_divider with a u32 mas=
k.
> The divider code is updated to use the bit mask internally but the tw=
o
> registration functions still accept the width to maintain compatibili=
ty
> with existing users.
>
> Also updated in this patch is the clk-private.h divider macro and
> various clock divider implementations that are based on struct
> clk_divider.
>
> Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> [james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org: forward port, fix new uses of width]
> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Cc: "Emilio L=C3=B3pez" <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> ---
> Changes since original:
> - Forward ported
> - Adjust new div_mask from recent patch "clk-divider: Fix READ_ONLY w=
hen
>    divider > 1"
> - Updated assignment of clk_divider::width in imx, rockchip, st, sunx=
i,
>    ti clock components to use mask instead (not tested), using the
>    following semantic patch:

Hi James/Mike,

This patch currently causes a build breakage with omap2plus_defconfig.=20
Reason being you are modifying the clk_divider struct, but not touching=
=20
the code under drivers/clk/ti/divider.c which uses it. The fixes are=20
basically the same you have done for clk-divider.c, the contents of thi=
s=20
file are mostly just copied under TI clock driver.

-Tero

>
> virtual context
> virtual patch
>
> @depends on context@
> struct clk_divider clk;
> expression e;
> @@
> *clk.width =3D e
>
> @depends on patch@
> struct clk_divider clk;
> expression e;
> @@
> -clk.width =3D fls(e)
> +clk.mask =3D e
>
> @depends on patch@
> struct clk_divider *clk;
> expression e;
> @@
> -clk->width =3D fls(e)
> +clk->mask =3D e
>
> @depends on patch@
> struct clk_divider clk;
> expression e;
> @@
> -clk.width =3D e
> +clk.mask =3D BIT(e) - 1
>
> @depends on patch@
> struct clk_divider *clk;
> expression e;
> @@
> -clk->width =3D e
> +clk->mask =3D BIT(e) - 1
> ---
>   arch/arm/mach-imx/clk-busy.c      |  2 +-
>   arch/arm/mach-imx/clk-fixup-div.c |  2 +-
>   drivers/clk/clk-divider.c         | 33 ++++++++++++++++------------=
-----
>   drivers/clk/mxs/clk-div.c         |  2 +-
>   drivers/clk/rockchip/clk.c        |  2 +-
>   drivers/clk/st/clk-flexgen.c      |  4 ++--
>   drivers/clk/st/clkgen-mux.c       |  4 ++--
>   drivers/clk/st/clkgen-pll.c       |  2 +-
>   drivers/clk/sunxi/clk-sunxi.c     |  2 +-
>   drivers/clk/ti/divider.c          |  2 +-
>   include/linux/clk-private.h       |  2 +-
>   include/linux/clk-provider.h      |  2 +-
>   12 files changed, 29 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-bus=
y.c
> index 4bb1bc4..bc88e38 100644
> --- a/arch/arm/mach-imx/clk-busy.c
> +++ b/arch/arm/mach-imx/clk-busy.c
> @@ -95,7 +95,7 @@ struct clk *imx_clk_busy_divider(const char *name, =
const char *parent_name,
>
>   	busy->div.reg =3D reg;
>   	busy->div.shift =3D shift;
> -	busy->div.width =3D width;
> +	busy->div.mask =3D BIT(width) - 1;
>   	busy->div.lock =3D &imx_ccm_lock;
>   	busy->div_ops =3D &clk_divider_ops;
>
> diff --git a/arch/arm/mach-imx/clk-fixup-div.c b/arch/arm/mach-imx/cl=
k-fixup-div.c
> index 21db020..af33b7a 100644
> --- a/arch/arm/mach-imx/clk-fixup-div.c
> +++ b/arch/arm/mach-imx/clk-fixup-div.c
> @@ -115,7 +115,7 @@ struct clk *imx_clk_fixup_divider(const char *nam=
e, const char *parent,
>
>   	fixup_div->divider.reg =3D reg;
>   	fixup_div->divider.shift =3D shift;
> -	fixup_div->divider.width =3D width;
> +	fixup_div->divider.mask =3D BIT(width) - 1;
>   	fixup_div->divider.lock =3D &imx_ccm_lock;
>   	fixup_div->divider.hw.init =3D &init;
>   	fixup_div->ops =3D &clk_divider_ops;
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index c0a842b..a432cf8 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -30,8 +30,6 @@
>
>   #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, h=
w)
>
> -#define div_mask(d)	((1 << ((d)->width)) - 1)
> -
>   static unsigned int _get_table_maxdiv(const struct clk_div_table *t=
able)
>   {
>   	unsigned int maxdiv =3D 0;
> @@ -57,12 +55,12 @@ static unsigned int _get_table_mindiv(const struc=
t clk_div_table *table)
>   static unsigned int _get_maxdiv(struct clk_divider *divider)
>   {
>   	if (divider->flags & CLK_DIVIDER_ONE_BASED)
> -		return div_mask(divider);
> +		return divider->mask;
>   	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> -		return 1 << div_mask(divider);
> +		return 1 << divider->mask;
>   	if (divider->table)
>   		return _get_table_maxdiv(divider->table);
> -	return div_mask(divider) + 1;
> +	return divider->mask + 1;
>   }
>
>   static unsigned int _get_table_div(const struct clk_div_table *tabl=
e,
> @@ -116,7 +114,7 @@ static unsigned long clk_divider_recalc_rate(stru=
ct clk_hw *hw,
>   	unsigned int div, val;
>
>   	val =3D clk_readl(divider->reg) >> divider->shift;
> -	val &=3D div_mask(divider);
> +	val &=3D divider->mask;
>
>   	div =3D _get_div(divider, val);
>   	if (!div) {
> @@ -266,7 +264,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw,=
 unsigned long rate,
>   	/* if read only, just return current value */
>   	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
>   		bestdiv =3D readl(divider->reg) >> divider->shift;
> -		bestdiv &=3D div_mask(divider);
> +		bestdiv &=3D divider->mask;
>   		bestdiv =3D _get_div(divider, bestdiv);
>   		return bestdiv;
>   	}
> @@ -341,17 +339,17 @@ static int clk_divider_set_rate(struct clk_hw *=
hw, unsigned long rate,
>
>   	value =3D _get_val(divider, div);
>
> -	if (value > div_mask(divider))
> -		value =3D div_mask(divider);
> +	if (value > divider->mask)
> +		value =3D divider->mask;
>
>   	if (divider->lock)
>   		spin_lock_irqsave(divider->lock, flags);
>
>   	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
> -		val =3D div_mask(divider) << (divider->shift + 16);
> +		val =3D divider->mask << (divider->shift + 16);
>   	} else {
>   		val =3D clk_readl(divider->reg);
> -		val &=3D ~(div_mask(divider) << divider->shift);
> +		val &=3D ~(divider->mask << divider->shift);
>   	}
>   	val |=3D value << divider->shift;
>   	clk_writel(val, divider->reg);
> @@ -371,7 +369,7 @@ EXPORT_SYMBOL_GPL(clk_divider_ops);
>
>   static struct clk *_register_divider(struct device *dev, const char=
 *name,
>   		const char *parent_name, unsigned long flags,
> -		void __iomem *reg, u8 shift, u8 width,
> +		void __iomem *reg, u8 shift, u32 mask,
>   		u8 clk_divider_flags, const struct clk_div_table *table,
>   		spinlock_t *lock)
>   {
> @@ -380,8 +378,9 @@ static struct clk *_register_divider(struct devic=
e *dev, const char *name,
>   	struct clk_init_data init;
>
>   	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
> -		if (width + shift > 16) {
> -			pr_warn("divider value exceeds LOWORD field\n");
> +		if ((mask << shift) & 0xffff0000) {
> +			pr_warn("%s: divider value exceeds LOWORD field\n",
> +					__func__);
>   			return ERR_PTR(-EINVAL);
>   		}
>   	}
> @@ -402,7 +401,7 @@ static struct clk *_register_divider(struct devic=
e *dev, const char *name,
>   	/* struct clk_divider assignments */
>   	div->reg =3D reg;
>   	div->shift =3D shift;
> -	div->width =3D width;
> +	div->mask =3D mask;
>   	div->flags =3D clk_divider_flags;
>   	div->lock =3D lock;
>   	div->hw.init =3D &init;
> @@ -435,7 +434,7 @@ struct clk *clk_register_divider(struct device *d=
ev, const char *name,
>   		u8 clk_divider_flags, spinlock_t *lock)
>   {
>   	return _register_divider(dev, name, parent_name, flags, reg, shift=
,
> -			width, clk_divider_flags, NULL, lock);
> +			((1 << width) - 1), clk_divider_flags, NULL, lock);
>   }
>   EXPORT_SYMBOL_GPL(clk_register_divider);
>
> @@ -460,6 +459,6 @@ struct clk *clk_register_divider_table(struct dev=
ice *dev, const char *name,
>   		spinlock_t *lock)
>   {
>   	return _register_divider(dev, name, parent_name, flags, reg, shift=
,
> -			width, clk_divider_flags, table, lock);
> +			((1 << width) - 1), clk_divider_flags, table, lock);
>   }
>   EXPORT_SYMBOL_GPL(clk_register_divider_table);
> diff --git a/drivers/clk/mxs/clk-div.c b/drivers/clk/mxs/clk-div.c
> index 90e1da9..af2428e 100644
> --- a/drivers/clk/mxs/clk-div.c
> +++ b/drivers/clk/mxs/clk-div.c
> @@ -96,7 +96,7 @@ struct clk *mxs_clk_div(const char *name, const cha=
r *parent_name,
>
>   	div->divider.reg =3D reg;
>   	div->divider.shift =3D shift;
> -	div->divider.width =3D width;
> +	div->divider.mask =3D BIT(width) - 1;
>   	div->divider.flags =3D CLK_DIVIDER_ONE_BASED;
>   	div->divider.lock =3D &mxs_lock;
>   	div->divider.hw.init =3D &init;
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 880a266..9024a0e 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -87,7 +87,7 @@ static struct clk *rockchip_clk_register_branch(con=
st char *name,
>   		div->flags =3D div_flags;
>   		div->reg =3D base + muxdiv_offset;
>   		div->shift =3D div_shift;
> -		div->width =3D div_width;
> +		div->mask =3D BIT(div_width) - 1;
>   		div->lock =3D lock;
>   		div->table =3D div_table;
>   		div_ops =3D &clk_divider_ops;
> diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexge=
n.c
> index 2282cef..603d5d6 100644
> --- a/drivers/clk/st/clk-flexgen.c
> +++ b/drivers/clk/st/clk-flexgen.c
> @@ -203,7 +203,7 @@ struct clk *clk_register_flexgen(const char *name=
,
>   	/* Pre-divider config */
>   	fgxbar->pdiv.lock =3D lock;
>   	fgxbar->pdiv.reg =3D reg + 0x58 + idx * 4;
> -	fgxbar->pdiv.width =3D 10;
> +	fgxbar->pdiv.mask =3D BIT(10) - 1;
>
>   	/* Final divider's gate config */
>   	fgxbar->fgate.lock =3D lock;
> @@ -213,7 +213,7 @@ struct clk *clk_register_flexgen(const char *name=
,
>   	/* Final divider config */
>   	fgxbar->fdiv.lock =3D lock;
>   	fgxbar->fdiv.reg =3D fdiv_reg;
> -	fgxbar->fdiv.width =3D 6;
> +	fgxbar->fdiv.mask =3D BIT(6) - 1;
>
>   	fgxbar->hw.init =3D &init;
>
> diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.=
c
> index 79dc40b..85a1165 100644
> --- a/drivers/clk/st/clkgen-mux.c
> +++ b/drivers/clk/st/clkgen-mux.c
> @@ -260,7 +260,7 @@ struct clk *clk_register_genamux(const char *name=
,
>   		 * Divider config for each input
>   		 */
>   		void __iomem *divbase =3D reg + muxdata->div_offsets[i];
> -		genamux->div[i].width =3D divider_width;
> +		genamux->div[i].mask =3D BIT(divider_width) - 1;
>   		genamux->div[i].reg =3D divbase + (idx * sizeof(u32));
>
>   		/*
> @@ -773,7 +773,7 @@ void __init st_of_clkgen_vcc_setup(struct device_=
node *np)
>
>   		div->reg =3D reg + VCC_DIV_OFFSET;
>   		div->shift =3D 2 * i;
> -		div->width =3D 2;
> +		div->mask =3D BIT(2) - 1;
>   		div->flags =3D CLK_DIVIDER_POWER_OF_TWO |
>   			CLK_DIVIDER_ROUND_CLOSEST;
>
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.=
c
> index 29769d7..0d76278 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -575,7 +575,7 @@ static struct clk * __init clkgen_odf_register(co=
nst char *parent_name,
>   	div->flags =3D CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
>   	div->reg =3D reg + pll_data->odf[odf].offset;
>   	div->shift =3D pll_data->odf[odf].shift;
> -	div->width =3D fls(pll_data->odf[odf].mask);
> +	div->mask =3D pll_data->odf[odf].mask;
>   	div->lock =3D odf_lock;
>
>   	clk =3D clk_register_composite(NULL, odf_name, &parent_name, 1,
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-su=
nxi.c
> index d5dc951..a23d393 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1015,7 +1015,7 @@ static void __init sunxi_divs_clk_setup(struct =
device_node *node,
>
>   			divider->reg =3D reg;
>   			divider->shift =3D data->div[i].shift;
> -			divider->width =3D SUNXI_DIVISOR_WIDTH;
> +			divider->mask =3D BIT(SUNXI_DIVISOR_WIDTH) - 1;
>   			divider->flags =3D flags;
>   			divider->lock =3D &clk_lock;
>   			divider->table =3D data->div[i].table;
> diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
> index bff2b5b..c27e01e 100644
> --- a/drivers/clk/ti/divider.c
> +++ b/drivers/clk/ti/divider.c
> @@ -285,7 +285,7 @@ static struct clk *_register_divider(struct devic=
e *dev, const char *name,
>   	/* struct clk_divider assignments */
>   	div->reg =3D reg;
>   	div->shift =3D shift;
> -	div->width =3D width;
> +	div->mask =3D BIT(width) - 1;
>   	div->flags =3D clk_divider_flags;
>   	div->lock =3D lock;
>   	div->hw.init =3D &init;
> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.=
h
> index 0ca5f60..40bc1b2 100644
> --- a/include/linux/clk-private.h
> +++ b/include/linux/clk-private.h
> @@ -130,7 +130,7 @@ struct clk {
>   		},						\
>   		.reg =3D _reg,					\
>   		.shift =3D _shift,				\
> -		.width =3D _width,				\
> +		.mask =3D ((1 << _width) - 1),			\
>   		.flags =3D _divider_flags,			\
>   		.table =3D _table,				\
>   		.lock =3D _lock,					\
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provide=
r.h
> index 2839c63..2c00215 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -338,7 +338,7 @@ struct clk_divider {
>   	struct clk_hw	hw;
>   	void __iomem	*reg;
>   	u8		shift;
> -	u8		width;
> +	u32		mask;
>   	u8		flags;
>   	const struct clk_div_table	*table;
>   	spinlock_t	*lock;
>

--
To unsubscribe from this list: send the line "unsubscribe linux-metag" =
in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
