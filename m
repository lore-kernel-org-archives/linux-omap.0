From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900: u-SD card in v4.2+
Date: Wed, 6 Jan 2016 21:46:27 +0100
Message-ID: <20160106204627.GA21477@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

In v4.1, both internal MMC and u-SD cards work ok.

In v4.2, only the internal MMC is detected. In v4.3, not even internal
MMC works. In v4.4, only the internal MMC is detected.

Does it work for you? Any patches?

(I do have hack in the dts to disable back cover detection...)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
