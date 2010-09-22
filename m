From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Wed, 22 Sep 2010 10:24:53 +0200
Message-ID: <4C99BD55.3070706@compulab.co.il>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il> <1285084993-27683-4-git-send-email-grinberg@compulab.co.il> <AANLkTin+canp9yrE-Jmv=n56dPFByZWU73uaRNBkruP6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:42801 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab0IVIZD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 04:25:03 -0400
In-Reply-To: <AANLkTin+canp9yrE-Jmv=n56dPFByZWU73uaRNBkruP6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

 On 09/21/10 18:26, Gadiyar, Anand wrote:
> On Tue, Sep 21, 2010 at 9:33 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> add support for hsusb host ports 1, 2 and on-module usb hub.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/mach-omap2/board-cm-t3517.c |   50 ++++++++++++++++++++++++++++++++++
> ...
>
>> @@ -100,6 +102,47 @@ static void __init cm_t3517_init_rtc(void)
>>  static inline void cm_t3517_init_rtc(void) {}
>>  #endif
>>
>> +#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
> Hi Igor,

Hi

> Do we really need to make these conditional on the driver being built?

This is depends on what are we trying to achieve...
I can think of two things:
[1] Simple, clear and nice code without ifdefs
[2] Smaller kernel, a bit less resources wasted and a bit faster boot time

> The hardware is present on the board at all times, right?

Yes, it is inside the SoC, except for the usb hub.

> It should be okay to execute this code independent of whether
> the driver is built or not. The device registration can be unconditional
> and if there is no driver present, we won't probe anyway.

It is ok, but again it depends on what we are trying to achieve here.

If we want [1], then indeed we need to remove the ifdefs also inside usb-ehci.c,
so pros:
 * we'll get nice and clean code,
cons:
 * a bit bigger kernel,
 * "floating" device without a driver,
 * a bit resources wasted for this device,
 * a bit slower startup time (device registration, gpio toggling, etc.).

If we want [2], then we'll have the opposite of [1] ;)

Personally, I don't mind either way... ,
but I want the code to be consistent (in this case with usb-ehci.c).

> (I see some similar logic in usb-ehci.c - probably a good idea to remove
> it as well).

...

> - Anand
>
>> +#define HSUSB1_RESET_GPIO      (146)
>> +#define HSUSB2_RESET_GPIO      (147)
>> +#define USB_HUB_RESET_GPIO     (152)
>> +
>> +static struct ehci_hcd_omap_platform_data cm_t3517_ehci_pdata __initdata = {
>> +       .port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
>> +       .port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
>> +       .port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
>> +
>> +       .phy_reset  = true,
>> +       .reset_gpio_port[0]  = HSUSB1_RESET_GPIO,
>> +       .reset_gpio_port[1]  = HSUSB2_RESET_GPIO,
>> +       .reset_gpio_port[2]  = -EINVAL,
>> +};
>> +
>> +static int cm_t3517_init_usbh(void)
>> +{
>> +       int err;
>> +
>> +       err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
>> +       if (err) {
>> +               pr_err("CM-T3517: usb hub rst gpio request failed: %d\n", err);
>> +       } else {
>> +               gpio_direction_output(USB_HUB_RESET_GPIO, 0);
>> +               udelay(10);
>> +               gpio_set_value(USB_HUB_RESET_GPIO, 1);
>> +               msleep(1);
>> +       }
>> +
>> +       usb_ehci_init(&cm_t3517_ehci_pdata);
>> +
>> +       return 0;
>> +}
>> +#else
>> +static inline int cm_t3517_init_usbh(void)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.

