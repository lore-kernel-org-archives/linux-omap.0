From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 05/11] ASoC: davinci-mcasp: Interrupts property
 to optional and add interrupt-names
Date: Mon, 7 Oct 2013 22:56:57 +0100
Message-ID: <20131007215657.GC2976@kartoffel>
References: <cover.1379590035.git.jsarha@ti.com>
 <0140013bd747832968ccd7dce8f9270e1459d018.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54689 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485Ab3JGV5K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 17:57:10 -0400
Content-Disposition: inline
In-Reply-To: <0140013bd747832968ccd7dce8f9270e1459d018.1379590036.git.jsarha@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>

On Thu, Sep 26, 2013 at 08:18:30PM +0100, Jyri Sarha wrote:
> Makes interrupts property optional as the interrupts are not currently
> used by the driver and adds interrupt-names property to name listed
> interrupts. Currently know interrupt names are "tx" and "rx".
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/sound/davinci-mcasp-audio.txt         |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> index 68e0f47..2fd0bf2 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -11,7 +11,6 @@ Required properties:
>  - reg-names : The mandatory reg-range must be named "mpu" and the optional DMA
>  	      reg-range must be named "dma". For backward compatibility it is
>  	      good to keep "mpu" first in the list.
> -- interrupts : Interrupt number for McASP
>  - op-mode : I2S/DIT ops mode.
>  - tdm-slots : Slots for TDM operation.
>  - num-serializer : Serializers used by McASP.
> @@ -31,6 +30,8 @@ Optional properties:
>  - rx-num-evt : FIFO levels.
>  - sram-size-playback : size of sram to be allocated during playback
>  - sram-size-capture  : size of sram to be allocated during capture
> +- interrupts : Interrupt numbers for McASP, currently not used by the driver
> +- interrupt-names : Known interrupt names are "tx" and "rx"

Are these _all_ the interrupts the McASP may generate? I was under the
impression there were also separate interrupts for errors.

Cheers,
Mark.

>  
>  Example:
>  
> @@ -41,6 +42,7 @@ mcasp0: mcasp0@1d00000 {
>  	reg = <0x100000 0x3000>;
>  	reg-names "mpu";
>  	interrupts = <82 83>;
> +	interrupts-names = "tx", "rx";
>  	op-mode = <0>;		/* MCASP_IIS_MODE */
>  	tdm-slots = <2>;
>  	num-serializer = <16>;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
