From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/8] ASoC: davinci-evm: HDMI audio support for TDA998x
 trough McASP I2S bus
Date: Tue, 19 Aug 2014 14:16:22 +0100
Message-ID: <20140819131621.GL3302@leverpostej>
References: <cover.1408397864.git.jsarha@ti.com>
 <a92cd9257efb58711b2d5d3de2abff9c8a1052d2.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63516 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbaHSNQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Aug 2014 09:16:29 -0400
Content-Disposition: inline
In-Reply-To: <a92cd9257efb58711b2d5d3de2abff9c8a1052d2.1408397864.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "detheridge@ti.com" <detheridge@ti.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "t-kristo@ti.com" <t-kristo@ti.com>

On Mon, Aug 18, 2014 at 10:46:41PM +0100, Jyri Sarha wrote:
> Add machine driver support for BeagleBone-Black HDMI audio. BBB has
> NXP TDA998X HDMI transmitter connected to McASP port in I2S mode. The
> 44100 Hz sample-rate and it's multiples can not be accurately produced
> on BBB. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
> The 8 least significant bits are ignored.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/sound/davinci-evm-audio.txt           |    4 +-
>  sound/soc/davinci/davinci-evm.c                    |   82 +++++++++++++++++++-
>  2 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
> index 963e100..c137436 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
> @@ -1,7 +1,9 @@
>  * Texas Instruments SoC audio setups with TLV320AIC3X Codec
>  
>  Required properties:
> -- compatible : "ti,da830-evm-audio" : forDM365/DA8xx/OMAPL1x/AM33xx
> +- compatible : "ti,da830-evm-audio" : for DM365/DA8xx/OMAPL1x/AM33xx
> +               "ti,am335x-beaglebone-black-audio" : for Beaglebone-black HDMI
> +                                                    audio

To keep this legible I'd recommend reorganising this like:

- compatible: should contain one of:
   * "ti,da830-evm-audio" for DM365/DA8xx/OMAPL1x/AM33xx
   * "ti,am335x-beaglebone-black-audio" for Beaglebone-black HDMI audio

For the BBB case, do you expect both strings or just the BBB-specific
string?

Is the 'x' in the BBB string a wildcard? If we know the particular
number for BBB we should use that.

Cheers,
Mark.
