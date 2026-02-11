Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C233F38C
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827544; cv=none; b=k/c2pC9En4RVOw03NgRUBtidCIfqFgTXTtG74wnj3k1ZEdzohB9T+48m+EQ6j3HabcqMiquGBNyDON7Ivdyg5x6Zs5/wJffL8G3Uc0d7hrJWJ0sLbEgEOld/3eeT3dY418XWl+Z2CaoRbCN2lvjROlVjr3srB3P9w94Hk5G4FTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827544; c=relaxed/simple;
	bh=UfYFQzw9DizcfbI8UKrSjkCRJhieWEEOgyJ4SZyP2T0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HefHlc1EkcrUKJe4/Z8N+vt4PQd9wvFsVwgerngg1PR+ADq7zzJoeD1V67QOXLiBuQu6n3Iq8ZyialroEAlIsDvEdWu+qaPg2RtQZtvSTcoxvE3NPz53gADcTfIgwXjtEMzbMQeEYsA6OmlXSla4B7qgVdAIO0hxjVXeIQyPDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/bNigMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/bNigMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20033C4AF0B;
	Wed, 11 Feb 2026 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770827544;
	bh=UfYFQzw9DizcfbI8UKrSjkCRJhieWEEOgyJ4SZyP2T0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=S/bNigMyu2iHQT1xmPSL1Ve8BuSCqCHVgygJX4vATi4CZvzQGbzYfmaPYbG7nc1FC
	 6wFSVby6yNrbScmQc+MBaF9w2K/lPqKAeOrSlHuT01xGUHmnQEdBPLhl7Vfk+kKfiL
	 ljbr7gZkjv+Qq0Relds2bfCXHUdsVDymHdjjJFA+G3jQjsxkCzVmfKTozfomy/hSiC
	 5p4DBggLkOTg3n0KkeeZJvvvoYUWaopaS510xkmTa0244iQiw9Ix4lUlX+jLW0Wh1h
	 sCxhoU0YTKugEgHMQ9qRPgGIPSuOeap0JFcZoTCGZYaV3btBKxTNet6X7brTeiJxof
	 LDb362ewehG9w==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0D873F40068;
	Wed, 11 Feb 2026 11:32:23 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 11:32:23 -0500
X-ME-Sender: <xms:Fq-MaRo16QXgUMCriSisFkAv3XAHq6k42Zu8W0FlpXBtoHzfDbuLew>
    <xme:Fq-MaefLh2XgGgDwiX4g049pSO82U6L78kIPzhisBoGb4DQ79Y7Dkhl1biTSSm2dk
    Y5-N1cFbltak_o1HmML9YAwCTVbVmiLXtxfOaxHYOoeeb0wFRjJ1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeftdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Fq-MaWhZObjCIHQbqjkDMsVOzq99p7RF3KwnZuT3zLVo_N-oZUX5dw>
    <xmx:Fq-MafJSnb3sKne5HvwMxdWaOguH57HCdonGqBU4xF_XnQGr2hYfVQ>
    <xmx:Fq-MadnKMjH8KHpIGOUfEpKZJTNJn3ac73bjuYykG_9RfDP0NG4tvQ>
    <xmx:Fq-MafPSVRX-o06ho0W-hsHiPJT3oAYbkZUPXmXhb9dp6t9pnOo8JA>
    <xmx:F6-Maf5EBeBZKj1ozTd2eOuD0sF5ZudExoifaYVc9kme0IsOaBfmcPNU>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6A92700065; Wed, 11 Feb 2026 11:32:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEuu_v-AJ7hw
Date: Wed, 11 Feb 2026 17:31:52 +0100
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
Message-Id: <213b82de-fee8-4ebf-a8ee-d8ca783ce403@app.fastmail.com>
In-Reply-To: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [RFT PATCH v2] ARM: omap1: enable real software node lookup of GPIOs on
 Nokia 770
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 11, 2026, at 14:13, Bartosz Golaszewski wrote:
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
> ---

I don't see mistakes here, and I don't want to throw a wrench in
this patch, but I wonder if there is a way to take this one step further:

> @@ -244,6 +263,14 @@ static int __init omap16xx_gpio_init(void)
>  		iounmap(base);
> 
>  		platform_device_register(omap16xx_gpio_dev[i]);
> +
> +		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
> +					       omap16xx_gpio_swnodes[i]);
> +
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to add software node.\n");
> +			return ret;
> +		}

I was planning to go through the remaining 'static struct platform_device'
definitions in arch/arm/ after the planned board file removal and
try to convert these to 'platform_device_info' or similar, using
platform_device_register_full(). Since that function already contains
code to dynamically allocate the software_node, I had hoped that
a lot of this would just go away.

However, I see that your patch creates pointers to those software_node
instances, so  think that would become a bit harder, but I have not
actually tried it.

Do you know if there is a good way to do this without using static
platform devices?

     Arnd
