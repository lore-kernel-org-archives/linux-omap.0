Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2404D17AC
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163259; cv=none; b=oTJPIfwJwyc6564G7Br4sSk0Gagesc3U4cRUFgSCU7PRU+24JswBBooylJ/CTc9jL9/xXa4unVSRa1C6RnSznQeXoUcLUrT7uyWxV7InWCUDnNEkkd5SCsCq1cuGCU1bDEIAViDinnN1W1NQJmzbcoEzIBI2yONX96mb1qWxQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163259; c=relaxed/simple;
	bh=7RGIO54fyE/iVl2rO+u+MlOK+PQfzNFmJNUDEqLEwwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=b3MQLdirGxcuURCAeXJaN1bRE5xsol+27UeDAtM3KcUyrCLJxEvHBVSa3j3ondiNHzHrRZhOUg4UIJNrkEk2Dyjfiwc4HsuzXFgFVUyxLu4kisRB0NUwHIjCcdLpeu0MZdgTHteEwLwidYJ2lX4wn4ptR/ekWnFYedatUCKpCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yndv2wP7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yndv2wP7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso605255e9.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792163256; x=1792768056; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VQBXFtSQf7WJJHzyT6nR2Bw3zqoZgRsxsOc7UBU3Xv4=;
        b=yndv2wP7MWTiybgyyrOBReyhGNHx49iRnEb+3zNzGIHs07eYYbaYRhdrvWOiPRT/TM
         KcEhzRNuTy7NkEy9IVcdEslLC8FL1BBIYctMxB9YXrwVTGP8+ZIZeQd38MNqXa7NXf7C
         gEkzNQLiFMKOJg44Isl+q/hRNPWXHG2uRi+eybMAXJYPIQX8NksosrXBy8rTK5QOavuh
         ylT3LlP1PEXJuuz0fhN11p6igTB8mGEVVIDezhrHXNVU4ClSfrdBx1FsitX9/Bw/kW5r
         EGss6n/KewYKM+IFJWMSKgLWmb/K4lIU/G5cFbLl9pBZondtkkRyjuO93Q3pkRROoh3u
         l+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163256; x=1792768056;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQBXFtSQf7WJJHzyT6nR2Bw3zqoZgRsxsOc7UBU3Xv4=;
        b=jNDg1tgC4Jstirw5vY5InrYJE6W91lUv6EAS5b2N1VdGhcdzOp+mzKAi6eTyYTlI+C
         5stKsHaAHaWotNbYUsu56g8GKSh11MDUYj6oQE3aK9mBa/WwiTsC7+ceLTwA37wbKACn
         egbN1Phkbs6hHVf5gQ0OaeEVrfSW8mWhQkJ6F5pOwc7f4AdUmpIu7zYLJ+R0RLmywLqe
         3Bs2Qc1GIZtq1acfo6du47JM1hRuOTW/7roi+O3MIEur9tsWcoJ4ohS1GY9cnJoLYnLj
         t2bZLpCsB16CjtnsoK/Dk8sYa76s/B1hLuaWVcpsw9LLtTf4tQNyrasU1YRua1al8mYu
         CAUA==
X-Gm-Message-State: AFq9FYJr6AlYbEESCf8XKmXn9BEGb6XYBe081HNomuP7Tdwn1qAZQ397
	d+8mSAksMxkk3hjzWpK9984aIFwrwQ1ZPWNMFzjGK/jplmzxY/k5ypX6I8pEP9aC4vo=
