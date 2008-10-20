From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: Fwd: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
Date: Tue, 21 Oct 2008 00:31:51 +0200
Message-ID: <20081020223151.GD4197@sortiz.org>
References: <200810181213.18616.david-b@pacbell.net>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:59198 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbYJTW3O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 18:29:14 -0400
Content-Disposition: inline
In-Reply-To: <200810181213.18616.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Sat, Oct 18, 2008 at 12:13:18PM -0700, David Brownell wrote:
> Note the MODULE_AUTHOR comment from Alessandro ... anyone
> want to fess up?  :)
> 
> GIT history suggests  Dmitry Krivoschekov did the original
> patch, Alexandre Rusev morphed some TI code into the RTC
> framework, and some anonymous TI person started the work.
I am pushing this code without MODULE_AUTHOR for now.
I agree with Alessandro it would be nice to have it, but only if it's someone
that could actually maintain it somehow. Are Dmitry or/and Alexandre good
candidates for that ?

Cheers,
Samuel.

> But I'm not sure I'd trust those inferences.
>
> 
> ----------  Forwarded Message  ----------
> 
> Subject: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
> Date: Saturday 18 October 2008
> From: Alessandro Zummo <alessandro.zummo@towertech.it>
> To: rtc-linux@googlegroups.com
> 
> On Fri, 17 Oct 2008 19:15:08 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > This adds a driver for the RTC inside the TWL4030 multi-function device.
> > It's a fairly basic RTC, with a wake-capable alarm.
> > 
> > Note that many of the pre-release Overo boards now in circulation can't
> > effectively use this RTC, because of a wiring error that puts its TWL
> > chip into "secure" mode.  (As in "secure yourself against tampering".)
> > This isn't an issue on other OMAP3 boards now supported in mainline,
> > such as Beagle and Labrador.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
>   Acked-by: Alessandro Zummo <a.zummo@towertech.it>
> 
>  I'd love to see an email in MODULE_AUTHOR
> -- 
> 
>  Best regards,
> 
>  Alessandro Zummo,
>   Tower Technologies - Torino, Italy
> 
>   http://www.towertech.it
> 
> 
> -------------------------------------------------------

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
