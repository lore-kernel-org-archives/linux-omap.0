Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560133;
	b=YDhUzwi8U9TyGEXHpZwEqbiTcnxiN9zyySDzcvFLcxVAti6kypaNgwFGjHsjDHZ2JtWc
	 DihhJJIGMI7jxJxS1e9WQ+yxE9dHWT6v/gCfOAG5lO0CcNQaVhdWuG3mFbZfESrQVy+LW
	 T11BdSnnEGTP4HklIr50gBU5SRPvm5OOM/B9wLsxExJ6cUDIOkXahMdImaC8KoLLESEOH
	 M2HtiCOwKvh4yOcf9azd/qpfo9ZrE2RFTjwaWqGBGGFTdrZ3CvgAs8nN1l9vL4SNL2yx5
	 H6CG9N9ulHqjQyln7I/54q10MhCqd3xAlsGoQjo+WPtcKdYm3+dBU+tUFwpuqCXk6+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560133;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tUCMqiOrGj4FihXgRmpoFzlOGU9HSbmXuDtn2DKC7dE=;
	b=WQtK6MQNRPGfDeuaHs9B5KNWREyoCr0flyxs+lCdU4aCu1I22YDkM/AVhWZpXeqHRE0o
	 DU8fKWB1BDG49Y3qeh3UbGTzcbhgiETYjmcBuuhEwErwRZJJ4vKwxzbNpAZVUkc7iLAv4
	 Xmg8WFVFSeWGpq3609yKt/irb5qvtXVuEi/A4abWruESY8fdgco7aJGsyIQufCZfHU6n9
	 b+Qlddp4mLfZjNG65BGw62cUgzKcgiMhR1yr0T4ZvB9N7wBYZf+hkG4V4OLZhciY2h2FR
	 dSKQ/tIHNn2Jt9xYN8F+BocMEJ4WoBNE8zc7MjCw+DMJLfcsSmzmH81T7K1ty89TZKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="GdY/kwmw";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDA606A31E;
	Tue, 24 Nov 2026 22:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7CDA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=GdY/kwmw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=tUCMqiOrGj4FihXgRmpoFzlOGU9HSbmXuDtn2DKC7dE=; t=1795560132; x=1796769732; 
	b=GdY/kwmwT+R1lfk4fqFu5/tSfR/N1ecX297lcM73Z8oxvrFxBCT2I/5ATUyCrAkk1gdgU62aQmp
	/v/ZKWDmvQXDzJKM1zDiuunLQxM7ZzCm0EXXGoF/d4UdCTGHLb7Ir3k9c3tUPUHyfplqPtsbMCIUS
	5TGMm1eSSrFUxTIg/Xp5NaOoGYHZSSyCGY3oYIZes242NDYHvzG5kPAwVlZQoVm2SHNfXbK9vWUjU
	SFlPbMJPrjvOWcd053O+0DAEF1PrE2TJF++ibbdPZ26nia3IUz7nudCYyYX8pDcnB7mKqGJmboKyB
	57v4ER93Lx4U0qakDAO+E44fmxso5EkJqCSg==;
Date: Tue, 24 Nov 2026 23:41:43 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones
 <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King
 <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Helge Deller
 <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jarkko Nikula
 <jarkko.nikula@bitmer.com>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 00/20] ARM: omap3: pandora: Modernize audio and
 backlight to use Device Tree to finally remove pdata-quirks
Message-ID: <20261124234143.4f099646@kemnade.info>
In-Reply-To: <1DCFB59E-E5EA-4470-997E-EAA4ED35D906@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
	<20261124151318.GA536798-robh@kernel.org>
	<1DCFB59E-E5EA-4470-997E-EAA4ED35D906@goldelico.com>
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

On Tue, 24 Nov 2026 16:27:16 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Surely 
> > this can be broken up into smaller series?  
> 
> Yes it (we?) can. It is just a question how to do it and properly describe
> the dependencies to avoid bisectability problems and avoid that the final
> goal is lost.
> 
I think it is indeed tricky, and probably induces delays.
You can point to the pandora_bl driver  resp the pandora sound card to show the
final goal. 

If I understand it correctly,  you have

1. preparations/extensions for using the standard pwm backlight.
2. REGEN stuff to wire up the power supply. 
3. dts changes to wire up backlight and its power supply. 
4. sound: quirks in twl4030 codec
5. sound: dt conversion of the sound card.
6. dts changes to wire up sound card and its power supply
7. machine quirk cleanup

So what brings it all together: the power supply requirments,
so both backlight and sound depend on 2.

Maybe it is an idea to split this into a set of

One patchset for
7a. machine quirk conditionally depending on available compatible
2.
1.
3.
Each can go into their individual trees.
3. might to in the next release cycle after 7a, 2. 1.

A second patchset sent after 3 is in -next, containg
4.
5.
6.

A third:
7b: remove quirk + pandora_bl

Regards,
Andreas
