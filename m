From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] omap2: Change clk dev id for rng to
 omap3-rom-rng
Date: Fri, 20 Sep 2013 11:31:44 -0700
Message-ID: <20130920183144.GB2684@atomide.com>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <201309201841.16197@pali>
 <20130920174640.GA2684@atomide.com>
 <201309202024.50755@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309202024.50755@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130920 11:32]:
> On Friday 20 September 2013 19:46:41 Tony Lindgren wrote:
>=20
> Ok, then there is new patch which only adding omap3-rom-rng and not r=
emoving omap_rng.
> It is OK to have same CLK data but with different names?

Yes in this case it's always either omap_rng or omap3-rom-rng
so the patch below looks OK to me.

Regards,

Tony
=20
> diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-om=
ap2/cclock3xxx_data.c
> index 334b767..03a2829 100644
> --- a/arch/arm/mach-omap2/cclock3xxx_data.c
> +++ b/arch/arm/mach-omap2/cclock3xxx_data.c
> @@ -3275,6 +3275,7 @@ static struct omap_clk omap36xx_clks[] =3D {
>  static struct omap_clk omap34xx_omap36xx_clks[] =3D {
>  	CLK(NULL,	"aes1_ick",	&aes1_ick),
>  	CLK("omap_rng",	"ick",		&rng_ick),
> +	CLK("omap3-rom-rng",	"ick",	&rng_ick),
>  	CLK(NULL,	"sha11_ick",	&sha11_ick),
>  	CLK(NULL,	"des1_ick",	&des1_ick),
>  	CLK(NULL,	"cam_mclk",	&cam_mclk),
>=20
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
