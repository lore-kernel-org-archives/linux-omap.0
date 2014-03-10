From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Mon, 10 Mar 2014 12:09:38 +0000
Message-ID: <20140310120938.GJ14999@e106331-lin.cambridge.arm.com>
References: <cover.1394440470.git.jsarha@ti.com>
 <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64732 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752694AbaCJMJu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 08:09:50 -0400
Content-Disposition: inline
In-Reply-To: <dc68ce35a3f44b5c8a55be928e06f72f463338fa.1394440470.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "detheridge@ti.com" <detheridge@ti.com>

On Mon, Mar 10, 2014 at 08:52:21AM +0000, Jyri Sarha wrote:
> This commit adds a bare bones driver support for TLV320AIC31XX family
> audio codecs. The driver adds basic stereo playback trough headphone
> and speaker outputs and mono capture trough microphone inputs.
> 
> The driver is currently missing support at least for mini DSP features
> and jack detection. I have tested the driver only on TLV320AIC3111,
> but based on the data sheets TLV320AIC3100, TLV320AIC3110, and
> TLV320AIC3120 should work Ok too.
> 
> The base for the implementation was taken from:
> git@gitorious.org:ti-codecs/ti-codecs.git ajitk/topics/k3.10.1-aic31xx
> -branch at commit 77504eba0294764e9e63b4a0c696b44db187cd13.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../devicetree/bindings/sound/tlv320aic31xx.txt    |   61 +
>  include/dt-bindings/sound/tlv320aic31xx-micbias.h  |    9 +
>  sound/soc/codecs/Kconfig                           |    4 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/tlv320aic31xx.c                   | 1343 ++++++++++++++++++++
>  sound/soc/codecs/tlv320aic31xx.h                   |  258 ++++
>  6 files changed, 1677 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
>  create mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
>  create mode 100644 sound/soc/codecs/tlv320aic31xx.c
>  create mode 100644 sound/soc/codecs/tlv320aic31xx.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> new file mode 100644
> index 0000000..0109df1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> @@ -0,0 +1,61 @@
> +Texas Instruments - tlv320aic31xx Codec module
> +
> +The tlv320aic31xx serial control bus communicates through I2C protocols
> +
> +Required properties:
> +
> +- compatible - "string" - One of:
> +    "ti,tlv320aic310x" - Generic TLV320AIC31xx with mono speaker amp
> +    "ti,tlv320aic311x" - Generic TLV320AIC31xx with stereo speaker amp
> +    "ti,tlv320aic3100" - TLV320AIC3100 (mono speaker amp, no MiniDSP)
> +    "ti,tlv320aic3110" - TLV320AIC3110 (stereo speaker amp, no MiniDSP)
> +    "ti,tlv320aic3120" - TLV320AIC3120 (mono speaker amp, MiniDSP)
> +    "ti,tlv320aic3111" - TLV320AIC3111 (stereo speaker amp, MiniDSP)
> +
> +- reg - <int> -  I2C slave address
> +
> +
> +Optional properties:
> +
> +- gpio-reset - gpio pin number used for codec reset

I believe calling this reset-gpio would be more in keeping with the gpio
bindings.

I'd get rid of "pin number" from the description. GPIOs are referred to
with phandle + gpio-specifier pairs, and this makes it sound like a
single integer value.

> +- ai31xx-micbias-vg - MicBias Voltage setting

This name is a bit terse. Perhaps s/vg/voltage/ ?

> +        0 or MICBIAS_OFF - MICBIAS output it not powered

s/it/is/

> +        1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
> +        2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
> +        3 or MICBIAS_AVDD - MICBIAS output is connected to AVDD
> +       If this node is not mentioned or if the value is unknown, then
> +       micbias is set to 2.0V.

Why does the dts write need to select these -- what prevents this
getting selected dynamically?

Cheers,
Mark.
