From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/6] dmaengine/dra7x: DMA router (crossbar support)
Date: Mon, 9 Mar 2015 15:14:06 +0200
Message-ID: <54FD9C9E.8000405@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 02/24/2015 04:21 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> The series adds support for DMA router type of devices. They are used=
 in SoCs
> which has more peripherals with DMA request lines than the DMA contro=
ller can
> handle.
> The router itself is not part of the DMA controller and it's operatio=
n should be
> transparent (as it is in the HW) for the SW stack.
>=20
> This series takes into accound the comments Sricharan received for hi=
s version
> of the crossbar driver:
> https://lkml.org/lkml/2014/3/7/199
>=20
> This implementation is not tied to any DMA driver so it is possible t=
o use the
> framework by other vendors, also ACPI version of binding can be easy =
enough to
> be added.
>=20
> The omap-dma part of changes are based on the dma property name chang=
e series:
> https://lkml.org/lkml/2015/2/20/182
>=20
> but the code has fallback so it is working w/o the changes in that se=
ries.

Gentle ping on this series before I send the V2 with the comments from =
Russell
and Paul addressed.

Kind Regards,
P=E9ter

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (6):
>   dmaengine: of_dma: Support for DMA routers
>   dmaengine: Add driver for TI DMA crossbar on DRA7x
>   dmaengine: omap-dma: Use defines for dma channels and request count
>   dmaengine: omap-dma: Take DMA request number from DT if it is
>     available
>   dmaengine: omap-dma: Remove mapping between virtual channels and
>     requests
>   ARM: DTS: dra7x: Integrate sDMA crossbar
>=20
>  Documentation/devicetree/bindings/dma/dma.txt |  27 ++++
>  arch/arm/boot/dts/dra7.dtsi                   |  57 ++++----
>  drivers/dma/Kconfig                           |   4 +
>  drivers/dma/Makefile                          |   1 +
>  drivers/dma/dmaengine.c                       |   7 +
>  drivers/dma/of-dma.c                          |  92 +++++++++++++
>  drivers/dma/omap-dma.c                        |  24 +++-
>  drivers/dma/ti-dma-crossbar.c                 | 191 ++++++++++++++++=
++++++++++
>  include/linux/dmaengine.h                     |  17 +++
>  include/linux/of_dma.h                        |  21 +++
>  10 files changed, 413 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/dma/ti-dma-crossbar.c
>=20
