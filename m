From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 12:18:06 -0600
Message-ID: <569694DE.5050709@ti.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113180006.GJ12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 12:00 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160113 09:30]:
>> On 01/13/2016 10:48 AM, Tony Lindgren wrote:
>>>
>>> So if we start changing things to GPIO mode, we really need some
>>> further explanations and neeed to handle the GPIO pin properly in
>>> the TWL driver. And it should be done in a separate patch for all
>>> of the TWL SoCs.
>>
>> That does not make sense to me. The original intent of MSECURE is to use
>> PMIC control (in specific certain usecases - which are no longer
>> relevant) in trustzone or equivalent secure processor modes. when such a
>> mode is not planned on being used, you just tell PMIC that it is always
>> in secure mode. In fact, there was discussion internally that MSECURE
>> should never even have been connected to SoC if the SoC was GP SoC - but
>> ofcourse, the want to have a consistent reference schematics for evms
>> (since EVMs have HS/Non-HS parts) trumped such talk.
>>
>> trying to split this up into further steps adds 0 additional
>> functionality - what is the pmic driver supposed to do with the GPIO even?
>>
>> in *real* HS product devices, in fact, the register space is really
>> firewalled out
> 
> Right, OK here we are finally getting some answers to the "why" part :)
> 
> And I also have few more "why" question in mind. If this change from
> msecure to GPIO muxing is so important.
> 
> Why it was never fixed in the mainline kernel for omap4 and omap5 and
> it was just sitting in various TI trees?
> 
> And it sounds like any kind of muxing on HS devices here for this
> pin will oops the device?
> 

It depends on what the secure firewall does - unfortunately HS devices
are basically lego blocks that way. In the original usecase where
specific function like MSECURE was desired, the 4k chunk for padconf
registers would be firewalled away and only setup for access from
trustzone or a specific "trusted" processor like IPU M3/DSP.

>> The last TI product kernel tree that seriously focussed on OMAP5/OMAP4
>> was
>> http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-linux-omap-3.4
>> things changed definitions (in terms of descope) since then.. but
>> anyways.. thought I'd just pitch it out here.
>>
>> sevm: - this board got scrapped
>> http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5evm.c;h=bd8d71d75cc3da921856bb2004230e4cd6505328;hb=refs/heads/p-linux-omap-3.4#l1097
>>
>> omap5-panda is the omap5uevm/evm now:
>> http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5panda.c;h=6113bc0e04625a1bd794b3f169581c67ad3b42ff;hb=refs/heads/p-linux-omap-3.4#l816
> 
> OK
> 
>>> I don't have anything against adding GPIO handling to the TWL driver
>>> so it can be optionally specified. But that's clearly a separate patch
>>
>> TWL/TPS driver will need no change in the proposal I made with "gpio
>> hog" mechanism (Documentation/devicetree/bindings/gpio/gpio.txt -
>> gpio-hog property) - just a dt change for the right configuration.
> 
> OK. So are we sure the TWL driver will never have to toggle this pin?
> 
> Again, that's another "why" that I have no clue about and that is not
> documented anywhere.
> 

It is not necessary for the functions we just described -MSECURE
function by itself is not something to be controlled by "non secure"
software (which is probably weird to us, but that is what security team
folks call HLOS like Linux). I dont recollect any recent product that
actually uses MSECURE the way we originally defined it. For the sake of
debate, Lets take a theoretical case where such a function might be
desired: in such a case, "non-secure" software should generate an SMC
service call into secure world for "setting RTC time"; When ARM enters
trustzone mode, MSECURE will be auto asserted by SoC. the secure
firmware will then have an I2C driver that will send a RTC set time
register access for the RTC time to be set.


In the above definition, we should not even have an TWL RTC driver,
instead a custom TWL-SMC-RTC driver will need to be written that will
access RTC on TWL/TPS over SMC calls to secure service. infact, if DSP
was desired for the "secure access", then a DSP-RPROC-RTC driver will
have to be written. The "generic definition" then became "MSECURE" and
was envisaged to protect further stuff eventually beyond RTC(I dont
recollect more than RTC unfortunately). In all such cases, you'd not use
MSECURE in GPIO mode - that will just defeat it's original purpose.
Instead you'd set it up as MSECURE in  secure boot software(even before
HLOS starts), then firewall the region off from access by non-secure
software, finally write a shim driver to send non-secure requests to the
secure world - which will determine who of the actors can actually do
which actions..

As you already see it is ridiculously round about way of protecting RTC
time.. but anyways, for what ever reason, that was mandatory function to
support on certain product lines.


I hope this helps.

>>> and should be done by somebody who knows more about the issue and has
>>> a test case needing the GPIO logic for this pin.
>>
>> Since my explanation does not seem to suffice, alright - we can wait for
>> the right person, then.
> 
> Sorry don't take it personally. I'm just trying to make sense of the
> "why do we need to do this change?" part. Especially if I need to make
> the change and write the commit log.

Not a problem, just trying to share what I can given that not all
thought process and background work that takes place inside TI is either
"logical" or in many cases fails to reach public documentation :( .

-- 
Regards,
Nishanth Menon
