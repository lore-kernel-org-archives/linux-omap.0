From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/2] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Wed, 1 Jul 2015 15:41:26 +0300
Message-ID: <5593DFF6.4090100@ti.com>
References: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 06/08/2015 04:22 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v01:
> - Drop change in compatible for the crossbar driver and do the config=
uration
>   based on the DT structure.
>=20
> The ti-dma-crossbar driver in it's current form can work when it is u=
sed with
> sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eDMA=
 available.
> The sDMA driver expects to get the DMA request line with offset 1. Th=
e eDMA
> stack does not need the offset.
> The crosbbar itself is identical for sDMA and eDMA.
> At probe time the driver will do a match to figure out which dma engi=
ne it is
> connected to and based on that information it will configure the offs=
et needed
> by the DMA driver.

Gentle ping, it has been almost a month ago this series has been sent.

> Regards,
> Peter
> ---
> Misael Lopez Cruz (1):
>   dmaengine: ti-dma-crossbar: Make idr xbar instance-specific
>=20
> Peter Ujfalusi (1):
>   dmaengine: ti-dma-crossbar: Add support for eDMA
>=20
>  drivers/dma/ti-dma-crossbar.c | 34 +++++++++++++++++++++++++++++----=
-
>  1 file changed, 29 insertions(+), 5 deletions(-)
>=20


--=20
P=E9ter
