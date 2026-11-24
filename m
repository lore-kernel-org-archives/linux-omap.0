Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795531813;
	b=XZVeddYgyd3DQ95atLaGB3RA0zveaPZ9EMWTUXxJOKkReqK3XM+oRS4HVugyQGfhITT1
	 K2cFSn9o5i5j9yoDI+9EdQG35SQ+Dggp9D7cZj+CPPxLStngKrRi+ABxivePvd1vNchit
	 c7pEu+MBD3GKOX2qFW/MlNiI8dJbzCj9gJMIqyu+0FxWnzzaiYSLH8Zy5sBa3EBxGOt7J
	 3XXh5vRZ34rorBk6xEzv4ueFx9Y7So6HgqRvpMptK8aCGdYQVY5wpZQx6cwMTjQ3PA2WC
	 ls0U297Ud8PdmcC0BYE9Bak72ivydUdO2soKeaw7sCS6J9Ecas3xFaff/RR+SOoZKZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531813;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=3wfW5PkmzSCGbjSgS4KH5aOe5wq8mU4dYCUNEge9nhY=;
	b=fQDKezdgVxg3WEvBOKOvV9MYq4j98+m085ouFoNcRlPVZ2TCpZkcaYqnwU97ViUth3j8
	 XN56Dcp7p4rLDj4vEq1DPwa6P+mjo/kzH4j8xyyjTB4asQNiuMaM6b0AwKcQsIL9s9rT8
	 S2rELcjTnvgmQ4oH0+DsJs0K6w/X9/VN+V4SPZ6LwCLGJT0HYwyiyqv87bYEvHmx7JKL+
	 hH9Atb8/DoMidTS9ld3tfo/YfqbQO999fXNrZl7pIXTR93frOzOId3wdBqNI+AulUKHFx
	 ZL/7QKCGbT3Q1JDqVP3XJYV7uYj9P9rNiyeoMMuIMU7vdF6xy8RKvo6prIyoRWWobVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="N/Sbg+Ag";
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rEqzJam3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.102
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F8606A31E;
	Tue, 24 Nov 2026 14:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 348F8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=N/Sbg+Ag;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rEqzJam3
ARC-Seal: i=1; a=rsa-sha256; t=1795531782; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dAhxvXSmiBKKgb+45n/Xo2CovjgV+ziY2NGUH39PRAgbojolpm7QAV9J8iH/VHI8lp
    vRQjzKyGLa2sIaZey9c0yGyB86RaeoiILF7Re6bXPZ9r457LeN58qeC0oYIXiInA1tWK
    wC1SogVCryh4BhTlQQkfHf4sukwTlp71AdScyOS8P8tvO3Zdv60Xm0owzxKAajk95vS+
    1H88tKpRM2nZWmXxZZqfpSTMyoHavCSlba2yAvAgW2PT7Jlv12GjYzDJu1ICrT1q3asc
    tY+O3qeRpm0wAmjsCMNWoXtq+XOfvMAmp1Wv/aQrh2bfEOTEr7D6ydZ3tZz+Z+VO4pal
    DzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795531782;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3wfW5PkmzSCGbjSgS4KH5aOe5wq8mU4dYCUNEge9nhY=;
    b=jDg6AFH5LjmDFwA4NGvBKA+q1U2abd7DnIAXarOnPKt7NHqW+u/64lLSPANxGEK1VX
    UpMFbnaTSDvwECqOU8JxNnZfAyfigX5xloUNUjjX69QrTLs8ok2VvcSbFMYPXupUbpRn
    vVB8CS4yEw0nRRfApHPN3v4Dwp8aH1yX/fF+q8eLff20QD5QHlZoGz+S4RxhJIWcHxka
    DiW9fuiMcVIlIc24jRTJKYRvgoB/ADzjRKpm4/5oUuJ+YW+7cI+Lc5QejG54yRAe0ZZv
    27raNlVGmN84OLBA7xnYyFZv1bd+6YoeJ6Wn7ufmWq/c8+KXOxeRUeiFlQlmPHIYC8K+
    AUew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795531782;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3wfW5PkmzSCGbjSgS4KH5aOe5wq8mU4dYCUNEge9nhY=;
    b=N/Sbg+AgTWDdgJw51hIAma9sfrPivzPQegGl0vLQWGYBbSJBkXVyCYLRhqlEGcEufy
    H98CuNQgZYNZfAe2KHqkqHpECe+3AZIcmqimC5b41g5+tKVdPt94+sSLa8eovoCto+gt
    qPCFhGR3RNfKym/3WUmZdDaWaFmCZCpAvGgsNLYsfpgTfAzVv/waGUU/bKxFZk95KV2C
    eLjkSQubqHFQYmqbo/aa778gQfHpVRX5Qtygka3J0ZSXfkOPfsfGIzPYJfKz/o80Zzw4
    ETIwQfDUD+zvvsLFLU9o7Uu+oXflG7NsGgK5tYNnHPOL3oMmJ23me4MzkUkB3gDTXrW9
    u9Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795531782;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3wfW5PkmzSCGbjSgS4KH5aOe5wq8mU4dYCUNEge9nhY=;
    b=rEqzJam3Vr3+e5NVXTNgGbpD3iSTySLuY2je+ZcXhqTyuDaiFHrTZ0UsGJGRH23Yco
    oJ8CIE1fjolz78Sq9xBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVWUgMvoVkTTR2P7jtjQyY2AeEP/F"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AOEne3fT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 15:49:40 +0100 (CET)
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
Subject: Re: [PATCH v2 08/20] dt-bindings: mfd: twl4030: Document 64-cycle PWM
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261124-neon-noble-seagull-df2d40@quoll>
Date: Tue, 24 Nov 2026 15:49:09 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org,
 kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1F1FE54-9C85-4708-AB24-D621582F555D@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <8e0c47487add0fa1bc0dad9b1bceef5ebf8071d4.1795505160.git.hns@goldelico.com>
 <20261124-neon-noble-seagull-df2d40@quoll>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.11)

