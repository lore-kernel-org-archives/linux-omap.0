Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114A34EF07
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896770; cv=none; b=gK+lLM3nco70LP9+x1rryaCJ2aZ/qn+ZW20MNMdOSQeCY6tY2MPnRxbZcOlNUnQRlgs6oRmfyc8XkEtb//MC/5ZTO0sdUkBVli5Le37OIl8eZkneT88vPvyXb2njszLNEM5PHQ6NMyaYHv+LWig2mgkPO2s98ACHvbUrv6TdSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896770; c=relaxed/simple;
	bh=8WINLAJJI9VoTtHGFrwUftgykkBdJtFx8Ya85T07T6w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cejddltq5NP+QBHf+Y+7zo85YdKS6DwEScI1Jc3J9ry4ic9wW7oxg2CxXeOGyAlH8gCjITdYDtg/PBmDkbPtQn+STckweSGyRtLzFBk8TTfJ0GlUt25pFF7Uqw4i+4hw8KaYNrapwKl1KDDLSq/UUysqCSdeTjYfNd+Uxs3zVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbt2b0SW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbt2b0SW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD56AC16AAE;
	Thu, 12 Feb 2026 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770896770;
	bh=8WINLAJJI9VoTtHGFrwUftgykkBdJtFx8Ya85T07T6w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Sbt2b0SWn0UiyMqYJp9YdsiF7Ouy83n3y6ndv+Vnd2U3444g6uqpnbOqHzx1cTd9D
	 UD3tmzWSrxn4jw8XUI7LAufJXPfLBt+90s3pk2a8xzllSLpOqVxC6eDmXkAvkwjbrJ
	 PrwBj/r+BqJhDL5hY3bjFkUz0blfUlKGakzAmcEdkjp19720QXxqnTMIia1ab2s0sz
	 SlPpknD/PMA4Xj05i9Wl69Bl8epl/6hA5o5m2CX2fnUXdqW5VCZBFYrB3H2ZyzsQln
	 /WGZVqRNqJjveiQFJloF4YAH+Wsu0bTy/3f3Ukv1mGecvAk+ZJz5BUaeHT5+OJRQLJ
	 TQ1cpTy3BmPZA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BBA3DF40068;
	Thu, 12 Feb 2026 06:46:08 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 06:46:08 -0500
X-ME-Sender: <xms:gL2NaYqTyxKpvFb8gXYn2alSRGFN54TN6xyNe9HE4-3erLF6AGMpjQ>
    <xme:gL2NaZehAnL5YtAUlEaDPaqCAalYHuNl2lnvZR2Bvnt3GiWPOf0claxb65xIt0ayB
    6Xux6ixqf1wTdJSCZV8xQ5M6C-Pt40eJ0HlwHtJrtXUeo8ExlzYHW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehl
    ihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepthhonhihsegrth
    homhhiuggvrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhm
    rghilhdrtghomhdprhgtphhtthhopehjmhhkrhiihihsiihtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprggrrhhordhkohhskhhinhgvnhesihhkihdrfhhipdhrtghpthhtohep
    sghrghhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsrghrthhoshiirdhgohhlrghsii
    gvfihskhhisehoshhsrdhquhgrlhgtohhmmhdrtghomh
X-ME-Proxy: <xmx:gL2NaVgiRYOB8ylcQ8A4k5wKnMwQtM9UBDPibj90OYPmlhpBF-wk9g>
    <xmx:gL2NaSKBaSUGJCu4ubCUMaXZVgY0zyaWoKn1UeUEC9WQtUnsbbvJGA>
    <xmx:gL2NaUmV4Qj_VciXcXgcuWiWmEeeMPk3CD2ZdXZwqL-cBv8l4l57Zg>
    <xmx:gL2NaaOk4rOB_1MNPHfJP6Vg6iv35exiaGZBJUASrwzuRsa4xkNODw>
    <xmx:gL2Nae6sntTubZlnIrDJoUqad_sdYgIImseR3BS3x3yhDq2ZWbRKc1QR>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A058E700069; Thu, 12 Feb 2026 06:46:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aj2XlnqiSkhV
Date: Thu, 12 Feb 2026 12:45:48 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 "Tony Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Bartosz Golaszewski" <brgl@kernel.org>
Message-Id: <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
In-Reply-To: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of GPIOs on
 Nokia 770
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
> Currently the board file for Nokia 770 creates dummy software nodes not
> attached in any way to the actual GPIO controller devices and uses the
> fact that GPIOLIB matching swnode's name to the GPIO chip's label during
> software node lookup. This behavior is wrong and we want to remove it.
> To that end, we need to first convert all existing users to creating
> actual fwnode links.
>
> Create real software nodes for GPIO controllers on OMAP16xx and
> reference them from the software nodes in the nokia board file.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
