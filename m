Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598609;
	b=mlHoykzpdexw1M0ZDV355SXuKIif2GSK7A5yvGtm1GMdP4+dVSzMXE+FthROHJG0h/af
	 X8S3oJkwkL0GX6ZiqqtPdgkcgGMJ+9uh7fqWCxRh7W9BhfjrGxwE5bnm2yYb/gEqH75Le
	 rwB6BFxT7oGHldmc+zzzju5kv3R8NLxvSujpT3g9KGL7xPe9kXYOPoHAdvabe/i/vWQoJ
	 y/Mu6FBSY3gL/98fgpw9HK6gNq0L2xxu7k+jkV8aW0aNb5cjYyEnK3Osy8mrRj8GgE8jB
	 AsWH9wyorlNO50lmlqHowS94vm4EByp9BhxqTGdQsoZXuU66kVBTRujKrZT5GdXDUQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=o+0U5uc8o8aSpg/3Nq2d92vcnnoDIvQVEgNyLz/yOhM=;
	b=HuaULRil+ZbZAmtw/t5AYcNYfSJUKlWRgHSuo6oeJzvG/0r6W2J1NMsi9lrXN6xqarUQ
	 UtNq1FneX7fpixyoJw4Vwml7a6lReRibvtwy9Ehz/IljUgrTU7PKLi0+RIrGuqso7yRrM
	 P8hG9JQ3iZpfa613pMDL8U8GQZk3KMIhDuOHHBSrr3bgLOlNg/xhzMHh3tFH1H8bnD+cW
	 lh4py+KWsixPau711tnAwBMWlFFJyLcKouBNgYGZAY0bMdWjYNau8LGd+Ss8LnmFhs+Az
	 g42Vc1JPlPWrlwjId75NHmx796ziNWtnLkrIJ1lBTx8OaNr0b2sp92rzlA8+BmlcuxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ODCOUX6J;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EA606A31B
	for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2026 16:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ODCOUX6J
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso5173895e9.3
        for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2026 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792598607; x=1793203407; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o+0U5uc8o8aSpg/3Nq2d92vcnnoDIvQVEgNyLz/yOhM=;
        b=ODCOUX6J/nS1bCRsALhyLHPBU1C/xS1fj8nsp286e4DZU3u9ZxMeUpnPoTjjFJ4dt+
         OhIjX8/kTsg8hZgQl4jcGPbP4QNI3iLqN4j8UIcStfSU5AaHDykBzJsuvHVVHQmq3ULo
         ccu/oNz991Yuuc6hNeqdWrNIGLZPLWYCW037fOHYAAG5Vbcxm4ht4dgdVr2oqATfRecE
         3BOIlfqLELk1H5r7OKFZOcJqHhYCmA3w2/j1hCocM/Ep8NH0Y71ljW2kFVkP8NJSyQnE
         RrmkoBcBg3f3LU6ktePBz8jrf+jg+IpysFIyzWJ9IoWzMg7M3//4Cn4lsnscoKkehLa6
         pQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598607; x=1793203407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+0U5uc8o8aSpg/3Nq2d92vcnnoDIvQVEgNyLz/yOhM=;
        b=YTWzlQ0m84qDct2Rcw69nMtJObcxAw+Qv8B2hqALzRzr+mZoRcvMVPs2+qkOyPYrKg
         aHkX6orsnPfN1wTWfQKhbzfZusf7O+22Z7eILr9JmERsvWOoXd32rLaj6XLb4iuFdXwl
         pR2cwMcOzdi96Mqd4iYRVUzv90918DH9XT8omwaPjSgjreAA+fGMH6ReRE2l4XocU9In
         FD8O6F9W1CL5G9a4A4IVJJOMMDLtDBe+9Lv7INcyCAgoFbiHATeqp3vVkQO9SLrJrbcY
         LooBGhVVGWPyM8en4YWWXq4lewd963nEJxq3Be93Q16G5gjqCK69G+9blOzhHz4vzekL
         O3Cg==
X-Forwarded-Encrypted: i=1; AKwUvBy4wBVWlh1p5kiR+uDPHcjzUWAwQBtVgE7ULzcIToNaABmMENfw3/7/B143I4SP7bLmoiR8Rhmbqk/K@vger.kernel.org
X-Gm-Message-State: AFq9FYIRVYCtY/J6FxNu7rNXfHwp0o0s8W7drt7rma/fzsoIT8djudZ5
	lTslZhS0F1pg0ab5OW2qLCKtAcKwAn2uLsXWrzbXGyRFkU5taINsvxvyqKRzwYV+ZlU=
