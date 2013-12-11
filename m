From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
Date: Wed, 11 Dec 2013 10:44:40 +0100
Message-ID: <20131211094440.GG18888@pengutronix.de>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386042188-12246-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, sameo@linux.intel.com, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lee.jones@linaro.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 02, 2013 at 09:42:54PM -0600, Felipe Balbi wrote:
> we could build that as a driver.
What is "that". How can it not be a driver? Do you mean modular? In tha=
t
case there is no problem, the only thing that doesn't work is unloading
the module.

Best regards
Uwe
=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index ad25bfa..975ff9e 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1262,7 +1262,7 @@ fail:
>  	return err;
>  }
> =20
> -static int __exit menelaus_remove(struct i2c_client *client)
> +static int menelaus_remove(struct i2c_client *client)
>  {
>  	struct menelaus_chip	*menelaus =3D i2c_get_clientdata(client);
> =20
> @@ -1283,7 +1283,7 @@ static struct i2c_driver menelaus_i2c_driver =3D=
 {
>  		.name		=3D DRIVER_NAME,
>  	},
>  	.probe		=3D menelaus_probe,
> -	.remove		=3D __exit_p(menelaus_remove),
> +	.remove		=3D menelaus_remove,
>  	.id_table	=3D menelaus_id,
>  };
> =20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
