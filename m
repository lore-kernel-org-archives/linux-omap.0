From: Pavel Machek <pavel@ucw.cz>
Subject: Mainline kernel really hates bateries in N900
Date: Mon, 8 Dec 2014 21:56:30 +0100
Message-ID: <20141208205630.GA28391@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg
List-Id: linux-omap@vger.kernel.org

Hi!

So... I thought leaving N900 with mainline kernel on USB connection
was bad... (end result was battery at 2.97V). Well... now I left the
machine idle without the charger ... and result was 2.85V on battery.

Li-ion batteries should not be discharged below 3.4V. As may batteries
are already reported as 5mAh total capacity from time to time, I'll
just have to get new ones... but perhaps you should not repeat those
experiments.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
