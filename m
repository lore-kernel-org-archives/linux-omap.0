From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: pending patch
Date: Fri, 25 Apr 2008 13:18:38 +0300
Message-ID: <20080425101837.GZ23350@gandalf.research.nokia.com>
References: <20080425075245.GX23350@gandalf.research.nokia.com> <200804250235.21910.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49663 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761094AbYDYKT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 06:19:56 -0400
Content-Disposition: inline
In-Reply-To: <200804250235.21910.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org

On Fri, Apr 25, 2008 at 02:35:21AM -0700, David Brownell wrote:
> On Friday 25 April 2008, Felipe Balbi wrote:
> > Hi Tony and Dave,
> > 
> > there's this one pending patch [1]. Do you guys have any comments on that
> > one?
> > 
> > Author: Felipe Balbi <felipe.balbi@nokia.com>
> > Date:   Thu Apr 17 17:34:20 2008 +0300
> > 
> >     USB: MUSB: Don't ignore disconnect on suspend
> >     
> >     As soon as a usb device is disconnect we should
> >     fall into a_wait_bcon state, ignoring disconnect
> >     irq will prevent this behaviour.
> 
> If it passes the OTG tests, fine.  I don't recall how the
> HNP handoff's disconnect signaling is handled ... presumably
> it's different from some "real" disconnect.

No opt available for now...
The problem is that when you ignore disconnect on suspend you only ack
the disconnect interrupt after attaching other device. It won't get us
too much trouble besides the bit will still set in int_src, but still
musb should ack disconnect as soon as it happens, shouldn't it? And
right after that start the timer for switching from a_wait_bcon to
a_wait_vfall and after that a_idle.

But as soon as I have and opt available, I'll try to run this test and
report you if I can see any issues with this patch applied.

For now, let's keep it as pending so.

-- 
	- Balbi
