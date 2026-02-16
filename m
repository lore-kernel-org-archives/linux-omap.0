Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69791318EC5
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254730; cv=none; b=RuMwU8Fx2irtvbkaYF03KT99Lo+e05h4rcc7GYpU7pH5ISAeQy4yMjEs53w0Z/6BzcaIylE/FUhaFGO/LvaLnqMD5l/YUNcS7lqXAcWyg9niUf/Eu9s/aiAxGKqR0YYLIqll/nXO/T310/WvznUl6MXak61uF+Q0qKlQIkl6GrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254730; c=relaxed/simple;
	bh=QWQwNC0VfMDFDTBO7+8mAooqAtHfTngoNqggBXt0Pbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EK9FbFTY48f5rlk6mmx6s6WqIZ0gY5RXzMv536C/L/5rWopEA9mlzgi4UXgINKgRPXg3QcXAYCOOPQbLTtzLA5DLvZTz2CIsVKHVdRincTAuM1ER40wpvN+XjTL6BlGlPqPjXj5bzP3R0nyMUJkjpeZXFAI/SAK4/anE7UAmF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cn4ubqFa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cn4ubqFa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6CF70C1786A;
	Mon, 16 Feb 2026 15:12:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 31968606CF;
	Mon, 16 Feb 2026 15:12:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3B971036916C;
	Mon, 16 Feb 2026 16:11:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771254723; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C+tdW27UyjmL/YGLro3NutiDN/boatLgbGvmemeFrI0=;
	b=cn4ubqFaLEFHWMpwCSy3F3VvF6VhBECXclViZUVpjom+GQxzPQrgq3/AP5iFCGxdHZ3kB9
	HZHqFZGQJxmTnr8OubiiV4u3PV4XaWsp/LqBtHiG0e1VEeNG0RfnnYo+5POrXo9V8z0bUT
	Yq8h0oY0/RE+RCWOlttRISGSnGT1n4cmAGQe1RUvUCe+W1UhgytI1lan3kG70I4/BSEIlK
	oWsq+/M9Z7RkauVggRyasxxxIhjKIBalk4lMzj8DA3AWV75lb48jM8TssSXnnr4YGHkphY
	lUPEQC4Y9vFmCNTvT3LanyKgFf8v6iBmE7TYE6XoEKVSWTzjc8Zf/CQest6V/w==
Date: Mon, 16 Feb 2026 16:11:55 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, "H. Nikolaus Schaller"
 <hns@goldelico.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bajjuri Praneeth <praneeth@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Louis Chauvet
 <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
Message-ID: <20260216161155.09fae580@kmaincent-XPS-13-7390>
In-Reply-To: <CAOCHtYicmeSzH5Q2_qTwAZw3s+__JRwUrXvz01+KCsJJHAznUw@mail.gmail.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
	<20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
	<B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
	<20260212174718.7daccb70@kemnade.info>
	<719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
	<20260212231907.6120a2e2@kemnade.info>
	<CAOCHtYicmeSzH5Q2_qTwAZw3s+__JRwUrXvz01+KCsJJHAznUw@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 12 Feb 2026 21:16:05 -0600
Robert Nelson <robertcnelson@gmail.com> wrote:

> On Thu, Feb 12, 2026 at 4:19=E2=80=AFPM Andreas Kemnade <andreas@kemnade.=
info> wrote:
> >
> > On Thu, 12 Feb 2026 17:55:43 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> > =20
> > > > Am 12.02.2026 um 17:47 schrieb Andreas Kemnade <andreas@kemnade.inf=
o>:
> > > >
> > > > On Thu, 12 Feb 2026 16:49:43 +0100
> > > > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> > > > =20
> > > >>> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI)
> > > >>> <kory.maincent@bootlin.com>:
> > > >>>
> > > >>> Allow overlays to be applied to any DTB. This adds around ~40% to=
 the
> > > >>> total size of the DTB files on average. =20
> > > >>
> > > >> Is this unconditionally enabled or can it be turned off by some
> > > >> CONFIG? We have our own defconfig so I would not worry if if is
> > > >> enabled in omap2plus_defconfig and disabled in ours.
> > > >>
> > > >> We have several devices where the boot loader can't handle overlays
> > > >> (never touch a working boot-loader :) So this seems to only contri=
bute
> > > >> to build and load time without benefit.
> > > >> =20
> > > > As long as you do not add overlays, the bootloader does not care. I
> > > > would like to simply carry around the 1-bit mmc overlay for one bro=
ken
> > > > board. That would help me. So I think there is a benefit but nobody
> > > > forces you to use it. =20
> > >
> > > Well, it does not force to use the really good feature, but it forces=
 to
> > > add ~40% more file size and some more compile time, if I understand it
> > > correctly.=20
> > Compile time, hardly measurable even if you just do make dtbs.
> >
> > Size on disk:
> > a) if it lives around in a /boot partitions with kernels and initrams i=
n it,
> >    then we are around 1% more space needed.
> >
> > b) if it has separate partitions maybe on some mtd: Looking around: GTA=
04
> >    has quite some headroom left. Usage is still <50% even with symbols
> >    enabled.
> >
> > But on the other no one else seems to enable that besides for devices w=
ith
> > open expansion boards carrying "hats". So overall, should we really be =
the
> > exception? =20
>=20
> Do we want to maybe transition like TI did for k3?
>=20
> Start with board specific DTC_FLAGS flags for specific boards:
>=20
> and then just enabling overlays by default :
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/arch/arm64/boot/dts/ti/Makefile?id=3Dbca4146b1f66dbca07591bfd6ad695c699b5a=
093
>=20
> If we do board-specific, all the "Beagle" related items can be auto
> enabled `-@`..

Yes, I will move on to this solution for now to avoid too many complaints a=
bout
the devicetree size increases.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
