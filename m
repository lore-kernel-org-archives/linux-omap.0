From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH RFC 1/7] platform: add a device node
Date: Mon, 18 Feb 2013 13:51:03 +0000
Message-ID: <CACxGe6sBgXVYVhEyUKnwLDziWCe3973BO4KWNyTye0k9wgbKDA@mail.gmail.com>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk>
 <20130210010246.GA1455@kroah.com> <5116FCA1.40703@collabora.co.uk>
 <20130210093708.GL17852@n2100.arm.linux.org.uk> <CAAwP0s0fCJmUfTJweGhXj5bXsQ0Gov9JbUJtqYMwL7duNLZv_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46223 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3BRNvb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 08:51:31 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so7338362ieb.29
        for <linux-omap@vger.kernel.org>; Mon, 18 Feb 2013 05:51:31 -0800 (PST)
In-Reply-To: <CAAwP0s0fCJmUfTJweGhXj5bXsQ0Gov9JbUJtqYMwL7duNLZv_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Feb 10, 2013 at 11:35 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> On Sun, Feb 10, 2013 at 10:37 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Sun, Feb 10, 2013 at 02:49:21AM +0100, Javier Martinez Canillas wrote:
>>> I knew this would be controversial and that's why I didn't mean it to be a patch
>>> but a RFC :)
>>>
>>> The problem basically is that you have to associate the platform device with its
>>> corresponding DT device node because it can be used in the driver probe function.
>>
>> When DT is being used, doesn't DT create the platform devices for you,
>> with the device node already set correctly?
>>
>
> Well they usually do but not always just like usually you have a
> platform_device in your board code and call platform_device_register().
>
> But in some configurations you can't just define the platform_device
> required resources (I/O memory, IRQ, etc) as static platform data.
> In some cases you need a level of indirection.
>
> In this particular case a SMSC ethernet chip is connected to an
> OMAP3 processor through its General-Purpose Memory Controller.
>
> You can't just define the I/O memory used by the device since you first
> need to request that address to the GPMC. The same happens with the
> IRQ line since a OMAP GPIO pin is used so you have to first configure
> the GPIO line as input.
>
> So in platform code you call to gpmc_smsc911x_init() passing all the
> GPMC specific configurations (GPIO used for IRQ, GPMC chip select, etc)
>
> Then gpmc_smsc911x_init() does all the needed setup, fills a platform_data
> for the real platform_device and calls  platform_device_register_resndata().
>
> From the smsc911x platform_driver probe function point of view it just have
> resources and doesn't know if it's I/O memory is directly mapped or is
> through a memory controller as the GPMC. It also doesn't know if the IRQ is
> a GPIO or not.

It's still the same difference as far as the device is concerned.
External bus chip-select lines are well understood. The key here is to
encode the CS line number into the reg property of the child node so
that the GPMC driver has the information it needs to configure the
chip selects. You do this by setting #address-cells to '2' in the GPMC
node, and  use the ranges property to map from the gpmc address space
to the cpu address space. Like so (if you had 2 Ethernet controllers)

        gpmc {
                #address-cells = <2>;  // First cell is CS#, second
cell is offset from CS base
                #size-cells = <1>;
                compatible = "ti,gpmc";
                ranges = <0 0 0xf1000000 0x1000>, //CS0 mapped to
0xf1000000..0xf1000fff
                                <1 0 0xf1001000 0x1000>; //CS1 mapped
to 0xf1001000..0xf1001fff

                ethernet@0,0 {
                        compatible = "smsc,91c111";
                        reg = <0 0 0x1000>;
                }
                ethernet@1,0 {
                        compatible = "smsc,91c111";
                        reg = <1 0 0x1000>;
               }
      }

The GPMC driver can use the information in the ranges property for
setting up the chip select mappings. For the smsc,91c111 driver the
mapping becomes transparent.

You can see another example of this in
arch/powerpc/boot/dts/media5200.dts in the localbus node.

g.
