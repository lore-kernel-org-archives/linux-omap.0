From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcpdm: Remove useless ressource get.
Date: Mon, 11 Feb 2013 14:08:07 +0100
Message-ID: <5118ED37.3070905@ti.com>
References: <1360587762-29072-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49337 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148Ab3BKNIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 08:08:16 -0500
In-Reply-To: <1360587762-29072-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

Hi Sebastien,

On 02/11/2013 02:02 PM, Sebastien Guiriec wrote:
> Remove unused memory ressource get from McPDM driver.

I have no idea how this remain in the driver ;)

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> ---
>  sound/soc/omap/omap-mcpdm.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.=
c
> index 2fe8be2..5ca11bd 100644
> --- a/sound/soc/omap/omap-mcpdm.c
> +++ b/sound/soc/omap/omap-mcpdm.c
> @@ -449,10 +449,6 @@ static int asoc_mcpdm_probe(struct platform_devi=
ce *pdev)
>  	omap_mcpdm_dai_dma_params[0].port_addr =3D res->start + MCPDM_REG_D=
N_DATA;
>  	omap_mcpdm_dai_dma_params[1].port_addr =3D res->start + MCPDM_REG_U=
P_DATA;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res =3D=3D NULL)
> -		return -ENOMEM;
> -
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "dn_link=
");
>  	if (!res)
>  		return -ENODEV;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
