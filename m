From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 30 Jul 2011 23:25:23 +0200
Message-ID: <20110730212523.GA10450@elf.ucw.cz>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
 <20110730203737.GA8762@elf.ucw.cz>
 <201107302305.00212.rjw@sisk.pl>
 <201107302309.19169.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37177 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab1G3VZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jul 2011 17:25:25 -0400
Content-Disposition: inline
In-Reply-To: <201107302309.19169.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org


> > > IIRC I solved it by just calling _PTS when sleepy Linux was
> > > enabled. It had side effect of lighting up moon icon, but otherwise
> > > seemed to work ok.
> > > 
> > > I do not think ACPI says what can and can not be done after _PTS...
> > 
> > Yes, it does.
> 
> And even if _PTS will work, you're certainly not supposed to execute _WAK
> with interrupts off.

It should be ok to execute _WAK in process context once system is
resumed. ... or maybe not executing _WAK at all. User can probably
live with moon icon lighted up.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
