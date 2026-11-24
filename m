Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795531949;
	b=a3Ge0v3ERkYmWbzG+oxR4937HLP5jPszztLGWr1coG3vU/3HsC+ewWKe0NaoS3olb0cX
	 isZDOZHOiySJtZnDu2hUP7l4+VTAyeM+om6vC8dnNk2UiJOYOuz4ySxrtzwV71til8Xt0
	 fQrcBPMT1+zqyrpJlDSnIRp1dSh5KxG4yhqtjcofCL8m8qDXkr+VVZj85yPH2FrdslVMs
	 NSNQ6mgC/r0Aq57tsG/onskf7mQtZIHJ9oyg5K15YnH8mdAZEYm2QdNj92SZu6dptzAEA
	 zrKmJlaQoR1ztugVgh5Jpnj1p6kuDkMjDn9sm4gWuHHRJ9ycKMFejHZJT4aivUd0Npg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531949;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=sDNNJ2qecfiNiBlu/HoIFSrNzNgDneS/Z9HnceIVm4k=;
	b=vy+FhdVradjToSoI8xyHn+rcJQ7rLJWjgbiJdhv3UG9TV7mKFs1Yjm5qGcu3cLfLV3rA
	 NJfvlp0pc0du9uDh0aBMEJ410tu6AgcuuMxtvPymoZ+alvgrD04MSpUyt4I7Va7hYtbDH
	 r6OijfR+vIlwMzvY69ys4t9/e5nMXw1qM6P40jvCaawO5gXryYTj7xqpWTlWt0twT6qbk
	 IOT88IrPS9YrHZg4J7A0DVS9BeYFF3b6FUa5swY3QPz0Esnx7aLIt/57gl+rU1bT/KUNk
	 6ckmrBPFwyXqRGLzQrVxikDeVFvOFZwv0+MDW4l6gwtolrH9ZpodNaNvMpeTkm7A5TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=DUO9ZTB0;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="FO/KgIrr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.124
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152C606A31E;
	Tue, 24 Nov 2026 14:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1152C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=DUO9ZTB0;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=FO/KgIrr
ARC-Seal: i=1; a=rsa-sha256; t=1795531887; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AGAUuV+AGkt1Lti0/74vBNAl6v1mYRSgS9ZK1Y0cTbTjphH1D0HXcMTgf8pqsoUEDu
    8FgYs/qxh/zZFr8XGUGGLADQDNhdd0+cGQL7S4m/eZecUUDpZR1Vz7pgefqNCNAUxMPI
    zqZc+CkAIltyjLl6TOcoqVV1W3WVdDgaUtabB0kK+ayTlDwJ1XG4qXojbcWbkuZ9j+15
    qm8c/Z8i6YTfl7H1Ph4UC7kiCGJUUDBZ0oNNIe7+rJY/gUsTaxZjcm0RFt6jZvHHTM3G
    dvWg/XzNqXh0JijNEgHYmDcboACCf3mAHD6+uEJSpewSpXR4jxBbyYdzqNF+Nr2Z1ybE
    WAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795531887;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=sDNNJ2qecfiNiBlu/HoIFSrNzNgDneS/Z9HnceIVm4k=;
    b=BbpCALDKiFdjr2IXHXhTrvnFayjbVaoOVu1F22gYhVvwZgh6hUhmV5tfbPmNBFpN89
    n3NrnAQrfRTcDwApr1B7aBzgWAKGOB3AIshooaIFNSCG97/tIlPMe0rpswPg0UszJnsl
    a76uqzllhdHL/n2yKgBks5O2yvbDrhuOJXWr6PflTDy60UgD508Zun1aU54RtgTSUtfH
    5YUNgWizlgwuxifKuWfMRFdP4Jv3PV3Sd4Zg6PmdVOqvrAVdkjwDAORQ4/Boms8IZ0bU
    mSaNDLgahuLYQE8HqIzDAJgGxILCqHU6im2GW+kDpmw0v4q3joKKVKjM/+Jbdl+ZKjw8
    Jpcw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795531887;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=sDNNJ2qecfiNiBlu/HoIFSrNzNgDneS/Z9HnceIVm4k=;
    b=DUO9ZTB0i+350z/oV/HSI6YtPl55Mm1vcXtCZYtOcvJJVRTAhm9YM5Rny8uipAc+wZ
    7cF1MUtY17VtraVF/9VdJ4iipUFTf/bplgoWExNxfFg69n2omukEALULRNO6PT6agEF9
    VNLBGN2BmAFuUsztZCIT/mw/XPxi+ypjKKVJv8CpC9HSCOb011lWuLizRXYGXJxkHV66
    xjD6U+ACC4qtzrFNyy8b8IfaMosv3DGTgdtuCysJ2TnBEcsNFa9O9rR1gzezfSgWbqyQ
    wr9l/3vfqTnjLV93CDMVfF9bWqU2DL0GmgFk2rfOL0bqJFB9/x7RG6wbEqT9g20Zqrt1
    qwLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795531887;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=sDNNJ2qecfiNiBlu/HoIFSrNzNgDneS/Z9HnceIVm4k=;
    b=FO/KgIrrZ6O+NJg7CHtRSQvroq+XUsSTTFco+O/8Wf8UDLLq5C5KnE+pc0NKwvZbiZ
    Us58QBEHkfGTvLrLgLDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVWUgMvoVkTTR2P7jtjQyY2AeEP/F"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AOEpQ3g3
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 15:51:26 +0100 (CET)
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
In-Reply-To: <20261124-crocodile-of-marvelous-essence-ee7b3c@quoll>
Date: Tue, 24 Nov 2026 15:50:55 +0100
Cc: linux-fbdev@vger.kernel.org,
 Lee Jones <lee@kernel.org>,
 linux-pwm@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel@lists.freedesktop.org,
 Jaroslav Kysela <perex@perex.cz>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 David Airlie <airlied@gmail.com>,
 linux-leds@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Helge Deller <deller@gmx.de>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Daniel Thompson <danielt@kernel.org>,
 devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Roger Quadros <rogerq@kernel.org>,
 linux-gpio@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 kernel@pyra-handheld.com,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E342D73-FAC6-4D8E-9A4F-D9E81DC5D8C2@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
 <20261124-crocodile-of-marvelous-essence-ee7b3c@quoll>
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3826.700.81.1.11)

