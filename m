Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3D1F30A9
	for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2026 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733541; cv=pass; b=hCEZo31j++DJ+dXP1rn6EgO5TL4q0FaZLzZ7CwmWGugsAZ2Odo2NVUeVAgVscl2sXN1f0hCb0SdvS+XlFT9q7GvgMv5879dd1VXTEdVBGfd4VBPjwwxJextzrNKAOlcAz7s3hff/zz7e47ds5s8J2BSHDLo6J67RHsrIK+9UVts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733541; c=relaxed/simple;
	bh=+G5Wylw68XgNtH6D5xVeqvnZZP1BRSsmctqG/RsT6eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcXy3hE4Cn7eP4+wLElN7Fy/G8bU+UA5x+7EjltK/HDj51zQGikmpZed5cbrzZECX431fQ4Lz2EQzWYC+1w4dd6z8U9IN37rAtJ+142/3pQ9FVqe0N0Saj8dQBHmNn5xCO9iCJBbspBFpdA1zRU5eeaYqIl1NIrY08KVnMtPZAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsfkehf2; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsfkehf2"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15f47e6297so942139466b.0
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2026 08:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733538; cv=none;
        d=google.com; s=arc-20260327;
        b=pKzt2Vg+W8sgTcvesikOpyTxUF2usAbPzfunn5yTKk3laAvg8aNLupsOhBW0KeTNbh
         YpjHwB2dzjIIFnsNxx60zvfl/+6Fc5yrhL8jegPioCMjuh126MSKP5KHYzHjir4pPhfb
         tIDgzaHHOEltual7pu2jUJThNUkfBgQqdA75njcJucoV04xnxlPVI2cN170HV6n0K6at
         2X5nvb9cgIisUC+DQ91n9OwBB6dxoUiOY93NJAxku/VMHqRrwEQ6VHTQ6ncs6cAIhQFV
         7OPk918/vJbb6DUk+fY90S+hJgJqqBSWB/CjZNoQZi3S7bLjKZbFJHdJ2BbG4tuId1++
         84hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
        fh=XrAAm88bIL0KQ3y1nRmrje8MxTqBecrVyOROBi5yGzw=;
        b=RoTNAZVwvxh8EPONR2wyTE7/9jAAZN5Wog4ZZ7CogIxQLo9fazqg2AUcwSC4I3e9km
         jFW1E3M4aYZbs/sEIhQ2V4AwRLJW41S1o3IJgrqmtZgMFp86ynhg4Aim9kMlz8mp3Df5
         nvheJMfkt2/HtR0GfNoW4bm2C8By6aQo99isdn/xXUOJ7R8X7Vq+QGhNbTkvNxbXjpyl
         aXMtYayNP56gIidmM9ZRXbexeryDkUKPvIWBQLHhlH8lMYQgiYr6mkhzfqI12fY4t+d6
         ZcPNXeUI0hhskZ/cz95HfdgiFZgrxi8HfDDDvIS3eHeBMEFUVM8fol/hS8BK4VHvz5wd
         9J6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784733538; x=1785338338; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
        b=dsfkehf2gRTOmYGTA6noprbWgxhtuUvNh9D8a+5KkfbXWpWrlEEeSDEikbPJDmQnEf
         A5ubEifvCH/ISxKZf8WcPRyVfvl6+zssPCWUB3Prdret+KeZFqD1T4O9xq92ql7mKr/U
         JVet+r1zvGU7nKHuFf8HZHSTaw2FybLRbksdIJXoa+RkwNYC+Y8lslKiYvcDfdpHnmsy
         dJRQhfanfoJGcnxHHyNSHqQyEo65U9uqIVCWKarPVlwE1fpVA6aZ+hZZefRZtgdMrQyW
         nrjR3s6Y2pSgN7Q/JpOU5P/BX0XYtzH12m7uMipXFSFc7t/vNHGE29tY/OFi1PCO1zTv
         teSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733538; x=1785338338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i1afpsh2OIvkZaaChULugvD8FxciERHSKG0pHwByaWw=;
        b=YqBGMjcUlP2YsrIySIJ++KMkeC5D+06fwAjUbB/amLbVumabyKJ+0mAt+kwK2sxefu
         BVLxXdo8ZdAdxDbrx63htGl7CZZDLxmkaNajZSAYGr1+IvzmxEM9Z9FhrcCpF/juhfOs
         4jjHhGE5sHZDKfy52seu6Rksb97Bp/436rcA/ryHTf4Jfsniz9JsP/Dfso5lHZZyaTga
         iHiygaf48Vk9+3I9mvvbfJ1rbWYAZgMkB8yXRAxaNcflcWeqOeMUjH4BBeQcPOdGs7bk
         0V+2HYeTg2oU5tkeOagsO8IZmp8rQLDh6ZunaYNb+NlI/iW9JGbCNvDw9L4AK3HtCj1c
         gsPw==
