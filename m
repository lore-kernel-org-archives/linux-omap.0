Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531251;
	b=IHsz29Vt100PkqTWK3vXY1dKzqQz+ZqAiWAn6eblbmGdvF2xfhiCafGsQZI0F4sWD/Xf
	 0C3v/E3kkgjfX6vRAOgph3TisB1px+FGDUNlPuOu1eP9baMZP0QEIIHPOPhcSFpZ4kBut
	 k4V9JnMeYm+rhW2VdKgBc9ajmy3lVWjZCnxldoNHHvYoMxOPTOBNzzyr4atJdL7/8aeFW
	 SKEpxPXn801XNixGbaa1poRTIlv6HYm9R6eLTMKxRxfxH7vM2d/MJrPhdfug4xt+7jcgP
	 2LN9v1TlLgWT/TSVxSY5abLD6JMbBaCV4UVARs0f87PD/f44deyjtm9WNbdGORrAN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531251;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=unbcf7IxetKvCKK1oK9oQ5fvh2u9DJnAEwqwMUBWQOo=;
	b=2t9qM2h2mfqUCw/mRISP5eaeBdQfcCj64QdQJjnfCLlcKAR+/DFbx8+0tpd6PTv/66oc
	 sNnOLa75YqdxinPfl8XkJswCsqpN5JFJK8yUXN9kRdbRgG3ivkef65Di1jtLF5d0YT+Oy
	 G8vZ5sS6FL9CI/tHqJj6LSMDODPMheR9YKuSDGgJDHBMj67P+t+Z8GxbduzQrr3pNCwUk
	 LS/03AOVK+B7ctcqmPQHwz10Bu776shOgaCfwDXiqAYwj5sM1rMIHsEN4g/zaVdKGsTB3
	 q22X5p5ObWbveSYJWQOXPgE6LhQPZWJ30ab24ptwhldaifVjIpXG0sA3zt3kuMyookg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io9tgaHH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB02606A332;
	Tue, 24 Nov 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io9tgaHH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572071F000D0;
	Tue, 24 Nov 2026 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531251;
	bh=unbcf7IxetKvCKK1oK9oQ5fvh2u9DJnAEwqwMUBWQOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=io9tgaHHOyo0Z5zikV7SPV2Mwg+94HMNGbKiAM6qeawvECgjSx8Wwf/4yH3FweP+3
	 TL7qQJAZMBWzCIlZak4Iy94oXDyTDm8kfC54GyWgMQaSBTQa9kkC8/F2r893oDxpwc
	 tlvIxnIdjAa8rhJn38qfedqiDhY2U4aFH4mg7hs2IJuSxAOxVT0VBEZithvdBqfqN+
	 xyFKXxxrBo5rneon0rgD37tzMv9xzSn6QyMSDl2YTyqXHgch9BVeQUItNuW3Ye4hUC
	 qGKaO8UhXh8/zqil67p9RbC3e68sJ/7wZHtumE4lq/eECPNerHkHhoYWSFOvQQcGGF
	 Dbl+rs4tjDHhw==
Date: Tue, 24 Nov 2026 15:40:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, 
	kernel@pyra-handheld.com
Subject: Re: [PATCH v2 08/20] dt-bindings: mfd: twl4030: Document 64-cycle PWM
Message-ID: <20261124-neon-noble-seagull-df2d40@quoll>
References: <cover.1795505160.git.hns@goldelico.com>
 <8e0c47487add0fa1bc0dad9b1bceef5ebf8071d4.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e0c47487add0fa1bc0dad9b1bceef5ebf8071d4.1795505160.git.hns@goldelico.com>

On Tue, Nov 24, 2026 at 08:25:48AM +0100, H. Nikolaus Schaller wrote:
> Document the optional ti,twl4030-pwm-frame-64 property for the
> TWL4030 PWM controller. It selects the 64-clock-cycle frame instead
> of the default 128-cycle frame, doubling the output frequency and
> reducing duty-cycle resolution.
> 
> The selection is explicit because the driver does not know the PWM
> input clock rate and cannot derive the hardware frame length from a
> consumer-requested period. The shorter frame can reduce PWM LOW
> intervals during startup mode detection of LED drivers such as the
> TI TPS61160/61.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> 
> Notes:
>     Changes against V1:
>     - Revised commit message to focus on the binding and the reason
>       for explicit 64-cycle frame selection.
>     - Commit-message review assisted by ChatGPT.
> 
>  Documentation/devicetree/bindings/mfd/ti,twl.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index 9cc3e4721612e..f458f0d80f2cd 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -396,6 +396,15 @@ properties:
>        '#pwm-cells':
>          const: 2
>  
> +      ti,twl4030-pwm-frame-64:

Drop twl4030. Properties are not model specific, but should be re-usable
among all of devices from that vendor (when applicable).

> +        type: boolean
> +        description:
> +          TWL4030 only; not supported by TWL6030 PWM.

Don't repeat constraints in free form text. Implement proper dt-schema
for this.

> +          Select the short 64-clock-cycle PWM frame instead of the
> +          default 128-cycle frame, doubling the PWM frequency. Required
> +          for dimming inputs requiring short PWM low intervals during
> +          startup mode detection (e.g. TI TPS61160/61).

I don't get how TPS is related here, but if you mention other specific
device then I wonder - why isn't this deducible from the compatible? Or
you mean that PWM consumers might need it, depending on  the consumer?

But isn't this then dynamic choice - depending on PWM frequency the
consumer wants?

Best regards,
Krzysztof