X-Gm-Gg: AYBFou2o7xA2GM5TCi0EziFQMX8RGA4StMA/554jFdh6Yu5guhH3rosULMVr9Htfxl/
	UIJvUeruutoAC2Cc8uWvvEsj3qFJJE33EWESgkSti1lNxPGVwH4Ubcu8ji5vvFeaUdzqnfUCfqR
	MqmsKnfgIMv71yfyKV9nIskULgVhKm1+/FrGtIetcmd3L9rAocqZSJuY/RsQmr3nJ50rWzVF1aO
	cHka/4eAnOMBeTQDW4EfBC/qJ0CPh6xqt+jSwn1Pb8EPMorJz3OsO1yimERiO0wuBuh/eIJYN09
	9CIHAdENXr00+01kCXnXvSYFHqwHb/bmTFJCynBzbrMEJHCe4qi5/QzRdEjUsS9uvxat69v7cHI
	jVYRrwJAKldqOzTnLk2EgYuc8Ch7YWB2WxuCpIjmbwNBqlpc2Hq4ohjRo/If60fM5+pNKiVXv4/
	a6ni8bX8Jo7a5xWrRC5Rp/y0FjKXKdcnNdQNIH5hIVCt64mycs18GXgy2goTZ7fOSU88L5fhIUX
	ehrCDxt+R8YM18rtJczc8L+lypyMZSCeaBLuJnnSaRHcFCryejW9vOlOltkxohy
X-Received: by 2002:a05:600d:644f:20b0:4a1:d307:d56f with SMTP id 5b1f17b1804b1-4a1d75fa37fmr1458705e9.15.1792163255733;
        Fri, 16 Oct 2026 08:07:35 -0700 (PDT)
Received: from localhost ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510ba3sm5544284f8f.56.2026.10.16.08.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 08:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 17:07:34 +0200
Message-Id: <DM6CUP7TSOMH.31T789KQ3Q6OB@linaro.org>
Subject: Re: [PATCH 02/10] dt-bindings: pinctrl: Add devicetree bindings for
 DM816x SoC Pinctrl
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Ettore Chimenti"
 <ettore.chimenti@linaro.org>, "Paul Walmsley" <paul@pwsan.com>, "Aaro
 Koskinen" <aaro.koskinen@iki.fi>, "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>,
 "Tony Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Christopher
 Obbard" <chris.obbard@oss.qualcomm.com>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Linus Walleij" <linusw@kernel.org>, "Rouven
 Czerwinski" <rouven.czerwinski@linaro.org>
Cc: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
 <20261016-patch-ektor5-dm8168-dts-v1-2-b4ce30217028@linaro.org>
 <ec27fd26-1862-43cf-803a-428846d66663@kernel.org>
In-Reply-To: <ec27fd26-1862-43cf-803a-428846d66663@kernel.org>

Hi Krzyszrof,

On Fri Oct 16, 2026 at 4:51 PM CEST, Krzysztof Kozlowski wrote:
> On 16/10/2026 16:41, Ettore Chimenti wrote:
>> Add devicetree bindings for TI DM816x SoC pinctrl configuration.
>> Using same definition as OMAP2/3 except pullup/down enable macros, which
>> are inverted in this SoC.
>>=20
>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>> ---
>>  include/dt-bindings/pinctrl/dm816x.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>=20
>> diff --git a/include/dt-bindings/pinctrl/dm816x.h b/include/dt-bindings/=
pinctrl/dm816x.h
>> new file mode 100644
>> index 000000000000..15aa15bca9bd
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/dm816x.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * This header provides constants specific to DM816X pinctrl bindings.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_PINCTRL_DM816X_H
>> +#define _DT_BINDINGS_PINCTRL_DM816X_H
>> +
>> +#include <dt-bindings/pinctrl/omap.h>
>
> I do not see this being used here, IWYU.
>
>> +
>> +#undef PULL_UP
>> +#undef PULL_ENA
>
> Why are you undefining other macros? That's not a easy to follow code.

Do you prefer to duplicate `omap.h` defines? Only the defines above do not
apply to DM816x.

>
>
>> +
>> +/* DM81xx mux bit defines */
>> +#define PULL_ENA		(0 << 3)  /* Pullup enabled  =3D> 0 */
>> +#define PULL_DIS		(1 << 3)  /* Pullup disabled =3D> 1 */
>> +#define PULL_DN			(0 << 4)
>> +#define PULL_UP			(1 << 4)
>
> I do not see this used by drivers, so why do we need one more header?
> What part of SW are you binding here?
>

I added those (DN/UP) because they are not defined in `omap.h`. It may be
convenient for future board upstreaming. I can drop those if undesired.

>
> Best regards,
> Krzysztof

Best regards,
Ettore

