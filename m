From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Wed, 15 Oct 2008 00:20:37 +0300
Message-ID: <20081014212034.GA31842@frodo>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <20081014153824.3722411c@hyperion.delvare> <20081014135230.GA28019@gandalf.research.nokia.com> <200810140900.55697.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41209 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbYJNVU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:20:59 -0400
Content-Disposition: inline
In-Reply-To: <200810140900.55697.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, ext Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Oct 14, 2008 at 09:00:55AM -0700, David Brownell wrote:
> On Tuesday 14 October 2008, Felipe Balbi wrote:
> > 
> > > Nack. Light sensors have nothing to do with hardware monitoring.
> > > 
> > > The only light sensor driver in the kernel tree at the moment
> > > is drivers/i2c/chips/tsl2550.c. But I'm not very happy with this
> > > either, as my ultimate goal is to delete the drivers/i2c/chips
> > > directory completely. So we should find a new home for light sensors.
> > 
> > and that's why I'm moving nokia drivers out of drivers/i2c/chips
> > directory.
> > 
> > > Maybe they should go into the new "industrial I/O" subsystem. Or if
> > > not, their own drivers/sensors/light directory.
> > 
> > Well, could be. We might need someone else, like Andrew, to answer that
> > question.
> 
> My two cents:  leave them where they are until a "good" answer exists.
> Or if drivers/i2c/chips is sufficiently annoying ... drivers/misc may
> be a good interim site.

I'd say that if it goes to the "wrong" place and doesn't bother anyone,
will get forgotten. Just like the whole bunch of other drivers sitting
in linux-omap. They don't bother anyone (probably they bother Tony when
API changes upstream and a few defconfigs don't build anymore) so they
got forgotten and still sitting in linux-omap.

Funny that most of such drivers are for nokia tablets :-p

-- 
balbi
