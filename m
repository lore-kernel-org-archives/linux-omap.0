From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: twl6040: Disable and unprepare clk32k in
 twl6040_power() error path
Date: Mon, 25 Apr 2016 17:18:29 +0100
Message-ID: <20160425161829.GK2713@dell>
References: <1461165398-12289-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461165398-12289-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 20 Apr 2016, Javier Martinez Canillas wrote:

> The clk32k clock is prepared and enabled in twl6040_power() but the c=
lock
> is left enabled in case of an error while it should be disable/unprep=
ared.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>=20
>  drivers/mfd/twl6040.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index 08a693cd38cc..4de92c16dfb8 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -300,6 +300,7 @@ int twl6040_power(struct twl6040 *twl6040, int on=
)
>  			/* use automatic power-up sequence */
>  			ret =3D twl6040_power_up_automatic(twl6040);
>  			if (ret) {
> +				clk_disable_unprepare(twl6040->clk32k);
>  				twl6040->power_count =3D 0;
>  				goto out;
>  			}
> @@ -307,6 +308,7 @@ int twl6040_power(struct twl6040 *twl6040, int on=
)
>  			/* use manual power-up sequence */
>  			ret =3D twl6040_power_up_manual(twl6040);
>  			if (ret) {
> +				clk_disable_unprepare(twl6040->clk32k);
>  				twl6040->power_count =3D 0;
>  				goto out;
>  			}

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
