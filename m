From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
Date: Thu, 13 Dec 2012 15:08:26 +0000
Message-ID: <20121213150826.GM26540@mudshark.cambridge.arm.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62361 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755910Ab2LMPIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Dec 2012 10:08:49 -0500
Content-Disposition: inline
In-Reply-To: <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>

On Wed, Dec 12, 2012 at 09:43:06PM +0000, Jon Hunter wrote:
> Convert the Cross Trigger Interface (CTI) helpers in cti.h into a
> AMBA bus driver so that we can use device-tree to look-up the hardware
> specific information such as base address and interrupt number during
> the device probe. This also add APIs to request, cti_get() and release,
> cti_put(), a CTI module so that drivers can allocate a module at
> runtime.
> 
> Currently, the driver only supports looking-up the CTI hardware
> information via device-tree, however, the driver could be extended to
> support non-device-tree configurations if needed for a particular
> architecture.
> 
> The CTI driver only currently supports CTI modules that have a single
> CPU interrupt, however, could be extended in the future to support more
> interrupts if a device requires this.

Aha, so elaborating on my earlier comments, we basically want to do the same
thing for ETB I reckon. This does raise the question about namespaces
though...

> +/**
> + * struct cti - Cross Trigger Interface (CTI) struct
> + *
> + * @node:      Connects CTI instance to list of CTI instances
> + * @dev:       Pointer to device structure
> + * @base:      Mapped virtual address of the CTI module
> + * @name:      Name associated with CTI instance
> + * @irq:       Interrupt associated with CTI instance
> + * @trig_out:  Trigger output associated with interrupt (@irq)
> + * @reserved:  Used to indicate if CTI instance has been allocated
> + * @enabled:   Used to indicate if CTI instance has been enabled
> + */
> +struct cti {
> +       struct list_head node;
> +       struct device *dev;
> +       void __iomem *base;
> +       const char *name;
> +       int irq;
> +       int trig_out;
> +       bool reserved;
> +       bool enabled;
> +};
> +
> +#ifdef CONFIG_ARM_AMBA_CTI
> +
> +int cti_map_trigger(struct cti *cti, int trig_in, int trig_out, int chan);
> +int cti_enable(struct cti *cti);
> +int cti_disable(struct cti *cti);
> +int cti_irq_ack(struct cti *cti);
> +struct cti *cti_get(const char *name);
> +void cti_put(struct cti *cti);

I wonder whether we should stick these all into a struct and have a general
way to see which coresight devices we have and then retrieve their ops
structures (so things like perf can walk a virtual coresight bus containing
initialised devices). It might also help if we decide to describe the
plumbing in the device tree, like Rob suggested.

What do you reckon?

Will