Hi Krzysztof,

> Am 24.11.2026 um 15:45 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On Tue, Nov 24, 2026 at 08:25:46AM +0100, H. Nikolaus Schaller wrote:
>> +description:
>> +  The OpenPandora audio subsystem describes the routing links =
between the
>> +  OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 =
audio codec,
>> +  alongside amplifiers and power supplies.
>> +
>> +properties:
>> +  compatible:
>> +    const: openpandora,omap3pandora-sound
>=20
> openpandora,omap3-pandora-sound
>=20
> (add hyphen) to match other style?

Yes, that is a good idea.

>=20
>> +
>> +  label:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: User-visible name for this sound card.
>> +
>> +  amp-gpios:
>> +    maxItems: 1
>> +    description: GPIO pin controlling the amplifier power state.
>> +
>> +  amp-supply:
>> +    description: Regulator supplying power to the amplifier.
>> +
>> +  sound-dai:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    minItems: 2
>> +    maxItems: 2
>> +    description:
>> +      Phandles to the audio CPU DAI (OMAP3 McBSP) and the codec DAI.
>> +
>> +  routing:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description:
>> +      A list of the connections between audio components.
>> +      Each entry is a pair of strings, the first being the =
connection's sink,
>> +      the second being the connection's source.
>> +
>> +  widgets:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description:
>> +      User-specified audio sound widgets.
>> +      Each entry is a pair of strings, the first being the widget =
type
>> +      (e.g., "Speaker", "Headphone", "Microphone", "Line") and the =
second being its name.
>> +
>> +required:
>> +  - compatible
>> +  - sound-dai
>> +
>=20
> allOf with $ref to sound-card-common.yaml and you can drop routing =
property.

Ok.

>=20
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    sound {
>> +        compatible =3D "openpandora,omap3pandora-sound";
>> +        status =3D "okay";
>=20
> Drop

Ok.

>=20
>> +
>> +        label =3D "OpenPandora";
>> +
>> +        amp-gpios =3D <&gpio1 14 GPIO_ACTIVE_HIGH>;
>> +        amp-supply =3D <&aux_5v>;
>> +
>> +        widgets =3D
>> +            "Line", "Line Out",
>=20
> Join these two lines

Ok, increases readability.

>=20
>> +            "Line", "Line In",
>> +            "Headphone", "Headphone Jack",
>> +            "Microphone", "Mic (internal)",
>> +            "Microphone", "Mic (external)";
>> +
>> +        routing =3D
>> +            "DAC1", "APLL Enable",
>=20
> As well
>=20
>=20
> Best regards,
> Krzysztof

BR and thanks,
Nikolaus=
