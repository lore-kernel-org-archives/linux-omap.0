Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B31A0BD0
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952594; cv=pass; b=HTscAQSIY3f0a4tjtp8QrfYv9hRUdKuHCdVMQtpsOfMtC6PENeV0bx95XxSoqzBdTS2koS5CfMaChH8a8V3VDmFSu3dBmD1bqPmsSfgEEoc3Xw/yxIozz/orCJpors/5OjeJ4bc5riRWvhB8o159CeE2/RBf5oQ3PKCEv0Jkrhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952594; c=relaxed/simple;
	bh=SNvAp5loPXmSCA/neGJKJzw3LHacsN8hVNlptAtg1Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmcEDHXxj+ibk1sTuApXMUK3CQbCXfdRW3eRuOGu5A4q2+OAtS40xTf1r7eQpcglfrwi3mZZovf0wrN9azyeHIyglQoDeLEjB5buvagfN3kW8nq3D7ZphUDGPX/PGrGT4m3o0oTYl0JZpcdXUbYZfeDLTCtEY3zLuPQjCR6Kf20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXkWTtNO; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXkWTtNO"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso679114c88.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 19:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770952592; cv=none;
        d=google.com; s=arc-20240605;
        b=al8lVi7fi8uGpClv0oErfI+nwxHjipjxykq3JfyZdiKB8ISwoMCGe6CJX2mz2omUOf
         UBhTcbXQbu/Eqgh49YDZFXa6aNwQEX9+3NdGTHBhFyAIsVVrIdAxuaCKUHN9SFXBnzwF
         uuPq/Nv/VjYjLqQJ064bLqwWoYSjr9pX67HLybpwVzU3l77ZfmPg3XW+T904LgHaVI0W
         g3Mm15VCDQfdVZI4Qc+VWUWCnXD1oJWpU7zdpNGK/dsNbzHE6+lp6DElc2NoJY6AiL4a
         s9pvVIMUQytRNszCSX4XzyS/l+0Q5NseKAJilGHjDnutJIa9DA6mA7TX9Iw4x3/vcCjM
         us+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9rVs9tfdzKqfLiEuYfz6qxedHCDF85xV49xx0uKo3k=;
        fh=63EgxJIx2oYAkJ2SZm18GzoDD0TADDJ8TeZDwIQvz0s=;
        b=KOQqE/3386P8EiR1lEBXiy/4mB8WLecrnHgUAk+86dI8/rw+EtuTIS0rNI8WxhtGiq
         ZUskCK4BF/OtEO7o+xmICyCW9FJgI7bwRR9FblJrm0QgURPstBP8PYWEu63JkBCd5sLf
         tNFieBGBg4ud9EOKAYPZpmoP+0RwGIK0ZsDmaSBPPeU5y1vwKJpiY1iYmQ6ci5WbBj3/
         T04EqfJ9GOJJ6W7YTlwpuN7Z/Y69UcpMYYqOywxt4nMI7rg/GqE7Qz/1GYMzZQulOG8n
         lrZThTZgb9n+FkdZVETHmslcUjwaLLxdT2qU2JcnAO4KgQ0ivwQE+Vzw/HYqfQ7jXKjv
         AtMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770952592; x=1771557392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9rVs9tfdzKqfLiEuYfz6qxedHCDF85xV49xx0uKo3k=;
        b=ZXkWTtNOzR1YJED7RLTxPXVsOpEuvaP3APLWpOglgZjEKvUAbmI4fYqxUQUFNXAOH0
         TGt/tIbopegzx/efSYu2jzCM+UVHd7aiH2ft7RwCHBq4XB/HVn6Ec8932EDbyolnaDID
         O5G8l6vleCAeCLP2Ic3cG4u/sGLbzZVNCQiEnNpEA6zyOsNWMaKTUQdN64cSQ4k+Te9Z
         WWz6ueLh5/4H4QgAf/sqZPZyWaCHaaaje0a44Er9uN/FZIyHDFjZm8c/VG0Pdh7yoeDQ
         Ye9sufBHvf+pj3Hzr6WNhf3z6r+d3GKs2eoK8okaQwunVQFTSa4d0+C8RcCLcNL+Ut1Q
         Hybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952592; x=1771557392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9rVs9tfdzKqfLiEuYfz6qxedHCDF85xV49xx0uKo3k=;
        b=B+znuvIqwnff9QWuCeJQ/Gh+TbpYTcCcIAMOWAZqEyBKvwSYmUVWrVhqXRK8W7+4zf
         hooOfxtXumj9XZhmMc/VoNj4lxmmsLbqhg9X8/ntFsHDOHez4f2AtWc94HO62Idf8K9M
         uZskVLV2oWvygqHUjD2Al6Hq9vCXSmiinZZG5i1pJAvnjW/rzXN2ffLnKXdgEGJK+ZUI
         yv/dApSjEiqwVL2+F6qDG20CYOdyDGP4r0yUzVUG5W90aMoMq3l0RB7vZR7iSAw7pNeY
         09KHI+KXiv5/AKot0eOKH+Ct/gN2RAiQlfbsAlG1YFA7alky+nLUDFMNtilh3+kVRYSC
         tUHg==
