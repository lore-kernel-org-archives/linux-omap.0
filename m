From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] omap2: Change clk dev id for rng to
 omap3-rom-rng
Date: Fri, 20 Sep 2013 09:23:43 -0700
Message-ID: <20130920162342.GS9994@atomide.com>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379683507-30793-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 06:33]:
> Name omap_rng is already used by omap_rng driver which is for omap2 a=
nd omap4.
> For omap3 HS devices there is new driver omap3-rom-rng which needs th=
at clk.
> And because there cannot be two drivers with same name, rename omap3 =
clk dev id.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-om=
ap2/cclock3xxx_data.c
> index 334b767..5059338 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -3274,7 +3274,7 @@ static struct omap_clk omap36xx_clks[] =3D {
>   */
>  static struct omap_clk omap34xx_omap36xx_clks[] =3D {
>  	CLK(NULL,	"aes1_ick",	&aes1_ick),
> -	CLK("omap_rng",	"ick",		&rng_ick),
> +	CLK("omap3-rom-rng",	"ick",		&rng_ick),
>  	CLK(NULL,	"sha11_ick",	&sha11_ick),
>  	CLK(NULL,	"des1_ick",	&des1_ick),
>  	CLK(NULL,	"cam_mclk",	&cam_mclk),

Hmm are you sure the omap_rng is not available on
any of the omap3 GP versions? If so, the omap_rng
alias should be kept as well.

Regards,

Tony
