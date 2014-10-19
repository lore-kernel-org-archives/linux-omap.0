From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Sun, 19 Oct 2014 21:14:51 +0100
Message-ID: <20141019201451.GV12379@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk> <543EF2B6.1050009@hurleysoftware.com> <20141016001801.GQ12379@n2100.arm.linux.org.uk> <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr> <20141017134112.GS12379@n2100.arm.linux.org.uk> <20141019095555.GU12379@n2100.arm.linux.org.uk> <CA+55aFw_N=E9O-7VknWTzjNgYG-tB-8736diA1r7K=50b+0czQ@mail.gmail.com> <20141019185118.GA22014@n2100.arm.linux.org.uk> <CA+55aFwy1hg25p3amy1xZq58afcaNSgP+uy=UA19BSgoVpARVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37920 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752445AbaJSUPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Oct 2014 16:15:06 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwy1hg25p3amy1xZq58afcaNSgP+uy=UA19BSgoVpARVQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Otavio Salvador <otavio@ossystems.com.br>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nathan Lynch <Nathan_Lynch@mentor.com>

On Sun, Oct 19, 2014 at 01:04:20PM -0700, Linus Torvalds wrote:
> On Sun, Oct 19, 2014 at 11:51 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > Does that work for things like allnoconfig and randconfig?  I guess people
> > /could/ seed those appropriately, but that seems to be something that Olof
> > wants to avoid doing.
> 
> You can force particular config options for those, using something like
> 
>     export KCONFIG_ALLCONFIG=custom.config
> 
> and filling the custom config file with the required config setting.

Yes, this is what I meant above by "seed"ing the configurations, and it
is something I do all the time with my autobuilder here for things like
allnoconfig where I want to ensure that certain options have specific
values.

When I talked to Olof about it, he seemed to be against using the
facility in his autobuilder.  I'm not clear on why that was, but I
suspect it's because Olof wants to test real allnoconfig builds.

An alternative is we could have a HAVE_GCC_PR58854_FIX preprocessor
conditional, and pass in KCFLAGS=-DHAVE_GCC_PR58854_FIX to the kernel
to bypass the check.

Either way, I think we need Olof's input on this to say what he's
willing to do.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
