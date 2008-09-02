From: Tony Lindgren <tony@atomide.com>
Subject: Re: Enabling MUSB support
Date: Tue, 2 Sep 2008 15:36:42 -0700
Message-ID: <20080902223641.GH23085@atomide.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61345 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYIBWgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:36:49 -0400
Content-Disposition: inline
In-Reply-To: <200808272354.28531.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080827 23:54]:
> On Wednesday 27 August 2008, Felipe Balbi wrote:
> > I tried musb on omap2420 (with tusb), omap3430 and omap3530
> > (beagle board) and all of them are working.
> 
> I tried it on Beagle and found that OTG mode wanted to oops
> while binding the gadget driver ... static config.  That's
> with current GIT.  Peripheral-only had the same issue ISTR.
> 
> Host mode seemed to come up partially.  There seem to be
> issues with control-OUT transfers, which caused problems
> trying to use the Ethernet adapter I was hooking up.
> 
> - Dave
> 
> p.s. FWIW my beagle identifies itself as 3430 ES2.2
>      not as 3530.

AFAIK, the revision registers are same for 3430 and 3530.. Luckily you
can now force the processor revision from board-*.c files if needed with
omap2_set_globals_xxxx(). I think the 3550 patches for that have not
been merged though.

Tony
