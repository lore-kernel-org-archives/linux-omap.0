From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 21 Jul 2015 09:31:27 +0200
Message-ID: <20150721073127.GA13216@amd>
References: <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150714163342.GA8512@deathray>
 <20150714200125.GA26147@amd>
 <20150714201722.GA31356@deathray>
 <20150715194932.GA10967@amd>
 <20150715201048.GA23569@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715201048.GA23569@deathray>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed 2015-07-15 15:10:48, Michael Welling wrote:
> On Wed, Jul 15, 2015 at 09:49:33PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > Ok, so:
> > > > 
> > > > 4.2-rc1 worked for me, IIRC.
> > > 
> > > This does not make sense.
> > > 
> > > Nothing has changed in drivers/spi between these versions.
> > > Are you sure that 4.2-rc1 worked for you?
> > 
> > Tested again: yes, I have 4.2-rc1 booted on the device... based on
> > Linus' 1c4c7159ed2468f3ac4ce5a7f08d79663d381a93 . I can push the
> > configs and trees to some public place.
> > 
> 
> Interesting. Something very strange is happening here.
> Send me the links if you push your tree/config to a public repo. 

Pushing now. It is on
kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900 mini-v4.2

f1376b91c1c765cf041235c14ac44c04d56fd2a9 is broken

cb8b6850aa49f72f226629796e349dd75d3f4f78 mostly works. (My notes say
that GSM is broken, but they may be not enough patches applied.) I
believe I even run the "tefone" testsuite, with only s2ram acting
funny.

https://gitlab.com/tui/tui/tree/master/ofone

> I would not hurt to have the same from Pali for comparison.
> 
> > > > 4.2-rc2 oopses a lot.
> > > > 
> > > > 4.2-rc2+ this patch oopses, too. I don't have serial console, so it is
> > > > hard to tell if it is the same oops.
> > 
> > But... I'm not sure I'm getting the same oops.
> 
> If the system is still booting, you could tell if the oopses were the
> same if your touchscreen and wifi do no work.

I'm pretty sure they worked. I'd notice broken touchscreen.

(Sorry, I'm a bit busy at the moment).

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
