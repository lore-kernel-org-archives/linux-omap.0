From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Fri, 17 Oct 2014 14:41:12 +0100
Message-ID: <20141017134112.GS12379@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk> <543EF2B6.1050009@hurleysoftware.com> <20141016001801.GQ12379@n2100.arm.linux.org.uk> <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36347 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753718AbaJQNl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Oct 2014 09:41:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Nathan Lynch <Nathan_Lynch@mentor.com>, David Laight <David.Laight@ACULAB.COM>, Otavio Salvador <otavio@ossystems.com.br>, Linus Torvalds <torvalds@linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Thu, Oct 16, 2014 at 10:58:06AM -0400, Nicolas Pitre wrote:
> On Thu, 16 Oct 2014, Russell King - ARM Linux wrote:
> 
> > So, let me put this another way: a compiler with this bug is _completely_
> > unsuitable for use for compiling programs for use under the Linux
> > kernel _as well_ as the Linux kernel itself.
> > 
> > The difference is that the Linaro compilers come with an expectation
> > that they are usable on ARM... whereas stock versions cover a lot more
> > and so the ARM arch is probably very small number of their users.
> > 
> > Hence why I recommend that Linaro takes down their buggy compiler.
> > Their 4.8.3 version should not be used *anywhere*, just the same as
> > the stock 4.8 to 4.8.2 inclusive should also not be used anywhere on
> > ARM either.
> 
> Here's the answer from the toolchain team:
> 
> On Thu, 16 Oct 2014, Yvan Roux <yvan.roux@linaro.org> wrote:
> 
> | Hi Nicolas,
> |
> | thanks for bringing this to our knowledge.
> |
> | The fix for PR58854 was included in our releases since the GCC
> | 4.8-2013.12 which is based on a 4.8.3 prerelease version (at svn
> | revision 205577).  As we are doing monthly releases based on a
> | revision of the related FSF branch, using GCC_VERSION (__GNUC__,
> | __GNUC_MINOR,__GNUC_PATCHLEVEL) is not accurate enough to identify the
> | release version (all our releases between November 2013 and May 2014
> | will be 4.8.3) the __VERSION__ predefined macro is a bit more accurate
> | here ("4.8.3 20131202 (prerelease)") but not completely satisfactory.
> |
> | I completely agree that we should at least mention in our impacted
> | releases download pages that this bug is present.

Unfortunately, __VERSION__ doesn't help us identify that the bug has
been fixed - it's not something which can be tested at preprocessor
time.

Those which identify themselves as 4.8.3 won't be impacted by the patch,
which means that the Linaro 4.8.3 GCC versions will continue to build
the kernel just fine.  Even the buggy versions.

I don't see the point of continuing to offer the buggy versions for
download though - the compiler is totally unsuitable for building any
Linux related binaries, be that kernel or userspace, and so should not
be used under any circumstances, period.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
