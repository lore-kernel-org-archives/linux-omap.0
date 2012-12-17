From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
Date: Mon, 17 Dec 2012 10:30:01 -0600
Message-ID: <50CF4889.5000408@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com> <1355348588-22318-3-git-send-email-jon-hunter@ti.com> <20121213174139.GA12946@mudshark.cambridge.arm.com> <50CA2ABA.1050600@ti.com> <20121217162055.GE16561@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56260 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab2LQQaZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 11:30:25 -0500
In-Reply-To: <20121217162055.GE16561@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>


On 12/17/2012 10:20 AM, Mark Rutland wrote:
> On Thu, Dec 13, 2012 at 07:21:30PM +0000, Jon Hunter wrote:
>>
>> On 12/13/2012 11:41 AM, Will Deacon wrote:
>>> On Wed, Dec 12, 2012 at 09:43:05PM +0000, Jon Hunter wrote:
>>>> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
>>>> The ARM Cross Trigger Interface provides a way to route events between
>>>> processor modules. For example, on OMAP4430 we use the CTI module to
>>>> route PMU events to the GIC interrupt module.
>>>>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/cti.txt |   32 +++++++++++++++++++++++++
>>>>  1 file changed, 32 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/arm/cti.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/cti.txt b/Documentation/devicetree/bindings/arm/cti.txt
>>>> new file mode 100644
>>>> index 0000000..4a0e2d3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/cti.txt
>>>> @@ -0,0 +1,32 @@
>>>> +* ARM Cross Trigger Interface (CTI)
>>>> +
>>>> +The ARM Cross Trigger Interface provides a way to route events between
>>>> +processor modules. For example, debug events from one processor can be
>>>> +broadcasted to other processors. The events that can be routed between
>>>> +processors are specific to the device.
>>>> +
>>>> +Required properties:
>>>> +
>>>> +- compatible:			Should be "arm,primecell".
>>>> +- interrupts:			Interrupt associated with CTI module.
>>>> +- reg:				Contains timer register address range (base
>>>> +				address and length).
>>>> +- arm,cti-name:			A unique name for the CTI module, that will be
>>>> +				used when requesting the CTI module instance.
>>>> +
>>>> +
>>>> +Optional properties:
>>>> +
>>>> +- arm-primecell-periphid:	Primecell peripheral ID associated with CTI
>>>> +				module.
>>>
>>> For multi-cluster systems, I wouldn't be surprised to see multiple CTI
>>> instances, each with different CPU affinities. Can we include an affinity
>>> property following Mark's proposed binding?
>>>
>>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137290.html
>>
>> Yes I can take a look. Would something like that be applicable to pmu as
>> well or is that unlikely to have different affinities? I am just
>> wondering if there is something that we should implement in general for
>> the various primecell components.
> 
> Do you mean for describing the PMU's affinity to the perf subsystem or its
> wiring to the CTI?

Yes the PMU's affinity in general, ignoring CTI for now.

> It's certainly applicable for the former; I've been working on a series to
> enable support for the PMUs in both clusters in a A15x2 A7x3 coretile using the
> binding, and I intend to post a series shortly. I'm not sure about the latter,
> as I don't have much of an understanding about the CTI.

Ok great. I think that this use-case of PMU+CTI is a special case for
OMAP. CTI could be used for many things and for some reason TI hooked up
the PMU interrupt via the CTI on OMAP4430 (which has been giving me
grief ;-)

So if there is a general way to describe the affinity of a module, such
as PMU, I could re-use this and add to the CTI binding as Will suggested.

> I'm not sure how many other components have affinity concerns, but the
> intention is for the binding to be reusable.

Great.

Thanks
Jon
