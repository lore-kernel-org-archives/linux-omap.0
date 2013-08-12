From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: AM4372: add few nodes
Date: Mon, 12 Aug 2013 12:18:06 +0530
Message-ID: <52088526.90004@ti.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com> <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com> <51FCEE60.7080809@ti.com> <51FF335D.4050803@ti.com> <20130810142317.GE18085@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab3HLGsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 02:48:50 -0400
In-Reply-To: <20130810142317.GE18085@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Hi Mark,

On Saturday 10 August 2013 07:53 PM, Mark Rutland wrote:

>>>> +		mac: ethernet@4a100000 {
>>>> +			compatible = "ti,am4372-cpsw","ti,cpsw";

> One point worth mentioning is that the "ti,am4372-cpsw" string isn't
> documented. Will the "ti,am4372-cpsw" binding definitely be a superset
> of the "ti,cpsw" binding, and if you were to take the DT as of this
> patch, and attempt to use it with a future kernel, can you guarantee
> it'll work?

"ti,am4372-cpsw" was not documented as OMAP DT maintainer didn't prefer 
documenting only for a new compatible.

For the only patch on this file that went into mainline, in that series 
actually I had posted patches to document "ti,am4372-*", but as 
maintainer didn't agree, it was discarded [A].

Regarding whether "ti,am4372-cpsw" would be a superset of "ti,cpsw", 
information I have (am4372 is in pre silicon stage) is that it is a 
reuse from am335x ("ti,cpsw" should have been named "ti,am3352-cpsw" or 
something like that, but nothing can be done now) with minor changes and 
all existing functionalities available, Mugunthan can shed more light on 
this, Mugunthan ?

As mentioned at other places in the thread, for cpsw, only a few 
properties to prevent hwmod code crash was added. I am sure that 
currently added properties for cpsw will not make driver functional this 
Kernel version (if this goes in) or future versions. To make driver work 
additional properties are required.

>>> There are many other parameters which are missed here.
>>
>> Reason has been mentioned in the commit message, quoting relevant here
>> again,
>
> Actually, as you've marked the nodes disabled, it's probably fine. But
> worth considering as properties are added...

There were two factors that was considered while adding cpsw node
1. DT as an ABI
2. While adding DT node, whether all existing required properties has to 
be added

Regarding 1 - DT would not make driver work for this Kernel version and 
also for not any newer Kernel version, I believe this does not go 
against DT an an ABI, although in a negative sense. To make driver work 
more DT properties would have to be added.

Regarding 2 - Currently, I believe most required & optional properties 
in bindings are defined w.r.t driver (bringing in a Linux attachment). 
If DT is only a hardware description, required & optional properties 
should correspond to something that are a must for hardware to work and 
additional features that can be used respectively. In that sense 
interrupts property for many of the peripherals would have to be 
considered optional, as it is possible to work in polling mode. And 
would it be practical for DT in most of the cases to be a complete 
hardware description ?, as to completely describe hardware, we may need 
to have a large amount of properties that may not be relevant to 
software. If requirement is only that DT should describe hardware that 
is relevant for software (this would bring in a software dependency for 
DT), required property for one software may not be required for another 
piece of software or may be an optional property (like in the case of 
interrupts as explained above).

So conclusion arrived within me was that as long as properties are not 
modified, but only added and as long as it does not go against DT as an 
ABI, it is ok.

I would like to hear from DT maintainers what the approach should be.

Regards
Afzal

[A] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg89408.html