X-Forwarded-Encrypted: i=1; AHgh+RpAwCp6bjKZsm7RXUOhGje0yR0npEcMH5pJDZlx8wOjfmCVkE1oUx9OweUvAWY8PQ/KwhNpIb4Vn+Nr@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHvdY+/gX+qA8/XuYfeEVdQwqIg5OptEphMmeqebuIKeme4b3
	X8BFDEMGtkga1eR6MQECb2VKHHHKDlupHh2TJ/Hrpimuc1FEgPc0XY92Jz78+axiwnYQbh46Lxv
	WmuLQqMEsALwpTVjdkgaU1gOcQjYxkhc=
X-Gm-Gg: AR+sD10UmeLEQMWEejDoIK4MbmsQYGqyUOEwBigIxVaShoOCR40fWK6wKEmgvUC/KTO
	wZB/h4YmzkgtxVxmU2bm+Cwu0Bh0BSQwBymQ2Y8oRb0ive3yrDozzh0LgltPJC50YGZVSS+teoV
	t6/hZQlLknq3k+kU2zGJ/LI9xqgheU8RU9DY/piYI9Et6W+zmjySjKih2yBnokteFryeMJChAsP
	exgzDwXjQ9FaGPFMhSp0jpCy1MAAe42LTfyMICzrQAv1roD0MeZmzSsluht2wSvyPHByKspaijs
	p1rjpvl4+uQMYocWXVlHRAwW+9WOUITxkj+J6R8K31K6L20hAyKc
X-Received: by 2002:a17:907:388c:b0:c16:945:97f0 with SMTP id
 a640c23a62f3a-c16b48533femr836839366b.39.1784733538115; Wed, 22 Jul 2026
 08:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721112133.70382-1-egbostina@gmail.com> <20260721112133.70382-5-egbostina@gmail.com>
 <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
In-Reply-To: <20260722-ochre-alpaca-of-tact-ef17e3@quoll>
From: Eduard Bostina <egbostina@gmail.com>
Date: Wed, 22 Jul 2026 18:18:46 +0300
X-Gm-Features: AUfX_mxRkciUP9PmKB_Sf5WpXXnp_jwGYivbso-yHbHHBjEP1jiN3c0a8MRq-10
Message-ID: <CAEFOc610_15k2z-kCtuKkH3M3_ugE6uotvh+=oiYe560UOW=Ow@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-omap@vger.kernel.org, Mark Jackson <mpfj@newflow.co.uk>, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 22, 2026 at 10:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Jul 21, 2026 at 11:21:28AM +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments TPS65217 bindings to DT schema.
> >
> > During the conversion, the following updates were made:
> > - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
> >   which are used by the boards but were missing from the old txt
> >   binding.
> > - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
> >   and 'ti,pmic-shutdown-controller' properties, which are used by the
> >   am335x boards and read by the driver.
> >
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> > ---
> >  .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
> >  .../leds/backlight/tps65217-backlight.txt     |  27 ---
>
> Biinding looks fine to me, but as pointed out you missed to remove old
> TXT binding.
>
> Best regards,
> Krzysztof
>

Thanks. Will send v4 that removes regulator/tps65217.txt as well.
Should I move the binding to another place (mfd/ or regulator/ as
suggested)? leds/backlight/ is arguably wrong now that the schema
describes the whole pmic.

Eduard
