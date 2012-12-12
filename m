From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
Date: Wed, 12 Dec 2012 17:23:59 -0600
Message-ID: <50C9120F.7080809@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com> <1355348588-22318-3-git-send-email-jon-hunter@ti.com> <50C90153.9070002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51348 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab2LLXYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 18:24:18 -0500
In-Reply-To: <50C90153.9070002@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>


On 12/12/2012 04:12 PM, Rob Herring wrote:
> On 12/12/2012 03:43 PM, Jon Hunter wrote:
>> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
>> The ARM Cross Trigger Interface provides a way to route events between
>> processor modules. For example, on OMAP4430 we use the CTI module to
>> route PMU events to the GIC interrupt module.
> 
> Do you need to describe the PMU-CTI-GIC connection in DT?

We definitely could. This is achieved by mapping a trigger-input to a
trigger-output. So we could list the trigger outputs and inputs in the
binding. For omap4430 we would have ...

arm,cti-trigin = <0 1 2 3 4 5 6>;
arm,cti-trigin-names =  "dbgack", "pmuirq", "ptmextout0",
			"ptmextout1", "commtx", "commrx",
			"ptmtrigger";
arm,cti-trigout = <0 1 2 3 4 6 7>;
arm,cti-trigout-names = "edbgreq", "ptmextin0", "ptmextin1",
			"ptmextin2", "ptmextin3","mpuirq",
			"dbgrestart";

So to map the PMU to GIC, we would map the "pmuirq" trigger input to the
"mpuirq" trigger output. Then we could setup the mapping by name instead
of index.

Let me know what you think about that.

Cheers
Jon
