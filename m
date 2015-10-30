From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] dmaengine: ti-dma-crossbar: dra7: Use bitops instead
 of idr
Date: Fri, 30 Oct 2015 10:02:47 +0200
Message-ID: <56332427.6000805@ti.com>
References: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
 <1446107331-30041-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446107331-30041-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

=46or the record...

On 10/29/2015 10:28 AM, Peter Ujfalusi wrote:
> The use of idr was nice, but it was a bit heavy and we did not need t=
he
> features it provides. Using simple bitmap to track allocated DMA chan=
nels
> is adequate here and it will be easier to add support for reserving
> channels later on.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> -	map->xbar_out =3D idr_alloc(&xbar->map_idr, NULL, 0, xbar->dma_requ=
ests,
> -				  GFP_KERNEL);
> +	mutex_lock(&xbar->mutex);
> +	map->xbar_out =3D find_next_zero_bit(xbar->dma_inuse, xbar->dma_req=
uests,
> +					   0);

find_first_zero_bit() ;)

> +	mutex_unlock(&xbar->mutex);
> +	if (map->xbar_out) {

Well, this is obviously wrong... Should have been:
	if (map->xbar_out =3D=3D xbar->dma_requests) {


> +		dev_err(&pdev->dev, "Run out of free DMA requests\n");
> +		kfree(map);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	set_bit(map->xbar_out, xbar->dma_inuse);
> +

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
