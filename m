From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Fri, 29 Jul 2011 15:41:05 +0200
Message-ID: <20110729134015.GA1561@ucw.cz>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
 <20110711112619.GH5092@opensource.wolfsonmicro.com>
 <alpine.DEB.2.00.1107130105530.30229@utopia.booyaka.com>
 <201107131104.06995.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53576 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab1G2NlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 09:41:15 -0400
Content-Disposition: inline
In-Reply-To: <201107131104.06995.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Hi!

> > > Actually, it just occurred to me that if we're waiting for a system
> > > timer and can hand that off to a suitable timer in the PMIC then we can
> > > do a suspend to RAM for the deep idle state from the hardware point of
> > > view.
> > 
> > Yep.  At LinuxCon Cambridge two years ago, we had a discussion about 
> > whether it would be possible to enter ACPI S-states from CPUIdle (or some 
> > idle governor) on Intel chips.  If I remember correctly, the conclusion 
> > was that ACPI always disables the screen/backlight, so it would only be 
> > useful for situations where that was acceptable.

Well, auto suspending when screensaver is active would still be
useful.

(And IIRC some machines kept screen on when in S-state unless driver
powered it down... but that might be S1.

> The reason why you can't enter ACPI S-states from CPUidle is because you
> need to go out of the idle loop to execute some ACPI-specific stuff.  Which
> is not even specific to Intel chips, but to ACPI in general.

The code was little tricky/unclean, but it "worked" for me at one
point... I called it  "sleepy linux".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
