From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 07/28] omap2 clock: init clksel clock parents to
	hardwarereality at clock init
Date: Mon, 20 Aug 2007 07:27:03 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901AD7C3F@dlee13.ent.ti.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095530.656090063@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070820095530.656090063@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Paul,

This will be a nice addition and was hole. Thanks.

Karthik added this type function for OMAP3 on its first go around.
Might be worth looking at that also. I don't think he did it via the
.init function.

BTW: Do you know if OMAP1 has this function, I don't think it used to.

In OMAP3 right now there has been a strong push to pull out much of the
register accesses into a lower layer.  This sets up for higher
compatibility in the face of multiple changes which may come in some
OMAP3 variants and OMAP4.  Trying to extend the access macros to account
for widely changing implementations but with similar concepts does not
provide enough flexibility.

Regards,
Richard W.

> Source-selectable clksel clocks have a 'default parent' assigned to
them
> at compile-time.  This default parent may or may not match the reality
> that is configured in the hardware registers by the bootloader.  Clock
> tree
> recalculations could be erratic if the struct clk parent field
contents
> don't match the hardware registers.
>=20
> Resolve this by creating omap2_init_clksel_parent() to read the
hardware
> registers and update the struct clk parent field as appropriate for
clksel
> clocks.  Add an '.init' field to each source-selectable clk structure
so
> that the parent is fixed up when the clock is initially registered.
(We
> don't do this for clksel clocks that are only rate-selectable, since
they
> only have one possible parent clock.)
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>=20
> ---
>  arch/arm/mach-omap2/clock.c |   58
> ++++++++++++++++++++++++++++++++++++++++----
>  arch/arm/mach-omap2/clock.h |   22 ++++++++++++++++
>  2 files changed, 75 insertions(+), 5 deletions(-)
>=20
> Index: linux-omap/arch/arm/mach-omap2/clock.c
> Index: linux-omap/arch/arm/mach-omap2/clock.c
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/clock.c
> +++ linux-omap/arch/arm/mach-omap2/clock.c
> @@ -93,6 +93,54 @@ static u32 sysclkout_div[] =3D {1, 2, 4, 8
>   * Omap2 specific clock functions
>
*-----------------------------------------------------------------------
> --*/
>=20
> +static inline u8 convert_mask_to_shift(u32 mask) {
> +	return ffs(mask) - 1;
> +}
> +
> +/**
> + * omap2_init_clksel_parent - set a clksel clk's parent field from
the
> hardware
> + * @clk: OMAP clock struct ptr to use
> + *
> + * Given a pointer to a source-selectable struct clk, read the
hardware
> + * register and determine what its parent is currently set to.
Update
> the
> + * clk->parent field with the appropriate clk ptr.
> + */
> +static void omap2_init_clksel_parent(struct clk *clk)
> +{
> +	const struct clksel *clks;
> +	const struct clksel_rate *clkr;
> +	u32 r, found =3D 0;
> +
> +	if (!clk->clksel)
> +		return;
> +
> +	/* XXX Should be __raw_readl for non-CM 3430 clocks ? */
> +	r =3D cm_read_reg(clk->clksel_reg) & clk->clksel_mask;
> +	r >>=3D convert_mask_to_shift(clk->clksel_mask);
> +
> +	for (clks =3D clk->clksel; clks->parent && !found; clks++) {
> +		for (clkr =3D clks->rates; clkr->div && !found; clkr++) {
> +			if ((clkr->flags & cpu_mask) && (clkr->val =3D=3D
r)) {
> +				if (clk->parent !=3D clks->parent) {
> +					pr_debug("clock: inited %s
parent "
> +						 "to %s (was %s)\n",
> +						 clk->name,
clks->parent->name,
> +						 ((clk->parent->name) ?
> +						  clk->parent->name :
"NULL"));
> +					clk->parent =3D clks->parent;
> +				};
> +				found =3D 1;
> +			}
> +		}
> +	}
> +
> +	if (!found)
> +		printk(KERN_ERR "clock: init parent: could not find "
> +		       "regval %0x for clock %s\n", r,  clk->name);
> +
> +	return;
> +}
> +
>  /* Recalculate SYST_CLK */
>  static void omap2_sys_clk_recalc(struct clk * clk)
>  {
> @@ -1193,6 +1241,11 @@ int __init omap2_clk_init(void)
>  	struct clk ** clkp;
>  	u32 clkrate;
>=20
> +	if (cpu_is_omap242x())
> +		cpu_mask =3D RATE_IN_242X;
> +	else if (cpu_is_omap2430())
> +		cpu_mask =3D RATE_IN_243X;
> +
>  	clk_init(&omap2_clk_functions);
>  	omap2_get_crystal_rate(&osc_ck, &sys_ck);
>=20
> @@ -1210,11 +1263,6 @@ int __init omap2_clk_init(void)
>  		}
>  	}
>=20
> -	if (cpu_is_omap242x())
> -		cpu_mask =3D RATE_IN_242X;
> -	else if (cpu_is_omap2430())
> -		cpu_mask =3D RATE_IN_243X;
> -
>  	/* Check the MPU rate set by bootloader */
>  	clkrate =3D omap2_get_dpll_rate(&dpll_ck);
>  	for (prcm =3D rate_table; prcm->mpu_speed; prcm++) {
> Index: linux-omap/arch/arm/mach-omap2/clock.h
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/clock.h
> +++ linux-omap/arch/arm/mach-omap2/clock.h
> @@ -29,6 +29,7 @@ static int omap2_select_table_rate(struc
>  static long omap2_round_to_table_rate(struct clk * clk, unsigned long
> rate);
>  static void omap2_clk_disable(struct clk *clk);
>  static void omap2_sys_clk_recalc(struct clk * clk);
> +static void omap2_init_clksel_parent(struct clk *clk);
>  static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
>  static u32 omap2_clksel_get_divisor(struct clk *clk);
>  static void omap2_dpll_recalc(struct clk *clk);
> @@ -690,6 +691,7 @@ static struct clk func_54m_ck =3D {
>  				RATE_FIXED | CM_PLL_SEL1 |
RATE_PROPAGATES |
>  				PARENT_CONTROLS_CLOCK,
>  	.src_offset	=3D OMAP24XX_54M_SOURCE_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
>  	.clksel_mask	=3D OMAP24XX_54M_SOURCE,
>  	.clksel		=3D func_54m_clksel,
> @@ -729,6 +731,7 @@ static struct clk func_96m_ck =3D {
>  	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
>  				RATE_FIXED | RATE_PROPAGATES |
>  				PARENT_CONTROLS_CLOCK,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
>  	.clksel_mask	=3D OMAP2430_96M_SOURCE,
>  	.clksel		=3D func_96m_clksel,
> @@ -761,6 +764,7 @@ static struct clk func_48m_ck =3D {
>  				RATE_FIXED | CM_PLL_SEL1 |
RATE_PROPAGATES |
>  				PARENT_CONTROLS_CLOCK,
>  	.src_offset	=3D OMAP24XX_48M_SOURCE_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
>  	.clksel_mask	=3D OMAP24XX_48M_SOURCE,
>  	.clksel		=3D func_48m_clksel,
> @@ -830,6 +834,7 @@ static struct clk sys_clkout_src =3D {
>  	.src_offset	=3D OMAP24XX_CLKOUT_SOURCE_SHIFT,
>  	.enable_reg	=3D OMAP24XX_PRCM_CLKOUT_CTRL,
>  	.enable_bit	=3D OMAP24XX_CLKOUT_EN_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP24XX_PRCM_CLKOUT_CTRL,
>  	.clksel_mask	=3D OMAP24XX_CLKOUT_SOURCE_MASK,
>  	.clksel		=3D common_clkout_src_clksel,
> @@ -872,6 +877,7 @@ static struct clk sys_clkout2_src =3D {
>  				RATE_PROPAGATES,
>  	.enable_reg	=3D OMAP24XX_PRCM_CLKOUT_CTRL,
>  	.enable_bit	=3D OMAP2420_CLKOUT2_EN_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP24XX_PRCM_CLKOUT_CTRL,
>  	.clksel_mask	=3D OMAP2420_CLKOUT2_SOURCE_MASK,
>  	.clksel		=3D common_clkout_src_clksel,
> @@ -937,6 +943,7 @@ static struct clk mpu_ck =3D {	/* Control
>  				ALWAYS_ENABLED | CM_MPU_SEL1 |
DELAYED_APP |
>  				CONFIG_PARTICIPANT | RATE_PROPAGATES,
>  	.rate_offset	=3D OMAP24XX_CLKSEL_MPU_SHIFT,	/* bits 0-4 */
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_MPU_MASK,
>  	.clksel		=3D mpu_clksel,
> @@ -1431,6 +1438,7 @@ static struct clk dss1_fck =3D {
>  	.enable_bit	=3D OMAP24XX_EN_DSS1_SHIFT,
>  	.rate_offset	=3D OMAP24XX_CLKSEL_DSS1_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_DSS1_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_DSS1_MASK,
>  	.clksel		=3D dss1_fck_clksel,
> @@ -1462,6 +1470,7 @@ static struct clk dss2_fck =3D {		/* Alt c
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_DSS2_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_DSS2_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_DSS2_MASK,
>  	.clksel		=3D dss2_fck_clksel,
> @@ -1522,6 +1531,7 @@ static struct clk gpt1_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
/*
> Bit0 */
>  	.enable_bit	=3D OMAP24XX_EN_GPT1_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT1_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT1_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1545,6 +1555,7 @@ static struct clk gpt2_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT2_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT2_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT2_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1568,6 +1579,7 @@ static struct clk gpt3_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT3_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT3_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT3_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1591,6 +1603,7 @@ static struct clk gpt4_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT4_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT4_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT4_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1614,6 +1627,7 @@ static struct clk gpt5_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT5_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT5_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT5_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1637,6 +1651,7 @@ static struct clk gpt6_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT6_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT6_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT6_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1660,6 +1675,7 @@ static struct clk gpt7_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT7_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT7_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT7_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1683,6 +1699,7 @@ static struct clk gpt8_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT8_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT8_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT8_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1706,6 +1723,7 @@ static struct clk gpt9_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT9_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT9_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT9_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1729,6 +1747,7 @@ static struct clk gpt10_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT10_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT10_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT10_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1752,6 +1771,7 @@ static struct clk gpt11_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT11_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT11_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT11_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -1775,6 +1795,7 @@ static struct clk gpt12_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP24XX_EN_GPT12_SHIFT,
>  	.src_offset	=3D OMAP24XX_CLKSEL_GPT12_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
>  	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT12_MASK,
>  	.clksel		=3D gpt_clksel,
> @@ -2308,6 +2329,7 @@ static struct clk vlynq_fck =3D {
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP2420_EN_VLYNQ_SHIFT,
>  	.src_offset	=3D OMAP2420_CLKSEL_VLYNQ_SHIFT,
> +	.init		=3D &omap2_init_clksel_parent,
>  	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
>  	.clksel_mask	=3D OMAP2420_CLKSEL_VLYNQ_MASK,
>  	.clksel		=3D vlynq_fck_clksel,
>=20
> --
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
