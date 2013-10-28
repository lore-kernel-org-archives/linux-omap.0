From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [RFC 4/4] ASoC: RX-51: Add DT support to sound driver
Date: Mon, 28 Oct 2013 01:45:59 -0500
Message-ID: <1CEF5C54-F0E4-4938-BFFA-580358D575B7@codeaurora.org>
References: <1382909086-10493-1-git-send-email-sre@debian.org> <1382909086-10493-5-git-send-email-sre@debian.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1382909086-10493-5-git-send-email-sre@debian.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


On Oct 27, 2013, at 4:24 PM, Sebastian Reichel wrote:

> This patch adds device tree support to the Nokia N900 audio driver.
> It also removes GPIO defines and gets them from platform data /
> device tree, since some GPIO numbers may be different with DT boot.
> 
> The binding also changes a helper function in omap-mcbsp, which
> is currently only used by the Nokia N900. This change is needed,
> because DT instanced omap-mcbsp driver has no valid id assigned.
> 
> Last but not least the DT binding is documented.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
> .../devicetree/bindings/sound/nokia,rx51.txt       |  28 ++++
> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> include/sound/rx51.h                               |  18 +++
> sound/soc/omap/omap-mcbsp.c                        |   5 +-
> sound/soc/omap/omap-mcbsp.h                        |   2 +-
> sound/soc/omap/rx51.c                              | 175 ++++++++++++++++-----
> 6 files changed, 184 insertions(+), 45 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/sound/nokia,rx51.txt
> create mode 100644 include/sound/rx51.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/nokia,rx51.txt b/Documentation/devicetree/bindings/sound/nokia,rx51.txt
> new file mode 100644
> index 0000000..4f985ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nokia,rx51.txt
> @@ -0,0 +1,28 @@
> +* Nokia N900 audio setup

This needs more description 

> +
> +Required properties:
> +- compatible: "nokia,rx51-audio"
> +- ti,mcbsp: phandle for the McBSP node
> +- ti,codec: phandle for the main TLV320AIC3X node
> +- ti,codec_aux: phandle for the main TLV320AIC3X auxiliary node
> +- ti,headset_amp: phandle for the TPA6130A2 node

Hmm, I don't think these should be ti prefixed but nokia.

> +- tvout-selection-gpio: GPIO for tvout selection
> +- jack-detection-gpio: GPIO for jack detection
> +- eci-sw-gpio: GPIO for ECI SW
> +- speaker-amp-gpio: GPIO for Speaker Amp

why aren't the gpio properties vendor prefixed?

> +
> +Example:
> +
> +sound {
> +	compatible = "nokia,rx51-audio";
> +
> +	ti,mcbsp = <&mcbsp2>;
> +	ti,codec = <&tlv320aic3x>;
> +	ti,codec_aux = <&tlv320aic3x_aux>;
> +	ti,headset_amp = <&tpa6130a2>;
> +
> +	tvout-selection-gpio = <&gpio2 8 GPIO_ACTIVE_HIGH>; /* 40 */
> +	jack-detection-gpio = <&gpio6 17 GPIO_ACTIVE_HIGH>; /* 177 */
> +	eci-sw-gpio = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* 182 */
> +	speaker-amp-gpio = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
> +};

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

