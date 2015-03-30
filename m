From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] mfd: menelaus: use macro for magic number
Date: Mon, 30 Mar 2015 08:15:41 +0100
Message-ID: <20150330071541.GJ457@x1>
References: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
 <1427575537-28508-4-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427575537-28508-4-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 28 Mar 2015, Aaro Koskinen wrote:

> Use macro to check a register bit.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/mfd/menelaus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 917fa86..c2ca665 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1216,7 +1216,7 @@ static int menelaus_probe(struct i2c_client *cl=
ient,
>  	err =3D menelaus_read_reg(MENELAUS_VCORE_CTRL1);
>  	if (err < 0)
>  		goto fail;
> -	if (err & BIT(7))
> +	if (err & VCORE_CTRL1_HW_NSW)
>  		menelaus->vcore_hw_mode =3D 1;
>  	else
>  		menelaus->vcore_hw_mode =3D 0;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
