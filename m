From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Sun, 31 Jul 2011 00:09:53 +0200
Message-ID: <20110730220953.GB10450@elf.ucw.cz>
References: <201107302336.06428.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44059 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab1G3WJz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jul 2011 18:09:55 -0400
Content-Disposition: inline
In-Reply-To: <201107302336.06428.rjw@sisk.pl>
 <201107302305.00212.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Hi!

> > IIRC I solved it by just calling _PTS when sleepy Linux was
> > enabled. It had side effect of lighting up moon icon, but otherwise
> > seemed to work ok.
> > 
> > I do not think ACPI says what can and can not be done after _PTS...
> 
> Yes, it does.

I have 2.0 spec here; it explains how _PTS can be called long time
before actual sleep and may not power down devices...

> > It should be ok to execute _WAK in process context once system is
> > resumed. ... or maybe not executing _WAK at all. User can probably
> > live with moon icon lighted up.
> 
> But I don't think the user can live with certain functionality missing,
> like battery status or such things.

Yep; you'd probably want to execute it before calling other ACPI methods...

> This is completely unrealistic to think that your prototype can be safely
> implemented on _every_ ACPI-based system.  Period.

My prototype would probably not be safe on any system, period. It was
quick hack to prove the concept.

> And that's even without taking SMP into account, BTW.

Idea was to do hot CPU unplug before enabling sleepy state. Sleepy
probably should be enabled when screen is turned off by
screensaver (if machine is sufficiently idle).

I'm not saying that task is easy, merely that is doable. (Doing it in
clean way will be harder still). Basically prepare all the devices to
sleep when machine gets "idle enough", along with _PTS, but keep
running, including userspace. Then, if next wake up is "long enough"
into future, set up RTC alarm and push machine to sleep.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
