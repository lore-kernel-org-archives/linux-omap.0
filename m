Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95454476062;
	Wed, 22 Jul 2026 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706267; cv=none; b=I9b3OgauZSMuTczyWtXVKb7h3I6MkrTRpUbxP6eWFU+NLMK3ldtjzyEQNXh4sxZ63R95g1s2A8ma1Ss67sjtjmCPjWm1+zi2jaeThPO5JoPLdM+YkIJpowHzbyrFF6vpsXycRpSkiTWt+ICuiBm96SG5ERIeTAuR9WwrcJ6g9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706267; c=relaxed/simple;
	bh=qXm+p7zcqfPvMBHTU21Ju8ppUnIsyl5IYr8Q3lZ/z5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmwWp4fb9ZsmIf5RWqAgEy7lNIhVmuLmUb2Zjb+3Yn6bjgbeorLepoIoscdP20EWkMZEpPWgCPkT7kJQtX2Vs2//+KibODV3mpmNtK34dqwaWFDs6vowNljhj9cS5gVet2atGN4xityDrVDb68YgodUM48k7MB4jkPLCoMf1JZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVrUwtL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVrUwtL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EF11F000E9;
	Wed, 22 Jul 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706263;
	bh=V4l0bgJu4dNffwU2H6XOh7AyQgVAynIIBVSAvtuEEbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FVrUwtL1R2NHyf4dsixrMSxCVF7LbcNDxl3A3VrXZ/rL9ZRCXQrUcDfiM8WT+NaRl
	 TnWwMIUZA1YPcaOEXh2gey4o6D9tUTosCR/wvcxEW5Sp4y91+MfBo02cYaaykOudGK
	 wpSThs96GvD5AioSAtdsYVT0RsEqj3Rfaciupj8mwl3FbyiCuLDNZfSTReoPYnjORK
	 qM+NE2tG9MeT8A9rZXaJcC1EPKKGIM3QR6xHABxRN39sOjW81oIm0wm6XN7TLTnmDq
	 m/TjOPG/iVvWI+qbFaDN5B2MYeWeEFFxSSAGw7avFPNOaEcJIEWsyYsP2OKGSH3uRR
	 2jZeEEyqf4r5A==
Date: Wed, 22 Jul 2026 09:44:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, 
	simona.toaca@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
Message-ID: <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-5-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721112133.70382-5-egbostina@gmail.com>

On Tue, Jul 21, 2026 at 11:21:28AM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
>   which are used by the boards but were missing from the old txt
>   binding.
> - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
>   and 'ti,pmic-shutdown-controller' properties, which are used by the
>   am335x boards and read by the driver.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
>  .../leds/backlight/tps65217-backlight.txt     |  27 ---

Biinding looks fine to me, but as pointed out you missed to remove old
TXT binding.

Best regards,
Krzysztof

