Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6853FE34D
	for <linux-omap@vger.kernel.org>; Mon, 20 Jul 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556454; cv=pass; b=t74ftz4OSV7N2y+8lhvfukZvy6rRXarVy0jW8kp0rrkMKApxSau9PJmZIx0+Pubx0Z6CEGoC2iuz7tOjAonPDRJCQ+FuFxWuQMXnt0l1ZLj5S4wUqp6dGGIjAI+x1dPujq5gEiPYI/yTyWH9uDdicDAmelI0wpDtx3a2tIEQwzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556454; c=relaxed/simple;
	bh=r6n4V8oTIiF6Cc2yyAdGZUbNGGVL2QpLuXftiOlSQEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrhirQw42XWEmSxoO3wSK7Ip8xzjmwaJqM0LhlU1PG7laW4afs3aRh6afaMJAWt/UrKA1BxzZarMNTBkIHftAu84V1PBSN/83g2FteNgy2fU734JT2oYAcWkx4YooN4p0Z1zzPGbBQD2QT6ITXU+HzVXDWzT9PuD/ot60aCTRLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2MgLzQt; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2MgLzQt"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1712a04ddaso638422466b.2
        for <linux-omap@vger.kernel.org>; Mon, 20 Jul 2026 07:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556451; cv=none;
        d=google.com; s=arc-20260327;
        b=UWTbjkd7o2MvwDzza+QUQIiq2XqmmI7xCycDS7UmjpVMQJvWL1Z5P59t9Pu5dj7YXG
         Viwfl65PJ+/u2Ud/JCqsFwmIZ74vG5sv7IqpQdgl1Q+ZIh7tlwZO/ncZKTTBVDj6sfDP
         ILT6wwuUpjRW+JrkJHist3Kl9cVSBPVx31y9/XuXLOw9jRhq3Wr+PpQxsLE6/L4iiRDS
         +WXe08ZXcqQRTu1VqIlok+OXLBecin4ktBZBHjCxICIPjcwTLRnJtCevdPwHcCDxsyTg
         hrMgpbLOuLN5cmGoe5RphTLH/j4xgHnSa3nJwqxQN6EhbpWTMatEP6e37CyqOjdbjwXo
         xM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
        fh=pT0mlZmSYFyMTYv2h1SYHfZP8bSkSNhyAfEf1OAw6vo=;
        b=rrizZavVgFBmjqetgSs8PF182ANJ6b8/Hhjsu8HZ7oEJ/tvnMPL50HhOSls/eInaKN
         wk9XJ+iKPrbW6eMPaJmUueB+d/A7O+gVwyGmiE0UaXyHguUxMBweZeACV5e6QNsfSkhu
         19cEByn/Cejc9nnwHjRLZonfZlEpywaiQw1DudluW5e6WeXHrYFDvExjLjywjg8PQSmS
         aEwul1a5XMeND4VAmcvCQG9WYLMPik4G/UyWxJyGWIuFi2a3qN6/au3CA/J3iIgPpmuG
         jKkZXO0Oojrgz6l6pgn1+CYnD08RTA40jgvDVJOB8IOCU60ClAyeAXxqqKc4B+tthaDg
         PlgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556451; x=1785161251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
        b=a2MgLzQt3CGzGz5eMCYyv46AMhuVNalm1K4dR3Xeg9zOQXopfu28uSd3Dn1MyG+UDY
         LYpOHmPxBsoaN8546q6TXqs+nKWL18NMO3lr2Bupq5pBlbbYXDpur9PaRE1q9w9pPM6K
         AEW3veYlo92OAzIkA6CO/Gr94w4wDHO+jtBaD3tVY1cIG2MW62IEUP3MVFUI/xLQnpDr
         tSMJ1bDo2L7hwBKlwSJuasLfXQFZ5UZ7RdrND7BAzm4QXHB+LVZ/5QEAwP+mI8qnke1N
         /2OoDp7r6SV/+olx+3tY3o11kmS7Ndwsg3xoH8M3sT+Gu4eqZwkWQTwh8ZADyrwc4VAa
         gTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556451; x=1785161251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6aKvIAiL2N7RKSpb432cnl3pylXzPZaT0UMOHNdrnY=;
        b=Ene1CDqXoS+0E0cASCn7jLk6EUBDStDuspgagPSdyioXiFnOBNrfHLwajzHtAuJ2fR
         L88+UQvqydsh3s1w718t4Lxl23ewmGx+wY45ch6sytrZZ3LGCIcHaHq0BmUO/cQcQk1V
         qv80P7oVCEJS6ypK0YcdpptVwK0WvjBlYEOoHajb9uAdAF7kBbaGLn7FTs6StL3gEQ7O
         Xa+P9k2vY4l3KKd93/vQP7zcGG9ew/2Fx7pdRfciH5k6yxNIaZtsZJl+KFBEcSTpeIrL
         UJVXsGPNGHGqz9dv3RvyetQvifObqFCLk1rASD4SfDRBDsxjZ9yJm/JuA7S5OQ2fPXJy
         DcEw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1l0mpClcVWZJA6b7EoD+4VBZyQoStsRUef0HpWJ44IpPc6uIS55GnoXXfVu0Y2a2CVyENWjdAQeBD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyql2iRmexLFw2KkEj+qr5KqDFTGFrDG0wQVWL9rD5D8vdQz4uE
	uvA/SH4k5Th6jZgZxesnKcerb7ld4u3d2cKqpLFPhAMJikZOCIdF1U+/Ri7dZ6cwsQewFIAc6wB
	U8063LuINjPB3nGas6J75vaLefEdrSwk=
