From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sun, 18 Jan 2015 22:02:17 +0100
Message-ID: <20150118210217.GB31807@amd>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel>
 <20150113204219.GJ2419@atomide.com>
 <201501132150.56938@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38347 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbARVCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 16:02:18 -0500
Content-Disposition: inline
In-Reply-To: <201501132150.56938@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>


> CCing Pavel Machek
> 
> He reported also some (still not fixed) regressions on n900.

adp1653 flash driver does not have device tree bindings, yet. Patches
were submitted, but I guess I'll need to push them some more.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