X-Forwarded-Encrypted: i=1; AJvYcCXv1D8/zrK4fRTKoDolMj7pjuh8EvoAR5ZAWYhjoeqoNK76/ynBak7xpUGf/5MtRd6wIZVi8ZebTQ7P@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOqDtSKMXjFEDX2z8iQ1x9ZhpSEknX8OG1KOCN0ltKGgCSbVG
	gJxhCCUOlqdyOt4jXxobnSesSAGQGq/cFA8WA4HlxRlq4k7OWBowqV8+e9N3tRq2FKLIQYzcTSv
	YiIAnHTnxkUbIo91kL5LBiVr7ulQpA+k=
X-Gm-Gg: AZuq6aK32HaiXrKjZbhHNGIZZ7I7tUOgs1R6P48douQ295AK2Y17LoBtWKGkfqUcmVa
	L+TAiLqc2qy2INOjxUJTQl4wS/vBin0mwOC4ayzqp7duTEG/HaOrrEGULMXOhl/lb5y7LUtN/L/
	POEVHELkcTNQtRoMoMfWYRL3AHQ1M4ctSdya5Gf+yWK5/aFHjY9/DZlSA+d+XuAiVxcQIVRKPtP
	8go8hff/TX43znS8hFjtP5Q5N0SkgfzwAhFAnQszS/60NJhpcVWn1XXF0naF2pQokXXa9ToRS9j
	qrsd9oEiV6XCbWomhpzZhrCFQL96/53aFnih6QNASa2Rwu3Lgnb5j31REjb5Mf5EjNFuqWJdCMt
	52hC9ZKQ487SnAcy8Dkxu83YS6Ro=
X-Received: by 2002:a05:7022:a91:b0:119:e56b:98ba with SMTP id
 a92af1059eb24-1273ae7fc16mr135317c88.33.1770952592138; Thu, 12 Feb 2026
 19:16:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
 <20260212-feature_bbge-v1-1-29014a212f35@bootlin.com> <B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
 <20260212174718.7daccb70@kemnade.info> <719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
 <20260212231907.6120a2e2@kemnade.info>
In-Reply-To: <20260212231907.6120a2e2@kemnade.info>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 12 Feb 2026 21:16:05 -0600
X-Gm-Features: AZwV_Qh971-afroyUXRtMyj8ruGTY0KPplbW-K5wj0BVh1d4xjPlxLEG3ejv_GE
Message-ID: <CAOCHtYicmeSzH5Q2_qTwAZw3s+__JRwUrXvz01+KCsJJHAznUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
To: Andreas Kemnade <andreas@kemnade.info>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, "Kory Maincent (TI)" <kory.maincent@bootlin.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Bajjuri Praneeth <praneeth@ti.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Louis Chauvet <louis.chauvet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 4:19=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> On Thu, 12 Feb 2026 17:55:43 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>
> > > Am 12.02.2026 um 17:47 schrieb Andreas Kemnade <andreas@kemnade.info>=
:
> > >
> > > On Thu, 12 Feb 2026 16:49:43 +0100
> > > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> > >
> > >>> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI) <kory.maincent@bo=
otlin.com>:
> > >>>
> > >>> Allow overlays to be applied to any DTB. This adds around ~40% to t=
he
> > >>> total size of the DTB files on average.
> > >>
> > >> Is this unconditionally enabled or can it be turned off by some CONF=
IG? We have
> > >> our own defconfig so I would not worry if if is enabled in omap2plus=
_defconfig
> > >> and disabled in ours.
> > >>
> > >> We have several devices where the boot loader can't handle overlays =
(never touch
> > >> a working boot-loader :) So this seems to only contribute to build a=
nd load time
> > >> without benefit.
> > >>
> > > As long as you do not add overlays, the bootloader does not care. I w=
ould
> > > like to simply carry around the 1-bit mmc overlay for one broken boar=
d.
> > > That would help me. So I think there is a benefit but nobody forces
> > > you to use it.
> >
> > Well, it does not force to use the really good feature, but it forces t=
o add
> > ~40% more file size and some more compile time, if I understand it corr=
ectly.
> >
> Compile time, hardly measurable even if you just do make dtbs.
>
> Size on disk:
> a) if it lives around in a /boot partitions with kernels and initrams in =
it,
>    then we are around 1% more space needed.
>
> b) if it has separate partitions maybe on some mtd: Looking around: GTA04
>    has quite some headroom left. Usage is still <50% even with symbols
>    enabled.
>
> But on the other no one else seems to enable that besides for devices wit=
h
> open expansion boards carrying "hats". So overall, should we really be th=
e
> exception?

Do we want to maybe transition like TI did for k3?

Start with board specific DTC_FLAGS flags for specific boards:

and then just enabling overlays by default :
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch/arm64/boot/dts/ti/Makefile?id=3Dbca4146b1f66dbca07591bfd6ad695c699b5a09=
3

If we do board-specific, all the "Beagle" related items can be auto
enabled `-@`..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
