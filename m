From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: [PATCH] ARM: OMAP3: allow setting cam_mclk rate
Date: Thu, 02 Jul 2009 10:44:28 +0300
Message-ID: <4A4C655C.90200@nokia.com>
References: <200907011427.29318.tuukka.o.toivonen@nokia.com>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31763 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZGBHoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 03:44:39 -0400
In-Reply-To: <200907011427.29318.tuukka.o.toivonen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?SMO2Z2FuZGVyIEpvdW5p?= <jouni.hogander@nokia.com>
Cc: "Toivonen Tuukka.O (Nokia-D/Oulu)" <tuukka.o.toivonen@nokia.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "core-review@ok.research.nokia.com" <core-review@ok.research.nokia.com>, "Hurskainen Mikko (Nokia-D/Helsinki)" <mikko.hurskainen@nokia.com>, "camera@ok.research.nokia.com" <camera@ok.research.nokia.com>

Hi Jouni,

could you please take a quick look at this patch? There is some
pressure to have this applied ASAP, but I'm afraid I do not have
enough competence in this area to review it. Could you take a
brief look and validate it?

Toivonen Tuukka.O (Nokia-D/Oulu) wrote:
> This patch allows drivers to modify cam_mclk rate which is
> used for generating external cam_xclka and cam_xclkb for cameras.
>=20
> Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |   18 ++++++++++++++++++
>  arch/arm/mach-omap2/clock34xx.h |    2 ++
>  2 files changed, 20 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cl=
ock34xx.c
> index 045da92..667a608 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -898,6 +898,24 @@ static unsigned long omap3_clkoutx2_recalc(struc=
t clk *clk)
>  	return rate;
>  }
> =20
> +/* Clock control for OMAP3 camera */
> +
> +static int omap3_cam_mclk_set_rate(struct clk *clk, unsigned long ra=
te)
> +{
> +	const unsigned int dpll4_rate =3D 864000000; /* Hz */
> +	int clksel;
> +
> +	if (rate <=3D 0)
> +		return -EINVAL;
> +
> +	clksel =3D (dpll4_rate + (rate>>1)) / rate;
> +	clksel =3D clamp(clksel, 1, 16);
> +	cm_write_mod_reg(clksel, OMAP3430_CAM_MOD, CM_CLKSEL);
> +	clk->rate =3D dpll4_rate / clksel;
> +
> +	return 0;
> +}
> +
>  /* Common clock code */
> =20
>  /*
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cl=
ock34xx.h
> index e433aec..bd09709 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -37,6 +37,7 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk=
);
>  static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned lon=
g rate);
>  static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)=
;
>  static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned lon=
g rate);
> +static int omap3_cam_mclk_set_rate(struct clk *clk, unsigned long ra=
te);
> =20
>  /* Maximum DPLL multiplier, divider values for OMAP3 */
>  #define OMAP3_MAX_DPLL_MULT		2048
> @@ -2342,6 +2343,7 @@ static struct clk uart3_fck =3D {
>  	.enable_bit	=3D OMAP3430_EN_UART3_SHIFT,
>  	.clkdm_name	=3D "per_clkdm",
>  	.recalc		=3D &followparent_recalc,
> +	.set_rate	=3D &omap3_cam_mclk_set_rate,
>  };
> =20
>  static struct clk gpt2_fck =3D {


--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
