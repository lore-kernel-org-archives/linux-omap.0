From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 14:02:20 -0700
Message-ID: <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<alpine.LFD.2.00.1103301531420.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 30, 2011 at 1:41 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> If in your mind "competitors" =3D=3D "morons" then you might be right.

There's a difference between "competition" and "do things differently
just to be difficult".

> Trying to rely on bootloaders doing things right is like saying that x86
> should always rely on the BIOS doing things right.

No. Not at all.

The problem with firmware/BIOS is that it's set in stone and closed-source.

I'm suggesting splitting out the crazy part into a separate project
that does this. Open-source. Like a mini-kernel. Because the thing is,
the main kernel doesn't care, and _shouldn't_ care. Those board files
are just noise.

The long-term situation should be that you should be able to have ONE
binary kernel "just work". That's where we are on x86. Really.

Without that kind of long-term view, where do you think ARM is going
to be in five years?

>> almost *SIXTY* percent of all arch updates were to ARM code.
>
> Absolutely not! =A0You have 14% going to OMAP code which happens to be
> under arch/arm/ but there is nothing ARM specific in there. =A0If OMAP was
> using a PPC or a MIPS core then you'd have the same result except under
> arch/powerpc or arch/mips. =A0There is very little in terms of ARM
> specific peculiarities under arch/arm/mach-omap2/ in fact.

But that's my point - the problem is all the crazy board crap.

I've never claimed that this is about the ARM cpu (which has it's own
issues, but that's a separate rant entirely). It's about the broken
infrastructure.

Now, some of it is quite understandable - ie real drivers for real
hardware. But a _lot_ of it seems to be just descriptor tables, and
I'm getting the very strong feeling that ARM people aren't even
_trying_ to make it sane, and trying to standardize things, or trying
to aim for the whole notion of "one kernel image, with much more hw
description done elsewhere".

Sure, you'll fundamentally always need several images (due to the
afore-mentioned crazy CPU architecture flaws - arm6 vs arm7 vs
armxyz), but I'm looking at the future, and arch/arm will get
_totally_ unmaintainable unless you guys have a plan for getting out
of the crazy hole you are in now.

arch/arm is already about 3x the size of arch/x86. And it's pretty
much all the crazy infrastructure afaik. timer chips, irq chips, gpio
differences - crap like that.

And the fact that you don't even seem to UNDERSTAND the problem, and
think that it's ok, and that continued future explosion of this is all
fine makes me even more nervous.

                           Linus
