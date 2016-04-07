From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v2] rtc: omap: Support ext_wakeup configuration
Date: Thu, 7 Apr 2016 19:11:12 +0200
Message-ID: <570694B0.4040500@grinn-global.com>
References: <1459960367-29399-1-git-send-email-m.niestroj@grinn-global.com>
 <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
 <20160406191103.GE27411@atomide.com> <57056352.1060801@grinn-global.com>
 <57063B1A.7080700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57063B1A.7080700-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 07.04.2016 12:48, Grygorii Strashko wrote:
> On 04/06/2016 10:28 PM, Marcin Niestroj wrote:
>> Hi,
>>
>> On 06.04.2016 21:11, Tony Lindgren wrote:
>>> * Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160406 09:34]:
>>>> Support configuration of ext_wakeup sources. This patch makes it
>>>> possible to enable ext_wakeup (and set it's polarity), depending on
>>>> board configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup
>>>> in SLEEP mode (RTC-only) to notify about power-button presses. Handling
>>>> power-button presses enables to recover from RTC-only power states
>>>> correctly.
>>>>
>>>> Implementation uses gpiochip to utilize standard bindings. However,
>>>> configuration is possible only using device-tree (no runtime changes).
>>>
>>> Hey looks good to me, adding linux-omap list to Cc.
>>>
>>> Can you please check that the "depends on GPIOLIB" does not disable
>>> the RTC driver for omap1?
>>
>> Looks ok for omap1. ARCH_OMAP1 selects ARCH_REQUIRE_GPIOLIB, which
>> selects GPIOLIB.
>>
>> Best regards,
>> Marcin
>>
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>>> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/rtc/rtc-omap.txt |  18 ++-
>>>>   drivers/rtc/Kconfig                                |   2 +-
>>>>   drivers/rtc/rtc-omap.c                             | 137
>>>> ++++++++++++++++++++-
>>>>   3 files changed, 154 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>> b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>> index bf7d11a..4a7738e 100644
>>>> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>> @@ -18,8 +18,12 @@ Optional properties:
>>>>     through pmic_power_en
>>>>   - clocks: Any internal or external clocks feeding in to rtc
>>>>   - clock-names: Corresponding names of the clocks
>>>> +- gpio-controller: Mark as gpio controller when using ext_wakeup
>>>> +- #gpio-cells: Should be set to 2
>>>> +- ngpios: Number of ext_wakeup sources supported by processor (board)
>>>> +- ext-wakeup-gpios: List of ext_wakeup sources to configure
>>>>
>>>> -Example:
>>>> +Examples:
>>>>
>>>>   rtc@1c23000 {
>>>>       compatible = "ti,da830-rtc";
>>>> @@ -31,3 +35,15 @@ rtc@1c23000 {
>>>>       clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
>>>>       clock-names = "ext-clk", "int-clk";
>>>>   };
>>>> +
>>>> +rtc: rtc@44e3e000 {
>>>> +    compatible = "ti,am3352-rtc", "ti,da830-rtc";
>>>> +    reg = <0x44e3e000 0x1000>;
>>>> +    interrupts = <75
>>>> +              76>;
>>>> +    system-power-controller;
>>>> +    gpio-controller;
>>>> +    #gpio-cells = <2>;
>>>> +    ngpios = <1>;
>>>> +    ext-wakeup-gpios = <&rtc 0 GPIO_ACTIVE_LOW>;
>>>> +};
>
> I'm not sure that rtc can request gpios by itself in this
> way (if i rememberer this can break modules isnmod/rmmod).
>
> cc: linux-gpio
>
> The gpio-hog is more correct way follow if I'm not mistaken)
> - see gpiochip_request_own_desc().

You are right. It is not possible to rmmod module, as it is "in use"
all the time. I'll try with gpio_requst_own_desc().

>
> Another question, in commit message you refer to  power-button,
> but i do not see anything related in binding description.

We don't have power-button connected right to the processor. It is
connected to PMIC. During runtime we receive IRQs about power-button
from PMIC using i2c bus. The only purpose of this patch is to
configure processor's ext_wakeup line, which is triggered during
RTC-only mode (for example when power-button is pressed), causing
device wakeup. On the other hand, it is not possible to use ext_wakeup
during runtime, as we are only able to read it's status, but it
cannot trigger any interrupts.

>
> Shouldn't some gpio-key node be here, which will consume rtc-gpio?
>
>
>>>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>>>> index 3e84315..f013346 100644
>>>> --- a/drivers/rtc/Kconfig
>>>> +++ b/drivers/rtc/Kconfig
>>>> @@ -1208,7 +1208,7 @@ config RTC_DRV_IMXDI
>>>>
>>>>   config RTC_DRV_OMAP
>>>>       tristate "TI OMAP Real Time Clock"
>>>> -    depends on ARCH_OMAP || ARCH_DAVINCI || COMPILE_TEST
>>>> +    depends on (ARCH_OMAP || ARCH_DAVINCI || COMPILE_TEST) && GPIOLIB
>>>>       help
>>>>         Say "yes" here to support the on chip real time clock
>>>>         present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and
>>>> DRA7xx.
>>>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>>>> index ec2e9c5..56c7155 100644
>>>> --- a/drivers/rtc/rtc-omap.c
>>>> +++ b/drivers/rtc/rtc-omap.c
>>>> @@ -26,6 +26,8 @@
>>>>   #include <linux/pm_runtime.h>
>>>>   #include <linux/io.h>
>>>>   #include <linux/clk.h>
>>>> +#include <linux/gpio/driver.h>
>>>> +#include <linux/gpio/consumer.h>
>>>>
>>>>   /*
>>>>    * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
>>>> @@ -114,7 +116,11 @@
>>>>   #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN    BIT(1)
>>>>
>>>>   /* OMAP_RTC_PMIC bit fields: */
>>>> -#define OMAP_RTC_PMIC_POWER_EN_EN    BIT(16)
>>>> +#define OMAP_RTC_PMIC_POWER_EN_EN        BIT(16)
>>>> +#define OMAP_RTC_PMIC_EXT_WAKEUP_EN(x)        (BIT(x))
>>>> +#define OMAP_RTC_PMIC_EXT_WAKEUP_POL(x)        (BIT(x) << 4)
>>>> +#define OMAP_RTC_PMIC_EXT_WAKEUP_EN_MASK    (0x0F)
>>>> +#define OMAP_RTC_PMIC_EXT_WAKEUP_POL_MASK    (0x0F << 4)
>>>>
>>>>   /* OMAP_RTC_KICKER values */
>>>>   #define    KICK0_VALUE            0x83e70b13
>>>> @@ -141,6 +147,7 @@ struct omap_rtc {
>>>>       bool is_pmic_controller;
>>>>       bool has_ext_clk;
>>>>       const struct omap_rtc_device_type *type;
>>>> +    struct gpio_chip gpio_chip;
>>>>   };
>>>>
>>>>   static inline u8 rtc_read(struct omap_rtc *rtc, unsigned int reg)
>>>> @@ -183,6 +190,104 @@ static void default_rtc_lock(struct omap_rtc
>>>> *rtc)
>>>>   {
>>>>   }
>>>>
>>>> +static int omap_rtc_gpio_request(struct gpio_chip *chip,
>>>> +                unsigned int offset)
>>>> +{
>>>> +    struct omap_rtc *rtc = gpiochip_get_data(chip);
>>>> +    u32 val;
>>>> +
>>>> +    rtc->type->unlock(rtc);
>>>> +
>>>> +    val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>>>> +    val |= OMAP_RTC_PMIC_EXT_WAKEUP_EN(offset);
>>>> +    rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
>>>> +
>>>> +    rtc->type->lock(rtc);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void omap_rtc_gpio_free(struct gpio_chip *chip,
>>>> +            unsigned int offset)
>>>> +{
>>>> +    struct omap_rtc *rtc = gpiochip_get_data(chip);
>>>> +    u32 val;
>>>> +
>>>> +    rtc->type->unlock(rtc);
>>>> +
>>>> +    val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>>>> +    val &= ~OMAP_RTC_PMIC_EXT_WAKEUP_EN(offset);
>>>> +    rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
>>>> +
>>>> +    rtc->type->lock(rtc);
>>>> +}
>>>> +
>>>> +static int omap_rtc_gpio_get_direction(struct gpio_chip *chip,
>>>> +                unsigned int offset)
>>>> +{
>>>> +    return 1; /* Always in */
>>>> +}
>>>> +
>>>> +
>>>> +static int omap_rtc_gpio_direction_input(struct gpio_chip *chip,
>>>> +                    unsigned int offset)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int omap_rtc_gpio_get(struct gpio_chip *chip, unsigned int
>>>> offset)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Note: This function is called only when setting ext_wakeup polarity
>>>> + * with omap_rtc_gpio_set_polarity
>>>> + */
>>>> +static void omap_rtc_gpio_set(struct gpio_chip *chip, unsigned int
>>>> offset,
>>>> +            int value)
>>>> +{
>>>> +    struct omap_rtc *rtc = gpiochip_get_data(chip);
>>>> +    u32 val;
>>>> +
>>>> +    rtc->type->unlock(rtc);
>>>> +
>>>> +    val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>>>> +    if (value)
>>>> +        val |= OMAP_RTC_PMIC_EXT_WAKEUP_POL(offset);
>>>> +    else
>>>> +        val &= ~OMAP_RTC_PMIC_EXT_WAKEUP_POL(offset);
>>>> +    rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
>>>> +
>>>> +    rtc->type->lock(rtc);
>>>> +}
>>>> +
>>>> +static void omap_rtc_gpio_set_polarity(struct gpio_descs *ext_wakeup)
>>>> +{
>>>> +    struct gpio_desc *desc;
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < ext_wakeup->ndescs; i++) {
>>>> +        desc = ext_wakeup->desc[i];
>>>> +        gpiod_set_raw_value_cansleep(desc,
>>>> +                    gpiod_is_active_low(desc));
>>>> +    }
>>>> +}
>>>> +
>>>> +static struct gpio_chip template_chip = {
>>>> +    .label            = "omap-rtc-gpio",
>>>> +    .owner            = THIS_MODULE,
>>>> +    .request        = omap_rtc_gpio_request,
>>>> +    .free            = omap_rtc_gpio_free,
>>>> +    .get_direction        = omap_rtc_gpio_get_direction,
>>>> +    .direction_input    = omap_rtc_gpio_direction_input,
>>>> +    .get            = omap_rtc_gpio_get,
>>>> +    .set            = omap_rtc_gpio_set,
>>>> +    .base            = -1,
>>>> +    .ngpio            = 4,
>>>> +    .can_sleep        = true,
>>>> +};
>>>> +
>>>>   /*
>>>>    * We rely on the rtc framework to handle locking (rtc->ops_lock),
>>>>    * so the only other requirement is that register accesses which
>>>> @@ -533,6 +638,8 @@ static int omap_rtc_probe(struct platform_device
>>>> *pdev)
>>>>       const struct platform_device_id *id_entry;
>>>>       const struct of_device_id *of_id;
>>>>       int ret;
>>>> +    struct gpio_descs *ext_wakeup;
>>>> +    u32 ngpios = 0;
>>>>
>>>>       rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
>>>>       if (!rtc)
>>>> @@ -544,6 +651,10 @@ static int omap_rtc_probe(struct platform_device
>>>> *pdev)
>>>>           rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
>>>>                   of_property_read_bool(pdev->dev.of_node,
>>>>                           "system-power-controller");
>>>> +        ret = of_property_read_u32(pdev->dev.of_node, "ngpios",
>>>> +                    &ngpios);
>>>> +        if (ret)
>>>> +            ngpios = 0;
>>>>       } else {
>>>>           id_entry = platform_get_device_id(pdev);
>>>>           rtc->type = (void *)id_entry->driver_data;
>>>> @@ -577,6 +688,30 @@ static int omap_rtc_probe(struct platform_device
>>>> *pdev)
>>>>       pm_runtime_enable(&pdev->dev);
>>>>       pm_runtime_get_sync(&pdev->dev);
>>>>
>>>> +    if (ngpios > 0) {
>>>> +        rtc->gpio_chip = template_chip;
>>>> +        rtc->gpio_chip.parent = &pdev->dev;
>>>> +        rtc->gpio_chip.ngpio = ngpios;
>>>> +        ret = devm_gpiochip_add_data(&pdev->dev, &rtc->gpio_chip,
>>>> +                    rtc);
>>>> +        if (ret < 0) {
>>>> +            dev_err(&pdev->dev, "Could not register gpiochip, %d\n",
>>>> +                ret);
>>>> +            return ret;
>>>> +        }
>>>> +
>>>> +        ext_wakeup = devm_gpiod_get_array_optional(&pdev->dev,
>>>> +                        "ext-wakeup", GPIOD_IN);
>>>> +        if (IS_ERR(ext_wakeup)) {
>>>> +            ret = PTR_ERR(ext_wakeup);
>>>> +            dev_err(&pdev->dev,
>>>> +                "ext-wakeup request failed, ret %d\n", ret);
>>>> +            return ret;
>>>> +        }
>>>> +        if (ext_wakeup)
>>>> +            omap_rtc_gpio_set_polarity(ext_wakeup);
>>>> +    }
>>>> +
>>>>       rtc->type->unlock(rtc);
>>>>
>>>>       /*
>>>> --
>>>> 2.8.0
>>>>
>>
>
>

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
