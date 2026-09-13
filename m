Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374593E2AD1
	for <linux-omap@vger.kernel.org>; Sun, 13 Sep 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789323252; cv=none; b=O+frgkBtICgS71L2tsP9/7yNMCIMJSRPcVesEe4fKtNP3uOpiCW/OvAaKQMlVvutbBA73/fmFCxXNu5s/EPnEZPQw5Nmf3nElVotiLNEt5hwdB8t7CgcCGY6A0aAPEeeqk3Y1l3YwYjvBPVKHsqWeQ5MZ8dBYokQhUWQcvqm6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789323252; c=relaxed/simple;
	bh=+i/WMQo12F+E81xj/jdX7lcu6060BfxnYwbQM4ckRZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVT+FkL+a1IPTfxm9hRygwPdikOA2tDbzQcvJz/XocuoaKhCDHlijXu6NSuAOpnbqCj8gmtp5KH7jgap8reG84yLB6C56KXl6dCKSKQyCCIv5T/1Y61fiOu6GBpFbXWLHNOsB3uW3YrhSBMTXt9c98rx4EzQd9kcb/ls2pr26tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO2SmIdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO2SmIdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB581F00899
	for <linux-omap@vger.kernel.org>; Sun, 13 Sep 2026 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789323239;
	bh=+i/WMQo12F+E81xj/jdX7lcu6060BfxnYwbQM4ckRZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SO2SmIdYjJe5zzSusPLufb1N/4sITaFnh3OuAjM0+HDJ/0jzTDRo1LJJD3yuz0LAe
	 m9utPZHktAferMrZ1uMTDiSdbFT8PuZIT68sd6yul+TOjyulMH1leZv3n2097fW0kI
	 HZSTnOlV/XWa3doV6AwdmTxJGx3acDrumYZ3xAXLg9oBP7AZeX4c+jdG+GE3leTYME
	 o+gGhWxF0SyzDJ1JCk+kUMy4kYISkcvV3AkuDb36TVraJLgPIZU84S7P5MYAV3syTK
	 sGiu4PkjnJsUoo795urpsWbR9ka05zNomPSqGObRwYr6ZGH3GsxtKSjfhGjyfqiex9
	 6SceEGtrOAcWw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso1282649e87.1
        for <linux-omap@vger.kernel.org>; Sun, 13 Sep 2026 11:13:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy5CWufBfXHigbW5TUZMcwAjVJIb+jdg/BtxiOd+xvwqVxAmTSSoEqUl2ACvDesb5smIhYsrVCmSz7r@vger.kernel.org
X-Gm-Message-State: AFuF++kka7Q6uGa8I4K0R1Ij2HfUGYtXttWnfupmtIG77NFEhkAEbeom
	NTaQ0mzFi48ZhbwUsJgHD3mikioT+TWJZRZ3MYS6IWkL/ZHOwqFog5sM5ikn9E9gTDWRS2o3JCq
	qUvSlVd+qNspsLRwdMToF11+78aNVv2U=
X-Received: by 2002:a05:6512:158b:b0:5b8:9ec5:c936 with SMTP id
 2adb3069b0e04-5b8a8ec2c76mr1378800e87.44.1789323238029; Sun, 13 Sep 2026
 11:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
 <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
 <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com> <CAFr9PX=tVOzqGU4k0zSzXheuU5z5LZi4LSGdUvjChrSTrbyjJg@mail.gmail.com>
In-Reply-To: <CAFr9PX=tVOzqGU4k0zSzXheuU5z5LZi4LSGdUvjChrSTrbyjJg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 13 Sep 2026 20:13:44 +0200
X-Gmail-Original-Message-ID: <CAD++jL=nr_Rgf6e+vo2bbTRNvEXysEEMjMhGp3-2J2_JPSVkiA@mail.gmail.com>
X-Gm-Features: AcwNN1UBjE2eanAt46mrgMtCvXLgZ5DQ_bTFYwRvKhaMIzHs2zMGgr1ICh4wWo0
Message-ID: <CAD++jL=nr_Rgf6e+vo2bbTRNvEXysEEMjMhGp3-2J2_JPSVkiA@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Daniel Palmer <daniel@0x0f.com>
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
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sat, Sep 12, 2026 at 3:29=E2=80=AFAM Daniel Palmer <daniel@0x0f.com> wro=
te:
> On Sat, 12 Sept 2026 at 03:15, Linus Walleij <linusw@kernel.org> wrote:

> > I would say using generic entry would be a prerequisite for
> > doing m68k SMP so we don't introduce *more* entry
> > oddities, but after that I'm game.
>
> I have started this for one part of the m68k tree (68000), but it's
> one of those things that is hard/frustrating to test on real hardware.

Pretty cool!

> For the last few weeks I've had claude create a QEMU that can boot all
> of the m68k supported machines to Linux, Netbsd and their original OS.
> It already found this:
> https://lore.kernel.org/linux-m68k/20260828094940.3882602-1-daniel@0x0f.c=
om/

Now we're talking.

> > As SoC maintainer I see that m68k has a lot of technical debt
> > like drivers under arch/m68k and no proper hardware description
> > (such as device tree)
>
> I have m68k machines using devicetree... :)
>
> > There are things like
> > amiints.c, cia.c, ataints.c, q40ints.c etc that should be in
> > drivers/irqchip. So many time.c that should be in
> > drivers/clocksource/* and many other unmodern things.
>
> Would be easier with devicetree. But is anyone crazy enough to go
> through the pain of merging the devicetree support and then arguing
> about devicetree bindings for each of those drivers only to be told
> m68k should just be removed?

That's conflating two completely different things that think
about themselves as different communities.

Devicetree is in its ambition OS-independent and the fact that
the bindings are all in the Linux git is just a convenience because
that community works well and is dominant.

No device tree maintainer should *ever* complain abot
*any* binding with reference to what Linux supports or
where Linux want to go. Only people not actually working
with device tree would say such things.

Device tree bindings have been deleted but then by the
person who is maintainer of the binding itself, and for
the argument that "no operating system" supports the
platform anymore.

Reviewing and merging m68k bindings should not be
any more problem than any other binding, and it should
not have an impact on Linux support of m68k.

> Once you have an emulator that the LLM can operate it can do the
> change/build/test/debug cycle all on its own.
> With a test harness it can even test the changes work on the real hardwar=
e.
> But I don't think that's enough to convince people the changes are
> worth reviewing/merging.

I will review them. And I do not think the DT maintainers
have anything against m68k.

Yours,
Linus Walleij
