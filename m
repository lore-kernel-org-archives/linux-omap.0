From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: Fwd: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
Date: Tue, 21 Oct 2008 01:15:55 +0200
Message-ID: <20081020231554.GB4833@localdomain>
References: <200810181213.18616.david-b@pacbell.net> <20081020223151.GD4197@sortiz.org> <200810201551.39189.david-b@pacbell.net>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:33210 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbYJTXQB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 19:16:01 -0400
Content-Disposition: inline
In-Reply-To: <200810201551.39189.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Mon, Oct 20, 2008 at 03:51:38PM -0700, David Brownell wrote:
> On Monday 20 October 2008, Samuel Ortiz wrote:
> > I am pushing this code without MODULE_AUTHOR for now.
> > I agree with Alessandro it would be nice to have it, but only if it's someone
> > that could actually maintain it somehow. Are Dmitry or/and Alexandre good
> > candidates for that ?
> 
> I won't speak for them ...
> 
> The OMAP community has, so far, tended to be fairly
> good about pitching in to fix things that break; so
> there may be less of a worry there.  I also know that
> TI is trying to be a bit more "in the loop" with its
> staff and mainline, so that should help a bit too.
> 
> Anyway, this driver "Just Works", so nothing else
> could go wrong.  ;)
I'm reassured ;-)

 
> - Dave
> 
> p.s. I just noticed a boatload of genirq patches
>      go upstream ... I suspect that at least the
>      reference to NR_IRQS in that one patch will
>      need to change.
You mean the NR_IRQS reference from the twl4030 irq update patch ?
I just applied it to my mfd tree, which is built on top of Linus latest git,
and it seemed to at least build fine.
I'm planning to send the last mfd pull request tomorrow, so if you have some
additional fixes, please send them by then.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
