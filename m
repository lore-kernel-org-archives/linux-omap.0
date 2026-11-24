Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795531435;
	b=BySQbcp04G7Qn45AP0Uwie3O20kTP3BhPSh7ex//4vR7vhcVfEDGqKi85ANm5o1GZG8Q
	 jHH0Er4boVX20IkgNoegbItNFKO/PqPZ8B4xIcATwkp1vCl6Vq0SixlUbKQVvl/hweLF0
	 SMSx6nNjlkcTIXG4ww7nMlNsbgKHi20A+zCmwlQRYpSWxTILZobHvkWaGN9Ze5VJ6AVw1
	 pHHZrNG70kcELTdG7/GWl20hTABa2wa3svKDTHEEyA/Z05FcibfyX43F1mA8r55knoUzW
	 kkIQLKqDUa27KNsmNmReMLKLzaIPEhi0Ts0IgLA38NS1VthJ7xK1sDGvYpXiS+yZ7Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531435;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=wjMPCLTKXUXSTgUWJyqY8hYDFtiorHpsk/A6fPEGtNY=;
	b=bG5LV1JkaASZfjYDwn64RLInLpCY7BCElO0gF7y+I0TSJStgmQQ1UIHmEmSY0dq2M0uH
	 3Zd0JkhpkpExdPUHls5b4t6xSzC29Axy4WdivAMP+3FKrrqdxCmM7s5XfAtERMSzJKIQk
	 uDKF4uPJvJcY6dC62qXRh9fGK3bV8JHQEMpbDSfU2FCNGt4l3tCQLKll7MNheY3QiU4Xb
	 r8uTrfec7/oSeMPHWQV4+rFv6bT/J4Br3B9FNE6XOHqRlSlQrFG0nS7xML9RTAHlnNfpd
	 nyQPKuqAP7UE7nlrIr9nalEEN0cE3WIwvJrFTP0FMWTcPmv0C0EjATZOOJC/ISY3K2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="B/N3NlED";
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="Gm8rV/jN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.103
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654C606A332;
	Tue, 24 Nov 2026 14:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B654C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=B/N3NlED;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Gm8rV/jN
