From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: ensure all sched_clock() implementations are
	notrace marked
Date: Thu, 16 Dec 2010 15:57:50 +0000
Message-ID: <20101216155750.GA28126@n2100.arm.linux.org.uk>
References: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk> <AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38748 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0LPP64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 10:58:56 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimGHSqO=QwESp98UBK28yawdiq+kURU=nwau27G@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Lennert Buytenhek <kernel@wantstofly.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Thu, Dec 16, 2010 at 08:42:23PM +0530, Rabin Vincent wrote:
> On Thu, Dec 16, 2010 at 1:48 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > ftrace requires sched_clock() to be notrace. =A0Ensure that all
> > implementations are so marked.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> It does seem better to have all of them explicity annotated anyway, e=
ven
> if it not required in most of the cases because they include
> <linux/sched.h> and the annotation in the declaration takes effect.

=46irstly, we shouldn't be relying upon that, and secondly, everywhere =
which
defines sched_clock() should already be including linux/sched.h to avoi=
d
the sparse error.  It sounds like there's also an exercise to make sure
that is the case.

> Note that in order for this to be fully effective, all functions call=
ed
> from sched_clock() need to be notrace too.  OMAP and u300 miss this.

Yes, OMAP still suffers from this.

However, I assume you haven't looked at the u300 sched_clock conversion
patch which is part of a follow-on series on lakml?  It sorts u300 out
in that regard.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
