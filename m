From: Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
Date: Fri, 21 Dec 2012 14:35:58 -0800
Message-ID: <20121221223558.GC2658@pratikp-linux.qualcomm.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
 <20121221222703.GB2658@pratikp-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:27395 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2LUWgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 17:36:00 -0500
Content-Disposition: inline
In-Reply-To: <20121221222703.GB2658@pratikp-linux.qualcomm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Dec 21, 2012 at 02:27:03PM -0800, Pratik Patel wrote:
> On Wed, Dec 12, 2012 at 03:43:06PM -0600, Jon Hunter wrote:
> > +
> > +/**
> > + * cti_irq_ack - acknowledges the CTI trigger output
> > + * @cti: CTI instance
> > + *
> > + * Acknowledges the CTI trigger output by writting to the appropriate
> > + * bit in the CTI interrupt acknowledge register.
> > + */
> > +int cti_irq_ack(struct cti *cti)
> > +{
> > +	u32 v;
> > +
> > +	if (!cti || !cti->enabled)
> > +		return -EINVAL;
> > +
> > +	v = cti_readl(cti, CTIINTACK);
> 
> Just curious if CTIINTACK is a read-write register? This is a
> read-only for us.
> 
Mistyped - its a write-only for us

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
