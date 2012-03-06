From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] arm: more fallout from i2c conversions in board-omap4panda.c
Date: Tue, 06 Mar 2012 14:27:24 +0200
Message-ID: <4F5602AC.3060107@ti.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com> <1330987310-8108-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1330987310-8108-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonicro.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 03/06/2012 12:41 AM, Paul Gortmaker wrote:
> Commit ded0df8510778a03a2f182a0cbfe3c25788e8852 (linux-next)
>=20
>    "mfd: Convert twl6040 to an i2c driver, and separate it from twl c=
ore"
>=20
> appears to have done an incomplete conversion on the board-omap4panda=
=2Ec
> file, leaving it with more build failures.  Comparing the changes tha=
t
> were done for board-4430sdp.c it is possible for me to whack it with =
a
> stick until it stops twitching, but someone who really understands th=
is
> code needs to take a look at the conversion, and check it is done
> completely and in a way that will actually work on hardware.

This is true.
I'm sending a revert series for the twl6040 patches causing this
breakage for Samuel.
The same feature will go via audio tree because the dependencies are
queued in that feature tree.

--=20
P=E9ter

PS: this might fix the compile breakage with omap2_defconfig, but the
audio will not work if you enable the support for it on OMAP4.

>=20
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Mark Brown <broonie@opensource.wolfsonicro.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-o=
map2/board-omap4panda.c
> index e919153..16a1814 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -287,16 +287,15 @@ static struct twl6040_codec_data twl6040_codec =
=3D {
>  	.hf_right_step	=3D 0x1d,
>  };
> =20
> -static struct twl4030_audio_data twl6040_audio =3D {
> +static struct twl6040_platform_data twl6040_data =3D {
>  	.codec		=3D &twl6040_codec,
>  	.audpwron_gpio	=3D 127,
> -	.naudint_irq	=3D OMAP44XX_IRQ_SYS_2N,
>  	.irq_base	=3D TWL6040_CODEC_IRQ_BASE,
>  };
> =20
>  /* Panda board uses the common PMIC configuration */
>  static struct twl4030_platform_data omap4_panda_twldata =3D {
> -	.audio		=3D &twl6040_audio,
> +   /*	.audio		=3D &twl6040_audio,	*/
>  };
> =20
>  /*
