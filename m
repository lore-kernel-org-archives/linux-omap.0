From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 07/13] Documentation: devicetree: add bindings for TI
 PRUSS
Date: Mon, 30 Jun 2014 10:33:32 +0100
Message-ID: <20140630093332.GT7262@leverpostej>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-8-git-send-email-a.heider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62095 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751314AbaF3JeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2014 05:34:18 -0400
Content-Disposition: inline
In-Reply-To: <1404058907-21112-8-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Heider <a.heider@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Jun 29, 2014 at 05:21:41PM +0100, Andre Heider wrote:
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  Documentation/devicetree/bindings/misc/ti,pruss.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/ti,pruss.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/ti,pruss.txt b/Documentation/devicetree/bindings/misc/ti,pruss.txt
> new file mode 100644
> index 0000000..4eacc41
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/ti,pruss.txt
> @@ -0,0 +1,19 @@
> +TI Programmable Real-Time Unit Sub System (PRUSS)
> +
> +Required properties:
> +- compatible :
> +	- "ti,pruss-v1" - for PRUv1 as found on the OMAPL138/DA850/AM18xx SoC families
> +	- "ti,pruss-v2" - for PRUv2 as found on the AM33xx SoC family
> +- ti,hwmods: Name of the hwmod associated to the PRUSS
> +- reg: Address range of rtc register set
> +- interrupts: host event interrupts in order

How many of these do we expect?

> +- interrupt-parent: phandle for the interrupt controller
> +
> +Example:
> +pruss: pruss@4a300000 {
> +	compatible = "ti,pruss-v2";
> +	ti,hwmods = "pruss";
> +	reg = <0x4a300000 0x080000>;
> +	interrupts = <20 21 22 23 24 25 26 27>;

Assuming these represent more than one interrupt, could you please
bracket them individually? e.g.

	interrupts = <20 21>, <22 23>, <24 25>, <26 27>;

It makes it far clearer that it's a list of multi-cell elements rather
than a giant binary blob, and usually makes it easier to read a dts.

Thanks,
Mark.
