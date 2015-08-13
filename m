From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 00/22] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Thu, 13 Aug 2015 10:13:53 +0300
Message-ID: <55CC43B1.4020409@ti.com>
References: <1438938752-31010-1-git-send-email-rogerq@ti.com> <20150811124829.GM4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811124829.GM4215-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 11/08/15 15:48, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150807 02:15]:
>> Hi,
>>
>> We do a couple of things in this series which result in
>> cleaner device tree implementation, faster perfomance and
>> multi-platform support. As an added bonus we get new GPI/Interrupt pins
>> for use in the system.
>>
>> - Establish a custom interface between NAND and GPMC driver. This is
>> needed because all of the NAND registers sit in the GPMC register space.
>> Some bits like NAND IRQ are even shared with GPMC.
>>
>> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
>> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
>> This causes performance increase when using prefetch-irq mode.
>> 30% increase in read, 17% increase in write in prefetch-irq mode.
>>
>> - Clean up device tree support so that omap-gpmc IP and the omap2 NAND
>> driver can be used on non-OMAP platforms. e.g. Keystone.
>>
>> - Implement GPIOCHIP + IRQCHIP for the GPMC WAITPINS. SoCs can contain
>> 2 to 4 of these and most of them would be unused otherwise. It also
>> allows a cleaner implementation of NAND Ready pin status for the NAND driver.
>>
>> - Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
> 
> Nice job :) Using GPIOCHIP + IRQCHIP allows us to make the GPMC
> using drivers pretty much generic eventually.

Thanks :)
>  
>> NOTE: I've only adapted dra7.dtsi and dra7x-evms for this series.
>> I will adapt all other boards when the series is in a shape to be accepted.
> 
> OK. Yeah let's make sure no regressions are caused by this.. We also
> still have the omap3 legacy booting around, have you checked that it
> keeps on working?

I don't have any omap3 board with legacy support with me. I have omap3-beagle
but looks like legacy boot is dropped for it already.

I'll try to revert the patch that drops beagle support and test it on that one.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
