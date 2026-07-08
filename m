Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2744CF44
	for <linux-omap@vger.kernel.org>; Wed,  8 Jul 2026 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515296; cv=none; b=JT/jxYGiw170OI08hePYK+ld+c6xc1wWtCuJCF/WcRmWufY01WbwkvaZN1qJulbAhQAmR3bnLGeeRdzV2wNbfUmFrYB+iBULwGdINjcnnh3bJmqFa1lcChUARYVdgwPBI2fjzcwM5et9J0cbbPBQAadOXux+eRgdxKYLiKbshyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515296; c=relaxed/simple;
	bh=NqIdz9eEaKfnjtFoMaD9625M1qr2VdseCv1Uqzseygc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7uTgLMcX8zRWHiXBzVUMMK9Ou8ZLGQtPhrz6JjeyfdC6QMi7v1QdMDrow0l+pj5dJc8J5E9zCWJgYBCu90Onk9mQNbEQSc3QhBEsi1LyzBKJm1EWgor5Zo1R4JGwNv1ogcSoDdku3br43v5rO/+3T/lXS2agab/9nomWF1JTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OPchiDIQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPchiDIQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso1179283a12.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Jul 2026 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783515293; x=1784120093; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NqIdz9eEaKfnjtFoMaD9625M1qr2VdseCv1Uqzseygc=;
        b=OPchiDIQUJypNYvQDZ5Emw1SPIjZMHfIfJz/4WNNtBw34u0DgXs097IcHrO/tft+pL
         5RkEn3HDA70TDl/nqQl5u5I6LbTRBPldanvHaX7C7u4VtoIRT2IjscdYeYVzwxqEtFC9
         8zNLW4Xk/H9tKCf6NQvOInnKR/0wkVgN75Iqx934PbZbl/9eL8wGP7Ow+KidHDW+uaa3
         WGFVUAxJa+hSHN7veFSM9/zOKXazGzNQd2EXwur8xbp2nFLePZheZnMkxfVVxEpfURil
         tOf1SXcjX0Gdu3aeDuF7dEPD/dELQ5kN0RvxrNi0R0XfUU7PypMXR3sP3DdwGKQwobSb
         qEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515293; x=1784120093;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqIdz9eEaKfnjtFoMaD9625M1qr2VdseCv1Uqzseygc=;
        b=Z3wpAW6P2bBG3dvRZCvt1efGenlssPdL/R+J6T7AuaB/BFAXPp/r2J5lIf+il8jn0R
         8lkm7W/8B7PE5mB209UD8dbKxRp4se00oSXv5ZI75JM5Lp/ZlFcs7ZKRk6qNLeYMPuHE
         Ehqf5MA0b0k/EBCLA5ZmgD+Fjig50XOuTHX/zolj9WRYJxbdU22dsjBd3HrBqsqYRLmS
         /C4ngS/Cn5JajYMbXVBkUvLQPJuIPrawNfeU69CLBQVsHamAn6KAM6tAyKzNx9kflTkB
         qyM0hDt/bN1KVIRwwFTQeH+SlH/8OD7Kqn99/6CBB8nFkRasJHzMSUbOJtk3yLZMghKm
         x59g==
X-Forwarded-Encrypted: i=1; AHgh+RrlBOPila3Pf1KmZvaav0L0fLfKh/j4ztME+3QB3aJfvNZnmzjXJNk1mkTxVsK/JnHZrahpS9KvR0E9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LdZZF4skp5kFKUWzWjbODHcYsDGkOoYDjl05SNaTQTzl6wjR
	ydZcFycIRkqNxJdOm/rMLxsb1CX1WzpNt3q53tiuP6QjKnVkjwYcfUmkm4dZIrBg+rQ=
X-Gm-Gg: AfdE7cmss3TEEVaky7vtifU98nZWnn1lGjWFXN0h2k3htFUJZWE1M618bN4UxSjt4ya
	nW/Cdz3kRucHgW7e+16VxjcEo22f0oMZV8sMfbg7TPgT7xK/2BuA3ohjpoSl4BLjaCe0Be7GcVI
	xKQKvdnXMf+41dWUknN/7UvKLzXAFed7xa2AZ7SO400GJoga3u1mo5oC0w9XU50HAhF3bbjEZzS
	3LNlN1pENm+GlCRuXPj46h5mK1fwv+0GlLel5Uxh9QUf0ILdFDUjOnsff2nmN1Xgalz8/7U2ACa
	fQQRVvslxYxPO9zlNGWVl5FP3DHYsFnRP8oFjyJuRpriV9cPyU6LFL9ZQwZC00bvYfoMS0MjbU7
	qOncQX450/ET+AQYQ11tisj6Lk9C+i4RckiLj2+vFyGuMOBl7DpCjh3f9mNce6sbUH7BukNrtLZ
	fsj5j1p9pvQhZu4KZ2FsI=
X-Received: by 2002:a05:6402:1906:b0:698:b60b:aac2 with SMTP id 4fb4d7f45d1cf-69ab4453d30mr1054344a12.4.1783515292855;
        Wed, 08 Jul 2026 05:54:52 -0700 (PDT)
Received: from draszik.lan ([212.129.81.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa613d4e2sm2000319a12.24.2026.07.08.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:54:52 -0700 (PDT)
Message-ID: <4a5a09fd68fe45939bdcec4a3c5a781d664eb34c.camel@linaro.org>
Subject: Re: [PATCH v2 13/23] mfd: Use named initializers for arrays of
 i2c_device_id
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"
	 <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>,  Chen-Yu Tsai <wens@kernel.org>, Marek
 Vasut <marek.vasut+renesas@gmail.com>, James Ogletree	
 <jogletre@opensource.cirrus.com>, Fred Treven <fred.treven@cirrus.com>, Ben
 Bright <ben.bright@cirrus.com>, Support Opensource
 <support.opensource@diasemi.com>, Andy Shevchenko <andy@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald	
 <rf@opensource.cirrus.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade	 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros	 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Andreas
 Werner	 <andreas.werner@men.de>, Samuel Kayode <samkay014@gmail.com>,
 Maxime Coquelin	 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, 	mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-omap@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 08 Jul 2026 13:55:06 +0100
In-Reply-To: <5aec0fc2ac0cd1d2e27027ad0c180e2647bd494e.1783507945.git.u.kleine-koenig@baylibre.com>
References: <cover.1783507945.git.u.kleine-koenig@baylibre.com>
	 <5aec0fc2ac0cd1d2e27027ad0c180e2647bd494e.1783507945.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:15 +0200, Uwe Kleine-K=C3=B6nig (The Capable Hub) =
wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
> =C2=A0drivers/mfd/max77759.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org> # for Maxim MAX7=
7759
