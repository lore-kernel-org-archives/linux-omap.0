From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 0/8] dmaengine/dra7x: DMA router (crossbar support)
Date: Wed, 22 Apr 2015 10:38:27 +0300
Message-ID: <55374FF3.1030003@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com
List-Id: linux-omap@vger.kernel.org

On 04/09/2015 12:35 PM, Peter Ujfalusi wrote:
> Vinod: is it OK if I send the Documnetation/dmanegine/ update a bit l=
ater when
> I have finished it?
>=20
> Changes since v4:
> - Comments from Maxime Ripard addressed:
>  - long line fixed in of-dma.c
>  - node leaks has been fixed in ti-dma-crossbar
>  - Using devm_ioremap_resource() in ti-dma-crossbar
>  - u16 casting has been addressed
> - Router drivers are expected to return with ERR_PTR in case their
>   of_dma_route_allocate() callback fails.

Are there more comments I need to address with this series?

Thanks,
P=E9ter

> Changes since v3:
> - Comments from Russell:
>  - Warnings removed in case of non DT boot when taking the DMA reques=
t number
>  - Reduced the number of channels presented to DMAengine
>  - removed the dma_sig parameter from omap_dma_chan_init()
> - Comments from Arnd:
>  - dma-device property renamed to dma-masters
>  - Allow list of phandes in dma-masters
>=20
> Changes since v2:
> - not using regmap for the TI crossbar driver.
>=20
> Changes since v1:
> - Comments from Russell King and  Paul Bolle addressed:
>  - Use the added defined in the omap-dma changes
>  - MODULE_* removed from the ti-dma-crossbar driver.
> - DMA router documentation: do not limit the #dma-cells to be the sam=
e as the
>   dma controller's #dma-cells. It might be possible to have a router =
which needs
>   more information than the DMA controller (direct request pairing fo=
r example)
> - Use defines in the ti-dma-crossbar driver
> - Binding document for the ti-dma-crossbar driver
>=20
> Intro mail from v1:
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
> Regards,
> Peter
> ---
> Peter Ujfalusi (8):
>   dmaengine: of_dma: Support for DMA routers
>   Documentation: devicetree: dma: Binding documentation for TI DMA
>     crossbar
>   dmaengine: Add driver for TI DMA crossbar on DRA7x
>   dmaengine: omap-dma: Use defines for dma channels and request count
>   dmaengine: omap-dma: Take DMA request number from DT if it is
>     available
>   dmaengine: omap-dma: Remove mapping between virtual channels and
>     requests
>   dmaengine: omap-dma: Reduce the number of virtual channels
>   ARM: DTS: dra7x: Integrate sDMA crossbar
>=20
>  Documentation/devicetree/bindings/dma/dma.txt      |  28 +++
>  .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  52 ++++++
>  arch/arm/boot/dts/dra7.dtsi                        |  57 ++++---
>  drivers/dma/Kconfig                                |   4 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/dmaengine.c                            |   7 +
>  drivers/dma/of-dma.c                               |  89 ++++++++++
>  drivers/dma/omap-dma.c                             |  29 +++-
>  drivers/dma/ti-dma-crossbar.c                      | 188 +++++++++++=
++++++++++
>  include/linux/dmaengine.h                          |  17 ++
>  include/linux/of_dma.h                             |  21 +++
>  11 files changed, 463 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-dma-cros=
sbar.txt
>  create mode 100644 drivers/dma/ti-dma-crossbar.c
>=20
