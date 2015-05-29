From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 22:30:59 +0200
Message-ID: <20150529203059.GB22083@amd>
References: <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529200306.GB17267@lukather>
 <20150529201804.GT30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55988 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbbE2UbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 16:31:01 -0400
Content-Disposition: inline
In-Reply-To: <20150529201804.GT30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com


> > > So, because this has been wrongly documented for so long, we should
> > > support both bindings. Sure, deprecate touchscreen-max-[xy], but they
> > > must still be supported, IMO.
> > 
> > This property has never been anything but a typo in a documentation of
> > a single driver.
> > 
> > Feel free to fix that in that driver, but I don't see why the core
> > code should handle that isolated typo.
> 
> OK thanks for confirming. Will apply this into omap-for-v4.1/fixes.

Thanks!
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
