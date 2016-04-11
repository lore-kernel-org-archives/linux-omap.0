From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 16/20] mfd: stw481x: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:32:05 +0100
Message-ID: <20160411093205.GG7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-17-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-17-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
> - Collected acks.
>=20
>  drivers/mfd/stw481x.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
> index ca613df..ab949ea 100644
> --- a/drivers/mfd/stw481x.c
> +++ b/drivers/mfd/stw481x.c
> @@ -206,8 +206,8 @@ static int stw481x_probe(struct i2c_client *clien=
t,
>  		stw481x_cells[i].pdata_size =3D sizeof(*stw481x);
>  	}
> =20
> -	ret =3D mfd_add_devices(&client->dev, 0, stw481x_cells,
> -			ARRAY_SIZE(stw481x_cells), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(&client->dev, 0, stw481x_cells,
> +				   ARRAY_SIZE(stw481x_cells), NULL, 0, NULL);
>  	if (ret)
>  		return ret;
> =20
> @@ -216,12 +216,6 @@ static int stw481x_probe(struct i2c_client *clie=
nt,
>  	return ret;
>  }
> =20
> -static int stw481x_remove(struct i2c_client *client)
> -{
> -	mfd_remove_devices(&client->dev);
> -	return 0;
> -}
> -
>  /*
>   * This ID table is completely unused, as this is a pure
>   * device-tree probed driver, but it has to be here due to
> @@ -246,7 +240,6 @@ static struct i2c_driver stw481x_driver =3D {
>  		.of_match_table =3D stw481x_match,
>  	},
>  	.probe		=3D stw481x_probe,
> -	.remove		=3D stw481x_remove,
>  	.id_table	=3D stw481x_id,
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
