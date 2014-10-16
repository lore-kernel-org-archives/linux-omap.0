From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Thu, 16 Oct 2014 15:29:44 +0100
Message-ID: <20141016142944.GR12379@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk> <063D6719AE5E284EB5DD2968C1650D6D1C9D80CC@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35755 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751232AbaJPO37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2014 10:29:59 -0400
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9D80CC@AcuExch.aculab.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Nathan Lynch <Nathan_Lynch@mentor.com>, Peter Hurley <peter@hurleysoftware.com>, Otavio Salvador <otavio@ossystems.com.br>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 16, 2014 at 10:30:30AM +0000, David Laight wrote:
> > +#ifdef __GNUC__
> >  #if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> >  #error Your compiler is too buggy; it is known to miscompile kernels.
> > -#error    Known good compilers: 3.3
> > +#error    Known good compilers: 3.3, 4.x
> 
> Except that isn't true since 4.8.0 isn't a good compiler.
> 
> > +#endif
> > +#if GCC_VERSION >= 40800 || GCC_VERSION < 40803
> > +#error Your compiler is too buggy; it is known to miscompile kernels
> > +#error and result in filesystem corruption and oopses.
> > +#endif
> >  #endif
> 
> You are mixing the style of the version check.
> Why not the single test:
> #if GCC_VERSION < 30300 || (GCC_VERSION >= 40800 && GCC_VERSION < 40803)
> #error Your compiler is too buggy; it is known to miscompile code.
> #error Known good compilers: 3.3 onwards excluding 4.8.0 through 4.8.2
> #endif

As you have just nicely demonstrated, changing what's already there can
cause unintentional changes to creep in.  The original test tested for
GCC 3 compilers older than GCC 3.3, excluding GCC 2.96 and older.  Your
version blacklists everything before GCC 3.3.

Such a change should be a separate patch.  Moreover, if we really do want
to blacklist all compilers older than GCC 3.3, then that too needs an
explanation in the comments above this block, and in commit message.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
