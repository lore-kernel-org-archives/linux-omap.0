From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 4/8] soc: ti: omap-prm: add support for denying idle for
 reset clockdomain
Date: Tue, 20 Aug 2019 10:51:45 +0300
Message-ID: <34c761e7-65c1-cc42-2b33-513dfbcd8574@ti.com>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
 <1565164139-21886-5-git-send-email-t-kristo@ti.com>
 <81cda31a-b321-f9b4-2df7-2b6c084b2ec5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <81cda31a-b321-f9b4-2df7-2b6c084b2ec5@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20.8.2019 2.16, Suman Anna wrote:
> Hi Tero,
> 
> On 8/7/19 2:48 AM, Tero Kristo wrote:
>> TI SoCs hardware reset signals require the parent clockdomain to be
>> in force wakeup mode while de-asserting the reset, otherwise it may
>> never complete. To support this, add pdata hooks to control the
>> clockdomain directly.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/soc/ti/omap_prm.c            | 32 ++++++++++++++++++++++++++++----
>>   include/linux/platform_data/ti-prm.h | 21 +++++++++++++++++++++
>>   2 files changed, 49 insertions(+), 4 deletions(-)
>>   create mode 100644 include/linux/platform_data/ti-prm.h
>>
>> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
>> index d412af3..870515e3 100644
>> --- a/drivers/soc/ti/omap_prm.c
>> +++ b/drivers/soc/ti/omap_prm.c
>> @@ -16,6 +16,8 @@
>>   #include <linux/reset-controller.h>
>>   #include <linux/delay.h>
>>   
>> +#include <linux/platform_data/ti-prm.h>
>> +
>>   struct omap_rst_map {
>>   	s8 rst;
>>   	s8 st;
>> @@ -24,6 +26,7 @@ struct omap_rst_map {
>>   struct omap_prm_data {
>>   	u32 base;
>>   	const char *name;
>> +	const char *clkdm_name;
>>   	u16 pwstctrl;
>>   	u16 pwstst;
>>   	u16 rstctl;
>> @@ -40,6 +43,8 @@ struct omap_prm {
>>   struct omap_reset_data {
>>   	struct reset_controller_dev rcdev;
>>   	struct omap_prm *prm;
>> +	struct clockdomain *clkdm;
>> +	struct device *dev;
>>   };
>>   
>>   #define to_omap_reset_data(p) container_of((p), struct omap_reset_data, rcdev)
>> @@ -108,6 +113,8 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
>>   	int st_bit = id;
>>   	bool has_rstst;
>>   	int timeout = 0;
>> +	struct ti_prm_platform_data *pdata = dev_get_platdata(reset->dev);
>> +	int ret = 0;
>>   
>>   	/* check the current status to avoid de-asserting the line twice */
>>   	v = readl_relaxed(reset->prm->base + reset->prm->data->rstctl);
>> @@ -125,13 +132,16 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
>>   		writel_relaxed(v, reset->prm->base + reset->prm->data->rstst);
>>   	}
>>   
>> +	if (pdata->clkdm_deny_idle && reset->clkdm)
>> +		pdata->clkdm_deny_idle(reset->clkdm);
>> +
>>   	/* de-assert the reset control line */
>>   	v = readl_relaxed(reset->prm->base + reset->prm->data->rstctl);
>>   	v &= ~(1 << id);
>>   	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctl);
>>   
>>   	if (!has_rstst)
>> -		return 0;
>> +		goto exit;
>>   
>>   	/* wait for the status to be set */
>>   	while (1) {
>> @@ -140,13 +150,19 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
>>   		if (v)
>>   			break;
>>   		timeout++;
>> -		if (timeout > OMAP_RESET_MAX_WAIT)
>> -			return -EBUSY;
>> +		if (timeout > OMAP_RESET_MAX_WAIT) {
>> +			ret = -EBUSY;
>> +			goto exit;
>> +		}
>>   
>>   		udelay(1);
>>   	}
>>   
>> -	return 0;
>> +exit:
>> +	if (pdata->clkdm_allow_idle && reset->clkdm)
>> +		pdata->clkdm_allow_idle(reset->clkdm);
>> +
>> +	return ret;
>>   }
>>   
>>   static const struct reset_control_ops omap_reset_ops = {
>> @@ -159,6 +175,8 @@ static int omap_prm_reset_probe(struct platform_device *pdev,
>>   				struct omap_prm *prm)
>>   {
>>   	struct omap_reset_data *reset;
>> +	struct ti_prm_platform_data *pdata = dev_get_platdata(&pdev->dev);
> 
> Please add checks for NULL callbacks. I don't think these are optional
> right, so better to check in init rather than during runtime. Granted
> you will probably not run into this after patch 8, but would be good to
> check and print an error in case pdata quirks is missed out.

Hmm ok, this would get rid of the runtime checks which would be slightly 
cleaner.

> 
>> +	char buf[32];
>>   
>>   	/*
>>   	 * Check if we have resets. If either rstctl or rstst is
>> @@ -177,9 +195,15 @@ static int omap_prm_reset_probe(struct platform_device *pdev,
>>   	reset->rcdev.ops = &omap_reset_ops;
>>   	reset->rcdev.of_node = pdev->dev.of_node;
>>   	reset->rcdev.nr_resets = OMAP_MAX_RESETS;
>> +	reset->dev = &pdev->dev;
>>   
>>   	reset->prm = prm;
>>   
>> +	sprintf(buf, "%s_clkdm", prm->data->clkdm_name ? prm->data->clkdm_name :
>> +		prm->data->name);
>> +
>> +	reset->clkdm = pdata->clkdm_lookup(buf);
> 
> Not checking return status?

clkdm will just end up being NULL in failure, which is fine for rest of 
the code. I don't think it can be ever NULL though, so I can add a check 
here for sanity.

-Tero

> 
> regards
> Suman
> 
>> +
>>   	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
>>   }
>>   
>> diff --git a/include/linux/platform_data/ti-prm.h b/include/linux/platform_data/ti-prm.h
>> new file mode 100644
>> index 0000000..28154c3
>> --- /dev/null
>> +++ b/include/linux/platform_data/ti-prm.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * TI PRM (Power & Reset Manager) platform data
>> + *
>> + * Copyright (C) 2019 Texas Instruments, Inc.
>> + *
>> + * Tero Kristo <t-kristo@ti.com>
>> + */
>> +
>> +#ifndef _LINUX_PLATFORM_DATA_TI_PRM_H
>> +#define _LINUX_PLATFORM_DATA_TI_PRM_H
>> +
>> +struct clockdomain;
>> +
>> +struct ti_prm_platform_data {
>> +	void (*clkdm_deny_idle)(struct clockdomain *clkdm);
>> +	void (*clkdm_allow_idle)(struct clockdomain *clkdm);
>> +	struct clockdomain * (*clkdm_lookup)(const char *name);
>> +};
>> +
>> +#endif /* _LINUX_PLATFORM_DATA_TI_PRM_H */
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
