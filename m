From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
Date: Wed, 12 Dec 2012 16:12:35 -0600
Message-ID: <50C90153.9070002@gmail.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com> <1355348588-22318-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63085 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab2LLWMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 17:12:39 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1362781oag.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 14:12:38 -0800 (PST)
In-Reply-To: <1355348588-22318-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Pratik Patel <pratikp@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ming Lei <ming.lei@canonical.com>

On 12/12/2012 03:43 PM, Jon Hunter wrote:
> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
> The ARM Cross Trigger Interface provides a way to route events between
> processor modules. For example, on OMAP4430 we use the CTI module to
> route PMU events to the GIC interrupt module.

Do you need to describe the PMU-CTI-GIC connection in DT?

Rob

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
> +
> +
> +Example:
> +
> +cti0: cti@0x54148000 {
> +	compatible = "arm,primecell";
> +	interrupts = <0 1 0x4>;
> +	reg = <0x54148000 0x1000>;
> +	arm,cti-name = "cti0";
> +	arm,primecell-periphid = <0x003bb906>;
> +};
> 