X-Gm-Gg: AfdE7ckOatL3sfNm0OpkGVt2HxUKmOK7i6g0OCkjojuHV7R5l+mKEPJZhpw1rMjOXd3
	bLxIFZqTXtrfcqKd9Wu3wx1BRD7fo5asHSjLgFr1ASOLVarYwhg1JDeVpQxaKGZJjYnlREuYHUc
	mIuzLcLEY+Dxn32Fnix5ZgRr5w7sSbw7reqgH03yaHvQOapu1M2AplVynyhheAL17khdhDM4X2U
	AEfnEj1gHXADyAOSIC452LCUjzJHrW1vdZwgOtv6Kz0ex3sX8LcTfUzXUGXaO4mXgto+17arhXw
	66rOlku0Dlqhkl9iB0Ui9Pj2SpA7FUsRCU0joPgX9W2cLIQIrKVv
X-Received: by 2002:a17:907:c012:b0:c15:c3bb:c90a with SMTP id
 a640c23a62f3a-c16b47c7292mr550030766b.35.1784556450739; Mon, 20 Jul 2026
 07:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718215632.3295049-1-egbostina@gmail.com> <20260718215632.3295049-4-egbostina@gmail.com>
 <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
In-Reply-To: <20260720-huge-sturgeon-from-shambhala-a1bdcf@quoll>
From: Eddie <egbostina@gmail.com>
Date: Mon, 20 Jul 2026 17:07:19 +0300
X-Gm-Features: AUfX_mweWNBqk7caXjK50S4Mh9MQkC1xza8VdHGojIe6ULgydOnDi9gkyNgr6GE
Message-ID: <CAEFOc61Tan85xQhz33BuGSnJHyACvjRc+6YMFYav85CzxMwiwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-omap@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
	m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 09:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Jul 18, 2026 at 09:56:32PM +0000, Eduard Bostina wrote:
>  +
> > +          regulator-compatible:
> > +            $ref: /schemas/types.yaml#/definitions/string
>
> You should not need this property, it is already in regulator.yaml.

I did not find it in regulator.yaml, or in any other schema, but I
found out that it has been deprecated in 2012 by commit 13511def87b9
("regulator: deprecate regulator-compatible DT property") and was
never carried over during the conversion.

I agree it should not be in a new binding, so I will drop it.

It needs a dts change too, tps65217.dtsi names the children
regulator@0..regulator@6, while the driver matches dcdc1, dcdc2,
dcdc3, ldo1=E2=80=A6ldo4. of_regulator_match() looks at regulator-compatibl=
e
first and falls back to the node name, so without the property nothing
matches and the regulators stop probing.

So I will rename the nodes to dcdc1..ldo4 and drop
regulator-compatible, reg and the address cells.
I will send that as a separate patch in v3 along with the other fixes.

Thanks,
Eduard
