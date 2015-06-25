From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
Date: Thu, 25 Jun 2015 22:25:41 +0200
Message-ID: <20150625202541.GA12659@amd>
References: <20150601095556.GH17267@lukather>
 <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
 <20150601152111.GA14015@amd>
 <20150601174730.GA30024@dtor-ws>
 <20150601212226.GH23777@lukather>
 <20150601213213.GB14395@dtor-ws>
 <20150602094447.GW23777@lukather>
 <20150602175845.GB11297@dtor-ws>
 <20150602180855.GC11297@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602180855.GC11297@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

> By the way, the previous version was busted, this one should compile.

> Input: improve parsing OF parameters for touchscreens
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> When applying touchscreen parameters specified in device tree let's
> make
> sure we keep whatever setup was done by the driver and not reset the
> missing values to zero.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
