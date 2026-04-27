Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C939F183;
	Mon, 27 Apr 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287131; cv=none; b=ZiYcgbbNqHp2uzGL7I85pGPUDGdW9Yv3/yYZqi4+6UCPFOczrjxJx3LGh/bhgYbRutat+JqWYU1y9pN5r/gh8dWHrr9H589k/eapcKMFqHRWvpyA1wB+xKGGThFMwbdXXvl0w+jntY3u3IKIR70CcZ6YC4Yw7oJ9PSNGHHhBoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287131; c=relaxed/simple;
	bh=4Q8RFZdoNcvjckQIC2L/uAHEUvkW3bgyntp44C+NCys=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PBSHfxtuYFzLtPzSwEqaBhI1n7d6fZ0Kifzp8Am57pHHpQaQiX4ltK59hnRcQPsrSAGDFISXzWiPfqj1SvHg9cP77sv8+8P8lwH9JlJyw/LGDjcQkXB2dPsI7Uzy2aHP0WB5yF2tE51DO2MX6F80ciiuJXdrBArqjo1rHg+xue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FfxgZOqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0vJanpD; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FfxgZOqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0vJanpD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 143071D000F0;
	Mon, 27 Apr 2026 06:52:07 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 06:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777287127;
	 x=1777373527; bh=4Q8RFZdoNcvjckQIC2L/uAHEUvkW3bgyntp44C+NCys=; b=
	FfxgZOqt0HsjJNzo+JunHXzEHqRA7pPzyOcmEyOYh90P/StS0FXWQYEvRv7BYQnz
	yk/r0+9nlFhfnYnG4bQkKmMqawcZGR52gcmV6JNPQ1QVBoWQs3tvjwdjXi1wsVOL
	cqPnRvKxjYrkO1GAA6ZNWdzJtPcJ7drk/9NRKAVG131Cx6kCZe263/DH8MNWDzal
	KqFWkHyJuprbniGbS0RPfsI5Gcot8nKGxSYz2R0AmALs3Crq88uhVGmHYhBVebzM
	zlPmC23A1eEmIBUsfgsH1RGeVkFMjMO3NeAIhPHgvs2WP8SF2+Bdh3mgpO//SS9j
	Rrt1xK3bFN59BocdCTdKSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777287127; x=
	1777373527; bh=4Q8RFZdoNcvjckQIC2L/uAHEUvkW3bgyntp44C+NCys=; b=j
	0vJanpDpiGgsZQjn9xyBOKo0bTBwdr/95fPdkw2e9NifUdVOboF+AwiYhBwSzAMy
	q71HGl6A3UgueBQZQH8qKpm4Vc1mSUN5IDvwzrylz3SdB+LF4f6p5zfSd7kaqudJ
	jSi8RSwrEMqjnomS9rTZBLQhRQHJyN9fCaZGWpcuutHS7b8CKN0i8pQysL1AYUXj
	9WSTjmnro3x+yUgvR8KXrDaK/4LsLWv8dKoIIpV5f0U4QyR5dlP8Q+GtvOlcGbw1
	8yqZARZeLCxFQdAm0YCZT+SPnU/lNK9I64V01W5Z1iTmJ6VJQLLIIOiLv/cK/gvw
	S4saNsdM7bhsIhxCk/6fw==
X-ME-Sender: <xms:1j_vadm9Zu6S55StWER-9bJtpTiVnskxOD6gPD8kSdUIxo5VEH0E8w>
    <xme:1j_vaTqf6t2BJasIXIEETOK1FxTOiDoP5LQ2CcPt4dkueguCOTozf8B-bZqlXW-cz
    HQkCOsPo_zalZ5bzoHlQNjxq1hvV2VbU9nGEVqQ4xRHK8VpxkW3XcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehtohhnhiesrghtohhmihguvgdrtghomhdprhgtphhtthhopehkhhhilhhmrghnsegs
    rgihlhhisghrvgdrtghomhdprhgtphhtthhopegujhhrshgtrghllhihsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjmhhkrhiihihsiihtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprggrrhhordhkohhskhhinhgvnhesihhkihdrfhhipdhrtghpthhtohepsghrghhlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1j_vaZ1WkpDZ1t2_8yc0PWrsmun432d_6BkzTZgGorggRhSwbZLY9w>
    <xmx:1j_vadRFFB280YI8YQJ5Efsr0_50NyfFMzuM9GsF9rq_RDdZrANoNQ>
    <xmx:1j_vaearhcehiiA4p6ZWS1mAXQOLj-FgKuVrCq1ar0qndn1-tGQbrw>
    <xmx:1j_vaTDcKw5MER7CmioDf5riajU40HSQLsvxYG8WHhukFqoThl2MKA>
    <xmx:1z_vaVax4mtKhdz5qnV-Zlnjuw-kGX1r05gOx_oJbZLu7Yr_KywLrwxs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB86C70006A; Mon, 27 Apr 2026 06:52:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah9Y8yUapS6-
Date: Mon, 27 Apr 2026 12:50:33 +0200
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
Message-Id: <61df85c4-d5c1-4109-bbcf-fbb6b681eefe@app.fastmail.com>
In-Reply-To: 
 <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com>
References: 
 <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
 <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] ARM: omap1: use platform_device_register_full() for GPIO
 devices on OMAP 16xx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 27, 2026, at 12:46, Bartosz Golaszewski wrote:
> Ahead of changes attaching GPIO controller's software nodes referenced
> from the Nokia 770 board files to their target devices, switch the
> method for registering the platform devices to the
> platform_device_register_full() variant. This is done to leverage the
> new swnode field of struct platform_device_info which automate the
> software node's registration and assignment.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
