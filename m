From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 05/11] soc: ti: omap-prm: sync func clock status with
 resets
Date: Fri, 30 Aug 2019 10:03:38 +0300
Message-ID: <7725d643-42ac-c3c1-9b07-ce2631fdb3c4@ti.com>
References: <20190828071941.32378-1-t-kristo@ti.com>
 <20190828071941.32378-6-t-kristo@ti.com>
 <1567085114.5345.12.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1567085114.5345.12.camel@pengutronix.de>
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
To: Philipp Zabel <p.zabel@pengutronix.de>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 29/08/2019 16:25, Philipp Zabel wrote:
> On Wed, 2019-08-28 at 10:19 +0300, Tero Kristo wrote:
>> Hardware reset signals are tightly coupled with associated clocks, and
>> basically de-asserting a reset won't succeed properly if the clock is
>> not enabled, and vice-versa. Also, disabling a clock won't fully succeed
>> if the associated hardware resets are not asserted. Add status sync
>> functionality between these two for TI drivers so that the situations
>> can be handled properly without generating any timeouts.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/soc/ti/omap_prm.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
>> index 38998ce19c71..e876bad8f8d5 100644
>> --- a/drivers/soc/ti/omap_prm.c
>> +++ b/drivers/soc/ti/omap_prm.c
>> @@ -15,6 +15,8 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/delay.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk/ti.h>
>>   
>>   #include <linux/platform_data/ti-prm.h>
>>   
>> @@ -42,7 +44,9 @@ struct omap_reset_data {
>>   	struct reset_controller_dev rcdev;
>>   	struct omap_prm *prm;
>>   	struct clockdomain *clkdm;
>> +	struct clk *clk;
>>   	struct device *dev;
>> +	u32 mask;
>>   };
>>   
>>   #define to_omap_reset_data(p) container_of((p), struct omap_reset_data, rcdev)
>> @@ -102,6 +106,8 @@ static int omap_reset_assert(struct reset_controller_dev *rcdev,
>>   	v |= 1 << id;
>>   	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctrl);
>>   
>> +	ti_clk_notify_resets(reset->clk, v == reset->mask);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -163,9 +169,19 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
>>   	v &= ~(1 << id);
>>   	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctrl);
>>   
>> +	ti_clk_notify_resets(reset->clk, v == reset->mask);
>> +
>>   	if (!has_rstst)
>>   		goto exit;
>>   
>> +	/* If associated clock is disabled, we can't poll completion status */
>> +	if (reset->clk) {
>> +		struct clk_hw *hw = __clk_get_hw(reset->clk);
>> +
>> +		if (!clk_hw_is_enabled(hw))
>> +			return ret;
>> +	}
>> +
>>   	/* wait for the status to be set */
>>   	while (1) {
>>   		v = readl_relaxed(reset->prm->base + reset->prm->data->rstst);
>> @@ -199,8 +215,10 @@ static int omap_prm_reset_init(struct platform_device *pdev,
>>   			       struct omap_prm *prm)
>>   {
>>   	struct omap_reset_data *reset;
>> +	const struct omap_rst_map *map;
>>   	struct ti_prm_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>   	char buf[32];
>> +	u32 v;
>>   
>>   	/*
>>   	 * Check if we have controllable resets. If either rstctrl is non-zero
>> @@ -215,6 +233,10 @@ static int omap_prm_reset_init(struct platform_device *pdev,
>>   	    !pdata->clkdm_allow_idle)
>>   		return -EINVAL;
>>   
>> +	map = prm->data->rstmap;
>> +	if (!map)
>> +		return -EINVAL;
> 
> Can this actually happen?

It can, if user writes bad data to the omap_prm_data structs. Without 
this check it would make the probe crash which is bad.

> 
>> +
>>   	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
>>   	if (!reset)
>>   		return -ENOMEM;
>> @@ -224,6 +246,10 @@ static int omap_prm_reset_init(struct platform_device *pdev,
>>   	reset->rcdev.of_node = pdev->dev.of_node;
>>   	reset->rcdev.nr_resets = OMAP_MAX_RESETS;
>>   	reset->dev = &pdev->dev;
>> +	reset->clk = of_clk_get(pdev->dev.of_node, 0);
>> +
>> +	if (IS_ERR(reset->clk))
>> +		reset->clk = NULL;
> 
> Maybe only ignore -ENOENT?

Yeah, I can modify this.

> 
>>   	reset->prm = prm;
>>   
>> @@ -234,6 +260,16 @@ static int omap_prm_reset_init(struct platform_device *pdev,
>>   	if (!reset->clkdm)
>>   		return -EINVAL;
>>   
>> +	while (map->rst >= 0) {
>> +		reset->mask |= BIT(map->rst);
>> +		map++;
>> +	}
> 
> With this, you could use reset->mask to simplify _is_valid_reset.

True, let me re-write it.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
