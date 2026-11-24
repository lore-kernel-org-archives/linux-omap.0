Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556598;
	b=NKlZB50iURndYegNdBo7BKHV/TlDCRQE9Ml22DAL1mkguzl7msr0w6I3CULCM9QTPnIw
	 QYmwBfD3UAcNEf/QR+WWE9heXpekZyRkqa0mU9wcY7JDXwol7UaMm1hfzAsOQuOImXs5p
	 rLJx/ac9Bwb1ooL1n6G1QB5bWPCl56GbuJLbiaVzuJMVLSdQnMGfC6sAv8dPBHe8kkUvF
	 2o2tpcgd5qV8wG005sx9JPfAf8enumvy7lZdgoQsF8bp4nACaTK6ZHGt7y4FrB5vo1+80
	 Gy1LViUvMdLQwe6DG2YsaIHmYYFreblKvnu6uUY4/ZgcDQKaRq/l8w5LY6IWxPivuiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556598;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EfGE9YBTewiWSglRdGN58o65rErT0L06vLupgEMSkpg=;
	b=1L6SLt9Pw4V2OsqLpBf7asw1RHVSq40acQ8TkVMjmmuA3YXVO79CpvmBv8+GcCuaYk3w
	 jclQubosncfeNZffCGZoXQbMKkBez4fidQ0l5nX6M6l/0FiBFTpFF4V9rYuPyOFhNB+ZN
	 +FovFYUPgfE8LVGMyguGd9YpAfV0RPC0Gl6yDxQWnV8s4QhSBzxmxzgvbFV8eL97FHxXL
	 nnRzRiZu3/7uuCrBPGgClU3kmcN30iCnJ16YEtUX9Tq87NgomFup4A7VoCDVUifUJk1kW
	 lETyvLa40QubSxw+MTPsl32wIGtC2hxarxxNE+hextRoOZhgIoZRi+/5bXo1QCQxHHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=cLTiWz7C;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08301606A332;
	Tue, 24 Nov 2026 21:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08301606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=cLTiWz7C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=EfGE9YBTewiWSglRdGN58o65rErT0L06vLupgEMSkpg=; t=1795556597; x=1796766197; 
	b=cLTiWz7C3yQl1bpgBLRvVCg3BtGmoLSgbOZefEoa9BHjZgVBJnmdvHZeFxe1lHtMqQjsi29YfbM
	KTrxTYgJFrOtMCYtkUKDvhgVgMl3I9MDpNpudf72LdUynq6I8NoPV3k0wPXzXp3I3ESvEz0QjqH82
	E9fEIhDntWx5oaL9rGoKnjqjMrJjXljodcwAV1JQ42ld3T2xjBORjB/RYs/SsdPzt0FBpfZDWDbEE
	1QNawRGmp06mRScNAd6OF68ez9PrmxNou/HWLCJ4XYUwUNQYb7V8rs/BHOrg21yUEXQpqr5GOsnYq
	t7gry6LPk5j5gjehb72A6/xTG8eOUgXTds8A==;
Date: Tue, 24 Nov 2026 22:43:00 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
 <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King
 <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Helge Deller
 <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jarkko Nikula
 <jarkko.nikula@bitmer.com>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
Message-ID: <20261124224300.519d8686@kemnade.info>
In-Reply-To: <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
	<5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 08:25:46 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> The OpenPandora audio subsystem describes the routing links between the
> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio
> codec, alongside amplifiers and power supplies.
> 
I think at least in some commit message should be commented why such
an interface is needed and the generic sound cards are not sufficient,
also as a starting point to recheck that later if these reasons are still
valid.

Regards,
Andreas

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> 
> Notes:
>     Changes against V1:
>     - Address Krzysztof Kozlowski's V1 request to run the documented
>       DT schema checks and fix the errors reported by Rob Herring's
>       automated DT validation.
>     - Update the binding example and schema during DT consistency review.
>     - Binding and commit-message review assisted by ChatGPT.
> 
>  .../sound/openpandora,omap3pandora-sound.yaml | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
> new file mode 100644
> index 0000000000000..6c4d69ffc1c50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/openpandora,omap3pandora-sound.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OpenPandora OMAP3 Audio Complex
> +
> +maintainers:
> +  - H. Nikolaus Schaller <hns@goldelico.com>
> +
> +description:
> +  The OpenPandora audio subsystem describes the routing links between the
> +  OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio codec,
> +  alongside amplifiers and power supplies.
> +
> +properties:
> +  compatible:
> +    const: openpandora,omap3pandora-sound
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
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    sound {
> +        compatible = "openpandora,omap3pandora-sound";
> +        status = "okay";
> +
> +        label = "OpenPandora";
> +
> +        amp-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +        amp-supply = <&aux_5v>;
> +
> +        widgets =
> +            "Line", "Line Out",
> +            "Line", "Line In",
> +            "Headphone", "Headphone Jack",
> +            "Microphone", "Mic (internal)",
> +            "Microphone", "Mic (external)";
> +
> +        routing =
> +            "DAC1", "APLL Enable",
> +            "DAC2", "APLL Enable",
> +            "Headphone Amplifier", "VOUTL",
> +            "Headphone Amplifier", "VOUTR",
> +            "Line Out", "VOUTL",
> +            "Line Out", "VOUTR",
> +            "Headphone Jack", "Headphone Amplifier",
> +            "AUXL", "Line In",
> +            "AUXR", "Line In",
> +            "MAINMIC", "Mic (internal)",
> +            "Mic (internal)", "Mic Bias 1",
> +            "SUBMIC", "Mic (external)",
> +            "Mic (external)", "Mic Bias 2";
> +
> +        sound-dai = <&mcbsp2>, <&dac>;
> +    };

