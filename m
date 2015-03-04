From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/15] twl4030_charger: enable manual enable/disable of
 usb charging.
Date: Wed, 4 Mar 2015 11:19:41 +0100
Message-ID: <20150304101941.GB30887@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.543.stgit@notabene.brown>
 <20150302210342.GD13270@amd>
 <20150304171509.2516f1ba@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304171509.2516f1ba@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed 2015-03-04 17:15:09, NeilBrown wrote:
> On Mon, 2 Mar 2015 22:03:42 +0100 Pavel Machek <pavel@ucw.cz> wrote:
> 
> > On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> > > 'off' or 'auto' to
> > > 
> > >  /sys/class/power/twl4030_usb/mode
> > > 
> > > will now enable or disable charging from USB port.  Normally this is
> > > enabled on 'plug' and disabled on 'unplug'.
> > > Unplug will still disable charging.  'plug' will only enable it if
> > > 'auto' if selected.
> > 
> > This should go to Documentation/
> 
> You mean in Documentation/ABI/stable I guess??

Yes.

> That strikes me as a failed experiment - there is hardly anything there.
> 
> I'd be very happy to put the documentation with the code if there was some
> mechanism to automatically extract it.  But I really see little value in
> Documentation/ABI.

It was useful in past, and rules say it is required. Feel free to talk
to greg about better place, but this is the place we have now and
documentation is useful. And since you already document it in the
changelogs... it should not be that much work.

> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Thanks a lot!

You are welcome :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
