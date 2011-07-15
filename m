From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/6] OMAP4: Add missing clock divider for OCP_ABE_ICLK
Date: Fri, 15 Jul 2011 02:21:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107150216380.16606@utopia.booyaka.com>
References: <1310685865-3249-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1114097473-1310718095=:16606"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964935Ab1GOIVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 04:21:36 -0400
In-Reply-To: <1310685865-3249-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1114097473-1310718095=:16606
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

cc'ing Beno=EEt

Hi Jon

On Thu, 14 Jul 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
>=20
> The parent clock of the OCP_ABE_ICLK is the AESS_FCLK and the
> parent clock of the AESS_FCLK is the ABE_FCLK...
>=20
> ABE_FCLK --> AESS_FCLK --> OCP_ABE_ICLK
>=20
> The AESS_FCLK and OCP_ABE_ICLK clocks both have dividers which
> determine their operational frequency. However, the dividers for
> the AESS_FCLK and OCP_ABE_ICLK are controlled via a single bit,
> which is the CM1_ABE_AESS_CLKCTRL[24] bit.> When this bit is set to
> 0, the AESS_FCLK divider is 1 and the OCP_ABE_ICLK divider is 2.
> Similarly, when this bit is set to 1, the AESS_FCLK divider is 2
> and the OCP_ABE_ICLK is 1.

Sigh.  This type of hardware design makes software design difficult :-(

> The above relationship between the AESS_FCLK and OCP_ABE_ICLK
> dividers ensure that the OCP_ABE_ICLK clock is always half the
> frequency of the ABE_CLK...
>=20
> OCP_ABE_ICLK =3D ABE_FCLK/2
>=20
> The divider for the OCP_ABE_ICLK is currently missing so add a
> divider that will ensure the OCP_ABE_ICLK frequency is always half
> the ABE_FCLK frequency.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/c=
lock44xx_data.c
> index 8c96567..6e158ce 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -1301,11 +1301,25 @@ static struct clk mcasp3_fclk =3D {
>  =09.recalc=09=09=3D &followparent_recalc,
>  };
> =20
> +static const struct clksel_rate div2_2to1_rates[] =3D {
> +=09{ .div =3D 1, .val =3D 1, .flags =3D RATE_IN_4430 },
> +=09{ .div =3D 2, .val =3D 0, .flags =3D RATE_IN_4430 },
> +=09{ .div =3D 0 },
> +};
> +
> +static const struct clksel ocp_abe_iclk_div[] =3D {
> +=09{ .parent =3D &aess_fclk, .rates =3D div2_2to1_rates },
> +=09{ .parent =3D NULL },
> +};
> +
>  static struct clk ocp_abe_iclk =3D {
>  =09.name=09=09=3D "ocp_abe_iclk",
>  =09.parent=09=09=3D &aess_fclk,
> +=09.clksel=09=09=3D ocp_abe_iclk_div,
> +=09.clksel_reg=09=3D OMAP4430_CM1_ABE_AESS_CLKCTRL,
> +=09.clksel_mask=09=3D OMAP4430_CLKSEL_AESS_FCLK_MASK,
>  =09.ops=09=09=3D &clkops_null,
> -=09.recalc=09=09=3D &followparent_recalc,
> +=09.recalc=09=09=3D &omap2_clksel_recalc,
>  };
> =20
>  static struct clk per_abe_24m_fclk =3D {

I guess the reason that this patch can get away with this is because it=20
doesn't allow software to change the rate of ocp_abe_iclk, and the=20
ocp_abe_iclk is a child of aess_fclk, so when aess_fclk is changed, it=20
will recalc ocp_abe_iclk.

Beno=EEt, what do you think?  Is this a reasonable approach for the script?=
 =20
Or do we need to deal with some kind of 'linked clock' implementation...


- Paul
--155748971-1114097473-1310718095=:16606--
