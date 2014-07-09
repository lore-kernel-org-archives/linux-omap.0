From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V2] ASoC: omap-mcbsp: Use devm_snd_soc_register_component
Date: Wed, 9 Jul 2014 08:45:50 +0300
Message-ID: <53BCD70E.5090808@ti.com>
References: <1404836723-4779-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42490 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaGIFp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 01:45:58 -0400
In-Reply-To: <1404836723-4779-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org

On 07/08/2014 07:25 PM, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.
>=20
> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
> Changes since V1:
>         Aligned function parameter properly.
>=20
> :100644 100644 efe2cd6... bd3ef2a... M	sound/soc/omap/omap-mcbsp.c
>  sound/soc/omap/omap-mcbsp.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.=
c
> index efe2cd6..bd3ef2a 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -805,8 +805,9 @@ static int asoc_mcbsp_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D snd_soc_register_component(&pdev->dev, &omap_mcbsp_componen=
t,
> -					 &omap_mcbsp_dai, 1);
> +	ret =3D devm_snd_soc_register_component(&pdev->dev,
> +					      &omap_mcbsp_component,
> +					      &omap_mcbsp_dai, 1);
>  	if (ret)
>  		return ret;
> =20
> @@ -817,8 +818,6 @@ static int asoc_mcbsp_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct omap_mcbsp *mcbsp =3D platform_get_drvdata(pdev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
>  		mcbsp->pdata->ops->free(mcbsp->id);
> =20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
