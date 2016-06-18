From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 00/19] Runtime PM fixes for omap-ssi
Date: Sun, 19 Jun 2016 00:00:22 +0200
Message-ID: <20160618220022.GA1309@amd>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
 <20160618185438.GA8866@amd>
 <20160618202059.GA5510@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160618202059.GA5510@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> > > (*) "ifconfig phonet0 up" will result in blocking ssi module
> > >     until modem setup has finished (data communication via
> > > 	phonet0 device), since it enables ssi wakelines.
> > > 
> > > [0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=runtime-pm-fixes
> > 
> > I tried applying it over v4.7-rc, but [...]
> > What tree should I try it against?
> 
> The patchset is based on hsi's for-next branch available here:
> 
> > > https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=for-next

Aha, ok, thanks. I have some fun with wlan, but machine now goes to
sleep.

Thanks!

Tested-by: Pavel Machek <pavel@ucw.cz>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
