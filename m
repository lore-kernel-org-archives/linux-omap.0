From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/2] arm: dts: omap4+: Add DMM bindings
Date: Thu, 10 Oct 2013 11:08:33 +0100
Message-ID: <20131010100833.GF26954@e106331-lin.cambridge.arm.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1381386994-24747-1-git-send-email-archit@ti.com>
 <1381386994-24747-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:53650 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754741Ab3JJKIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 06:08:42 -0400
Content-Disposition: inline
In-Reply-To: <1381386994-24747-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "robdclark@gmail.com" <robdclark@gmail.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andy Gross <andygro@gmail.com>

On Thu, Oct 10, 2013 at 07:36:33AM +0100, Archit Taneja wrote:
> Add Dynamic Memory Manager (DMM) bindings for OMAP4 and OMAP5 devices. DMM
> only requires address and irq information.
> 
> Add documentation for the DMM bindings.
> 
> Originally worked on by Andy Gross <andygro@gmail.com>
> 
> Cc: Andy Gross <andygro@gmail.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/dmm.txt | 16 ++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
>  arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/dmm.txt b/Documentation/devicetree/bindings/arm/omap/dmm.txt
> new file mode 100644
> index 0000000..6fc3d79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/dmm.txt
> @@ -0,0 +1,16 @@
> +OMAP Dynamic Memory Manager (DMM) bindings

Is there any documentation? A brief description of what this is would be
nice.

> +
> +Required properties:
> +- compatible:	Must be "ti,omap4-dmm" for OMAP4 family
> +		Must be "ti,omap5-dmm" for OMAP5 and DRA7x family

s/must be/should contain/

> +- reg:		Contains timer register address range (base address and length)

Huh? What's a timer got to do with the DMM?

> +- interrupts:	Contains interrupt information (source, etc) for the DMM IRQ

Is there a single interrupt? If so:

- interrupts: Should contain an interrupt-specifier for the DMM IRQ.

Assuming the "DMM IRQ" is well defined. If there's a name for it in
documentation, using that's preferable. If a future revision may have
multiple interrupts, please use interrupt-names now to save us endless
pain in future.

Cheers,
Mark.
