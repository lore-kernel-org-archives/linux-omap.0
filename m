From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Mon, 1 Jun 2015 11:54:36 +0200
Message-ID: <20150601095435.GA21417@amd>
References: <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529200306.GB17267@lukather>
 <20150530101430.GA505@amd>
 <20150601094919.GG17267@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54744 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbbFAJyj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 05:54:39 -0400
Content-Disposition: inline
In-Reply-To: <20150601094919.GG17267@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

On Mon 2015-06-01 11:49:19, Maxime Ripard wrote:
> On Sat, May 30, 2015 at 12:14:30PM +0200, Pavel Machek wrote:
> > Well... the driver was not broken... before you did "cleanup" that did
> > two functional changes. And yes, the dts should be fixed, but that
> > does not make your "cleanup" good.
> 
> Whether it's good or not is arguable, and it really boils down to what
> we consider the default value when properties are missing.
> 
> If it's 0, then my code does the right thing. If it's undefined, well,
> I'd expect undefined behaviour to change without any notice.

It is "whatever was in the structure in the first place", as it was
before you patched the code.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
