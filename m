From: Pavel Machek <pavel@ucw.cz>
Subject: 4.5-rc0 regression: GPRS breaks after very short while
Date: Wed, 18 May 2016 09:49:24 +0200
Message-ID: <20160518074924.GA20652@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

I was afraid another GSM chip desoldered itself in N900, but no, it
seems to be software this time.

In 4.4, GPRS is rock solid, can survive overnight ping.

In 4.5-rc0 and v4.6, modem fails when I use gprs for like a
minute. Phone is not usable.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
