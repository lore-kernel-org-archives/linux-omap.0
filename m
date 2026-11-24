Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527319;
	b=ojLS0grrocbayw7N0WSxOEf3D+QZvbA4O3H8zd0Ew/WQomJLHrQWo1oq0klAY1PPdIpo
	 Q9ZWT+J8cczk8LAKhyHRWLWM5SL1sPLzA9NEeqVMiPR7x1HAgU52p/nWqg50aP5FIHIIa
	 qTHslbOtM2VvOy5XPM2mKp3Ve3UxAh/sQ7dDlH1zqjbOcNs1qjyvdlxb1OJOKbEllP/bx
	 FBr50fHQyKSiUNhhADiy6jDzHdm6x+dll7uvkesj8B7Jj3cFk3ArljUFcMj/C0XxwdVug
	 aa+yO1T1VHjA9LqDplouJ4iWzkvEzzIBbBcr+9537QiRqzvdveZl21Lo0jqExDprJlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527319;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=brA1TZa4Xw4gj6MGSoKR1QMCPQppauTAeMn4qP0Jvxc=;
	b=EtxY4gYjBTFwXHw/jg1c67gXLm4/3943WpSnDnHez645HIrzwLwEoZjYEqPkk4ysWRc6
	 MSVJPgWNi8/VGiXlnrZiehl5ullf28NOaty+qdQ/Ii8/QIwTJETl4qhTzMESy0dUKyEu9
	 3W2u2MmJGy1t3Q4KU/LBTcbOYeCtyXpkTE6aZogqqQu+GKfcBk0Yud/nA7INbdkyPJa9i
	 hrOo3w62ijCRkl1M3n/9dFS6QnihO9MyuCVqruXCRZrKFnfJeskfUz2HzTGJlGjI/CI2M
	 vCeDq5t+BLaXu1bkG9e3sZtp5a5cwy83pVd0Yz4u/IY1BkK0/MaGWIAvkYwBvCxv/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dSbn8Y/N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596D606A326;
	Tue, 24 Nov 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSbn8Y/N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521941F000CA;
	Tue, 24 Nov 2026 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527318;
	bh=brA1TZa4Xw4gj6MGSoKR1QMCPQppauTAeMn4qP0Jvxc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=dSbn8Y/NI1ECMCHeJz8N3SxMgDZHe+m/bc5KiR6zO3arfCHJFGOb54XmBsHndC0+V
	 vcjb8SFTRbLoKuKNbV/azVrHe6azEoNKNz/qSTWz1i2JRmUpvuK7w2lEaqoxzv0+Ff
	 oJBlc/Z+RlgnHkujXGg4c35l9BHhWa3dRHlg/0eRsRdPW4yVxkJr7Bx2/zCHRjYjGV
	 /AH9oZZONTz0rWgy021OWu/lg2Jp4aqTqXj47Gh3Yrpq1bqgYkNZ40zocELH/IhVSR
	 6uE6wBHJW47Rm+SU89zd0WmBwbgxzcfhPsDGqSYMV0NAigEXW1T6ZERf8FoGh4RB/u
	 g+o4oxsJZe+3g==
Date: Tue, 24 Nov 2026 07:35:16 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>, linux-omap@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, linux-pwm@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Thompson <danielt@kernel.org>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Roger Quadros <rogerq@kernel.org>, 
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org, 
 Jingoo Han <jingoohan1@gmail.com>, letux-kernel@openphoenux.org, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 kernel@pyra-handheld.com, Helge Deller <deller@gmx.de>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
Message-Id: <179552715646.40567.8345105080206889175.robh@kernel.org>
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora
 sound card


On Tue, 24 Nov 2026 08:25:46 +0100, H. Nikolaus Schaller wrote:
> The OpenPandora audio subsystem describes the routing links between the
> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio
> codec, alongside amplifiers and power supplies.
> 
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.dtb: sound@7702000 (qcom,apq8016-sbc-sndcard): primary-dai-link:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.dtb: sound@7702000 (qcom,apq8016-sbc-sndcard): quaternary-dai-link:cpu:sound-dai: [[4294967295],[3]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.dtb: sound@7702000 (qcom,apq8016-sbc-sndcard): tertiary-dai-link:cpu:sound-dai: [[4294967295],[2]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.dtb: sound@7702000 (qcom,msm8916-qdsp6-sndcard): mm1-dai-link:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.dtb: sound@7702000 (qcom,msm8916-qdsp6-sndcard): primary-dai-link:cpu:sound-dai: [[4294967295],[16]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
Documentation/devicetree/bindings/sound/samsung,snow.example.dtb: sound (google,snow-audio-max98095): codec:sound-dai: [[4294967295],[0],[4294967295]] has more than 2 items
	from schema $id: http://devicetree.org/schemas/sound/samsung,snow.yaml
Documentation/devicetree/bindings/sound/samsung,snow.example.dtb: sound (google,snow-audio-max98095): cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/samsung,snow.yaml
Documentation/devicetree/bindings/sound/fsl,qmc-audio.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@0:cpu:sound-dai: [[1],[16]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/fsl,qmc-audio.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@1:cpu:sound-dai: [[1],[17]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/fsl,qmc-audio.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@2:cpu:sound-dai: [[1],[18]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650.example.dtb: sound (mediatek,mt8173-rt5650): codec-capture:sound-dai: [[4294967295],[1]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8173-rt5650.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,cpu@0:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,cpu@1:sound-dai: [[4294967295],[1]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@0:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@1:codec:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@1:cpu-0:sound-dai: [[4294967295],[1]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@1:cpu-1:sound-dai: [[4294967295],[2]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@1:cpu-2:sound-dai: [[4294967295],[3]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@1:cpu-3:sound-dai: [[4294967295],[4]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@2:codec:sound-dai: [[4294967295],[1]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound (simple-audio-card): simple-audio-card,dai-link@2:cpu:sound-dai: [[4294967295],[5]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): hdmi-dai-link:cpu:sound-dai: [[4294967295],[20]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): mm1-dai-link:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): mm2-dai-link:cpu:sound-dai: [[4294967295],[1]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): mm3-dai-link:cpu:sound-dai: [[4294967295],[2]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): usb-dai-link:cpu:sound-dai: [[4294967295],[136]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): va-dai-link:cpu:sound-dai: [[4294967295],[110]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound (qcom,qrb5165-rb5-sndcard): wsa-dai-link:cpu:sound-dai: [[4294967295],[105]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
Documentation/devicetree/bindings/sound/google,sc7180-trogdor.example.dtb: sound (google,sc7180-trogdor): dai-link@0:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/google,sc7180-trogdor.yaml
Documentation/devicetree/bindings/sound/google,sc7180-trogdor.example.dtb: sound (google,sc7180-trogdor): dai-link@1:cpu:sound-dai: [[4294967295],[1]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/google,sc7180-trogdor.yaml
Documentation/devicetree/bindings/sound/google,sc7180-trogdor.example.dtb: sound (google,sc7180-trogdor): dai-link@2:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
	from schema $id: http://devicetree.org/schemas/sound/google,sc7180-trogdor.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

