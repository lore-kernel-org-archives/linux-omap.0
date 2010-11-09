From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 23:53:29 +0200
Message-ID: <AANLkTin0Lszi6MVo8GBWmpvMQRL3V+VGbtGdaMkBe5XO@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
	<201011091729.17679.arnd@arndb.de>
	<20101109165509.GA9698@kroah.com>
	<AANLkTinFW431t9XFqHc=wZAws9gjT0ikrc03J83kH7iF@mail.gmail.com>
	<20101109172511.GA10958@kroah.com>
	<AANLkTi=CKERMcSLXwQa7G55P69DO--UPN9HgOScHP_yO@mail.gmail.com>
	<20101109175828.GA27627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36842 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab0KIVxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 16:53:31 -0500
In-Reply-To: <20101109175828.GA27627@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 9, 2010 at 7:58 PM, Greg KH <greg@kroah.com> wrote:
> If it is easy to revert and push later, then the "revert just this
> piece" should be done now.
>
> Seriously, I'm getting very confused here, and am very annoyed by the
> whole thing.

With good reason.

> Here's what I don't like:
> =C2=A0- the original driver didn't even seem to work properly

It _was_ working properly, when it was a separate branch, but the
merge to staging wasn't done correctly, so it has never worked there.

> =C2=A0- people sent me patches they never tested and broke things eve=
n worse

Part of the blame goes to TI. Even if you have the hardware, it's not
straightforward to test this. I have struggled to improve the
situation on user-space with the gst-dsp and dsp-tools projects, which
btw have not received support from TI, but apparently they were not
used to test this (neither was the "official" solution from TI which
is much harder to set up).

> =C2=A0- some people have no respect for the omap maintainers and what=
 they
> =C2=A0 =C2=A0think about things, or even basic knowledge of the kerne=
l
> =C2=A0 =C2=A0development cycle.

I don't think this is the case. The opinion of the OMAP maintainers is
valuable in order to cleanup the mess that is this driver. But _first_
it has to work. Most people are not developers, they just want to use
this driver.

> =C2=A0- I do not have this hardware so I can't test anything.
>
> So, from now on, I'm not taking ANYONES patches for this driver unles=
s
> it gets an ack from the driver maintainer, Omar Luna.
>
> Actually, no, I'm not going to take any patch unless it _comes from_
> Omar. =C2=A0Omar, please work to queue up patches and test them, and =
then
> send them to me for merging.
>
> Any questions?

You mean after this pull, or should Omar re-send this pull request?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
