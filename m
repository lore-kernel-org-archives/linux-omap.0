From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] usb: phy: twl4030: add support for reading restore
 on ID pin.
Date: Wed, 4 Mar 2015 11:17:38 +0100
Message-ID: <20150304101737.GA30887@amd>
References: <20150224033730.31400.78200.stgit@notabene.brown>
 <20150224034037.31400.52748.stgit@notabene.brown>
 <20150302210431.GH13270@amd>
 <20150304173551.7cb93917@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304173551.7cb93917@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> > New /sys files should be documented somewhere...?
> 
> Preferably with the code...
> 
> > Does it make sense to change "440k" -> "440KOhm"?
> 
> Interesting question.  I prefer to avoid including units in files - bare
> numbers is better.  But there is no number to match "floating" unless I spell
> it out as "infinity", and wouldn't be helpful.
> 
> Certainly "K" would be preferred over "k", and given that I have "ground"
> and  "floating", it is more consistent to include the "Ohm"....
> 
> These are really names, not measures of resistance.  The data sheet calls
> them:
>  ID_RES_FLOAT  (or sometimes ID_FLOAT)
>  ID_RES_440K
>  ID_RES_200K
>  ID_RES_102K
>  ID_GND        (or sometimes ID_RES_GND)
> 
> So using those names is defensible.
> 
> I think I'll change them all to upper case, but leave out the "Ohm".
> My justification is consistency with the data sheet.

Does it make sense to use "_ohm" in the attribute name, then? (And
yes, I was wrong with the "K", "k" is actually right.)

> > Plus I guess you need to update Documentation/
> 
> I guess I'll need to give in to this eventually :-)

Yes please. It was useful in past.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
