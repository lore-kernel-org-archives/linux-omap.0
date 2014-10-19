From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Sun, 19 Oct 2014 19:51:18 +0100
Message-ID: <20141019185118.GA22014@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
 <543EF2B6.1050009@hurleysoftware.com>
 <20141016001801.GQ12379@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
 <20141017134112.GS12379@n2100.arm.linux.org.uk>
 <20141019095555.GU12379@n2100.arm.linux.org.uk>
 <CA+55aFw_N=E9O-7VknWTzjNgYG-tB-8736diA1r7K=50b+0czQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37871 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751769AbaJSSvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Oct 2014 14:51:35 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw_N=E9O-7VknWTzjNgYG-tB-8736diA1r7K=50b+0czQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, Otavio Salvador <otavio@ossystems.com.br>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nathan Lynch <Nathan_Lynch@mentor.com>

On Sun, Oct 19, 2014 at 08:55:14AM -0700, Linus Torvalds wrote:
> On Oct 19, 2014 2:56 AM, "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> wrote:
> >
> > Right, with the test fixed (&& instead of ||), I've just pushed it out
> > this morning, and received the results from Olof's kernel builder,
> > which shows that he's using a gcc 4.8.x version which gets caught by
> > the test.
> >
> > I think Olof needs to do something about his gcc version there.
> 
> ... or maybe you could just add a "I have a working compiler" config option
> override to show people to say "I have one of the affected versions, but my
> compiler has the fix"?

Does that work for things like allnoconfig and randconfig?  I guess people
/could/ seed those appropriately, but that seems to be something that Olof
wants to avoid doing.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
