From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: omap_device: Correct resource handling
 for DT boot
Date: Tue, 30 Oct 2012 12:21:11 +0100
Message-ID: <508FB827.4030604@ti.com>
References: <1351593205-13590-1-git-send-email-peter.ujfalusi@ti.com> <1351593205-13590-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41768 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757029Ab2J3LVR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 07:21:17 -0400
In-Reply-To: <1351593205-13590-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/30/2012 11:33 AM, Peter Ujfalusi wrote:
> When booting with DT the OF core can fill up the resources provided w=
ithin
> the DT blob.
> The current way of handling the DT boot prevents us from removing hwm=
od data
> for platforms only suppose to boot with DT (OMAP5 for example) since =
we need
> to keep the whole hwmod database intact in order to have more resourc=
es in
> hwmod than in DT (to be able to append the DMA resource from hwmod).
>=20
> To fix this issue we just examine the OF provided resources:
> If we do not have resources we use hwmod to fill them.
> If we have resources we check if we already able to recive DMA resour=
ce, if
> no we only append the DMA resurce from hwmod to the OF provided ones.
>=20
> In this way we can start removing hwmod data for devices which have t=
heir
> resources correctly configured in DT without regressions.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c | 80 +++++++++++++++++++++++-------=
----------
>  1 file changed, 47 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index 915cf68..a8a9d08 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -560,55 +560,69 @@ struct omap_device *omap_device_alloc(struct pl=
atform_device *pdev,
>  	od->hwmods =3D hwmods;
>  	od->pdev =3D pdev;
> =20
> -	/* Count all resources for the device */
> -	res_count =3D omap_device_count_resources(od, IORESOURCE_IRQ |
> -						    IORESOURCE_DMA |
> -						    IORESOURCE_MEM);
>  	/*
> +	 * Non-DT Boot:
> +	 *   Here, pdev->num_resources =3D 0, and we should get all the
> +	 *   resources from hwmod.
> +	 *
>  	 * DT Boot:
>  	 *   OF framework will construct the resource structure (currently
>  	 *   does for MEM & IRQ resource) and we should respect/use these
>  	 *   resources, killing hwmod dependency.
>  	 *   If pdev->num_resources > 0, we assume that MEM & IRQ resources
>  	 *   have been allocated by OF layer already (through DTB).
> -	 *
> -	 * Non-DT Boot:
> -	 *   Here, pdev->num_resources =3D 0, and we should get all the
> -	 *   resources from hwmod.
> +	 *   As preparation for the future we examine the OF provided resou=
rces
> +	 *   to see if we have DMA resources provided already. In this case
> +	 *   there is no need to update the resources for the device, we us=
e the
> +	 *   OF provided ones.
>  	 *
>  	 * TODO: Once DMA resource is available from OF layer, we should
>  	 *   kill filling any resources from hwmod.
>  	 */
> -	if (res_count > pdev->num_resources) {
> -		/* Allocate resources memory to account for new resources */
> -		res =3D kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
> -		if (!res)
> -			goto oda_exit3;
> -
> -		/*
> -		 * If pdev->num_resources > 0, then assume that,
> -		 * MEM and IRQ resources will only come from DT and only
> -		 * fill DMA resource from hwmod layer.
> -		 */
> -		if (pdev->num_resources && pdev->resource) {
> -			dev_dbg(&pdev->dev, "%s(): resources already allocated %d\n",
> -				__func__, res_count);
> -			memcpy(res, pdev->resource,
> -			       sizeof(struct resource) * pdev->num_resources);
> -			_od_fill_dma_resources(od, &res[pdev->num_resources]);
> -		} else {
> -			dev_dbg(&pdev->dev, "%s(): using resources from hwmod %d\n",
> -				__func__, res_count);
> -			omap_device_fill_resources(od, res);
> +	if (!pdev->num_resources) {
> +		/* Count all resources for the device */
> +		res_count =3D omap_device_count_resources(od, IORESOURCE_IRQ |
> +							    IORESOURCE_DMA |
> +							    IORESOURCE_MEM);
> +	} else {
> +		/* Take a look if we already have DMA resource via DT */
> +		for (i =3D 0; i < pdev->num_resources; i++) {
> +			struct resource *r =3D &pdev->resource[i];
> +
> +			/* We have it, no need to touch the resources */
> +			if (r->flags =3D=3D IORESOURCE_DMA)
> +				goto have_everything;
>  		}
> +		/* Count only DMA resources for the device */
> +		res_count =3D omap_device_count_resources(od, IORESOURCE_DMA);

We have devices without DMA channel so we can skip the resource recreat=
ion for
them.
I'll resend the series with this update.

> +		res_count +=3D pdev->num_resources;
> +	}
> =20
> -		ret =3D platform_device_add_resources(pdev, res, res_count);
> -		kfree(res);
> +	/* Allocate resources memory to account for new resources */
> +	res =3D kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
> +	if (!res)
> +		goto oda_exit3;
> =20
> -		if (ret)
> -			goto oda_exit3;
> +	if (!pdev->num_resources) {
> +		dev_dbg(&pdev->dev, "%s: using %d resources from hwmod\n",
> +			__func__, res_count);
> +		omap_device_fill_resources(od, res);
> +	} else {
> +		dev_dbg(&pdev->dev,
> +			"%s: appending %d DMA resources from hwmod\n",
> +			__func__, res_count - pdev->num_resources);
> +		memcpy(res, pdev->resource,
> +		       sizeof(struct resource) * pdev->num_resources);
> +		_od_fill_dma_resources(od, &res[pdev->num_resources]);
>  	}
> =20
> +	ret =3D platform_device_add_resources(pdev, res, res_count);
> +	kfree(res);
> +
> +	if (ret)
> +		goto oda_exit3;
> +
> +have_everything:
>  	if (!pm_lats) {
>  		pm_lats =3D omap_default_latency;
>  		pm_lats_cnt =3D ARRAY_SIZE(omap_default_latency);
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
