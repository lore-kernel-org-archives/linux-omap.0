From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sat, 30 Jul 2011 22:37:37 +0200
Message-ID: <20110730203737.GA8762@elf.ucw.cz>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
 <201107131104.06995.rjw@sisk.pl>
 <20110729134015.GA1561@ucw.cz>
 <201107292152.27066.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49743 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab1G3Uhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jul 2011 16:37:40 -0400
Content-Disposition: inline
In-Reply-To: <201107292152.27066.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Hi!

> > Well, auto suspending when screensaver is active would still be
> > useful.
> > 
> > (And IIRC some machines kept screen on when in S-state unless driver
> > powered it down... but that might be S1.
> > 
> > > The reason why you can't enter ACPI S-states from CPUidle is because you
> > > need to go out of the idle loop to execute some ACPI-specific stuff.  Which
> > > is not even specific to Intel chips, but to ACPI in general.
> > 
> > The code was little tricky/unclean, but it "worked" for me at one
> > point... I called it  "sleepy linux".
> 
> Yes, you can find a system where it might kind of work (just because
> _PTS is empty or something like this).  Is it going to work in general?
> No way.

IIRC I solved it by just calling _PTS when sleepy Linux was
enabled. It had side effect of lighting up moon icon, but otherwise
seemed to work ok.

I do not think ACPI says what can and can not be done after _PTS...


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
