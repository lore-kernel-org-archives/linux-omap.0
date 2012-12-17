From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes and cleanups for v3.8 merge window
Date: Mon, 17 Dec 2012 10:38:52 -0800
Message-ID: <20121217183852.GX4989@atomide.com>
References: <20121217180200.GU4989@atomide.com>
 <20121217180852.GA24440@arwen.pp.htv.fi>
 <20121217183103.GW4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:34550 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753706Ab2LQSi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 13:38:58 -0500
Content-Disposition: inline
In-Reply-To: <20121217183103.GW4989@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [121217 10:33]:
> * Felipe Balbi <balbi@ti.com> [121217 10:18]:
> > Hi,
> > 
> > On Mon, Dec 17, 2012 at 10:02:01AM -0800, Tony Lindgren wrote:
> > >  drivers/mfd/omap-usb-host.c                        |  3 +-
> > >  drivers/tty/serial/omap-serial.c                   |  3 +-
> > >  drivers/usb/phy/Kconfig                            |  1 +
> > 
> > I did mention I was against adding OMAP dependencies do drivers.
> > Interesting to see to commit going upstream without a reply to my
> > comment :-s
> > 
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=3e194c88f8b71700822828749187e65853ed8166
> 
> Looks like Linus already applied it. Anyways, I like Dmitry's idea
> of adding an extra COMPILE_COVERAGE flag to enable the build of
> arch specific drivers for driver subsystem maintainers, I'll
> do a patch for that so you can test build all the arch specific
> USB drivers on x86 also.

Oh I see I have it also in my fixes, that should not be there.

I'll fix that and do another pull request. The commit Linus
applied is 770b6cb4.

Regards,

Tony
