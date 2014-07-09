From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V2] ASoC: omap-dmic: Use devm_snd_soc_register_component
Date: Wed, 9 Jul 2014 08:46:13 +0300
Message-ID: <53BCD725.8080300@ti.com>
References: <1404838397-5309-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaGIFqT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2014 01:46:19 -0400
In-Reply-To: <1404838397-5309-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org

On 07/08/2014 07:53 PM, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.
>=20
> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> Changes since V1:
>         Aligned function parameter properly.
>=20
> :100644 100644 6925d71... f125eb9... M	sound/soc/omap/omap-dmic.c
>  sound/soc/omap/omap-dmic.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index 6925d71..f125eb9 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -490,8 +490,9 @@ static int asoc_dmic_probe(struct platform_device=
 *pdev)
>  	}
> =20
> =20
> -	ret =3D snd_soc_register_component(&pdev->dev, &omap_dmic_component=
,
> -					 &omap_dmic_dai, 1);
> +	ret =3D devm_snd_soc_register_component(&pdev->dev,
> +					      &omap_dmic_component,
> +					      &omap_dmic_dai, 1);
>  	if (ret)
>  		goto err_put_clk;
> =20
> @@ -510,7 +511,6 @@ static int asoc_dmic_remove(struct platform_devic=
e *pdev)
>  {
>  	struct omap_dmic *dmic =3D platform_get_drvdata(pdev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
>  	clk_put(dmic->fclk);
> =20
>  	return 0;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
