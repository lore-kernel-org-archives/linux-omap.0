From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-dmic: Use devm_snd_soc_register_component
Date: Mon, 7 Jul 2014 12:30:25 +0300
Message-ID: <53BA68B1.5040309@ti.com>
References: <1404629414-3263-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47150 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbaGGJac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 05:30:32 -0400
In-Reply-To: <1404629414-3263-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org

On 07/06/2014 09:50 AM, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.
>=20
> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
> ---
> :100644 100644 6925d71... 011e30e... M	sound/soc/omap/omap-dmic.c
>  sound/soc/omap/omap-dmic.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
> index 6925d71..011e30e 100644
> --- a/sound/soc/omap/omap-dmic.c
> +++ b/sound/soc/omap/omap-dmic.c
> @@ -490,7 +490,7 @@ static int asoc_dmic_probe(struct platform_device=
 *pdev)
>  	}
> =20
> =20
> -	ret =3D snd_soc_register_component(&pdev->dev, &omap_dmic_component=
,
> +	ret =3D devm_snd_soc_register_component(&pdev->dev, &omap_dmic_comp=
onent,
>  					 &omap_dmic_dai, 1);

Would you align the parameters at the same time?

>  	if (ret)
>  		goto err_put_clk;
> @@ -510,7 +510,6 @@ static int asoc_dmic_remove(struct platform_devic=
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
