From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Use devm_snd_soc_register_component
Date: Mon, 7 Jul 2014 12:29:25 +0300
Message-ID: <53BA6875.8060309@ti.com>
References: <1404536979-5318-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40099 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbaGGJ3d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Jul 2014 05:29:33 -0400
In-Reply-To: <1404536979-5318-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org

On 07/05/2014 08:09 AM, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.
>=20
> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
> ---
> :100644 100644 efe2cd6... bfc8f8e... M	sound/soc/omap/omap-mcbsp.c
>  sound/soc/omap/omap-mcbsp.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.=
c
> index efe2cd6..bfc8f8e 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -805,7 +805,7 @@ static int asoc_mcbsp_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D snd_soc_register_component(&pdev->dev, &omap_mcbsp_componen=
t,
> +	ret =3D devm_snd_soc_register_component(&pdev->dev, &omap_mcbsp_com=
ponent,
>  					 &omap_mcbsp_dai, 1);

Can you align the parameters as well?

>  	if (ret)
>  		return ret;
> @@ -817,8 +817,6 @@ static int asoc_mcbsp_remove(struct platform_devi=
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
