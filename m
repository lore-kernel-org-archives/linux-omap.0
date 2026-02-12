Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2734E747
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896750; cv=none; b=Fd1qL4gPTphgq3oO7ZzYHC/pNP3wcQ3YfgRi8F5e1/iYdPdI3Kq69RRd2bd4QZVwzC3bkG5TNBVAZIXO7PsTLVEHQnfj3xTG90l8uQHAZZfF3aVFTOc9JGbQAXSLsqAZ4oTWRwhM03ztfpoqL7sfJEpLuKDjtyw3e4o4BwssmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896750; c=relaxed/simple;
	bh=Dli/CIeO7DY3Sdyy7gMsEweRZ3dl7FnjiHHy9RR0tXQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R4yzys7FOB9K+mk+uyBBW+Kq6Wxtba0YpFsoPZ8t8lvft4i5o/1qxT6AV1VNUaqE9hx1lzpfrcoYd1PHWoA4Sgb4xtz3ywOZcKcT+JsijiZnA5SFCxxj6Uu6gdV8eFkaKj7HZFPdXk+NdapmxVYln7KFb7hQK3q10J6XkElGw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dur+zzHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dur+zzHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C4C19422;
	Thu, 12 Feb 2026 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770896750;
	bh=Dli/CIeO7DY3Sdyy7gMsEweRZ3dl7FnjiHHy9RR0tXQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dur+zzHOrxqLE02AOZva+oe9xPLhDERkrdJh4vra03sHiVxEdu4RERh5si87dTNTn
	 aA/ghR075GSoKA/6XJjBU+1y5V6Mw5/eQ3ZVZrCMceW9ohqBXg3JeGo/qSaRpvBw3F
	 mF1RohVzdYM2gtMBmRjfdyaTEFdHUYEgvbEJbBrRxLGIoOn32Bvebcoc+b4oH3RXQp
	 cUJSU8D4LfY4OEK9RJjgo/NkVgAP9McFmhJ8UvNpBe3hsu65yvXstNEH8PV0yIRkvo
	 +/tIq79F7gZhWcHOQLhozHL7vBYqaYr9WuKlHrjCMgdHG5WF8iUGBJfAtnr3HE9QZl
	 WGGWaknxSraKg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8E1F2F40068;
	Thu, 12 Feb 2026 06:45:48 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 06:45:48 -0500
X-ME-Sender: <xms:bL2Nab7RpRrE2259is5mISjL18EDaJktv_YfTNuKfB-FkewVEZ5fLg>
    <xme:bL2NabvVwU1jzatcUIysxRMgpL9z9sCzRwTb01UYzPRwcpqyi5TggSZ7Ys5WU7EeS
    mnXwNvDwsgJPZjxXvyuh6aSX6PlIKkNlpvIIWAdmh3Cl4481kXhSkgn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepudefjeetteelhfegudekhfetffehtefhtdevkeehfefgtdehheeghfektdek
    vdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
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
X-ME-Proxy: <xmx:bL2NaWxB2CG4atkoshXdltEaJ4ZtRGKcIXESffgiR65lO2fyqMQbpg>
    <xmx:bL2Naaa0adZ-PK_ca6D1E5655KrzF1JfZPZp5OekbvCA2zCYwPyo4w>
    <xmx:bL2NaX0c8ImAxHY-DmIBRyxOLCaX61cHeWTnlvWmwzBhEjeAx7_y6Q>
    <xmx:bL2NacftenBriLaeINY06PKBWntgZvGPD108kzug5isFDkM9-__EjQ>
    <xmx:bL2NaUIpXJjW2xtFagPZL--z6_mf1AHxUQbrd-CjOmaRSPDjof5ofz8V>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64526700065; Thu, 12 Feb 2026 06:45:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEuu_v-AJ7hw
Date: Thu, 12 Feb 2026 12:45:28 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Bartosz Golaszewski" <brgl@kernel.org>
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 "Tony Lindgren" <tony@atomide.com>, "Russell King" <linux@armlinux.org.uk>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <8a4b2d6f-acf4-414a-b695-65dd7eaa8863@app.fastmail.com>
In-Reply-To: 
 <CAMRc=MeWgo3b8DTG3w8U2bxR6ejd2UmFVGASvRe7_tJkK2f4ug@mail.gmail.com>
References: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
 <213b82de-fee8-4ebf-a8ee-d8ca783ce403@app.fastmail.com>
 <CAMRc=MeWgo3b8DTG3w8U2bxR6ejd2UmFVGASvRe7_tJkK2f4ug@mail.gmail.com>
Subject: Re: [RFT PATCH v2] ARM: omap1: enable real software node lookup of GPIOs on
 Nokia 770
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026, at 12:40, Bartosz Golaszewski wrote:
> On Wed, Feb 11, 2026 at 5:32=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>> On Wed, Feb 11, 2026, at 14:13, Bartosz Golaszewski wrote:
>
> Add a pointer to const struct software_node to platform_device_info
> and then use this if it's set and there's no fwnode? It's in line with
> what MFD does with its cells.

Right, that's what Dmitry also suggested, see his earlier patch/

> In any case, I'd prefer to not overcomplicate this patch, let's do it
> separately?

Sure, I mainly wanted to make sure we're not blocking future
changes here that I had already planned, and this sounds like
we can change that later without undoing all of your patch again.

      Arnd
