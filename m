Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19837475C;
	Sat, 11 Jul 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755564; cv=none; b=bRjDmWYgtUEGs+ejvsXj/9QplBvNaZOMnENg0p73Pc1659bU24vn7t0nV2MRctaKIXy90XBzkGc/qi4IftyfUy1fO1lZ8EFcsPLv6yi3j7j8jg/Slvda+Xg0OHyAgAb/FbAniLNhmaszDSkwfVMPE/TWopiz4uxpLnU63BL7FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755564; c=relaxed/simple;
	bh=YCYEWqMTFfeXF1HRMWj57Z2nVa42zZN1nrHic65Chm8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=E20QL94LlwAZpq+g7GpcUBVjeEKs7RWNyOSdbWtl1LO70ZKYsMHOWXs6i21RZR/ILJUrB2oahVC3nv9tm1sqEYqZ7qdwaSIQAFGzxdFn9dF/zdlMKVRxCmTKgfQJAoO75l2iBQ6RGVaciBeNq7EKeA7i9y4oENSzlYlch35lnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAEUkMAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAEUkMAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1282A1F00A3A;
	Sat, 11 Jul 2026 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783755563;
	bh=iV5e6pRe5bHAjJTm6bWvI5nFVRDfFXzcLJLu3ZoiTio=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=DAEUkMAp2/M99hv5JAlJsvDDrRXFNP24LsCgoiohXjn6HURC+eEyNFPG3FEN/jdVJ
	 2cSYPMD16xyDYscq6hOUYQlWdHu6y3h038V5Lj8mRNWepM3vXLdf5Vbtvy9KQL8rI0
	 ri7EEkjZ3FD4ynF+vqFPeP0W+dXdS3tVli8dAI5NRmFfgrORV707PHCGOjv1Wq7HGY
	 WFXhJw+XW/+5tWrlblqFRBElP9YXVIyudq6eBpJlLxc7iN0/kasokANd4XFzJxonr5
	 PdfDjpcrTiOct/J2T0GdHzUV7ysbR0xPdOhpeE4J/a9rs8coZBjiVRAMLJ71QwQuH4
	 rvprBma6OslAA==
Date: Sat, 11 Jul 2026 02:39:22 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Stefan Leichter <sle85276@gmx.de>, Daniel Thompson <danielt@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, 
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-omap@vger.kernel.org, 
 mfd@lists.linux.dev, linux-sound@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Niranjan H Y <niranjan.hy@ti.com>, 
 Grazvydas Ignotas <notasas@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Roger Quadros <rogerq@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, dri-devel@lists.freedesktop.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Helge Deller <deller@gmx.de>, 
 Grond <grond66@riseup.net>, linux-fbdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>, Sen Wang <sen@ti.com>, 
 kernel@pyra-handheld.com, Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 letux-kernel@openphoenux.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>
Message-Id: <178375556139.2516965.6236993416627662539.robh@kernel.org>
Subject: Re: [PATCH 07/16] ASoC: dt-bindings: add TI PCM1773


On Sat, 11 Jul 2026 08:01:54 +0200, H. Nikolaus Schaller wrote:
> PCM1771/3 is a simple audio codec that can be enabled through an
> enable-gpio.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/sound/pcm1773.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm1773.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

