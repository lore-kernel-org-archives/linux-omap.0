Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531514;
	b=r5r8D8VPCd6rjR/EY24rd01YH6rg2smkKXEXwdx48jt7TIm9TU8KzzIrrwIw9pBjmXkO
	 8qLgW9T2aO/u367bwFf7RJt4PSZFLEL4FVFVgLPxdC5HYfX24OkTMTkb4R1dpNIDvXNbc
	 X2wvEmqucmIm9Xv4lGFDS2FSEt9VEVRXj+GgrG1V+dRECdvh5bjIfFnabn+uoC/F/J555
	 xIVMP5W/Lxq3LiFzv3xL1VoP3rgqgcs4+BaE26Je4zrEtM8CjIGC6oJVqGQ3iEylUwrJb
	 FS+xy33S1GMKq6F10bbelQcHA5Kjt/FNcptnXE4A6yW9FfDzMpsE4OFv40QIbqRXHnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531514;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4Nv92dxJ4w/rbnjAgaKNTvEaElRmvxU69eClhfhiUIs=;
	b=lBtwbqoHoqO4GuBEn8eV79LrrU63YM7QzEJ4i316hnFSpAHsPrmYpDNKdn139yA46LBJ
	 q89tXx94hjjkb/HGJ6g5soj2qpJmsuKXFvLnZsQVk3j0X4QKq6QgaXkF+3/6FZeI2oweP
	 X817+zfwDAAC03yCduxUUPYt72iv39jJHfMqyufP5rnOkPtPDTuss4w7ZmdQTs1gBX4U8
	 EVNnCHbRfPdQ1pr2RGrW6iGP0RUE5rptPfuUOE9R4eTnYOf1fEPegWcISHpcHv/vvLl3L
	 WaKhHOON6YyRaDuWbcC3sxG9kRlNWYetFRqZOqmMosB+Nu8zSn6JJu9KRMfEmiYZTWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n1bcvz/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB08606A327;
	Tue, 24 Nov 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1bcvz/q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72A91F000CF;
	Tue, 24 Nov 2026 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531513;
	bh=4Nv92dxJ4w/rbnjAgaKNTvEaElRmvxU69eClhfhiUIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1bcvz/qeq9Ha5Q2rYDT/yOsThuugZ60fYPMtesxbQLDUbsqv01PuYYF75cT470VJ
	 DknZtTatgltJFfhqpA59xGxe3tmnmekjfufDT8/PIWNbvYt5fnZUdoBOgoOegRbjJD
	 cK6Muxro7N4LY8C2oxuRh3hVMlKzqs5iF6sKZ+C0lKnVseMXqLnPxTTjScAtXNEhro
	 Aqbdpx0FdkUlqBytLgPc/7RoUbE/U7BVRiGTDPo3zjtG+RYyrb67RMptNA9HG1mbS3
	 SguyyRHy3DqpNTXQcywxpM/ypGdAnzHjNiyO5COVa8sg6ZbIN2ZikhNVXjboSubZc+
	 5Sqi1eojYbmBg==
Date: Tue, 24 Nov 2026 15:45:10 +0100
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
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
Message-ID: <20261124-crocodile-of-marvelous-essence-ee7b3c@quoll>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
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
In-Reply-To: <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>

On Tue, Nov 24, 2026 at 08:25:46AM +0100, H. Nikolaus Schaller wrote:
> +description:
> +  The OpenPandora audio subsystem describes the routing links between the
> +  OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio codec,
> +  alongside amplifiers and power supplies.
> +
> +properties:
> +  compatible:
> +    const: openpandora,omap3pandora-sound

openpandora,omap3-pandora-sound

(add hyphen) to match other style?

> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User-visible name for this sound card.
> +
> +  amp-gpios:
> +    maxItems: 1
> +    description: GPIO pin controlling the amplifier power state.
> +
> +  amp-supply:
> +    description: Regulator supplying power to the amplifier.
> +
> +  sound-dai:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Phandles to the audio CPU DAI (OMAP3 McBSP) and the codec DAI.
> +
> +  routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components.
> +      Each entry is a pair of strings, the first being the connection's sink,
> +      the second being the connection's source.
> +
> +  widgets:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      User-specified audio sound widgets.
> +      Each entry is a pair of strings, the first being the widget type
> +      (e.g., "Speaker", "Headphone", "Microphone", "Line") and the second being its name.
> +
> +required:
> +  - compatible
> +  - sound-dai
> +

allOf with $ref to sound-card-common.yaml and you can drop routing property.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    sound {
> +        compatible = "openpandora,omap3pandora-sound";
> +        status = "okay";

Drop

> +
> +        label = "OpenPandora";
> +
> +        amp-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +        amp-supply = <&aux_5v>;
> +
> +        widgets =
> +            "Line", "Line Out",

Join these two lines

> +            "Line", "Line In",
> +            "Headphone", "Headphone Jack",
> +            "Microphone", "Mic (internal)",
> +            "Microphone", "Mic (external)";
> +
> +        routing =
> +            "DAC1", "APLL Enable",

As well


Best regards,
Krzysztof

