Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717269;
	b=Q0bGlh0aOvOdVv+5K/i5Ngevn9Vh/847kxvmmQBjl1C0+Y5ksMuTECyDMiWHI8l1osxm
	 55lSL/tH0vOoOUdIjwdG+uCd5rHlBW229rbsoVOYQ3idHdjVnge4l2vTALuZE3Gr08GBU
	 81lLZe3oUvVTqcn6y5T6s3xi0va8P/9wsQ7vNANy/hGQ+LJ1hLEWq/3RGOLtql93q+Omb
	 59GwXX3LM7Fz1jX+44LD/bqF+X186brN0mIOF5TslstOMlYNse89aUylFF6mUT0ojjNxC
	 RYWOov3NghIzEaWjVdDGZ3M/f9dKo5LJ2Yxa0UQlQrelLj3yhBiOIk/y3FqBHs2bKqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717269;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ycuAt8nWPqLFoRiGaSafeLgsWrIGk1PBMq6nncFMtF4=;
	b=fAW19Pq/+vUwon/+yWfWqDTYg+FSBTwExfq3RGeX2GfGIWNEyzoNSCnl0BnUr52Nt1LW
	 UIqu1t6KGUeWWOrh0qBB/WGRe0XBxNbevyQ2opVXibXfYFKyl+rACjGUFnq96fyDhEhiS
	 l0R/rJo7x7Cx+Y8ZeX2iQmM0ryF5kkUVHzaGkJ4BsIIHkkyuIjZ8ClY4pT7z4a7m2Qq2P
	 V2HVk1DzC1jttXV28FrsqGVaeriCP97BScoOOCrLtRluufcMAeQAVMmMbqsIsKvVQq3Oj
	 XXfK14X+PtJKOc93JZVu51LPVX/32SRiAx1mApKdMR/tzPhL6IqE57WAKJLQEOzRnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="jc/wHpEz";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DC606A690;
	Thu, 26 Nov 2026 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B35DC606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=jc/wHpEz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=ycuAt8nWPqLFoRiGaSafeLgsWrIGk1PBMq6nncFMtF4=; t=1795717268; x=1796926868; 
	b=jc/wHpEzWkwqq8W5hkHS7rNhDBb4bA7NL1BpGUqIYVVKrDGF6aXDAkn+ItU49bcA4C1LNw75Ue5
	1V951TTRjHHdpmapGlIjlFQ4jFS0SeDSKW7dqCZZjk6pUozwMQ2PvtTVXuoksLn1QU1wFGxYzTq2i
	DSVg3JZuGxLfQxmYCJ0/K/Ix/mqUHZ4BuzwKhD7VRYrwXfn6tXMnrJdg9gi3GeUeP4DCUXZL03LRQ
	0xaHKmyGRa2QBh3IGed8oGnM4VWJDQ6gADj/aeraPzmfVISH+vGp/mimLn+tpqPcUytrbOrAc+LOH
	u6eosaDZu3y3b5feLh57MfybL6cv4cW29Vrw==;
Date: Thu, 26 Nov 2026 19:20:36 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
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
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
Message-ID: <20261126192036.6646c688@kemnade.info>
In-Reply-To: <20261124224300.519d8686@kemnade.info>
References: <cover.1795505160.git.hns@goldelico.com>
	<5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
	<20261124224300.519d8686@kemnade.info>
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

On Tue, 24 Nov 2026 22:43:00 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Tue, 24 Nov 2026 08:25:46 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> 
> > The OpenPandora audio subsystem describes the routing links between the
> > OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 audio
> > codec, alongside amplifiers and power supplies.
> >   
> I think at least in some commit message should be commented why such
> an interface is needed and the generic sound cards are not sufficient,
> also as a starting point to recheck that later if these reasons are still
> valid.
> 
To clarify a bit what I am talking about:
there is e.g.

https://lore.kernel.org/linux-omap/20261123-omap-mcbsp-tdm-slot-v2-0-3e3aae215952@telaak.dev/

which might be one piece of the puzzle.

Regards,
Andreas
