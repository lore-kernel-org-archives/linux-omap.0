From: Pavel Machek <pavel@ucw.cz>
Subject: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it breaks
 touchscreen on n900.
Date: Mon, 1 Jun 2015 16:06:06 +0200
Message-ID: <20150601140605.GA26908@amd>
References: <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60302 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbFAOGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 10:06:08 -0400
Content-Disposition: inline
In-Reply-To: <20150601095556.GH17267@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

Hi!

> > But that's not what I'm asking. See a changelog of
> > 3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
> > actually does.
> > 
> > It is buggy. If fuzz is specified but maximum is not, it overwites
> > maximum with zero.
> 
> If maximum is not set, you'll have other issues anyway. But it really
> boils down on what the default behaviour should be.

It was not broken before commit
3eea8b5d68c801fec788b411582b803463834752. Maximum was set, but after
your patch, it is overwritten with zero.

> > Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".
> 
> It's not a new failure, it's testing against stupid code.

Yes. In a commit marked "cleanup". We call this "undocumented
feature".

> If an axis is setup in the DT but not registered in the driver,
> something is wrong, most probably the DT.

Yes, we have fixed the DT, so that bug you introduced will not happen
on n900 with updated device tree.

> > Plus it fails to distinguish between "value not specified in the dt"
> > and "zero is specified in the dt".
> 
> Again, default behaviour.

Again, regression from 4.0 kernel, you are not willing to fix.

> > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> 
> You were very welcome to review this patch at the time and/or suggest
> a fix that pleases everyone.

You should be the one that should suggest fixes, as you broke it in
the first place. But clearly you don't understand that.

Dmitry, please revert 3eea8b5d68c801fec788b411582b803463834752
. You'll probably need to revert
0a363a380954e10fece7cd9931b66056eeb07d56 too. Then, Maxime can submit
his multitouch patches in a way it does not break existing setups.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
