From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 14/14] mfd: twl6040: Constify struct regmap_config and
 reg_default array
Date: Tue, 20 Jan 2015 12:00:20 +0000
Message-ID: <20150120120020.GZ13701@x1>
References: <1420448493-9355-1-git-send-email-k.kozlowski@samsung.com>
 <1420448493-9355-14-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420448493-9355-14-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> The regmap_config struct may be const because it is not modified by t=
he
> driver and regmap_init() accepts pointer to const. Make array of
> struct reg_default const as well.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/mfd/twl6040.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied with Tony's Ack, thanks.

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index 9687645162ae..f71ee3dbc2a2 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -44,7 +44,7 @@
>  #define VIBRACTRL_MEMBER(reg) ((reg =3D=3D TWL6040_REG_VIBCTLL) ? 0 =
: 1)
>  #define TWL6040_NUM_SUPPLIES	(2)
> =20
> -static struct reg_default twl6040_defaults[] =3D {
> +static const struct reg_default twl6040_defaults[] =3D {
>  	{ 0x01, 0x4B }, /* REG_ASICID	(ro) */
>  	{ 0x02, 0x00 }, /* REG_ASICREV	(ro) */
>  	{ 0x03, 0x00 }, /* REG_INTID	*/
> @@ -580,7 +580,7 @@ static bool twl6040_writeable_reg(struct device *=
dev, unsigned int reg)
>  	}
>  }
> =20
> -static struct regmap_config twl6040_regmap_config =3D {
> +static const struct regmap_config twl6040_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
