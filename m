From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Thu, 16 Oct 2014 01:18:01 +0100
Message-ID: <20141016001801.GQ12379@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk> <543EF2B6.1050009@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35219 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751251AbaJPASU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 20:18:20 -0400
Content-Disposition: inline
In-Reply-To: <543EF2B6.1050009@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Nathan Lynch <Nathan_Lynch@mentor.com>, David Laight <David.Laight@ACULAB.COM>, Otavio Salvador <otavio@ossystems.com.br>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Oct 15, 2014 at 06:18:30PM -0400, Peter Hurley wrote:
> On 10/15/2014 05:56 PM, Russell King wrote:
> > I was in two minds whether to include 4.8.3 as Linaro released a buggy
> > toolchain which identifies itself as 4.8.3, but I decided that's also
> > a distro problem.  IMHO Linaro should really think about taking that
> > compiler down given the seriousness of this bug and it being
> > indistinguishable from the fixed stock version.
> 
> Maybe it's unfair to blame them; Linaro just took a snapshot and
> released what was there.
> 
> If gcc is going to retain the "change release number then add all the
> new features" model, some kind of prerelease indicator would help
> eliminate this kind of problem. And that indicator should be both
> a preprocessor define and parseable from the command line :)

My comment is not to attribute blame to them, my comment is entirely
on a technical level.

My reasoning is that the bug is just as prevalent in userspace, though
it will occur less often.  Any program which uses signal handlers is
a candidate for exactly the same kind of corruption, since you can
receive that signal between the point that the stack pointer is
modified and the function loads the parent context.

Of course, there are ways around that: don't use signal handlers, or
if you do, use alternate signal stacks.  Neither of those can be
guaranteed for any program though.

So, let me put this another way: a compiler with this bug is _completely_
unsuitable for use for compiling programs for use under the Linux
kernel _as well_ as the Linux kernel itself.

The difference is that the Linaro compilers come with an expectation
that they are usable on ARM... whereas stock versions cover a lot more
and so the ARM arch is probably very small number of their users.

Hence why I recommend that Linaro takes down their buggy compiler.
Their 4.8.3 version should not be used *anywhere*, just the same as
the stock 4.8 to 4.8.2 inclusive should also not be used anywhere on
ARM either.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
