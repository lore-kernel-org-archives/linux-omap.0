From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] ehci: Fix EHCI init for OMAP3EVM
Date: Mon, 6 Jul 2009 12:53:28 +0300
Message-ID: <20090706095328.GS8461@nokia.com>
References: <1246867091-13495-1-git-send-email-ajay.gupta@ti.com>
 <4A51B500.1080004@gmail.com>
 <19F8576C6E063C45BE387C64729E739404328C675C@dbde02.ent.ti.com>
 <20090706095059.GQ8461@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32291 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbZGFJxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 05:53:41 -0400
Content-Disposition: inline
In-Reply-To: <20090706095059.GQ8461@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, no To-header on input <"unlisted-recipients:;"@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Mon, Jul 06, 2009 at 11:50:59AM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> Hi,
> 
> On Mon, Jul 06, 2009 at 10:55:05AM +0200, ext Gupta, Ajay Kumar wrote:
> > Looks better but if USB itself is not included in the build then this part of code would be unnecessary in board-omap3evm.c. We again need to add some #ifdef there to avoid this.
> > 
> > Another solution is to add something like board_is_omap3evm() in <mach/board.h> and use them in usb-ehci.c.
> > 
> > Felipe, what do you suggest?
> 
> how about passing setup() and cleanup() function pointers from
> board-file to the driver via platform_data ?
> 
> the board-specific setup() could handle the mux config then.

looking more closely, it doesn't make sense what I said...

I need to think this through a little bit more, but I guess, for now the
ifdef is the way to go to, at least, get the board working.

I'll think this through.

-- 
balbi
