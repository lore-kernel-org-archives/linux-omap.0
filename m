From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n900 in 4.1-rc0
Date: Sun, 26 Apr 2015 12:15:24 +0200
Message-ID: <20150426101524.GA4088@amd>
References: <20150416093234.GA17423@amd>
 <552F82F0.3070709@arm.com>
 <20150416163553.GJ18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150416163553.GJ18048@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Thu 2015-04-16 09:35:54, Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [150416 02:38]:
> > On 16/04/15 10:32, Pavel Machek wrote:
> > > Hi!
> > > 
> > > Just tried booting 4.1-rc0 on n900 (commit
> > > 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085) and it is broken.
> > > 
> > > Any ideas?
> > 
> > To such a question, the only answer I have is "Yes".
> > 
> > For a more useful reply, I'm afraid you'll have to ask a better question.
> 
> Just tried it at 34c9a0ffc75ad25b6a60f61e27c4a4b1189b8085
> and it boots just fine on my n900.

Thanks for testing. I did some investigation, and found that twl4030
charger (that is not useful on n900) was breaking my boot. (And it may
be interaction with some of my local changes).

Best regards (and sorry for the noise),
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
