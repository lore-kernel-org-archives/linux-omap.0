From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] twl4030-madc fixes
Date: Fri, 27 Feb 2009 09:03:31 -0800
Message-ID: <20090227170330.GC11594@atomide.com>
References: <499EB9EB.4050008@nokia.com> <200902221359.33590.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51247 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZB0RDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 12:03:44 -0500
Content-Disposition: inline
In-Reply-To: <200902221359.33590.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090222 13:59]:
> On Friday 20 February 2009, Aaro Koskinen wrote:
> > Hello,
> > 
> > Two fixes for twl4030-madc:
> > 
> > - The first one converts the ioctl to unlocked one.
> > 
> > - The second one should return the conversion status to user quicker, 
> > both in OK and timeout cases. There's also fix for the timeout case 
> > (currently the request remains active) and some cleanup.
> 
> They both look OK to me.

Aaro, please post these to the accociated driver lists to get these
integrated. Also Cc l-o so people can easily track what's happening.

Regards,

Tony
