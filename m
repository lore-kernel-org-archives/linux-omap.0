From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/6] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Mon, 2 Mar 2015 09:57:57 +0200
Message-ID: <54F41805.2000505@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com>	 <1424787683-19151-3-git-send-email-peter.ujfalusi@ti.com> <1425139258.24292.56.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425139258.24292.56.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 02/28/2015 06:00 PM, Paul Bolle wrote:
> On Tue, 2015-02-24 at 16:21 +0200, Peter Ujfalusi wrote:
>> The DRA7x has more peripherals with DMA requests than the sDMA can h=
andle:
>> 205 vs 127. All DMA requests are routed through the DMA crossbar, wh=
ich can
>> be configured to route selected incoming DMA requests to specific sD=
MA
>> request.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/Kconfig           |   4 +
>>  drivers/dma/Makefile          |   1 +
>>  drivers/dma/ti-dma-crossbar.c | 191 +++++++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 196 insertions(+)
>>  create mode 100644 drivers/dma/ti-dma-crossbar.c
>=20
> A simple observation follows.
>=20
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index a874b6ec6650..dfe72a0f46dc 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -245,6 +245,9 @@ config TI_EDMA
>>  	  Enable support for the TI EDMA controller. This DMA
>>  	  engine is found on TI DaVinci and AM33xx parts.
>> =20
>> +config TI_DMA_CROSSBAR
>> +	bool
>> +
>=20
> This is a bool symbol...
>=20
>>  config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
>>  	bool
>> =20
>> @@ -330,6 +333,7 @@ config DMA_OMAP
>>  	depends on ARCH_OMAP
>>  	select DMA_ENGINE
>>  	select DMA_VIRTUAL_CHANNELS
>> +	select TI_DMA_CROSSBAR if SOC_DRA7XX
>> =20
>>  config DMA_BCM2835
>>  	tristate "BCM2835 DMA engine support"
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index f915f61ec574..bc12f9a4e62b 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_EP93XX_DMA) +=3D ep93xx_dma.o
>>  obj-$(CONFIG_DMA_SA11X0) +=3D sa11x0-dma.o
>>  obj-$(CONFIG_MMP_TDMA) +=3D mmp_tdma.o
>>  obj-$(CONFIG_DMA_OMAP) +=3D omap-dma.o
>> +obj-$(CONFIG_TI_DMA_CROSSBAR) +=3D ti-dma-crossbar.o
>=20
> ... so this file will be either not built or built into the kernel...
>=20
>>  obj-$(CONFIG_DMA_BCM2835) +=3D bcm2835-dma.o
>>  obj-$(CONFIG_MMP_PDMA) +=3D mmp_pdma.o
>>  obj-$(CONFIG_DMA_JZ4740) +=3D dma-jz4740.o
>> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-cros=
sbar.c
>> new file mode 100644
>> index 000000000000..bf01434df46a
>> --- /dev/null
>> +++ b/drivers/dma/ti-dma-crossbar.c
>> @@ -0,0 +1,191 @@
>> +/*
>> + *  Copyright (C) 2015 Texas Instruments Incorporated - http://www.=
ti.com
>> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +#include <linux/slab.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/list.h>
>> +#include <linux/io.h>
>> +#include <linux/regmap.h>
>> +#include <linux/idr.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/module.h>
>=20
> ...  this includes linux/module.h ...
>=20
> [...]
>=20
>> +static struct platform_driver ti_dma_xbar_driver =3D {
>> +	.probe	=3D ti_dma_xbar_probe,
>> +	.driver =3D {
>> +		.name =3D "ti-dma-crossbar",
>> +		.owner =3D THIS_MODULE,
>=20
> ... is that needed to make this work?
>=20
>> +		.of_match_table =3D of_match_ptr(ti_dma_xbar_match),
>> +	},
>> +};
>> +
>> +int omap_dmaxbar_init(void)
>> +{
>> +	return platform_driver_register(&ti_dma_xbar_driver);
>> +}
>> +arch_initcall(omap_dmaxbar_init);
>> +
>> +MODULE_DESCRIPTION("TI DMA Crossbar");
>> +MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
>> +MODULE_LICENSE("GPL");
>=20
> And why are these three macros needed?
>=20
> By the way: there's a mismatch between the header (which is GPL v2) a=
nd
> the MODULE_LICENSE() string (which means GPL v2 or later).

True, the linux/module.h and the lines with *MODULE* in it is not neede=
d in
case the driver will be not built as module. I have not really thought =
about
this to be honest, I have had these macros in most (all?) of the driver=
s I wrote.
They will be gone in V2 of the series.

Thanks,
P=C3=A9ter
