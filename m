From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
Date: Thu, 13 Dec 2012 13:21:30 -0600
Message-ID: <50CA2ABA.1050600@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com> <1355348588-22318-3-git-send-email-jon-hunter@ti.com> <20121213174139.GA12946@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36587 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755598Ab2LMTVu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Dec 2012 14:21:50 -0500
In-Reply-To: <20121213174139.GA12946@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>


On 12/13/2012 11:41 AM, Will Deacon wrote:
> On Wed, Dec 12, 2012 at 09:43:05PM +0000, Jon Hunter wrote:
>> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
>> The ARM Cross Trigger Interface provides a way to route events between
>> processor modules. For example, on OMAP4430 we use the CTI module to
>> route PMU events to the GIC interrupt module.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/cti.txt |   32 +++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/cti.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cti.txt b/Documentation/devicetree/bindings/arm/cti.txt
>> new file mode 100644
>> index 0000000..4a0e2d3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/cti.txt
>> @@ -0,0 +1,32 @@
>> +* ARM Cross Trigger Interface (CTI)
>> +
>> +The ARM Cross Trigger Interface provides a way to route events between
>> +processor modules. For example, debug events from one processor can be
>> +broadcasted to other processors. The events that can be routed between
>> +processors are specific to the device.
>> +
>> +Required properties:
>> +
>> +- compatible:			Should be "arm,primecell".
>> +- interrupts:			Interrupt associated with CTI module.
>> +- reg:				Contains timer register address range (base
>> +				address and length).
>> +- arm,cti-name:			A unique name for the CTI module, that will be
>> +				used when requesting the CTI module instance.
>> +
>> +
>> +Optional properties:
>> +
>> +- arm-primecell-periphid:	Primecell peripheral ID associated with CTI
>> +				module.
> 
> For multi-cluster systems, I wouldn't be surprised to see multiple CTI
> instances, each with different CPU affinities. Can we include an affinity
> property following Mark's proposed binding?
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137290.html

Yes I can take a look. Would something like that be applicable to pmu as
well or is that unlikely to have different affinities? I am just
wondering if there is something that we should implement in general for
the various primecell components.

Cheers
Jon
