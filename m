From: Pavel Machek <pavel@ucw.cz>
Subject: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
Date: Thu, 21 Jan 2016 19:42:34 +0100
Message-ID: <20160121184234.GA17679@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

In 4.4, n900 battery charging works. If indicator is turned off, it
stays off, and if I select 1.8A charge, it sticks. (There may be
problems after system suspend and resume. But normal operation seems
to be pretty reliable).

In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery charging
works for few hours. But then indicator (yellow light on 3color LED)
turns back on, and if I ask for 1.8A charge, it goes back to .1A,
discharging battery.

Any ideas?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
