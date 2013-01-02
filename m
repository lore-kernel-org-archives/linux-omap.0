From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
Date: Wed, 2 Jan 2013 13:13:47 -0600
Message-ID: <50E486EB.8030506@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com> <1355348588-22318-4-git-send-email-jon-hunter@ti.com> <20121221222703.GB2658@pratikp-linux.qualcomm.com> <20121221223558.GC2658@pratikp-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41172 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab3ABTOK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jan 2013 14:14:10 -0500
In-Reply-To: <20121221223558.GC2658@pratikp-linux.qualcomm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pratik Patel <pratikp@codeaurora.org>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Linus Walleij <linus.walleij@linaro.org>


On 12/21/2012 04:35 PM, Pratik Patel wrote:
> On Fri, Dec 21, 2012 at 02:27:03PM -0800, Pratik Patel wrote:
>> On Wed, Dec 12, 2012 at 03:43:06PM -0600, Jon Hunter wrote:
>>> +
>>> +/**
>>> + * cti_irq_ack - acknowledges the CTI trigger output
>>> + * @cti: CTI instance
>>> + *
>>> + * Acknowledges the CTI trigger output by writting to the appropriate
>>> + * bit in the CTI interrupt acknowledge register.
>>> + */
>>> +int cti_irq_ack(struct cti *cti)
>>> +{
>>> +	u32 v;
>>> +
>>> +	if (!cti || !cti->enabled)
>>> +		return -EINVAL;
>>> +
>>> +	v = cti_readl(cti, CTIINTACK);
>>
>> Just curious if CTIINTACK is a read-write register? This is a
>> read-only for us.
>>
> Mistyped - its a write-only for us

You are right. Looking at the ARM documentation this is a write-only
register. I had copied this function from the original helpers but had
not checked if this was readable. I will correct this.

Cheers
Jon

