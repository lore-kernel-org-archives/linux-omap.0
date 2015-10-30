From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] dmaengine: ti-dma-crossbar: channel reserving and
 edma3-tcc support
Date: Fri, 30 Oct 2015 09:20:37 +0200
Message-ID: <56331A45.6020201@ti.com>
References: <1446107331-30041-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446107331-30041-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Vinod,

On 10/29/2015 10:28 AM, Peter Ujfalusi wrote:
> Hi,
>=20
> This series depends on the eDMA work I have done, which has been now =
applied:
> https://lkml.org/lkml/2015/10/16/64
>=20
> DRA7 family of chips have both sDMA and eDMA. Currently only sDMA can=
 be used
> becasue the old driver stack for eDMA did not allowed integration w/o=
 hacks.
>=20
> Due to the nature of eDMA the crossbar needs to know which eDMA event=
s it can
> use to map incoming events towards the eDMA. In eDMA a channel is wir=
ed to be
> used with one specific event. For example eDMA event 14 can only be h=
andled by
> eDMA channel 14.
> The eDMA itself can be shared by different processors in the system (=
ARM, DSP,
> etc) and since ARM/Linux is the master we need to know which channels=
 are used
> by other cores. Also we need to mask out channels used for memcpy fro=
m the
> events we use for HW triggers.

Please ignore this series, I have found some issue with it and I just s=
tarted
to debug it. Will post V2 as soon as I found the problem.

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr
>   dmaengine: ti-dma-crossbar: dra7: Support for reserving DMA event
>     ranges
>   dmaengine: ti-dma-crossbar: dra7: Support for eDMA with new binding=
s
>=20
>  .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  6 ++
>  drivers/dma/ti-dma-crossbar.c                      | 81 ++++++++++++=
+++++++---
>  2 files changed, 76 insertions(+), 11 deletions(-)
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
