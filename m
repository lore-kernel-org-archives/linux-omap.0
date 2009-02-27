From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] twl4030-madc fixes
Date: Fri, 27 Feb 2009 10:11:52 -0800
Message-ID: <20090227181151.GF11594@atomide.com>
References: <499EB9EB.4050008@nokia.com> <200902221359.33590.david-b@pacbell.net> <20090227170330.GC11594@atomide.com> <20090227174603.GC16801@frodo> <20090227175510.GE11594@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61324 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbZB0SL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 13:11:58 -0500
Content-Disposition: inline
In-Reply-To: <20090227175510.GE11594@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [090227 09:56]:
> * Felipe Balbi <me@felipebalbi.com> [090227 09:46]:
> > On Fri, Feb 27, 2009 at 09:03:31AM -0800, Tony Lindgren wrote:
> > > * David Brownell <david-b@pacbell.net> [090222 13:59]:
> > > > On Friday 20 February 2009, Aaro Koskinen wrote:
> > > > > Hello,
> > > > > 
> > > > > Two fixes for twl4030-madc:
> > > > > 
> > > > > - The first one converts the ioctl to unlocked one.
> > > > > 
> > > > > - The second one should return the conversion status to user quicker, 
> > > > > both in OK and timeout cases. There's also fix for the timeout case 
> > > > > (currently the request remains active) and some cleanup.
> > > > 
> > > > They both look OK to me.
> > > 
> > > Aaro, please post these to the accociated driver lists to get these
> > > integrated. Also Cc l-o so people can easily track what's happening.
> > 
> > twl4030 madc is still in l-o only. I guess we need to figure out a way
> > to get that moved to hwmon and push it via the proper mailing list.
> > 
> > Until then, bummer, it's gonna stay here :-(
> 
> I think after 2.6.29 gets tagged it's time to reset all the twl code to
> the mainline.
> 
> So everybody with twl patches, please try to get them integrated to
> the mainline this coming merge window!

I've applied Aaro's fixes to l-o for so it's easier to find them. But
will remove any non-mainline twl code after v2.6.29-omap1 gets tagged.

Regards,

Tony
