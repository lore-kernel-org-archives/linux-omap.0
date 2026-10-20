Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525932;
	b=W7tCmiA86+M6yYzGwk3EW83DAuG154fLiQo6KEVHhTTUGo1osg+tscDkSUOsvI2DjibK
	 OW11veGvI3JgBokhd2td3jKZgW1koi4LJcY8ad6FRPJWCKzeOeUwph0FI/jTN8eWqf5JS
	 2BFRBS9kizICmBwWZ3V7Hg3Rb7U4ZSQMyW/aNQghmVcJtCxKOW8Op9C9FNFBxx1Ksaugb
	 Xb9sFrLMRGLqIiQiujjQb0wS80c/yrA37iKUSgquyNhIQFRcU+EbXZAJk9Q2K0RelSi/j
	 qwg+0Q0YaI6sE3lBPrD8AQjYToswwa+peZzPKMTUaPphgb0UAIh95N25U1M4O0XZnOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525932;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WnKiBHjj/zZJZwT63i24hX+x8FOF0JDz2q0Gba8m/uk=;
	b=MtUgIGppFvcBW95ZNmfk3PdIE1X0gpL5hdoaEUqBkF6sFzB9bPtvrEBFxTmeskREZgXo
	 xXMjhnJP8p5MxWXTiy6UZ2kx9SU0BDUGhmljNNjBmx5q6oPbUKXqxnO5bK/CRjlSoCK8u
	 qfBBDV5cMo0h8/NtsWxNsDf/m3xSE1yDXV9DlNLOzAP9wQhM0bQS4A/38YleQv1ctaeoJ
	 NAo2VFkYIBD8whJf+ER3W6ZrsD11Gt1f+qUGmfriBWhNiFpG+80zMze8OjuSg35RT24Iq
	 i6LdwbV8T+Aht6ax5Hwe3X9yw07EQkQjEy5fOSMJyJpt8uMx3mPLt/E1bcAVuvbB0Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=HFsU7Bop;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10418606A31A;
	Tue, 20 Oct 2026 19:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10418606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=HFsU7Bop
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=WnKiBHjj/zZJZwT63i24hX+x8FOF0JDz2q0Gba8m/uk=; t=1792525931; x=1793735531; 
	b=HFsU7BoplaQHjXNOGKNPI/WOz4SpjaN1vcj0K7wUbdI6Vvnfits560ErIdPZP+tmr4KGYXAGvYZ
	lgPem0z+V2QGyWuA54HR3EkgxfPDpzq84UO6mAB7cniLA9PckKOdZ2dMv+QI3ZhX0NLuoHW6eDBrf
	6Y+xjscljbbB9WW+RFavOzuIpKiyOZYIKn4NPWSUi868hdlFBSK+RRun+qjsOo6lPe4E6aiwYg7vn
	3NndzHSAsHPLySPXGaAHdwSnmGLSoUrMgd7tdeWm/4ZmovRbmqUrZj5df8X9cL+J+5JpWfQMWVD2z
	y7Pbo2kgPzW8wWApkJ6JsFblHYJTYwnsBj8g==;
Date: Tue, 20 Oct 2026 21:51:43 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "Ettore Chimenti" <ettore.chimenti@linaro.org>
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
Message-ID: <20261020215143.7dd0ad5d@kemnade.info>
In-Reply-To: <DM9L7QLLNMOR.1NHOUWGMQK181@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
	<20261016-patch-ektor5-dm8168-dts-v1-2-b4ce30217028@linaro.org>
	<ec27fd26-1862-43cf-803a-428846d66663@kernel.org>
	<DM6CUP7TSOMH.31T789KQ3Q6OB@linaro.org>
	<46414ff2-1273-4690-9001-4d1f825d8cf6@kernel.org>
	<DM9L7QLLNMOR.1NHOUWGMQK181@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[...]
> Sorry, does dm814x.h not look as bindings? I'm a bit confused.

probably also not the ideal placement in bindings.

> FWIW, dm8148-evm.dts is not including the header, dm814x.dtsi is.
> Following 
> 
> Basically PULL_ENA define in omap.h is wrong for DM8168 SoCs. 
> 
> For a better solution, you would prefer:
> - Keep omap.h in dm816x.dtsi
> - Add a variant like DM816X_PULL_{ENA,DIS} in dm816x.h
> - Replace defines in dm8168-evm.dts
> - Add the header in dm8168-evm.dts
> 
> or:
> 
> - Keep omap.h in dm816x.dtsi
> - Add a variant like DM816X_PULL_{ENA,DIS} in omap.h
> - Replace defines in dm8168-evm.dts
> 
Hmm, there is dm8168-evm.dts which uses PULL_UP / PULL_ENA
in nandflash-pins. Do they factor in this inversion? Do you have that board
by chance? We probably need to take the brush there anyways.

If I had my head in some OMAP3/4/5 dts files with non-prefixed
defines, I would probably not object against any PULL_ENA without
DM816X_ in front of it if I am not very awake.

So better do the undef and not use DM816X_ prefixes there.
Maybe rename that file to dm816x-pinctrl.h. That is a bit
inconsistent with the other omap files but at least that inconsistency
can be catched by the compiler.
Other arm32 platforms have things like e.g. nxp/imx/imx6sll-pinfunc.h

Regards,
Andreas
