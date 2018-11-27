From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 06/17] soc: ti: pruss: Add a platform driver for PRUSS in
 TI SoCs
Date: Tue, 27 Nov 2018 17:17:17 +0200
Message-ID: <5BFD5FFD.9010807@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-7-git-send-email-rogerq@ti.com>
 <1608af03-35b5-79ce-4995-84e85e740687@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1608af03-35b5-79ce-4995-84e85e740687@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 26/11/18 23:15, David Lechner wrote:
> On 11/22/18 5:39 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The PRUSS platform driver deals with the overall PRUSS and is
>> used for managing the subsystem level resources like various
>> memories. It is responsible for the creation and deletion of
>> the platform devices for the child PRU devices and other child
>> devices (Interrupt Controller or MDIO node or some syscon nodes)
>> so that they can be managed by specific platform drivers.
>>
>> This design provides flexibility in representing the different
>> modules of PRUSS accordingly, and at the same time allowing the
>> PRUSS driver to add some instance specific configuration within
>> an SoC.
>>
>> The driver currently supports the AM335x SoC.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/soc/ti/Makefile |   2 +-
>>   drivers/soc/ti/pruss.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/soc/ti/pruss.h  |  44 ++++++++++++++++++
>>   3 files changed, 161 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/ti/pruss.c
>>   create mode 100644 drivers/soc/ti/pruss.h
>>
> 
> ...
> 
>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>> new file mode 100644
>> index 0000000..0840b59
>> --- /dev/null
>> +++ b/drivers/soc/ti/pruss.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PRU-ICSS platform driver for various TI SoCs
>> + *
>> + * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *    Suman Anna <s-anna@ti.com>
>> + *    Andrew F. Davis <afd@ti.com>
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
> 
> alphabetical order?

ok.

> 
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +
>> +#include "pruss.h"
>> +
>> +static int pruss_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct device_node *node = dev->of_node;
>> +    struct device_node *np;
>> +    struct pruss *pruss;
>> +    struct resource res;
>> +    int ret, i, index;
>> +    const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
>> +
>> +    if (!node) {
>> +        dev_err(dev, "Non-DT platform device not supported\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>> +    if (ret) {
>> +        dev_err(dev, "dma_set_coherent_mask: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    pruss = devm_kzalloc(dev, sizeof(*pruss), GFP_KERNEL);
>> +    if (!pruss)
>> +        return -ENOMEM;
>> +
>> +    pruss->dev = dev;
>> +
>> +    np = of_get_child_by_name(node, "memories");
>> +    if (!np)
> 
> error message?

Yes.
> 
>> +        return -ENODEV;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
>> +        index = of_property_match_string(np, "reg-names", mem_names[i]);
>> +        if (index < 0) {
>> +            of_node_put(np);
>> +            return index;
>> +        }
>> +
>> +        if (of_address_to_resource(np, index, &res)) {
>> +            of_node_put(np);
>> +            return -EINVAL;
>> +        }
>> +
>> +        pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
>> +                            resource_size(&res));
>> +        if (!pruss->mem_regions[i].va) {
>> +            dev_err(dev, "failed to parse and map memory resource %d %s\n",
>> +                i, mem_names[i]);
>> +            of_node_put(np);
>> +            return -ENOMEM;
>> +        }
>> +        pruss->mem_regions[i].pa = res.start;
>> +        pruss->mem_regions[i].size = resource_size(&res);
>> +
>> +        dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
>> +            mem_names[i], &pruss->mem_regions[i].pa,
>> +            pruss->mem_regions[i].size, pruss->mem_regions[i].va);
>> +    }
>> +    of_node_put(np);
>> +
>> +    platform_set_drvdata(pdev, pruss);
>> +
>> +    dev_info(&pdev->dev, "creating PRU cores and other child platform devices\n");
> 
> Is this really needed? Or dev_dbg instead?
> 
>> +    ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
>> +    if (ret)
>> +        dev_err(dev, "of_platform_populate failed\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static int pruss_remove(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +
>> +    dev_info(dev, "remove PRU cores and other child platform devices\n");
> 
> same here... looks like debug message

Yes for both.
> 
>> +    of_platform_depopulate(dev);
>> +
>> +    return 0;
>> +}
>> +

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
