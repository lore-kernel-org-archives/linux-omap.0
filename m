Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AE7E0E4;
	Mon, 13 Jul 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928367; cv=none; b=nkGuX7WMZGov3OZzIu5e5rbQA/K5Sf3TcXT1qk8wgL3dtJqp+3Ev54/2cWy4obDUmU6MtwqywfYSoCZiQ5p0QRjcbLpU5hCX2IfUSkJWDCTp4VFUS9Sse+1c9FBGscsca+9j5bJGEHaHMLOUq16IgwVa9ZV+vxrtZs91wWQ3xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928367; c=relaxed/simple;
	bh=5FP4NVlDZQNYCUyj0g8FbrAkZY9FoBlt1xLDWjZ7Zzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrz/Zwg4xR4CxMBh8otL2Dc7ng+UymAFzARYiaXaQisL7L07mlLHR072pR3ceNKDQwu0kXmEri7chK9PW9UG01lqHPQuC9VB5Tqxus+nQ0hHgJpfqnvhmGHj4CVCjBaR7Rb/ujZp+wAWm0O6/UdpOec2fHjc6RMkXoa5cIdbEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIzr1qLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIzr1qLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897DD1F000E9;
	Mon, 13 Jul 2026 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783928366;
	bh=4SLrEtPKJZ9McaHLWnqLfegFeDqMlOMFc4Y8tHwrtXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IIzr1qLNUULtevegyuR89oEHlFQ23S1IkHVuva7jxxnZTpPzRSOm3nITKPUQ2BnzM
	 d2C5gBOQaN2qIYb/XgMBqlSdeSAyZzo6nPXSONQ/Ac4y4Zn0Kcg2e6Svq6lVZjNzwn
	 ZYyTS/Qc39cObYasBpdjlWNRmanmuyhw9xJWMsjQ/Pq9Z6W/vuiO6pA4Mq8eF/Z6XZ
	 7ifQvDuNRBLXBLA1QLqcYYq8hxg+KJmYnR2twoRhcBvsB0+2bV6bytbkl4dzK0GOLL
	 mam3rDgJfp/mkXq72+uoSqUjRefvJQkEv8aFGGAcvbZotorH2qwU2BO1g7Rk2uV+/g
	 Q6A08PLBaqOCQ==
Date: Mon, 13 Jul 2026 09:39:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>, 
	Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Andreas Kemnade <andreas@kemnade.info>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sen Wang <sen@ti.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>, 
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Niranjan H Y <niranjan.hy@ti.com>, letux-kernel@openphoenux.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, kernel@pyra-handheld.com, 
	mfd@lists.linux.dev
Subject: Re: [PATCH 01/16] dt-bindings: twl-regulator: Add bindings for
 exposing ti,twl4030-regen
Message-ID: <20260713-aquatic-memorable-griffin-cf9e46@quoll>
References: <cover.1783749722.git.hns@goldelico.com>
 <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>

On Sat, Jul 11, 2026 at 08:01:48AM +0200, H. Nikolaus Schaller wrote:
> From: Grond <grond66@riseup.net>
> 
> FIXME: not reflected in the bindings
> 
> +Reguired properties:
> +For twl3040 REGEN signal:
> + - regulator-min-microvolt:
> +  - Same meaning as in bindings/regulator/regulator.yaml, but must match
> +    regulator-max-microvolt.
> + - regulator-max-microvolt:
> +  - Same meaning as in bindings/regulator/regulator.yaml, but must match
> +    regulator-min-microvolt.
> + - startup-delay-us:
> +  - Same meaning as in bindings/regulator/fixed-regulator.yaml.

I don't know what that means.

> 
> Signed-off-by: Grond <grond66@riseup.net>

As explicitly written in submitting patches: we do not take anonymous
contributions.

Best regards,
Krzysztof

