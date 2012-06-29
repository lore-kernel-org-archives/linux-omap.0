From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
Date: Fri, 29 Jun 2012 14:35:22 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2057762280-1341002122=:2338"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57390 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797Ab2F2UfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 16:35:23 -0400
In-Reply-To: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2057762280-1341002122=:2338
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

+ Beno=EEt who is the maintainer of this file

+ the linux-arm-kernel mailing list, which should be cc'ed on all OMAP=20
patches

On Fri, 29 Jun 2012, Ruslan Bilovol wrote:

> From: Wenbiao Wang <wwang@ti.com>
>=20
> OTG clock usb_otg_hs_ick used a incorrect parent l3_div_ck.
> Correct it to use the right colck otg_60m_gfclk as its
> parent.
>=20
> Signed-off-by: Wenbiao Wang <wwang@ti.com>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/c=
lock44xx_data.c
> index b825049..fd43214 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -199,12 +199,6 @@ static struct clk tie_low_clock_ck =3D {
>  =09.ops=09=09=3D &clkops_null,
>  };
> =20
> -static struct clk utmi_phy_clkout_ck =3D {
> -=09.name=09=09=3D "utmi_phy_clkout_ck",
> -=09.rate=09=09=3D 60000000,
> -=09.ops=09=09=3D &clkops_null,
> -};
> -
>  static struct clk xclk60mhsp1_ck =3D {
>  =09.name=09=09=3D "xclk60mhsp1_ck",
>  =09.rate=09=09=3D 60000000,
> @@ -992,6 +986,13 @@ static struct clk dpll_usb_clkdcoldo_ck =3D {
>  =09.recalc=09=09=3D &followparent_recalc,
>  };
> =20
> +static struct clk utmi_phy_clkout_ck =3D {
> +=09.name=09=09=3D "utmi_phy_clkout_ck",
> +=09.ops=09=09=3D &clkops_null,
> +=09.parent=09=09=3D &dpll_usb_clkdcoldo_ck,
> +=09.recalc=09=09=3D &followparent_recalc,
> +};
> +
>  static const struct clksel dpll_usb_m2_div[] =3D {
>  =09{ .parent =3D &dpll_usb_ck, .rates =3D div31_1to31_rates },
>  =09{ .parent =3D NULL },
> @@ -2685,7 +2686,7 @@ static struct clk usb_otg_hs_ick =3D {
>  =09.enable_reg=09=3D OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
>  =09.enable_bit=09=3D OMAP4430_MODULEMODE_HWCTRL,
>  =09.clkdm_name=09=3D "l3_init_clkdm",
> -=09.parent=09=09=3D &l3_div_ck,
> +=09.parent=09=09=3D &otg_60m_gfclk,
>  =09.recalc=09=09=3D &followparent_recalc,
>  };

Beno=EEt should have a look at this one, I think.


- Paul
--155748971-2057762280-1341002122=:2338--
