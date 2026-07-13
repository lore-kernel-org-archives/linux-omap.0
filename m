Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA07E0E4;
	Mon, 13 Jul 2026 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928301; cv=none; b=WgePMb/CHbEeW8+6GPmO9/QXd2qKDtkqAUKPetlcJNBq0+Fn5B/IhNsFvOamvQSsgsT1YtbiON7uLvDa9hegRIddNVfugsdCfuqzTmTKY+JswTWGBM4ENL7OgNEop6FETWD/va5C40g/pS7qqp+bc8m08J2edPOnJprrwyZSptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928301; c=relaxed/simple;
	bh=5Esc0/md1dcYXyPKmZLcixnjBNt2TQg2Nk2m4Ct3EY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb0wld35zjB65jOnQVDHYsksDwig8aqxCE+nxyT4EqsgqFEywbOHIUJn7sybJUwBvsYEwpzVyFG5HXZLfmtLnEcdbMSrmQZTT4X8SsN8UDEdmuFPisRByzgpwztXmgiJI3kA/DOeNYLo72/bhrNKuX5HYxKyb9y6lQMNIbRzMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHWAWU/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHWAWU/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F012D1F000E9;
	Mon, 13 Jul 2026 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783928300;
	bh=GOk+q11iQ5FGQBuFxsE6IN4gWGVpyDYBHJev4U8yed0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nHWAWU/T/RjmHrkeBuNNuw4Fm2S1sV9R8mVbQaQHKt5VV9K0aBrVtw6RRNTp1pL5U
	 Zt93F+0hre/OlRuaUiufTQMn2oF8+Vz6u7Q/+vULhZ8g9XuL3EG7eeCJaqNfF8iZ4B
	 aHD61SlT8ANBLuhopVlpXfMxSr5iJ77+tMF6AKKvR7MPOzbWxm/fAi65xuE7v6aEXb
	 ZvU2mgtRzEt1HqR45Os8kHacCV0hSYVOCle4J124zCcgsqK1SVGA86/cmyjphf2dVC
	 RH6Wson/gX8TOm9uMqGT+fo9/3dtti7weq6QO6SLPKX3rZcJ4h8OADMDvD7BUFoXmb
	 QwS8CDtLjZHlw==
Date: Mon, 13 Jul 2026 09:38:16 +0200
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
Subject: Re: [PATCH 07/16] ASoC: dt-bindings: add TI PCM1773
Message-ID: <20260713-abiding-jumping-ape-7ce8ff@quoll>
References: <cover.1783749722.git.hns@goldelico.com>
 <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>

On Sat, Jul 11, 2026 at 08:01:54AM +0200, H. Nikolaus Schaller wrote:
> PCM1771/3 is a simple audio codec that can be enabled through an
> enable-gpio.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/sound/pcm1773.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm1773.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm1773.yaml b/Documentation/devicetree/bindings/sound/pcm1773.yaml
> new file mode 100644
> index 0000000000000..f3e640705bf70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm1773.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/sound/pcm1773.yaml#

You need to use latest existing bindings as starting point and test your
code.

Best regards,
Krzysztof

