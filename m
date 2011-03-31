From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 20:15:02 -0500
Message-ID: <AANLkTik-BFTzyPLuYVdhCJPocc0wPY0rKvO7BQS4Fg1S@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<20110331001502.GB6680@n2100.arm.linux.org.uk>
	<AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44732 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab1CaBPD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 21:15:03 -0400
In-Reply-To: <AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>

Linus:

On Wed, Mar 30, 2011 at 7:55 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> =A0124022 total arch/sh
> =A0124418 total arch/sparc
> =A0181997 total arch/m68k
> =A0246717 total arch/mips
> =A0254785 total arch/x86
> =A0370912 total arch/powerpc
> =A0732732 total arch/arm

I'm not sure this metric is completely fair to ARM.  If you want to
level the field, I think you have to divide each result by the number
of SoC's (or equivalent, in the case of x86) represented by that
architecture.  Otherwise you aren't taking the diversity of the
various implementations of that instruction set into account.

Doing that, I think you'll find that ARM is in much better shape than
it appears.

> And ARM fanbois can say "oh, but arm is special" all they want, but
> they need to realize that the lack of common platform for ARM is a
> real major issue. It's not a "feature", and I'm sorry, but anybody wh=
o
> calls x86 "peanuts" is a moron and should be ashamed of himself.
> Instead of trying to feel superior, those people should feel like
> pariah.

I didn't say it was peanuts, but I agreed with the statement and I
stand by it.  I don't think x86 is even close to the diversity you
find in the various ARM implementations.

> The fact that x86 has a platform, and people have cared about
> compatibility, and actually gets things to work with less code is a
> good thing.

Depends on who you ask.  I have had to completely re-do entire
projects because we weren't able to bend the x86's notion of
"platform" to fit the task at hand (the decision to go with x86 was
made before I was involved in those projects, fwiw).

=46urthermore, why aren't you saying the same thing about SH?  They
don't appear to have a concept of "platform" that's any more evolved
than ARM.  But there are a lot fewer SH SoCs supported in-kernel, so
the "problem" doesn't look as pronounced.

> I know ARM people who think that x86 is an "ugly" architecture.

You don't know me, but I think x86 is an ugly architecture.

> But the fact is, of all the architectures out there, ARM
> right now is the ugliest BY FAR. Exactly because of people who don't
> seem to understand that this kind of crap is a problem.

It's an OPPORTUNITY, not a problem.  ARM's absence of a "platform"
concept allows developers to bend ARM into the shape needed to solve
the problem--- something that you can't say about x86.

This is a kernel architecture problem, not an SoC problem.


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
