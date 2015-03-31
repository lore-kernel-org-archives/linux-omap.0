From: Pavel Machek <pavel@ucw.cz>
Subject: 4.0-rc1 to -rc4: random sound and speed problems on n900
Date: Tue, 31 Mar 2015 09:26:20 +0200
Message-ID: <20150331072620.GA30788@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

4.0-rc4 (or more specifically 7b09ac704bac2de5bf0362793edc22a0094e381c
based kernel boots really really slowly on n900, and there's an ugly
backtrace from sound in the dmesg.

I re-tested 4.0-rc4 and it worked ok. Weird. I guess we have some
random stuff going on during boot....

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
