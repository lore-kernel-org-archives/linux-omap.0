From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 2/2] ARM: dts: AM4372: add few nodes
Date: Fri, 16 Aug 2013 12:17:27 +0200
Message-ID: <520DFC37.3080601@baylibre.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com> <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com> <51FCEE60.7080809@ti.com> <51FF335D.4050803@ti.com> <20130810142317.GE18085@e106331-lin.cambridge.arm.com> <52088526.90004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61094 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab3HPKRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 06:17:32 -0400
Received: by mail-wi0-f176.google.com with SMTP id f14so631885wiw.15
        for <linux-omap@vger.kernel.org>; Fri, 16 Aug 2013 03:17:30 -0700 (PDT)
In-Reply-To: <52088526.90004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Mugunthan V N <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Hi Afzal,

On 12/08/2013 08:48, Afzal Mohammed wrote:
> Hi Mark,
>
> On Saturday 10 August 2013 07:53 PM, Mark Rutland wrote:
>
>>>>> +        mac: ethernet@4a100000 {
>>>>> +            compatible = "ti,am4372-cpsw","ti,cpsw";
>
>> One point worth mentioning is that the "ti,am4372-cpsw" string isn't
>> documented. Will the "ti,am4372-cpsw" binding definitely be a superset
>> of the "ti,cpsw" binding, and if you were to take the DT as of this
>> patch, and attempt to use it with a future kernel, can you guarantee
>> it'll work?
>
> "ti,am4372-cpsw" was not documented as OMAP DT maintainer didn't prefer
> documenting only for a new compatible.

My point was more that creating a new compatible for the exact same 
version of the IP is pointeless and could lead to tons of compatible 
strings that would never be used since this is always the exact same IP.

AFAIK, the rational is that we never know what will happen in the future 
and maybe, when a HW bug specific for that SoC will appear, we will have 
a way to differentiate that version.
Sure we never know what will be the future, but with rational like that 
we can quiclky clutter the kernel or the DTS with tons of useless data...

> For the only patch on this file that went into mainline, in that series
> actually I had posted patches to document "ti,am4372-*", but as
> maintainer didn't agree, it was discarded [A].
>
> Regarding whether "ti,am4372-cpsw" would be a superset of "ti,cpsw",
> information I have (am4372 is in pre silicon stage) is that it is a
> reuse from am335x ("ti,cpsw" should have been named "ti,am3352-cpsw" or
> something like that, but nothing can be done now) with minor changes and
> all existing functionalities available, Mugunthan can shed more light on
> this, Mugunthan ?

My second point is, even if we want to differentiate the IPs in various 
SoCs, using the name of the SoC in the IP compatible string is not a 
very good practice anyway.
What is relevant at driver level is most of the time the version of the 
IP. The fact that this is an am3352 or am4372 is irrelevant for the 
driver. With the exception of a different integration of the IP that 
might lead to some functionality change and thus could impact the driver.
But the fact that the ti,cpsw is integrated inside a SoC is already 
describe in the SoC DTS tree. A quick look of the hierarchy root will 
already provide the SoC name.

The current rule is thus enforcing the duplication in every nodes of a 
the exact same SoC name string whereas the information could be 
retrieved potentially from the root node.
This lead us to a bunch of useless strings in the DTS and a bunch of 
useless text in the bindings.

Bottom-line, I'm not challenging your patch, which is applying the 
current rules correctly, I'm challenging this rule that for my point of 
view is a little bit outdated. It was maybe good enough for small DTS 
file in the PPC world but is a source of unneeded overhead in our case 
for my point of view.

> As mentioned at other places in the thread, for cpsw, only a few
> properties to prevent hwmod code crash was added. I am sure that
> currently added properties for cpsw will not make driver functional this
> Kernel version (if this goes in) or future versions. To make driver work
> additional properties are required.
>
>>>> There are many other parameters which are missed here.
>>>
>>> Reason has been mentioned in the commit message, quoting relevant here
>>> again,
>>
>> Actually, as you've marked the nodes disabled, it's probably fine. But
>> worth considering as properties are added...
>
> There were two factors that was considered while adding cpsw node
> 1. DT as an ABI
> 2. While adding DT node, whether all existing required properties has to
> be added
>
> Regarding 1 - DT would not make driver work for this Kernel version and
> also for not any newer Kernel version, I believe this does not go
> against DT an an ABI, although in a negative sense. To make driver work
> more DT properties would have to be added.
>
> Regarding 2 - Currently, I believe most required & optional properties
> in bindings are defined w.r.t driver (bringing in a Linux attachment).
> If DT is only a hardware description, required & optional properties
> should correspond to something that are a must for hardware to work and
> additional features that can be used respectively. In that sense
> interrupts property for many of the peripherals would have to be
> considered optional, as it is possible to work in polling mode. And
> would it be practical for DT in most of the cases to be a complete
> hardware description ?, as to completely describe hardware, we may need
> to have a large amount of properties that may not be relevant to
> software. If requirement is only that DT should describe hardware that
> is relevant for software (this would bring in a software dependency for
> DT), required property for one software may not be required for another
> piece of software or may be an optional property (like in the case of
> interrupts as explained above).
>
> So conclusion arrived within me was that as long as properties are not
> modified, but only added and as long as it does not go against DT as an
> ABI, it is ok.
>
> I would like to hear from DT maintainers what the approach should be.

DT is clearly an ABI. It is there to provide HW information that are 
needed by the SW but cannot be extracted from the HW registers of from 
some ACPI table.

It could as well provide information about the HW hierarchy assuming 
this is relevant for the SW. That's typically why you do not have the 
full accurate description of the OMAP interconnects in DTS. That is just 
pointless for the SW point of view.

The goal is thus not to describe the full HW, which is anyway not 
realistic, but to provide the HW information needed by the SW.

And the driver is really the first one to know what is needed or not for 
a certain IP. Hence a dependency with the driver in term if binding 
definition.

Regards,
Benoit