ARC-Seal: i=1; a=rsa-sha256; t=1795531380; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eFqapcrDkZWfDBugJ2ET555mbIpYEVehoLLZJ30Ke6V2BQb54yMB8BEb1EfkYX2G/D
    jxlhSJa5/Ru5wvdhGJ/DDnTAwcQH3PJEDoRPYfDJoINKWc2FBkp35BIX0mnlH0jr6e8C
    bEw30vBjZ5sIdRoavYNO6vGYsMkI4OhB7P0G5xXiiD37kxALzXphG+jZ3ZFFsufL70W7
    vKLkFNSKX9JqgJ4rNBaOD2SHMFY3Efi8PTyK8tBmDIBrAK/wzTb5pW3Mm3SAz2WIVtQy
    xL41sPIMIv8f2OJ6WxHRTn3JQzJRPS2wrfGI5o8ProndNqI7qvrs2ZP7UPmR+RubEvPN
    pjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795531380;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wjMPCLTKXUXSTgUWJyqY8hYDFtiorHpsk/A6fPEGtNY=;
    b=p7JAC0yyxvb9gDCsU9uNwfI25ok9wg9d0T9WxRcfuVEvA1PqHWzKpWAy9rQCexD/NY
    jUs8I7Xam22lqpZSyUBFji+V1wtuvOuKYg9RJiuQw6r8o8R2/8KLEr9+Wkn6oy2N196Q
    hvbGBsjcEka7kxkNgAKhEcZrwzqP8I1ELgrR4jwSnnmzB73cli21CEnowkhk+XeH1ho8
    6SPHU5hGt4dgMfA6pJPREP2m+iTjgHXeo52qxGVgo/IwhAJHFSw40MgKA1IkYw2H2eu1
    +gURGDhEzGottigCv8sP1UG6fLhgq6Ftt79D/xophmwwg7Dz3f6nFldeCbgilLJ6ZzQs
    37Qw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795531380;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wjMPCLTKXUXSTgUWJyqY8hYDFtiorHpsk/A6fPEGtNY=;
    b=B/N3NlED62XC53fS3dKlDLGNW+EUx5t5aIC+129AcWVLZgIEvrGsJu8Z/aR5UEgaBQ
    CGKHh8DOLMSIVtBDm2/JMmhaMT0nTcRTR6lX3ZUsGRjLArp+IFERM8p96rSY5ExI7+4B
    ROUg9knka+ouN9OUVROEWSMTwpo+0UVg2CtKhCfEqfl5y0uDUn7856HpOa6wr+rhvRaM
    g6EOP/0ytoBEgOeptjIoi7FL0xswmBfQbJKWiJJ2AOE5kFHdMxEMcuzfTe+kOyet+dN4
    djVOU6mZQzaC8N7sm+PttNjRvqCEuRJOuKv50ppSxF51gRqnlXgc3BpJaXK7zR0AaRAJ
    O7nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795531379;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=wjMPCLTKXUXSTgUWJyqY8hYDFtiorHpsk/A6fPEGtNY=;
    b=Gm8rV/jN7XY6sL30KeLRzBRmXQeucYP6KypPWqMDt63TNw2QRayySpECkE6kSlHjtq
    BvCB4jEKrBRkjmFDpEAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVWUgMvoVkTTR2P7jtjQyY2AeEP/F"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AOEgw3dW
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 15:42:58 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.11\))
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <179552715646.40567.8345105080206889175.robh@kernel.org>
Date: Tue, 24 Nov 2026 15:42:27 +0100
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Mark Brown <broonie@kernel.org>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 Pavel Machek <pavel@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>,
 linux-sound@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>,
 linux-omap@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-pwm@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Roger Quadros <rogerq@kernel.org>,
 David Airlie <airlied@gmail.com>,
 devicetree@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>,
 letux-kernel@openphoenux.org,
 Bartosz Golaszewski <brgl@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 kernel@pyra-handheld.com,
 Helge Deller <deller@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC45A20D-18E7-4D8F-A6F4-9F51FE2022BD@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
 <179552715646.40567.8345105080206889175.robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.11)

Hi Rob,

