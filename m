From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Mon, 1 Apr 2013 22:05:00 +0200
Message-ID: <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
References: <1364631689.3767.7.camel@mars> <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
 <1364834508.3939.74.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:57887 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759102Ab3DAUF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 16:05:26 -0400
Received: by mail-ve0-f175.google.com with SMTP id pb11so2938682veb.6
        for <linux-omap@vger.kernel.org>; Mon, 01 Apr 2013 13:05:25 -0700 (PDT)
In-Reply-To: <1364834508.3939.74.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, Apr 1, 2013 at 6:41 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> Hi Javier
>
> On Sat, 2013-03-30 at 14:18 +0100, Javier Martinez Canillas wrote:
>> A call to gpio_request() to enable the GPIO bank is needed before
>> using a GPIO as an IRQ source, otherwise accesses to the GPIO bank
>> registers fails making the kernel to hang.
>
> Yes, that is exactly my problem here. I'm using the GPIO as an IRQ
> source.
>
>> Jon's (added as cc)"gpio/omap: warn if bank is not enabled on setting
>> irq type" patch [1] fixes the issue by warning and returning -EINVAL.
>>
>> This patch will make the kernel to boot but the call to request_irq()
>> will fail of course. For now, the only solution is to call
>> gpio_request() before request_irq() in your platform code or device
>> driver. There is an on going discussion about what's the better way to
>> address this but we still haven't found a good solution to this
>> problem, you can see the last email for this discussion here [2]
>>
>> Also, even when calling gpio_request() before request_irq() this won't
>> work. When specifying the trigger/level flags on the second cell for
>> an GPIO-IRQ, this is not set on the IORESOURCE_IRQ struct resource.
>> The IRQ flag is set on of_irq_to_resource() but it just does:
>>
>> r->flags = IORESOURCE_IRQ;
>>
>> and then the call stack is irq_to_parse_and_map() ->
>> irq_set_irq_type() ->  __irq_set_trigger() -> chip->irq_set_type() ->
>> (drivers/gpio/gpio-omap.c) gpio_irq_type().
>>
>> So, even when gpio_irq_type() receive the correct flags, this are not
>> returned neither stored on the flags member of the IORESOURCE_IRQ
>> struct resource that passed to the drivers in their struct
>> platform_device.
>
> As a quick-fix (hack) I wrote directly to the registers in gpio_probe()
> to enable GPIO banks. I now geht this:
>
>> > [    0.214630] omap_gpio_probe, 1133, CM_CLKSEL_PER 0x48005040: 0x000000ff
>> > [    0.214660] omap_gpio_probe, 1136, CM_ICLKEN_PER 0x48005010: 0x0007ffff
>> > [    0.214660] omap_gpio_probe, 1139, CM_FCLKEN_PER 0x48005000: 0x0007ffff
>
> And it works for me. _But_ when I do enable regulator twl4030
> (CONFIG_REGULATOR_TWL4030=y) in my config these registers get reset:
>
> [    2.935455] smsc911x_open, 1537, CM_CLKSEL_PER 0x48005040: 0x000000ff
> [    2.942291] smsc911x_open, 1540, CM_ICLKEN_PER 0x48005010: 0x00040fff
> [    2.949066] smsc911x_open, 1543, CM_FCLKEN_PER 0x48005000: 0x00000000
>
> And the IRQ source for the network chip (smsc911x) is disabled :-(
>
> Do you have any idea how to ("quick") fix this?
>

A quick hack is to call gpio_request() explicitly before calling to
irq_set_type() is made.
I've this patch just to make it work until we find a clean solution:

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 90c15ee..d594e1d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -14,6 +14,7 @@
  */
 #undef DEBUG

+#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -1528,6 +1529,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
                return ret;
        }

+       ret = gpio_request_one(176, GPIOF_IN, "smsc911x irq");
+       if (ret) {
+               pr_err("Failed to request IRQ GPIO%d\n", 176);
+               return ret;
+       }
+
        for_each_node_by_name(child, "nand") {
                ret = gpmc_probe_nand_child(pdev, child);
                if (ret < 0) {

This solves the issue of the non-initialized GPIO bank before that
makes the kernel to hang. Since I've to configure the IRQ polarity as
active low level-sensitive on my board and the flags are not set by
the IRQ core, I've another ugly hack that forces this:

diff --git a/drivers/net/ethernet/smsc/smsc911x.c
b/drivers/net/ethernet/smsc/smsc
index da5cc9a..27e46f9 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2390,6 +2390,9 @@ static int smsc911x_drv_probe(struct
platform_device *pdev)
        pdata = netdev_priv(dev);
        dev->irq = irq_res->start;
-        irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
+       irq_flags = IRQF_TRIGGER_LOW;
        pdata->ioaddr = ioremap_nocache(res->start, res_size);

        pdata->dev = dev;

>  Thanks
>   -- Christoph
>

I hope to find some time this week to work on this and at least find a
solution for the second issue (IORESOURCE_IRQ struct resource flags
not being set).

Best regards,
Javier
