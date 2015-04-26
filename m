From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in 4.1-rc0
Date: Sun, 26 Apr 2015 12:20:46 +0200
Message-ID: <20150426102046.GA4340@amd>
References: <20150416093234.GA17423@amd>
 <CANMBJr5G2RpS1sw3N8FYitqzqFu8a2Gqj__i_742FZrMYuusOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMBJr5G2RpS1sw3N8FYitqzqFu8a2Gqj__i_742FZrMYuusOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baker <tyler.baker@linaro.org>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, tony@atomide.com, Kevin's boot bot <khilman@kernel.org>, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

> > Just tried booting 4.1-rc0 on n900 (commit
> > 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085) and it is broken.
> >
> > Any ideas?
> 
> Looks like DT and legacy booting are working fine in our
> labs. [0][1]

Interesting web pages, thanks.

I noticed that legacy booting indicates broken today, but... Is there
list of your targets somewhere?

Best regards,
									Pavel



> [0] http://kernelci.org/boot/omap3-n900/
> [1] http://kernelci.org/boot/omap3-n900,legacy/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