> Am 24.11.2026 um 14:35 schrieb Rob Herring (Arm) <robh@kernel.org>:
>=20
>=20
> On Tue, 24 Nov 2026 08:25:46 +0100, H. Nikolaus Schaller wrote:
>> The OpenPandora audio subsystem describes the routing links between =
the
>> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 =
audio
>> codec, alongside amplifiers and power supplies.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>=20
>> Notes:
>>    Changes against V1:
>>    - Address Krzysztof Kozlowski's V1 request to run the documented
>>      DT schema checks and fix the errors reported by Rob Herring's
>>      automated DT validation.
>>    - Update the binding example and schema during DT consistency =
review.
>>    - Binding and commit-message review assisted by ChatGPT.
>>=20
>> .../sound/openpandora,omap3pandora-sound.yaml | 95 =
+++++++++++++++++++
>> 1 file changed, 95 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yam=
l
>>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> =
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.d=
tb: sound@7702000 (qcom,apq8016-sbc-sndcard): =
primary-dai-link:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
> =
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.d=
tb: sound@7702000 (qcom,apq8016-sbc-sndcard): =
quaternary-dai-link:cpu:sound-dai: [[4294967295],[3]] has more than 1 =
item
> from schema $id: =
http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
> =
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.d=
tb: sound@7702000 (qcom,apq8016-sbc-sndcard): =
tertiary-dai-link:cpu:sound-dai: [[4294967295],[2]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
> =
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.d=
tb: sound@7702000 (qcom,msm8916-qdsp6-sndcard): =
mm1-dai-link:cpu:sound-dai: [[4294967295],[0]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
> =
Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.example.d=
tb: sound@7702000 (qcom,msm8916-qdsp6-sndcard): =
primary-dai-link:cpu:sound-dai: [[4294967295],[16]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/qcom,apq8016-sbc-sndcard.yaml
> Documentation/devicetree/bindings/sound/samsung,snow.example.dtb: =
sound (google,snow-audio-max98095): codec:sound-dai: =
[[4294967295],[0],[4294967295]] has more than 2 items
> from schema $id: http://devicetree.org/schemas/sound/samsung,snow.yaml
> Documentation/devicetree/bindings/sound/samsung,snow.example.dtb: =
sound (google,snow-audio-max98095): cpu:sound-dai: [[4294967295],[0]] =
has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/samsung,snow.yaml
> Documentation/devicetree/bindings/sound/fsl,qmc-audio.example.dtb: =
sound (simple-audio-card): simple-audio-card,dai-link@0:cpu:sound-dai: =
[[1],[16]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/fsl,qmc-audio.example.dtb: =
sound (simple-audio-card): simple-audio-card,dai-link@1:cpu:sound-dai: =
[[1],[17]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/fsl,qmc-audio.example.dtb: =
sound (simple-audio-card): simple-audio-card,dai-link@2:cpu:sound-dai: =
[[1],[18]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> =
Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650.example.dtb=
: sound (mediatek,mt8173-rt5650): codec-capture:sound-dai: =
[[4294967295],[1]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/mediatek,mt8173-rt5650.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,cpu:sound-dai: [[4294967295],[0]] =
has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,cpu@0:sound-dai: =
[[4294967295],[0]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,cpu@1:sound-dai: =
[[4294967295],[1]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@0:cpu:sound-dai: =
[[4294967295],[0]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@1:codec:sound-dai: =
[[4294967295],[0]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@1:cpu-0:sound-dai: =
[[4294967295],[1]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@1:cpu-1:sound-dai: =
[[4294967295],[2]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@1:cpu-2:sound-dai: =
[[4294967295],[3]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@1:cpu-3:sound-dai: =
[[4294967295],[4]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@2:codec:sound-dai: =
[[4294967295],[1]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/simple-card.example.dtb: sound =
(simple-audio-card): simple-audio-card,dai-link@2:cpu:sound-dai: =
[[4294967295],[5]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/simple-card.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): hdmi-dai-link:cpu:sound-dai: =
[[4294967295],[20]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): mm1-dai-link:cpu:sound-dai: =
[[4294967295],[0]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): mm2-dai-link:cpu:sound-dai: =
[[4294967295],[1]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): mm3-dai-link:cpu:sound-dai: =
[[4294967295],[2]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): usb-dai-link:cpu:sound-dai: =
[[4294967295],[136]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): va-dai-link:cpu:sound-dai: =
[[4294967295],[110]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> Documentation/devicetree/bindings/sound/qcom,sm8250.example.dtb: sound =
(qcom,qrb5165-rb5-sndcard): wsa-dai-link:cpu:sound-dai: =
[[4294967295],[105]] has more than 1 item
> from schema $id: http://devicetree.org/schemas/sound/qcom,sm8250.yaml
> =
Documentation/devicetree/bindings/sound/google,sc7180-trogdor.example.dtb:=
 sound (google,sc7180-trogdor): dai-link@0:cpu:sound-dai: =
[[4294967295],[0]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/google,sc7180-trogdor.yaml
> =
Documentation/devicetree/bindings/sound/google,sc7180-trogdor.example.dtb:=
 sound (google,sc7180-trogdor): dai-link@1:cpu:sound-dai: =
[[4294967295],[1]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/google,sc7180-trogdor.yaml
> =
Documentation/devicetree/bindings/sound/google,sc7180-trogdor.example.dtb:=
 sound (google,sc7180-trogdor): dai-link@2:cpu:sound-dai: =
[[4294967295],[0]] has more than 1 item
> from schema $id: =
http://devicetree.org/schemas/sound/google,sc7180-trogdor.yaml
>=20
> doc reference errors (make refcheckdocs):
>=20
> See =
https://patchwork.kernel.org/project/devicetree/patch/5c6f7deca16f70f1f19c=
b40c57d70e30068d6000.1795505160.git.hns@goldelico.com
>=20
> The base for the series is generally the latest rc1. A different =
dependency
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up =
to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. =
Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up =
checking
> your schema. However, it must be unset to test all examples with your =
schema.

To no unset the file list was the mistake and why I haven't seen these =
reports.

BR and thanks,
Nikolaus

>=20

