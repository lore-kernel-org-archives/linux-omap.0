From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Tue, 6 Oct 2015 12:54:58 +0300
Message-ID: <56139A72.6040600@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <560BC0DB.5020205@ti.com> <20151006083346.GL23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151006083346.GL23801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/10/15 11:33, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150930 04:04]:
>> Tony,
>>
>> On 18/09/15 17:53, Roger Quadros wrote:
>>> Hi,
>>>
>>> We do a couple of things in this series which result in
>>> cleaner device tree implementation, faster perfomance and
>>> multi-platform support. As an added bonus we get new GPI/Interrupt pins
>>> for use in the system.
>>>
>>> - Establish a custom interface between NAND and GPMC driver. This is
>>> needed because all of the NAND registers sit in the GPMC register space.
>>> Some bits like NAND IRQ are even shared with GPMC.
>>>
>>> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
>>> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
>>> This causes performance increase when using prefetch-irq mode.
>>> 30% increase in read, 17% increase in write in prefetch-irq mode.
>>>
>>> - Clean up device tree support so that omap-gpmc IP and the omap2 NAND
>>> driver can be used on non-OMAP platforms. e.g. Keystone.
>>>
>>> - Implement GPIOCHIP + IRQCHIP for the GPMC WAITPINS. SoCs can contain
>>> 2 to 4 of these and most of them would be unused otherwise. It also
>>> allows a cleaner implementation of NAND Ready pin status for the NAND driver.
>>>
>>> - Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
>>>
>>> This series is available at
>>> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git
>>> in branch
>>> for-v4.4/gpmc-v3
> 
> In general, very nice work :)

Thanks :)

> 
>> I've verified this series with the following boards
>> -dra7-evm
>> -am437x-gp-evm
>> -am335x-evm
>> -beagleboard-c4
>>
>> For legacy boot I've checked only on beagleboard-c4.
> 
> Great.
> 
> Does build and boot and use NAND work throughtout the series?
> Otherwise we'll have hard time bisecting anything..

Yes it does with the following exceptions.

- Patch 7 "memory: omap-gpmc: Remove NAND IRQ code" breaks prefetch-irq mode
but none of the boards seem to be using it so it shouldn't break NAND on existing boards.
At patch 9 "mtd: nand: omap2: manage NAND interrupts" prefetch-irq mode is working again.
Do you want me to squash patches 7,8,9 so that pre-fetch irq is not broken at any point?

- Then at patch 11 "mtd: nand: omap: Clean up device tree support" we break NAND on all DT
boards as we expect NAND to be a real child node with compatible id. Simply applying the
DT patch at this point makes it work again.

> 
>> Test procedure was to read an existing ubifs partition,
>> create a new one and read it back.
>>
>> Need you to Ack if it looks good.
>> Do you mind taking it via omap-soc once MTD maintainers ack their relevant parts?
> 
> Sure. I'll try to do some testing on the series first too.
> 
Thanks.

> Can the dts changes be merged separtely? Otherwise we'll have
> a dependency between dts branch and the GPMC/NAND changes.

I'm afraid no. Patch 11 makes us incompatible with the old DT.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
