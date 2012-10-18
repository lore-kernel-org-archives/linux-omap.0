From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP: Add counter-32k nodes
Date: Thu, 18 Oct 2012 16:23:29 +0200
Message-ID: <508010E1.6010102@ti.com>
References: <1350498803-22150-1-git-send-email-jon-hunter@ti.com> <1350498803-22150-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37583 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab2JROXk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 10:23:40 -0400
In-Reply-To: <1350498803-22150-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

This looks good to me, I just have a minor nit comment.

On 10/17/2012 08:33 PM, Jon Hunter wrote:
> Adds the counter-32k timers nodes present in OMAP2/3/4 devices and
> device-tree binding documentation for OMAP counter-32k.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/counter32k.txt    |   15 +++++++++++++++
>  arch/arm/boot/dts/omap2420.dtsi                    |    6 ++++++
>  arch/arm/boot/dts/omap2430.dtsi                    |    6 ++++++
>  arch/arm/boot/dts/omap3.dtsi                       |    6 ++++++
>  arch/arm/boot/dts/omap4.dtsi                       |    6 ++++++
>  5 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/counter32k.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/counter32k.txt b/Documentation/devicetree/bindings/arm/omap/counter32k.txt
> new file mode 100644
> index 0000000..1983fae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/counter32k.txt
> @@ -0,0 +1,15 @@
> +OMAP Counter-32K bindings
> +
> +Required properties:
> +- compatible:	Must be "ti,omap-counter32k" for OMAP controllers
> +- reg:		Contains timer register address range (base address and length)
> +- ti,hwmods:	Name of the hwmod associated to the counter, which is typically
> +		"counter_32k"
> +
> +Example:
> +
> +counter32k: counter32k@4a304000 {
> +	compatible = "ti,omap-counter32k";
> +	reg = <0x4a304000 0x001f>;
> +	ti,hwmods = "counter_32k";
> +};
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> index 5f68a70..082193f 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -14,6 +14,12 @@
>  	compatible = "ti,omap2420", "ti,omap2";
>  
>  	ocp {
> +		counter32k: counter32k@48004000 {

I'd rather use "counter" as generic type to be consistent with the timer
type we are already using.

+		counter32k: counter@48004000 {

Regards,
Benoit

