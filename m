From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
Date: Thu, 29 Nov 2018 11:26:13 +0200
Message-ID: <5BFFB0B5.6070109@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-5-git-send-email-rogerq@ti.com>
 <e63ac3f9-8daf-af84-a200-4c5f40a1a3ed@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e63ac3f9-8daf-af84-a200-4c5f40a1a3ed@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 27/11/18 00:32, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
> 
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index ce5d061..88a86cc 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -26,3 +26,4 @@ qcom_wcnss_pil-y            += qcom_wcnss.o
>>   qcom_wcnss_pil-y            += qcom_wcnss_iris.o
>>   obj-$(CONFIG_ST_REMOTEPROC)        += st_remoteproc.o
>>   obj-$(CONFIG_ST_SLIM_REMOTEPROC)    += st_slim_rproc.o
>> +obj-$(CONFIG_PRUSS_REMOTEPROC)        += pru_rproc.o
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> new file mode 100644
>> index 0000000..c35f432
>> --- /dev/null
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -0,0 +1,392 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PRU-ICSS remoteproc driver for various TI SoCs
>> + *
>> + * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *    Suman Anna <s-anna@ti.com>
>> + *    Andrew F. Davis <afd@ti.com>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/remoteproc.h>
> 
> alphabetical order?
> 
>> +#include <linux/pruss.h>
>> +
>> +#include "remoteproc_internal.h"
> 
> alphabetical order?

ok for both.

> 
>> +#include "pru_rproc.h"
>> +
>> +/* PRU_ICSS_PRU_CTRL registers */
>> +#define PRU_CTRL_CTRL        0x0000
>> +#define PRU_CTRL_STS        0x0004
>> +#define PRU_CTRL_WAKEUP_EN    0x0008
>> +#define PRU_CTRL_CYCLE        0x000C
>> +#define PRU_CTRL_STALL        0x0010
>> +#define PRU_CTRL_CTBIR0        0x0020
>> +#define PRU_CTRL_CTBIR1        0x0024
>> +#define PRU_CTRL_CTPPR0        0x0028
>> +#define PRU_CTRL_CTPPR1        0x002C
>> +
>> +/* CTRL register bit-fields */
>> +#define CTRL_CTRL_SOFT_RST_N    BIT(0)
>> +#define CTRL_CTRL_EN        BIT(1)
>> +#define CTRL_CTRL_SLEEPING    BIT(2)
>> +#define CTRL_CTRL_CTR_EN    BIT(3)
>> +#define CTRL_CTRL_SINGLE_STEP    BIT(8)
>> +#define CTRL_CTRL_RUNSTATE    BIT(15)
>> +
>> +/**
>> + * enum pru_mem - PRU core memory range identifiers
>> + */
>> +enum pru_mem {
>> +    PRU_MEM_IRAM = 0,
>> +    PRU_MEM_CTRL,
>> +    PRU_MEM_DEBUG,
>> +    PRU_MEM_MAX,
>> +};
> 
> I am finding the name "mem" here to be confusing. I keep thinking
> these are just RAM regions instead of memory mapped I/O. Maybe call
> it "iomem" instead of "mem"?
> 

ok.

> ...
> 
>> +static int pru_rproc_set_id(struct pru_rproc *pru)
>> +{
>> +    int ret = 0;
>> +    u32 mask1 = 0x34000;
>> +    u32 mask2 = 0x38000;
> 
> These values are non-obvious and could use some comments. Also,
> they could be made into constants or macros.
> 

ok.

>> +
>> +    if ((pru->mem_regions[0].pa & mask1) == mask1)
> 
> how about this instead:
> 
>     if ((pru->mem_regions[PRU_MEM_IRAM].pa & 0xfffff) == mask1)
> 
> The 0xfffff mask will be important on AM18xx where INTC is at 0x34000,
> PRU0 IRAM is at 0x38000 and PRU1 IRAM is at 0x3C000.
> 

I think this approach of figuring out id based on IRAM address is not scalable.

At the moment ID is used for these operations

pruss_cfg_gpimode()
pruss_cfg_get_gpmux()
pruss_cfg_set_gpmux()

All of which affect the GPCFG register of the respective PRU.

I think a better approach is to get rid of this ID logic and provide the
GPCFG syscon address to the PRU node and let the pru driver directly affect the register.

e.g. on am335x

				pru0: pru@4a334000 {
					compatible = "ti,am3356-pru";
					...
					gpcfg = <&pruss_cfg 8>;
				};

So the API changes from

int pruss_cfg_get_gpmux(struct pruss *pruss, enum pruss_pru_id id, u8 *mux)

to

int pru_rproc_cfg_get_gpmux(struct pru_rproc *pru, u8 *mux)


>> +        pru->id = 0;
>> +    else if ((pru->mem_regions[0].pa & mask2) == mask2)
>> +        pru->id = 1;
>> +    else
>> +        ret = -EINVAL;
>> +
>> +    return ret;
>> +}
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