X-Gm-Gg: AYBFou2vvOs8Ad6YI4J573Lj5hyB+NUwwigouG/ukb9/6K0VlocBms3ya+qp3HnrsoW
	hYH5Cb7I5TxvWXbim/HeYGo8QYSt3WdtRzh1oxJW2bKmNu8jPfyL5fZ5uQ+ddNNnFLOXML5e7iL
	RcT4LfFx59NnYPqTRknH4xxmLDyuL3AvkFPEPftT4N0UKyyKf/RVwmbkgiqwiAZ9DK6UumgIRj2
	vgUcwrhG1UlNw3gNVjarVmNp96BXnd/NwDTN4zWg11RVJj/6OylhFSGEjH1kVzID6/VM/fXckVN
	8PrUVKYdQavVetn6rMGHaBoUVTpdBNo0mGE0c7lDGc7kZy+JCxXJLCUmAsL7lTm3QwammavM81Y
	EIZLJgjuuGibnoqTT/8LGozvRo1/K1xEVt4T3NOovA0zatNwFg5ApDoQli+RY1PbxIj1VAXGaGS
	WZi0/EQd+2QNW+y/iOErxs85/ofYaCpSjEsfFCMRbApqTmSfLeLWL55Mm46ZGHy14e+L3/DYnYL
	Gr5lQJG4BZo+o9ntxnTgr/Emn9kx3uFRRuHQoD9lJre0PhobeQiqxv9Go+h8rkP9y8IkDCErZrS
	BXSvJ0uoKLw4BfzGf4fNhSbwitlY4KupJxue1z79T4OvxLM=
X-Received: by 2002:a05:600c:4fc8:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a1fdd2472emr58485645e9.11.1792598606167;
        Wed, 21 Oct 2026 09:03:26 -0700 (PDT)
Received: from localhost ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd629bbsm53982045e9.5.2026.10.21.09.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:03:25 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 18:03:23 +0200
Message-Id: <DMAN65SWMXQ0.125AVDDDSIG7@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Paul Walmsley"
 <paul@pwsan.com>, "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Kevin Hilman"
 <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Christopher Obbard"
 <chris.obbard@oss.qualcomm.com>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Linus Walleij" <linusw@kernel.org>, "Rouven
 Czerwinski" <rouven.czerwinski@linaro.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 02/10] dt-bindings: pinctrl: Add devicetree bindings for
 DM816x SoC Pinctrl
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
To: "Andreas Kemnade" <andreas@kemnade.info>, "Ettore Chimenti"
 <ettore.chimenti@linaro.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
 <20261016-patch-ektor5-dm8168-dts-v1-2-b4ce30217028@linaro.org>
 <ec27fd26-1862-43cf-803a-428846d66663@kernel.org>
 <DM6CUP7TSOMH.31T789KQ3Q6OB@linaro.org>
 <46414ff2-1273-4690-9001-4d1f825d8cf6@kernel.org>
 <DM9L7QLLNMOR.1NHOUWGMQK181@linaro.org>
 <20261020215143.7dd0ad5d@kemnade.info>
In-Reply-To: <20261020215143.7dd0ad5d@kemnade.info>

Hi Andreas,

On Tue Oct 20, 2026 at 9:51 PM CEST, Andreas Kemnade wrote:
> [...]
>> Sorry, does dm814x.h not look as bindings? I'm a bit confused.
>
> probably also not the ideal placement in bindings.
>
>> FWIW, dm8148-evm.dts is not including the header, dm814x.dtsi is.
>> Following=20
>>=20
>> Basically PULL_ENA define in omap.h is wrong for DM8168 SoCs.=20
>>=20
>> For a better solution, you would prefer:
>> - Keep omap.h in dm816x.dtsi
>> - Add a variant like DM816X_PULL_{ENA,DIS} in dm816x.h
>> - Replace defines in dm8168-evm.dts
>> - Add the header in dm8168-evm.dts
>>=20
>> or:
>>=20
>> - Keep omap.h in dm816x.dtsi
>> - Add a variant like DM816X_PULL_{ENA,DIS} in omap.h
>> - Replace defines in dm8168-evm.dts
>>=20
> Hmm, there is dm8168-evm.dts which uses PULL_UP / PULL_ENA
> in nandflash-pins. Do they factor in this inversion? Do you have that boa=
rd
> by chance? We probably need to take the brush there anyways.

Andrew has one, AFAIK he already tested that, it should be fine.
We are checking the schematics anyway to be *extra* sure, but the board
boots and all the peripherals seem to work.

>
> If I had my head in some OMAP3/4/5 dts files with non-prefixed
> defines, I would probably not object against any PULL_ENA without
> DM816X_ in front of it if I am not very awake.
>
> So better do the undef and not use DM816X_ prefixes there.
> Maybe rename that file to dm816x-pinctrl.h. That is a bit
> inconsistent with the other omap files but at least that inconsistency
> can be catched by the compiler.
> Other arm32 platforms have things like e.g. nxp/imx/imx6sll-pinfunc.h

Ok, it is a nice idea, I'll refactor in dts/omap/ti, using the same
pattern as dm814x.h.

>
> Regards,
> Andreas

Thanks,
Ettore

