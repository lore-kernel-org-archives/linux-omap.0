From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 10/11] ARM/dts: am33xx: mcasp: Add new dma
 register location to reg-property
Date: Mon, 7 Oct 2013 23:00:30 +0100
Message-ID: <20131007220030.GD2976@kartoffel>
References: <cover.1379590035.git.jsarha@ti.com>
 <c7a2c57b695804f52927ed5fd865bc8a9988335a.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54768 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab3JGWAp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 18:00:45 -0400
Content-Disposition: inline
In-Reply-To: <c7a2c57b695804f52927ed5fd865bc8a9988335a.1379590036.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

On Thu, Sep 26, 2013 at 08:18:35PM +0100, Jyri Sarha wrote:
> This patch adds an optional address range to reg property. The range
> describes the register location for DMA controller on am33xx. The both
> address ranges are named accordingly in the reg-names property.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index fe53ce0..4dc388a 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -556,19 +556,29 @@
>  		mcasp0: mcasp@48038000 {
>  			compatible = "ti,omap2-mcasp-audio";
>  			ti,hwmods = "mcasp0";
> -			reg = <0x48038000 0x2000>;
> +			reg = <0x48038000 0x2000>,
> +			      <0x46400000 0x400000>;
> +			reg-names = "mpu", "dma";
>  			interrupts = <80 81>;
>  			interrupts-names = "tx", "rx";
>  			status = "disabled";
> +			dmas = <&edma 8
> +				&edma 9>;

For consistency with reg and other composite value properties, I'd prefer that
each entry in the list were individually bracketed:

			dmas = <&edma 8>,
			       <&edma 9>;

It would also be nice if interrupts were written this way.

> +			dma-names = "tx", "rx";
>  		};
>  
>  		mcasp1: mcasp@4803C000 {
>  			compatible = "ti,omap2-mcasp-audio";
>  			ti,hwmods = "mcasp1";
> -			reg = <0x4803C000 0x2000>;
> +			reg = <0x4803C000 0x2000>,
> +			      <0x46400000 0x400000>;
> +			reg-names = "mpu", "dma";
>  			interrupts = <82 83>;
>  			interrupts-names = "tx", "rx";
>  			status = "disabled";
> +			dmas = <&edma 10
> +				&edma 11>;

Similarly here.

Cheers,
Mark.
