From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 20 Jul 2015 15:48:14 -0500
Message-ID: <20150720204814.GB11931@deathstar>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150714163342.GA8512@deathray>
 <20150714200125.GA26147@amd>
 <20150714201722.GA31356@deathray>
 <20150715194932.GA10967@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715194932.GA10967@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 15, 2015 at 09:49:33PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Ok, so:
> > > 
> > > 4.2-rc1 worked for me, IIRC.
> > 
> > This does not make sense.
> > 
> > Nothing has changed in drivers/spi between these versions.
> > Are you sure that 4.2-rc1 worked for you?
> 
> Tested again: yes, I have 4.2-rc1 booted on the device... based on
> Linus' 1c4c7159ed2468f3ac4ce5a7f08d79663d381a93 . I can push the
> configs and trees to some public place.
> 
> > > 4.2-rc2 oopses a lot.
> > > 
> > > 4.2-rc2+ this patch oopses, too. I don't have serial console, so it is
> > > hard to tell if it is the same oops.
> 
> But... I'm not sure I'm getting the same oops.
> 								Pavel

Any progress as to what is causing the oops for you starting at 4.2-rc2?

> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
