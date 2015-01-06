From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Tue, 6 Jan 2015 18:51:15 +0100
Message-ID: <20150106175115.GA19487@amd>
References: <20150106170433.GA5408@amd>
 <20150106172545.GK6502@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150106172545.GK6502@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org


On Tue 2015-01-06 11:25:45, Felipe Balbi wrote:
> On Tue, Jan 06, 2015 at 06:04:33PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > In 3.18, sound is nice and clear.
> > 
> > In 3.19, sound is unusable. It produces nasty tone when it should be
> > quiet, and there's at least as much noise as is sound.
> > 
> > Unfortunately, list of mixers also changed (and there's cca 120
> > settings), but a) it does not work with the old list and b) nothing I
> > could figure out did make the sound usable. Some setting resulted in
> > even more noise.
> > 
> > Any idea what could have caused it?
> 
> $ git bisect start
> $ git bisect good v3.18
> $ git bisect bad
> 
> that'll help find what caused it.

Telling someone to do hard and time consuming job that probably will
not succeed, instead of actually providing help. Very very funny.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
