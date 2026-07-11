Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12263603C9;
	Sat, 11 Jul 2026 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755564; cv=none; b=figbmxlYmNac40EIKmFKzzolAa0HU2nsyiQGJXhSpl3mcJHF6BBZXZRBdFF40od0F+gCheeNWzp/XxE/BU375UCtFxcYxPpZr65PYIMh16tyCdEvUeLohGfsNNkVVPGlVrmyznv1nCz2xgJbfx02M4sK0VoSDg7SgFVgTVeROtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755564; c=relaxed/simple;
	bh=EwEusek1czoOpXHbaygqhpMtyKAbqtWqGBgOiD2R2ME=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ufH57enqNjMmhf+uXbYftrSubVQbJvc2ZbMFSzJbsMLdQsiZ7uApTi9ZLOxhoZ3VrXoT3WNflPlHsuNyT6rH/x++Br7H9EXCWyph7NsPPv8iUnCFmNLs3trzkTJjgNJG3r8MU1x4g4sVbDnU0209f/IGjwolQfezXLltS7cFPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfw1unyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfw1unyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308CA1F000E9;
	Sat, 11 Jul 2026 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783755562;
	bh=TYtjAVPyiyVCs7rEX4PjUS/qYasF91VWIyzMuMsClWc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=mfw1unyuyde0ALrJe/zfiLZV52Hf0qQbPaw+v/si5t6SCNDG+XDDrpRyzh4VfeRR3
	 PFkxRkHui1szF8apGh0eXyqKpWrtX/+h1xHkgpNha6Kqe7VfPJSgswBIGohK1t/Qy1
	 XS56RLqs4XmG1GENPccTJVaXXqajFIYGcKDpoWsztu37CxAw5raopZPOBSKu62msBm
	 J008e0O1weHW8gBfv8rQZGmkqETkt3qs9p6Zo7zgVwMnknuTCOgFM/6YIgHR4iIxBB
	 gJyJBaIhWl0aipIst8kQhZGIP7a+JrSt7nLr2rGd4O9EEcOXj+DhDcBWZto7L/DHKg
	 l9GYOiIPrY96w==
Date: Sat, 11 Jul 2026 02:39:21 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-omap@vger.kernel.org, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, kernel@pyra-handheld.com, 
 Lee Jones <lee@kernel.org>, linux-fbdev@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Stefan Leichter <sle85276@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, Niranjan H Y <niranjan.hy@ti.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Grazvydas Ignotas <notasas@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 linux-arm-kernel@lists.infradead.org, letux-kernel@openphoenux.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
 dri-devel@lists.freedesktop.org, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Kevin Hilman <khilman@baylibre.com>, Sen Wang <sen@ti.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Helge Deller <deller@gmx.de>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Grond <grond66@riseup.net>, Conor Dooley <conor+dt@kernel.org>, 
 linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 devicetree@vger.kernel.org, mfd@lists.linux.dev
To: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <7989e699de400c0fe3f0cb7af77a54077784df78.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <7989e699de400c0fe3f0cb7af77a54077784df78.1783749722.git.hns@goldelico.com>
Message-Id: <178375556058.2516925.10169600172051423562.robh@kernel.org>
Subject: Re: [PATCH 09/16] ASoC: dt-bindings: add OpenPandora Sound Card


On Sat, 11 Jul 2026 08:01:56 +0200, H. Nikolaus Schaller wrote:
> The OpenPandora audio subsystem describes the routing links between the
> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio
> codec, alongside amplifiers and power supplies.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../sound/openpandora,omap3pandora-sound.yaml | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml:10:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml:13:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml:18:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml:56:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
./Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml:62:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
    ret |= check_doc(f)
           ~~~~~~~~~^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 29, in check_doc
    for error in sorted(dtsch.iter_errors(), key=lambda e: e.linecol):
                 ~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 167, in iter_errors
    self.validator = self.DtValidator(registry.contents(meta_schema_id), registry=registry)
                                      ~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 488, in contents
    return self[uri].contents
           ~~~~^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 338, in __getitem__
    raise exceptions.NoSuchResource(ref=uri) from None
referencing.exceptions.NoSuchResource: 'http://devicetree.org'
Lexical error: Documentation/devicetree/bindings/sound/pcm1773.example.dts:20.37-52 Unexpected 'GPIO_ACTIVE_LOW'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/sound/pcm1773.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1705: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/7989e699de400c0fe3f0cb7af77a54077784df78.1783749722.git.hns@goldelico.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

