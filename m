From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
Date: Thu, 13 Dec 2012 17:41:40 +0000
Message-ID: <20121213174139.GA12946@mudshark.cambridge.arm.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:32966 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755738Ab2LMRmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Dec 2012 12:42:07 -0500
Content-Disposition: inline
In-Reply-To: <1355348588-22318-3-git-send-email-jon-hunter@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>

On Wed, Dec 12, 2012 at 09:43:05PM +0000, Jon Hunter wrote:
> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
> The ARM Cross Trigger Interface provides a way to route events between
> processor modules. For example, on OMAP4430 we use the CTI module to
> route PMU events to the GIC interrupt module.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/cti.txt |   32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cti.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cti.txt b/Documentation/devicetree/bindings/arm/cti.txt
> new file mode 100644
> index 0000000..4a0e2d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cti.txt
> @@ -0,0 +1,32 @@
> +* ARM Cross Trigger Interface (CTI)
> +
> +The ARM Cross Trigger Interface provides a way to route events between
> +processor modules. For example, debug events from one processor can be
> +broadcasted to other processors. The events that can be routed between
> +processors are specific to the device.
> +
> +Required properties:
> +
> +- compatible:			Should be "arm,primecell".
> +- interrupts:			Interrupt associated with CTI module.
> +- reg:				Contains timer register address range (base
> +				address and length).
> +- arm,cti-name:			A unique name for the CTI module, that will be
> +				used when requesting the CTI module instance.
> +
> +
> +Optional properties:
> +
> +- arm-primecell-periphid:	Primecell peripheral ID associated with CTI
> +				module.

For multi-cluster systems, I wouldn't be surprised to see multiple CTI
instances, each with different CPU affinities. Can we include an affinity
property following Mark's proposed binding?

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137290.html

Will