Hi Krzysztof,

> Am 24.11.2026 um 15:40 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On Tue, Nov 24, 2026 at 08:25:48AM +0100, H. Nikolaus Schaller wrote:
>> Document the optional ti,twl4030-pwm-frame-64 property for the
>> TWL4030 PWM controller. It selects the 64-clock-cycle frame instead
>> of the default 128-cycle frame, doubling the output frequency and
>> reducing duty-cycle resolution.
>>=20
>> The selection is explicit because the driver does not know the PWM
>> input clock rate and cannot derive the hardware frame length from a
>> consumer-requested period. The shorter frame can reduce PWM LOW
>> intervals during startup mode detection of LED drivers such as the
>> TI TPS61160/61.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>=20
>> Notes:
>>    Changes against V1:
>>    - Revised commit message to focus on the binding and the reason
>>      for explicit 64-cycle frame selection.
>>    - Commit-message review assisted by ChatGPT.
>>=20
>> Documentation/devicetree/bindings/mfd/ti,twl.yaml | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml =
b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
>> index 9cc3e4721612e..f458f0d80f2cd 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
>> @@ -396,6 +396,15 @@ properties:
>>       '#pwm-cells':
>>         const: 2
>>=20
>> +      ti,twl4030-pwm-frame-64:
>=20
> Drop twl4030. Properties are not model specific, but should be =
re-usable
> among all of devices from that vendor (when applicable).

Ok.

>=20
>> +        type: boolean
>> +        description:
>> +          TWL4030 only; not supported by TWL6030 PWM.
>=20
> Don't repeat constraints in free form text. Implement proper dt-schema
> for this.

Ok.

>=20
>> +          Select the short 64-clock-cycle PWM frame instead of the
>> +          default 128-cycle frame, doubling the PWM frequency. =
Required
>> +          for dimming inputs requiring short PWM low intervals =
during
>> +          startup mode detection (e.g. TI TPS61160/61).
>=20
> I don't get how TPS is related here, but if you mention other specific
> device then I wonder - why isn't this deducible from the compatible? =
Or
> you mean that PWM consumers might need it, depending on  the consumer?

The TPS61160 is an LED boost driver used for the panel backlight of
the OpenPandora.

Besides being capable of PWM for the backlight intensity the TPS also
can undestand some 1-wire data protocol. It switches to that mode if
the common PWM/1-wire input follows a specific timing sequence.

Since we can't reprogram the PWM output connected in the OpenPandora
to speak this protocol, we have to make sure that the TPS chip never
enters this mode accidentially.

This feature is part of it.

And since the TPS is not described in the device tree and can not have
its own driver (because there is PWM and not the protocol) there is no
compatible to base this on.

Yes, I agree in combination with the comments from Mark that we should
split the series and better describe this background.

>=20
> But isn't this then dynamic choice - depending on PWM frequency the
> consumer wants?
>=20
> Best regards,
> Krzysztof

I'll collect feedbacks over some days and come up with multiple
series as suggested by Mark.

BR and thanks,
Nikolaus=
