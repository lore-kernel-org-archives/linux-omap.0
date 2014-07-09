From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V2] ASoC: omap-hdmi: Use devm_snd_soc_register_component
Date: Wed, 9 Jul 2014 08:48:09 +0300
Message-ID: <53BCD799.7000700@ti.com>
References: <n> <1404838043-5095-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41372 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbaGIFsQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jul 2014 01:48:16 -0400
In-Reply-To: <1404838043-5095-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org

On 07/08/2014 07:47 PM, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.
>=20
> Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>

Jut to make things easier I think we should not have this patch applied=
 since
Jyri's OMAP4+ HDMI audio rework series is going to delete this file.

> ---
> Changes since V1:
>         Aligned function parameter properly.
>=20
> :100644 100644 eb9c392... 8dcd7f7... M	sound/soc/omap/omap-hdmi.c
>  sound/soc/omap/omap-hdmi.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
> index eb9c392..8dcd7f7 100644
> --- a/sound/soc/omap/omap-hdmi.c
> +++ b/sound/soc/omap/omap-hdmi.c
> @@ -322,8 +322,9 @@ static int omap_hdmi_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	dev_set_drvdata(&pdev->dev, hdmi_data);
> -	ret =3D snd_soc_register_component(&pdev->dev, &omap_hdmi_component=
,
> -					 &omap_hdmi_dai, 1);
> +	ret =3D devm_snd_soc_register_component(&pdev->dev,
> +					      &omap_hdmi_component,
> +					      &omap_hdmi_dai, 1);
> =20
>  	if (ret)
>  		return ret;
> @@ -335,8 +336,6 @@ static int omap_hdmi_remove(struct platform_devic=
e *pdev)
>  {
>  	struct hdmi_priv *hdmi_data =3D dev_get_drvdata(&pdev->dev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	if (hdmi_data =3D=3D NULL) {
>  		dev_err(&pdev->dev, "cannot obtain HDMi data\n");
>  		return -ENODEV;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
