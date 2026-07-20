Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA53B3C03;
	Mon, 20 Jul 2026 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530478; cv=none; b=gnicxU36YbEFvh7b50CY7JlOHxCZk4S0Sb2i+R080G11664V4moKd1TzDyql/CWjapXUgsIvxCAJemp40kfy08WizB02Zgked9DjyE8Lt2CY8x/aQHdGamz8wn0mH3fRACm5Y4RTu4NtIH07wCLueTZLHD4mForB6rkQz+Q3xSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530478; c=relaxed/simple;
	bh=vtLCtIjJKKRh4VRV4nRc1Y9ekrXfoITM6CyzN+T8pUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2KbePuatwU1hYNd1N4IBXNxvJKGuke/2X6VF+C3mSkYsGfR0NbgMZemlM54mYtFW05/4l7EEaGWq9oZEa6BE0FEYy2PegcVhW/gIK/tWPc5fM1kGmjTULHl0oFDf287ST+Ap4NIWhzp+k57lb8cwOoOrFgxv+Qql9VMU1E9hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrQosxJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrQosxJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848101F000E9;
	Mon, 20 Jul 2026 06:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784530477;
	bh=KRb6TGQxOC1FpFX6y3n5ATAXoW7DHU5XuX04bzI5yNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KrQosxJrHCwq+btkXOpUYptoX+JGrJtGW8RNxpgyd9ZY2dQFMRbV2zas5fN5KzMAw
	 djgrG3YRQnM7FmnOYIPrhzmsxyF2gJ2AlC1USnFXuNCQygnr6flhkYVwrA5dxj7XA6
	 TNbRojYNm/XqFDwcZJl3v19Qh9sqeLduiLJwyKIlyT+4FDRlE5G6U7z0zCT4Nhb+RI
	 n46RehFK6SwdWabFoPlisYKQeakodv9MUvja1J94TjU75wH26W6QVfxHzgjII6YnnT
	 rwl70AVrhnBDnKyGFEJ5gX9ecIlMvhiMG27UziU+/wv91zzEuMsOm25F+uXTt276OG
	 xBDcAbrR2zj+Q==
Date: Mon, 20 Jul 2026 08:54:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
Message-ID: <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-4-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-4-egbostina@gmail.com>

On Sat, Jul 18, 2026 at 09:56:32PM +0000, Eduard Bostina wrote:
 +
> +    patternProperties:
> +      "^regulator@[0-6]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          regulator-compatible:
> +            $ref: /schemas/types.yaml#/definitions/string

You should not need this property, it is already in regulator.yaml.

> +
> +  charger:
> +    $ref: /schemas/power/supply/tps65217-charger.yaml#

unevaluatedProperties: false

> +
> +  pwrbutton:
> +    $ref: /schemas/input/ti,tps65217-pwrbutton.yaml#

unevaluatedProperties: false

> +
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tps@24 {

pmic@24

Please make the example mostly complete - add rest of properties and nodes.

> +            reg = <0x24>;
> +            compatible = "ti,tps65217";
> +
> +            backlight {
> +                isel = <1>;   /* 1 - ISET1, 2 ISET2 */
> +                fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
> +                default-brightness = <50>;
> +            };
> +        };

Best regards,
Krzysztof

