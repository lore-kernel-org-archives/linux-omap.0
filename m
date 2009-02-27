From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/2] twl4030-madc fixes
Date: Fri, 27 Feb 2009 19:46:04 +0200
Message-ID: <20090227174603.GC16801@frodo>
References: <499EB9EB.4050008@nokia.com> <200902221359.33590.david-b@pacbell.net> <20090227170330.GC11594@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41090 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474AbZB0RqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 12:46:19 -0500
Content-Disposition: inline
In-Reply-To: <20090227170330.GC11594@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 27, 2009 at 09:03:31AM -0800, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [090222 13:59]:
> > On Friday 20 February 2009, Aaro Koskinen wrote:
> > > Hello,
> > > 
> > > Two fixes for twl4030-madc:
> > > 
> > > - The first one converts the ioctl to unlocked one.
> > > 
> > > - The second one should return the conversion status to user quicker, 
> > > both in OK and timeout cases. There's also fix for the timeout case 
> > > (currently the request remains active) and some cleanup.
> > 
> > They both look OK to me.
> 
> Aaro, please post these to the accociated driver lists to get these
> integrated. Also Cc l-o so people can easily track what's happening.

twl4030 madc is still in l-o only. I guess we need to figure out a way
to get that moved to hwmon and push it via the proper mailing list.

Until then, bummer, it's gonna stay here :-(

-- 
balbi
