From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Wed, 13 Jan 2016 19:08:46 +0100
Message-ID: <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com> <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com> <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com> <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com> <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com> <56966558.1070608@ti.com> <569669C5.2070200@ti.com> <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com> <20160113180006.GJ12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160113180006.GJ12777-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Am 13.01.2016 um 19:00 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:

> * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160113 09:30]:
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

After studying the Palmas TRM it appears that this pin just should be "high"
to be able to write to RTC and some scratchpad register. If the Palmas OTP
is programmed to use gpio7 as msecure input.

Since the scratchpad is not used we can permanently enable msecure. Which
means that we must somehow get the driving output to be "1".

This can be either done by
* a gpio with pull-up - switched to input mode as I proposed, or
* a real gpio output which is actively set to value 1 in u-boot or kernel driver, or
* the not well documented feature of MUX_MODE1 (OMAP5), other MUX_MODEs for OMAP3/4.

For my application we do not need to change the msecure state. We just need
to be able to write the rtc. And since the gpio7 of the Palmas is connected to
gpio8_234 of the OMAP5 we just have to initialize it properly once.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
