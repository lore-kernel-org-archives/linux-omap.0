From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 22:34:56 +0200
Message-ID: <20150529203456.GC22083@amd>
References: <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150529202954.GA26494@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > > single DT, you don't even use that property in your driver, and now
> > > that you realise you meant something else, you want the code that
> > 
> > not Pali, Sebastian.
> > 
> > > actually parse the *right* property and does the right thing, that all
> > > other DT agree (and depend on) to be reverted?
> > 
> > We shouldn't revert, that I agree. But both properties should be parsed.
> 
> No. If the property is wrong, and nobody parsed it, I do not see any reason to
> start now.

Agreed.

But that's not what I'm asking. See a changelog of
3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
actually does.

It is buggy. If fuzz is specified but maximum is not, it overwites
maximum with zero.

Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".

Plus it fails to distinguish between "value not specified in the dt"
and "zero is specified in the dt".

The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
