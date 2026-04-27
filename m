Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51C3B19CE;
	Mon, 27 Apr 2026 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287150; cv=none; b=DthOFjOV4sL2MlBrD7ouYqb42PTTHEiNnC+/j5OwfP0kI3E0/vA0dlx9DM9O5qF19QpUAgpdp4E+GEpi0Uz4tg4eDtgdyp196YMAPxmrO+6IL5iLrU3AGHGD3cQ3A+xg/Rm/ArtMYzl/m8i5qBMSN6TWxV7kDAIxhO92nB2oMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287150; c=relaxed/simple;
	bh=2/M+r/dzyAJl/ExhHcBys0ugylVvG6ynvp563L3fnPI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kANsfUG2wzTrQWvAWh1zlzhX753aPSEh9cNNvUKVEe6TEKUA3Nmh/z3F2od/PDmUTmic+sRd47hDudO1+o6AeUYDfGhE6rwNqvWq+80xxChC+uyO/YF3V03nyMfKN1fPLqvGJEoXETwjaqC6cqNCsYoNhfixP2X9WsLrfMVKHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=i3lKiaXV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sq0xlL49; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="i3lKiaXV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sq0xlL49"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7B677A00BC;
	Mon, 27 Apr 2026 06:52:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 06:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777287146;
	 x=1777373546; bh=VszaiiOS69LMCrF4cs+T+KN9spCJ8nVeRr4kSbOs1XQ=; b=
	i3lKiaXV1DkZ7dW7YxB0zQBj7iLHSfc30tdPzrsF+LdH55SqyMKCJp5g45zn9wpb
	wQnu/3lSs6alP0zb/RlIstJWCRPxrcVVZ/LVhFGns8vlj5EVZzSH6gnARb4HunHT
	UFlAdlTGiW7+C8gTkm0rZpuOdFmzhvXJ8TboWVUDBmSH/9HmmJocBOLF/RN92dCj
	0VxSNh1U1r/D9GcXq7qya7oApU+AkVwTsoPW3dZ1JetNjc8Ln4YYWUCdxHnR67kz
	PUnwReYoqBj13a4QRbd8Hl6mPdYkPMDDIjsDdCH0LaojvzgH5zGggaD/PundXGd2
	RpeZ7fjKpJFIYTGMwsSW+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777287146; x=
	1777373546; bh=VszaiiOS69LMCrF4cs+T+KN9spCJ8nVeRr4kSbOs1XQ=; b=s
	q0xlL49/jJdl1t2cEtLucmn0Q9bXqfkKBiXTm5f3kSlshyH+XuoJOVTqCT4/7lyt
	lQfJ5my5YtLb/b22yJJ1ewi8bnmCDDr4tS7gX3lM9Qdq49UcSa6j0j7OXQ6DX4kL
	jmYOpP1P8KHwdv7CW25yUWB4jm4Xa1WIDWHYzAIrtLXnNsZsNGbuarNMlS1tE/5k
	0q7ZA/5kN8274gO62/WZC9AKpPZfgIYtGsjc4NOHDAvLoWsrPKiWh9OSjHpb18Gq
	FljH+v9gBbqniVnE3AO57oaCUNtPEH363bIshQH07MPgQuHXd3KN1VQOaDrLljhR
	FCtmRAfYzfqWcrqTkqYeg==
X-ME-Sender: <xms:6j_vae90RTOVVNevnRVJ7_7NkpEW2pW4JrnqAC6w5ePkOAZXnSWZ1A>
    <xme:6j_vaZhXhCUtRtYEnMWD6jbEzzdLhuVoM1AzsFeq-MCe_cjVnq_XK6DSN1xFBNE2l
    eGz8XatgZi6K8dfspSEfMN7lgfpYA-0Ler7ub4GKtbCX6EXYdOnSjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehtohhnhiesrghtohhmihguvgdrtghomhdprhgtphhtthhopehkhhhilhhmrghnsegs
    rgihlhhisghrvgdrtghomhdprhgtphhtthhopegujhhrshgtrghllhihsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjmhhkrhiihihsiihtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprggrrhhordhkohhskhhinhgvnhesihhkihdrfhhipdhrtghpthhtohepsghrghhlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6j_vacMXLOCRI7xDUznXTth8jdPsep2YclT8G2_FhbPaB3u1JYokhQ>
    <xmx:6j_vaQKnGyjQT2V7a9bokjAPQlndHf3khTSONj8OIR8S2dMInAIoiA>
    <xmx:6j_vaXxgYZU7PKY05SkCYggqJddVDeQi6MeiOqc8SeGwdsj6wLqcfA>
    <xmx:6j_vaQ6EPqeScOkCDw-NObr5fpNmf2LvgLqTcSUZ2s4j5itKTbMAoA>
    <xmx:6j_vaUSzpLA04WEL2-l84ubvlS_Eq2ohIFp_r3RJzzp9oCnpyJ2Hjha8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 849C770006A; Mon, 27 Apr 2026 06:52:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGuRs2470qq3
Date: Mon, 27 Apr 2026 12:52:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Scally" <djrscally@gmail.com>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 "Tony Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Kevin Hilman" <khilman@baylibre.com>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Message-Id: <94985c72-fd4c-4afd-aee6-881d1f17b2f6@app.fastmail.com>
In-Reply-To: 
 <20260427-nokia770-gpio-swnodes-v6-1-b693296c1985@oss.qualcomm.com>
References: 
 <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
 <20260427-nokia770-gpio-swnodes-v6-1-b693296c1985@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/3] ARM: omap1: drop unused variable from omap16xx_gpio_init()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 27, 2026, at 12:46, Bartosz Golaszewski wrote:
> The pdata variable is set but not used. Remove it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  arch/arm/mach-omap1/gpio16xx.c | 2 --

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
