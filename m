From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/3] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Fri, 5 Jun 2015 19:17:17 +0300
Message-ID: <5571CB8D.7030401@ti.com>
References: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433518474-26628-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

On 06/05/2015 06:34 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> The ti-dma-crossbar driver in it's current form can work when it is u=
sed with
> sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eDMA=
 available.
> The DT bindings for sDMA has been done in a way that DMA users need t=
o specify
> the required DMA request number + 1 when they request for channel and=
 the driver
> stack has been written in this way also for sDMA.
> Since right now we do not have the crossbar enabled we can still chan=
ge the
> compatible string to reflect the crossbar use. The TRM also refers th=
e crossbars
> in this way.

Now that I have sent this series...
Would it be better to not touch the compatible strings, but add of_devi=
ce_id
table in the ti-dma-crossbar driver containing the supported dma contro=
llers,
like "ti,omap4430-sdma" and "ti,edma3" and to of_match_node() against t=
he node
we got via dma-masters?

So we would keep the ti,dra7-dma-crossbar and depending on where the
dma-masters point us we can decide in the code on how to handle?

Just a thought.

>=20
> Regards,
> Peter
> ---
> Misael Lopez Cruz (2):
>   dmaengine: ti-dma-crossbar: Make idr xbar instance-specific
>   dmaengine: ti-dma-crossbar: Add support for eDMA xbar
>=20
> Peter Ujfalusi (1):
>   dmaengine: ti-dma-crossbar: Change the compatible string to
>     ti,dra7-sdma-crossbar
>=20
>  Documentation/devicetree/bindings/dma/dma.txt      |  2 +-
>  .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  5 +--
>  drivers/dma/ti-dma-crossbar.c                      | 37 ++++++++++++=
++++------
>  3 files changed, 31 insertions(+), 13 deletions(-)
>=20


--=20
P=E9ter
