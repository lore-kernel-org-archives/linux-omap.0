From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] phy: twl4030-usb: add support for reading resistor
 on ID pin.
Date: Sat, 6 Jun 2015 15:10:09 +0200
Message-ID: <20150606131009.GD1329@xo-6d-61-c0.localdomain>
References: <20150416075945.23307.24424.stgit@notabene.brown>
 <20150416080304.23307.41913.stgit@notabene.brown>
 <556C5FF4.3050603@ti.com>
 <20150602073731.26edbd3b@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602073731.26edbd3b@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-06-02 07:37:31, NeilBrown wrote:
> On Mon, 1 Jun 2015 19:06:52 +0530 Kishon Vijay Abraham I <kishon@ti.com>
> wrote:
> 
> > Hi,
> > 
> > On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
> > > From: NeilBrown <neilb@suse.de>
> > >
> > > The twl4030 phy can measure, with low precision, the
> > > resistance-to-ground of the ID pin.
> > >
> > > Add a function to read the value, and export the result
> > > via sysfs.
> > 
> > Little sceptical about adding new sysfs entries. Do you have a good reason to 
> > add this?
> 
> The hardware can report the value, so why not present it to user-space?
> 
> I originally used this with a udev rule which would configure the maximum
> current based on the resistance measure - to work with the particular charger
> hardware I have.
> 
> More recent patches try to do all of the max-current configuration in the
> kernel, so I could live without exporting the value via sysfs if that is a
> show-stopper.
> 
> I can't see where the scepticism comes from though.  It is a well defined
> and cleary documented feature of the hardware.  Why not expose it?

sysfs interface is supposed to work for different chargers, without userspace
noticing.

Are these values the ones that are likely to be useful there?

> > > +	Possible values are:
> > > +		ground
> > > +		102k
> > > +		200k
> > > +		440k
> > > +		floating
> > > +		unknown

...or would it make more sense to export for example numerical ohms, as that's
what are other chargers likely to provide?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
