From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 23:59:21 +0300
Message-ID: <20080829205918.GC14130@frodo>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <200808291305.31639.david-b@pacbell.net> <20080829202114.GA14130@frodo> <200808291350.17181.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55290 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYH2U7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 16:59:43 -0400
Content-Disposition: inline
In-Reply-To: <200808291350.17181.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, ext Ashwin Bihari <abihari@gmail.com>, linux-omap@vger.kernel.org

On Fri, Aug 29, 2008 at 01:50:16PM -0700, David Brownell wrote:
> Right, that's why I thought I'd chase the easier host-side issue
> first.  Must have "apt-get install ..." working after all!!

hmm... sure.

> Were those self-powered devices, or bus-powered?  Descriptors
> are not entirely trustworthy about current usage.  Sometimes
> they represent worst-case; sometimes it's best-case.

bus-powered.

> > Do you have the BLACKLIST_HUB set? (just to be sure).
> 
> No, that's not set.

yet another new bug so, is it a full or high speed hub ?

> IMO it's the silicon that's buggy.  The specific window I kept seeing
> was between VBUS_ON and the 100msec later where it's expected to be
> stable.  During that window, VBUS is allowed to not be stable ... which
> is good, because that's when current spikes happen while charging the
> various capacitances involved.  (Cable, caps at either end, etc.)
> 
> I saw TUSB6010 reporting VBUS_ERR during that 100msec window ... and
> same thing with DaVinci.  Both needed retry logic to cope with the
> inappropriate VBUS fault reports.  The thing in common is the silicon
> IP, not the hardware.

Sure, musb is damn buggy and looks like it won't be fixed after all. At
least we're sure it's a silicon bug. I wonder if mentor has plans to fix
it ?!? A better dma engine would also be welcome, the whole "mode"
thingy is a mess.

btw, do you need me to help you debugging anything ? I can to the office
tomorrow and debug some stuff there if it's needed, otherwise I'll get
back to this only on monday.

-- 
balbi
