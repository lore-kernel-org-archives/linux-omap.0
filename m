From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
	omap_i2c
Date: Thu, 9 Dec 2010 22:21:40 +0000
Message-ID: <20101209222140.GU20097@trinity.fluff.org>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com> <1291904657-32729-2-git-send-email-b-cousson@ti.com> <878vzydgxr.fsf@deeprootsystems.com> <87wrni7jys.fsf@deeprootsystems.com> <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:58383 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757484Ab0LIWVo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 17:21:44 -0500
Content-Disposition: inline
In-Reply-To: <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: aaro.koskinen@nokia.com
Cc: khilman@deeprootsystems.com, ben-i2c@fluff.org, paul@pwsan.com, linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Thu, Dec 09, 2010 at 10:18:48PM +0000, aaro.koskinen@nokia.com wrote:
> Hi,
> 
> Kevin Hilman [khilman@deeprootsystems.com]:
> > Ben Dooks <ben-i2c@fluff.org> writes:
> > > Renaming stuff like this is going to have an impact on the userspace
> > > as anyone looking through /sys's driver heirarchy is going to miss the
> > > old name...
> > >
> > > It all depends if you really want to go ahead with this...
> >
> > Yes, we are aware of the userspace impact, but this name change makes
> > all devices on OMAP have consistent names and actually improves the
> > ability to have userspace tools have consistent naming as well.
> 
> So there are no imporant users, or if there is, they are prepared for this change?
> 
> >> >  drivers/i2c/busses/i2c-omap.c        |    4 ++--
> 
> What about the .c / .ko file name?

Pretty much everyone is in the form of i2c-xxx.c, so I would prefer it
to stay that way.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

