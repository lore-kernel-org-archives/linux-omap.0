From: Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
Date: Thu, 3 Jan 2013 10:47:52 -0800
Message-ID: <20130103184752.GB30277@pratikp-linux.qualcomm.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
 <20121221222703.GB2658@pratikp-linux.qualcomm.com>
 <50E48934.6070201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:8153 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab3ACSry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 13:47:54 -0500
Content-Disposition: inline
In-Reply-To: <50E48934.6070201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Paul Walmsley <paul@pwsan.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 02, 2013 at 01:23:32PM -0600, Jon Hunter wrote:
> 
> On 12/21/2012 04:27 PM, Pratik Patel wrote:
> > On Wed, Dec 12, 2012 at 03:43:06PM -0600, Jon Hunter wrote:
> >> +
> >> +/**
> >> + * cti_irq_ack - acknowledges the CTI trigger output
> >> + * @cti: CTI instance
> >> + *
> >> + * Acknowledges the CTI trigger output by writting to the appropriate
> >> + * bit in the CTI interrupt acknowledge register.
> >> + */
> >> +int cti_irq_ack(struct cti *cti)
> >> +{
> >> +	u32 v;
> >> +
> >> +	if (!cti || !cti->enabled)
> >> +		return -EINVAL;
> >> +
> >> +	v = cti_readl(cti, CTIINTACK);
> > 
> > Just curious if CTIINTACK is a read-write register? This is a
> > read-only for us.
> > 
> >> +	v |= BIT(cti->trig_out);
> >> +	cti_writel(v, cti, CTIINTACK);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +
> >> +static int cti_probe(struct amba_device *dev, const struct amba_id *id)
> >> +{
> >> +	struct cti *cti;
> >> +	struct device_node *np = dev->dev.of_node;
> >> +	int rc;
> >> +
> >> +	if (!np) {
> >> +		dev_err(&dev->dev, "device-tree not found!\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	cti = devm_kzalloc(&dev->dev, sizeof(struct cti), GFP_KERNEL);
> >> +	if (!cti) {
> >> +		dev_err(&dev->dev, "memory allocation failed!\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	rc = of_property_read_string_index(np, "arm,cti-name", 0, &cti->name);
> >> +	if (rc) {
> >> +		dev_err(&dev->dev, "no name found for CTI!\n");
> >> +		return rc;
> >> +	}
> > 
> > Shouldn't the CTI driver have some kind of clock management that
> > it does for itself?
> 
> It does by using runtime PM. If you look at the cti_get/put functions,
> you will see calls to pm_runtime_get/put. These calls will enable the
> AMBA apb-clock. If you need to enable additional clocks then you could
> register pm runtime resume/idle call backs to do this.
> 

Ok

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
