From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 device tree conversion: how to do first step
Date: Sun, 28 Jul 2013 15:37:29 +0200
Message-ID: <20130728133728.GA5382@amd.pavel.ucw.cz>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <20130719181416.GA1204@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43770 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab3G1Nha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 09:37:30 -0400
Content-Disposition: inline
In-Reply-To: <20130719181416.GA1204@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, lauri.leukkunen@nokia.com

Hi!

> > I'd like to convert Nokia N900 to device tree.
> > 
> > Unfortunately, serial port is not easily available (very special cable
> > would be needed, does someone know where to get one?)
> 
> One way to get one is building it yourself. I finished mine yesterday:
> 
> http://elektranox.org/n900/adapter/index.html

Nice but a bit above my hardware hacking skills. For now, I'm using
automated scripts to run qemu... (They are available at 

http://tui.cvs.sourceforge.net/viewvc/tui/tui/auto/

). They should allow automated testing for regressions and automatic
bisect.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
