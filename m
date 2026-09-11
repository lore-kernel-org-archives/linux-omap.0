Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977D363C6F
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137513; cv=pass; b=YjskZ9RviasN9RTN/ZRXN+3wkR99ULx0Yhi50S6iSotjPXnhXBOEua8XY6p+UCGr5hWiE85K8AebtFHHVrr/4JtDGWhpF78NMBI7t0v34p/ke9Eytw0UN+fT6F2u5lh6cJZ74K3YJ/aLAE9uVmfxQ+5gWhGd3/lkKXozO/kmCJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137513; c=relaxed/simple;
	bh=XLpKjuu4srfrU1du6/lAaUzD7jl948KYiIqSg/FlWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEwRmpJYB8iH8S7jQ79ZX3eaviE1GW0MCDqUBhQqXwyphBwRsM/yzRcRLwOUY9ZNIxt4X96C9UPpS5osRoyTZvOH6F+UaKBg/ySjErexU56rRZkSalkapk14SjZHJKZCKfiNk9ZQMStqr9oJrrZnCukRRBuGU0cQTV/1p90lsGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HB8Y+RT4; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HB8Y+RT4"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8588583a7c3so9079387b3.2
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 07:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789137507; cv=none;
        d=google.com; s=arc-20260327;
        b=MVHZbibe5IhqWbZ7KjoWhIutMFlvEEqYn2WBAFer4/fgYVG+ZpD0IvKtsBdr1nDiz9
         kcUyaS/dpmd2hyITvsybGcivXZRA2rlFUrRox4B57Wuk3cC4qt07pC/JMeCiitdAdQ01
         YdmHY445a4dPTmfZ0pFhdMGCgMZJ6gRX8MtatoY8HtWPOFEBb6t9xgbsZhpO/Nd47nnn
         Ybu8B01kWzD5N1rq00WBTF1C/C5TG+sgQijmd2rlUz04oV29OeP5W3hPbhUh4ADRz3eM
         E8Hle7VlZfhoX/jhywCy3CHUdqcXtWkdLBwkM4gFMCd2k8RXCOqG0ToL7bzrtWVQs4zY
         dL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        fh=fPkj0oIYicYd+3ulvH0sXPDQrvbu8EDiAMfcgBni+ao=;
        b=XwFrMMtLHdkjd65YyGNuaGN2LI64481CMTkF3+46hET5AZb9kzB8hcdF0Sk7VxbTHw
         DC6ngdaytLG6SqcrUeDNULcbk3tC7nsMieiNDfE/VgMm6pCJbAHaGBV3m01cs5dPZ/kU
         4AHVmh3cr7Br4BGDp2OhezG9eTrs9uMSdM5TugbGDEc5y6L/9+qXjk1Zx1FzK9VTmA6v
         I2T31uVN97q2Oc1Ay5RP9Rcbqn+OTFefjulcRZ7PM2xAO9N2sLBWHVz4kkkzuNLycBoJ
         T46qt5jaReCUoa/subc+re9v8lAlEUj7dzE90vY1/c4eW+Pm9ERLr8fsccfuqsbs3zEB
         Lcgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1789137507; x=1789742307; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=HB8Y+RT4TRPooM8mqpi8DeLFRTPVsBx9aCjZB/tdFSV51HaKr7YUqtjHQkphkOVbT6
         uuwIWKH3SAN0TzGoi7GXFe0YJRT5iKtXrRz5k8GxzTLnZPeidsaT8lGynlHxy7GjzZ9r
         wzrI72QggorLaBikBSbsEG1noEYrmgMFuOan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137507; x=1789742307;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=o/pcRCwm+1z1f5SQFNEgcrkFj7RRCrtquFShQ72O7VLD37XahmZEECc7BEKQxtuAJy
         sh4q/RR2S5V4nKXiGVNyZygtfKyLpiaexnykBzPxcgcAAHTBGvUcftcJjNwAgGIXdYS7
         EMgz5WwyOgZ97MZgr+53C9RB9NoeG/HxH83wN4faSL8prRt/hQwZZOyF2/KTeLGXH4Pb
         KkGFOHrrYRYJjImsM3qsvqMkmtRE4+od2gd1+KEMlKAAULuac9idtjstRZiTrUl/d+oU
         ooS+ZqKmfOj7Xaf2IoYCRjBHvA2/tl58z0H6OusM7R+Jay4SYoQphrT88nXMKGL98Z0e
         7NkA==
X-Forwarded-Encrypted: i=1; AKwUvBzp3e1kjkEr/NYHXlNAzBdhXgJnWJtW6xboVIvZYBvRppIWwKJNzIkyxJJdFxPykq0f7N4D54+5HSR9@vger.kernel.org
X-Gm-Message-State: AFuF++lUWrN9FzI1bkdzdgPBUNonXFR3JYAkchi7szWLjTHvkFI4JHmq
	6IBQFki2fzDWHgfp8S1/eQiUiNqikuCnMWgsotAdDTqnH4fuWHXhNBp0ePemkgK56hGLQh6m/T6
	KQfx3Mf3FUR/M684dDnvRsXe3OmRG9f4gHx4vTaU46Q==
X-Gm-Gg: AYBFou3j2BnxdeU85QNnXa61bpsqYPnOgRTpqj73oL/7wAnzLut+wovBmy/IaSj7vD2
	F7S/jvHqNCDWOYIctmbnl2S3+vE5bH4bfw1ZcfIVz2kV3I3oK+UZsq4x6XKeDYkCvv+CyIIWZ7Z
	hl8eIJ2tqPhta2r6bbgcFMCVMZHoI4nnaFHqSSxcd54p9rc4YsaROZK6MAVgVFpnXcY3szjes17
	2jAL7nQp+SBioaMuylWMtEPIn8wnWdZvyi3CT/b4NPyOjcWFaNIS4QXA54bxaubJHPN/bW6xkxd
	W1/gCxJh07TvVYD9UswfPdK4QXYVZKc+cW/g0pVBMFOwUUSH9hTROpcTmFLuUnbN
X-Received: by 2002:a05:690c:399:b0:873:5bb2:6c10 with SMTP id
 00721157ae682-884b7316b4dmr14810657b3.58.1789137507274; Fri, 11 Sep 2026
 07:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com> <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
In-Reply-To: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 11 Sep 2026 23:38:14 +0900
X-Gm-Features: AcwNN1V8w1uOymS_yob5PvYfeWzm1NprI6fjxQoUm4Mlo3gyAoZUnypuVT5lDl8
Message-ID: <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Linus Walleij <linusw@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

On Fri, 11 Sept 2026 at 18:11, Linus Walleij <linusw@kernel.org> wrote:
> - One camp that are enthusiast like yourself. That kind of people
>   are running the show inside arch/m68k on Amigas and Ataris.

I have SMP working on m68k (dual 68040, real hardware) among other
oddities. I think some people would get a kick out of seeing it but
also I think some people would also ask why we can't just delete
everything that isn't arm64/amd64/riscv. I'm putting off sending
patches like that to avoid everything getting deleted. :)

Cheers,

Daniel
