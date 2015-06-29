From: Pavel Machek <pavel@ucw.cz>
Subject: n900 in 4.2-rc0: repeating oopses
Date: Mon, 29 Jun 2015 11:11:46 +0200
Message-ID: <20150629091146.GA5103@amd>
References: <20150416093234.GA17423@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150416093234.GA17423@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

Just tried booting 4.2-rc0 on n900 (commit
4a10a91756ef381bced7b88cfb9232f660b92d93) and it is broken. Previous
-rc0 version worked. This time, there's some output on console, but
too fast for me to read.

It seems oopses happen before mounting root. If you have serial
console, they should be easy to see.

I tried booting same kernel in qemu, but it seems to work ok there.

Any ideas? Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
