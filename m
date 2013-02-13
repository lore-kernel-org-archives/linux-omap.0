From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-dmic: Clean up with devm_request_and_ioremap
Date: Wed, 13 Feb 2013 14:15:35 +0100
Message-ID: <511B91F7.6020305@ti.com>
References: <1360740127-4154-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37152 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab3BMNPw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 08:15:52 -0500
In-Reply-To: <1360740127-4154-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 02/13/2013 08:22 AM, Sebastien Guiriec wrote:
> Clean up dmic code with devm_request_and_ioremap function.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> ---
>  sound/soc/omap/omap-dmic.c |   11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index ba49ccd..77e9e7e 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -493,16 +493,9 @@ static int asoc_dmic_probe(struct platform_devic=
e *pdev)
>  		goto err_put_clk;
>  	}
> =20
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), pdev->name)) {
> -		dev_err(dmic->dev, "memory region already claimed\n");
> -		ret =3D -ENODEV;
> -		goto err_put_clk;
> -	}
> -
> -	dmic->io_base =3D devm_ioremap(&pdev->dev, res->start,
> -				     resource_size(res));
> +	dmic->io_base =3D devm_request_and_ioremap(&pdev->dev, res);
>  	if (!dmic->io_base) {
> +		dev_err(&pdev->dev, "cannot remap\n");
>  		ret =3D -ENOMEM;
>  		goto err_put_clk;
>  	}
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
