From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 11:29:19 -0600
Message-ID: <5696896F.4090309@ti.com>
References: <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com>
 <20160108190457.GY12777@atomide.com>
 <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160113164856.GF12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Nishanth Menon <nm@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 10:48 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [160113 07:15]:
>> On 01/13/2016 04:55 PM, Nishanth Menon wrote:
>>> On 01/13/2016 04:25 AM, H. Nikolaus Schaller wrote:
>>>>
>>>> I wonder now what MODE1 is.
>>>>
>>>> In my OMAP5 TRM (Version "Y" - may be too old) the MODE1 is tagged as "reserved".
>>>>
>>>> Maybe "reserved" happens to output a "1" on OMAP5 and a "0" on the X15?
> 
> The 5430 data manual I listed in the commit states mode 1 is for
> msecure. It is unlikely it got changed for 5432 as the mux registers
> tend to stay the same for most part across a SoC generation with just
> devices being enabled or disabled.

Again - it depends on NDA or non-NDA version of the TRM being refered to.

> 
> For beagle-x15, the msecure is now called "powerhold" and seems to
> have some additional or different functionality in the PMIC. So
> that's a separate issue from this one.

powerhold is NOT the same as msecure. the PMICs for X15 and O5, though
they share the same pedigree, are NOT the same. there are distinct
changes done in both PMIC definition, functionality and markets being
targeted by the PMIC.

> 
>>>> And as far as I am aware there is no "driver" for some MSECURE module (but I don't know the details of MSECURE control by software).
>>>
>>> Good catch. This one is interesting. If my memory serves me right,
>>> MSECURE signal from SoC is triggered in secure mode (trustzone) - the
>>> requirement was that certain PMIC modifications should only be done in
>>> secure mode for certain product applications. What this means is that
>>> certain functions of the PMIC will be unavailable when the SoC is
>>> running in "untrusted" mode.
>>>
>>> Instead, the usual mode of operation is to set it up as GPIO (as Nikolas
>>> pointed below) and either use GPIO HOG or default weak pull to keep it
>>> in the required state.
>>>
>>> I think it is better to set it as GPIO than as DRM_MSECURE.
> 
> Well we do have the data manual saying it's the msecure pin, and
> we are muxing it to msecure for omap4 in twl6030_omap4.dtsi. And a
> TI commit has used msecure mode for GP omap5 evm at least here:
> 
> https://gitlab.com/ubuntu-omap/u-boot-omap5/commit/dcc5279ffe880e874abb4d7f95302a34ab4968ca

We used to have High security devices previously (before those got
scrapped).

> 
> I've added Keerthy to Cc, maybe he knows how this should be handled
> in the long run?
> 
> So if we start changing things to GPIO mode, we really need some
> further explanations and neeed to handle the GPIO pin properly in
> the TWL driver. And it should be done in a separate patch for all
> of the TWL SoCs.

That does not make sense to me. The original intent of MSECURE is to use
PMIC control (in specific certain usecases - which are no longer
relevant) in trustzone or equivalent secure processor modes. when such a
mode is not planned on being used, you just tell PMIC that it is always
in secure mode. In fact, there was discussion internally that MSECURE
should never even have been connected to SoC if the SoC was GP SoC - but
ofcourse, the want to have a consistent reference schematics for evms
(since EVMs have HS/Non-HS parts) trumped such talk.

trying to split this up into further steps adds 0 additional
functionality - what is the pmic driver supposed to do with the GPIO even?

in *real* HS product devices, in fact, the register space is really
firewalled out


> 
>>> This is probably also the reason why this mode is NOT in public TRM -
>>> all security related topics are probably in the NDA only secure TRM
>>> addendum.
> 
> Right, probably the msecure pin has been set reserved in the public TRM
> because of whatever NDA reasons there might be to not allow writes to RTC.
> 

Unfortunately, the norm inside TI, anything that remotely sounds
"secure" gets wrapped up in NDA and triple signed blah blah.. I cant
explain the rationale for why such a definition came on RTC.


>>> I'd suggest setting up a GPIO hog and a mux to GPIO for board-common (we
>>> are not doing any HS OMAP5 at least in public domain :) ).
>>
>> Yeah. As I remember the same issue was with OMAP4 (twl6030_omap4.dtsi)
>> and, again if i remember correctly, someone reported that sys_drm_msecure might have different values
>> on different SoCs. Also I'd like to note that on Old non-DT kernel such functionality
>> was always modeled using GPIO.
> 
> Care to dig up some more information on that?


The last TI product kernel tree that seriously focussed on OMAP5/OMAP4
was
http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-linux-omap-3.4
things changed definitions (in terms of descope) since then.. but
anyways.. thought I'd just pitch it out here.

sevm: - this board got scrapped
http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5evm.c;h=bd8d71d75cc3da921856bb2004230e4cd6505328;hb=refs/heads/p-linux-omap-3.4#l1097

omap5-panda is the omap5uevm/evm now:
http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5panda.c;h=6113bc0e04625a1bd794b3f169581c67ad3b42ff;hb=refs/heads/p-linux-omap-3.4#l816

> 
> I don't have anything against adding GPIO handling to the TWL driver
> so it can be optionally specified. But that's clearly a separate patch

TWL/TPS driver will need no change in the proposal I made with "gpio
hog" mechanism (Documentation/devicetree/bindings/gpio/gpio.txt -
gpio-hog property) - just a dt change for the right configuration.


> and should be done by somebody who knows more about the issue and has
> a test case needing the GPIO logic for this pin.
> 

Since my explanation does not seem to suffice, alright - we can wait for
the right person, then.


-- 
Regards,
Nishanth Menon
