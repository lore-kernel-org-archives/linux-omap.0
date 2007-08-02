From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked
	aspresent on OMAP2430
Date: Thu, 2 Aug 2007 14:05:19 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181142.567475486@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070802181142.567475486@pwsan.com>
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

Hi Paul,

CLOCKOUT2 is in the latest functional spec.  This might be a TRM error =
or the removed the ball for later ES versions.

In 2420ES1 there was no clockout2 it was added for ES2 and beyond.

Need to see if it can be mux'ed to a ball.

Regards,
Richard W.

> Several clocks are marked as present on OMAP2430, even though they are
> 2420-only.  Drop CLOCK_IN_OMAP243X from those clocks' flags.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>=20
> ---
>  arch/arm/mach-omap2/clock.h |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> Index: linux-omap/arch/arm/mach-omap2/clock.h
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-omap.orig/arch/arm/mach-omap2/clock.h
> +++ linux-omap/arch/arm/mach-omap2/clock.h
> @@ -742,8 +742,7 @@ static struct clk sys_clkout2 =3D {
>  	.name		=3D "sys_clkout2",
>  	.parent		=3D &func_54m_ck,
>  	.rate		=3D 54000000,
> -	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
> -				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
> +	.flags		=3D CLOCK_IN_OMAP242X | CM_SYSCLKOUT_SEL1 |
> RATE_CKCTL,
>  	.src_offset	=3D OMAP2420_CLKOUT2_SOURCE_SHIFT,
>  	.enable_reg	=3D OMAP24XX_PRCM_CLKOUT_CTRL,
>  	.enable_bit	=3D OMAP2420_CLKOUT2_EN_SHIFT,
> @@ -1740,7 +1739,7 @@ static struct clk i2c2_ick =3D {
>  	.name		=3D "i2c_ick",
>  	.id		=3D 2,
>  	.parent		=3D &l4_ck,
> -	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
> +	.flags		=3D CLOCK_IN_OMAP242X,
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
>  	.enable_bit	=3D OMAP2420_EN_I2C2_SHIFT,
>  	.recalc		=3D &omap2_followparent_recalc,
> @@ -1750,7 +1749,7 @@ static struct clk i2c2_fck =3D {
>  	.name		=3D "i2c_fck",
>  	.id		=3D 2,
>  	.parent		=3D &func_12m_ck,
> -	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
> +	.flags		=3D CLOCK_IN_OMAP242X,
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP2420_EN_I2C2_SHIFT,
>  	.recalc		=3D &omap2_followparent_recalc,
> @@ -1770,7 +1769,7 @@ static struct clk i2c1_ick =3D {
>  	.name		=3D "i2c_ick",
>  	.id		=3D 1,
>  	.parent		=3D &l4_ck,
> -	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
> +	.flags		=3D CLOCK_IN_OMAP242X,
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
>  	.enable_bit	=3D OMAP2420_EN_I2C1_SHIFT,
>  	.recalc		=3D &omap2_followparent_recalc,
> @@ -1780,7 +1779,7 @@ static struct clk i2c1_fck =3D {
>  	.name		=3D "i2c_fck",
>  	.id		=3D 1,
>  	.parent		=3D &func_12m_ck,
> -	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
> +	.flags		=3D CLOCK_IN_OMAP242X,
>  	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>  	.enable_bit	=3D OMAP2420_EN_I2C1_SHIFT,
>  	.recalc		=3D &omap2_followparent_recalc,
>=20
> --
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
