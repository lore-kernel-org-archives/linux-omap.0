From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Wed, 20 Jun 2012 18:35:56 -0500
Message-ID: <4FE25E5C.9020908@ti.com>
References: <4FD8A906.8080202@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com> <4FD9E5AF.6010201@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com> <4FDA3464.4040704@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com> <20120615124520.GS12766@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E99A9E7@DBDE01.ent.ti.com> <20120620132848.GK12766@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E99D1C5@DBDE01.ent.ti.com> <20120620151221.GT12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45341 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744Ab2FTXfz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 19:35:55 -0400
In-Reply-To: <20120620151221.GT12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 06/20/2012 10:12 AM, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120620 07:57]:
>> Hi Tony,
>>
>> On Wed, Jun 20, 2012 at 18:58:49, Tony Lindgren wrote:
>>> * Mohammed, Afzal <afzal@ti.com> [120616 02:19]:
>>>> On Fri, Jun 15, 2012 at 18:15:20, Tony Lindgren wrote:
>>
>>>> By gpmc registration, if you meant registering platform device for
>>>> gpmc peripherals, for a board that uses the new gpmc driver interface*,
>>>> it will be done in probe only.
>>>
>>> I was thinking when the gpmc needs to be initialized, and there should
>>> not be any need to do it earlier than at the gpmc using driver probe
>>> time. With device tree that is, as there's no need to stuff the gpmc
>>> timings into a board-*.c file.
>>
>> I believe by "gpmc needs to be initialized", you meant calculating gpmc
>> timings, determining configuration, the things that are done in functions
>> like gpmc_smsc911x_update etc. as in [1] and not initializing gpmc at
>> hardware level. With the above assumption, I feel we need to have a way
>> first to generalize gpmc timing calculation for different peripherals as
>> suggested by Jon as well as have logic to handle timings that depends on
>> cycles too.
> 
> Yup. We'll be only getting the timings from device tree. Ideally the gpmc
> code would just do all the calculations, but it sounds like device timings
> may require some calculation on the gpmc consumer driver side too.
> 
>>>>> It may require some bus level hooks, or wrapper drivers for the generic
>>>>> device drivers like smsc911x.
>>>>
>>>> This too, not sure whether I follow you
>>>
>>> Well smsc911x has device tree binding, and is a generic driver. How do
>>> we trigger the gpmc initialization from a generic driver probe?
>>
>> Not sure whether device tree have capability to represent something like
>> child devices, if non bus devices can have child devices, then we
>> can have peripherals connected to gpmc as childs, but may be this will
>> remain only as a dream; I need to get into DT to find things out
> 
> Yes the that's there set up automatically. But for the timings we
> could have something like this to associate the following invented
> gpmc timings with smsc911x:
> 
> /* in omap[234].dtsi */
> gpmc: gpmc@480121234 {
> 	compatible = "ti,gpmc";
> 	reg = <0x480121234 0x1234>;
> 	#address-cells = <0>;
> 	#size-cells = <0>;
> };
> ...
> 
> /* in some board *.dts file */
> &gpmc {
> 	gpmc_cs1: gpmc_cs1_timings {
> 		...
> 	};
> };
> 
> net@48001234 {
> 	compatible = "smsc,lan91c111";
> 	reg = <0x48001234 0x10000>;
> 	interrupts = <12>;
> 	gpmc_timings = <&gpmc_cs1>;
> };

The above make sense to me, but I am struggling to see how we can make
the above work with the proposed driver Afzal has created. The problem
is how devices are getting registered with Afzal's driver in comparison
to how device tree will register them.

In Afzal's driver the gpmc_probe() is going to request and configure the
chip-selects and if successful, then call platform_device_register() to
register the child devices. So all child devices get registered during
the gpmc_probe() itself.

With device tree, my understanding is that, it will first register the
gpmc device and then the children afterwards. In other words, the
gpmc_probe will be called first and the children registered/probed after.

Therefore, I am wondering if Afzal's driver needs to register the gpmc
devices outside of the gpmc_probe() and add the devices as children. Or
maybe we tackle that when we migrate it to DT.

>>>>> We should not need to pass clock handles around. It's better to
>>>>> export some helper functions in the gpmc code for the calculation.
>>>>
>>>> Currently we have helper function in gpmc.c for the same, were you
>>>> referring those ?
>>>
>>> Yes something that let's the driver call gpmc code to do the calculation.
>>> The other option would be to just add gpmc clock as a clock fwk node,
>>> and then the driver could clk_get() it as ick.
>>
>> For gpmc driver to calculate timings rather than platform code doing it,
>> we first need to have a generalized way to calculate gpmc timings for
>> all peripherals as well as have a logic to calculate timings based on
>> time & cycles, correct ? (to make sure we are talking the same thing)
> 
> Yes that might be tricky..

I am wondering more and more if we need to do a clean-up of the timing
calculations prior to driver migration ...

Cheers
Jon
