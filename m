From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
Date: Fri, 14 Dec 2012 13:53:31 -0600
Message-ID: <50CB83BB.6080901@gmail.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com> <1355348588-22318-3-git-send-email-jon-hunter@ti.com> <50C90153.9070002@gmail.com> <50C9120F.7080809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51511 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2LNTxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 14:53:34 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so3763825obb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 11:53:33 -0800 (PST)
In-Reply-To: <50C9120F.7080809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>

On 12/12/2012 05:23 PM, Jon Hunter wrote:
> 
> On 12/12/2012 04:12 PM, Rob Herring wrote:
>> On 12/12/2012 03:43 PM, Jon Hunter wrote:
>>> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
>>> The ARM Cross Trigger Interface provides a way to route events between
>>> processor modules. For example, on OMAP4430 we use the CTI module to
>>> route PMU events to the GIC interrupt module.
>>
>> Do you need to describe the PMU-CTI-GIC connection in DT?
> 
> We definitely could. This is achieved by mapping a trigger-input to a
> trigger-output. So we could list the trigger outputs and inputs in the
> binding. For omap4430 we would have ...
> 
> arm,cti-trigin = <0 1 2 3 4 5 6>;

I'd prefer to just spell it out: arm,cti-trigger-in

> arm,cti-trigin-names =  "dbgack", "pmuirq", "ptmextout0",
> 			"ptmextout1", "commtx", "commrx",
> 			"ptmtrigger";
> arm,cti-trigout = <0 1 2 3 4 6 7>;
> arm,cti-trigout-names = "edbgreq", "ptmextin0", "ptmextin1",
> 			"ptmextin2", "ptmextin3","mpuirq",
> 			"dbgrestart";
> 
> So to map the PMU to GIC, we would map the "pmuirq" trigger input to the
> "mpuirq" trigger output. Then we could setup the mapping by name instead
> of index.

I'm not crazy about the name strings and would prefer something with
phandles. The above binding doesn't really describe the connection of
the CTI to the GIC. The GIC node would need to define some inputs and
then you show the connection to the CTI outputs. This may be similar to
an interrupt nexus node.

Rob

