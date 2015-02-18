From: Pavel Machek <pavel@ucw.cz>
Subject: testing script for n900
Date: Wed, 18 Feb 2015 11:51:36 +0100
Message-ID: <20150218105135.GA20760@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

When you are drowning in regressions

..then the first step is to stop more regressions. That's the
situation with Nokia N900 kernel now: it has a lot of hardware, and
there's kernel support for most of that, but userland support really
is not mature enough. So I added test script to tui/ofone, which
allows testing of battery, audio, LEDs, backlight, GPS, bluetooth and
more. It is called "tefone". "ofone" script (with gtk gui) can be used
to control modem, place calls and read SMSes. You'll need a library to
actually get voice calls with audio.

More at http://pavelmachek.livejournal.com/127317.html .

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
