From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Gta04-owner] [PATCH 10/13] twl4030_charger: add software
 controlled linear charging mode.
Date: Sat, 14 Nov 2015 19:12:16 +0100
Message-ID: <20151114181216.GB20429@amd>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.27784.stgit@noble>
 <20150915112825.GA10704@amd>
 <87bncjjesu.fsf@notabene.neil.brown.name>
 <20151006143407.GA24518@xo-6d-61-c0.localdomain>
 <20151029172041.2a9cd266@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151029172041.2a9cd266@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, Neil Brown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> > > Pavel Machek <pavel@ucw.cz> writes:
> > > > On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> > > >> 
> > > >> Add a 'continuous' option for usb charging which enables
> > > >> the "linear" charging mode of the twl4030.
> > > >> 
> > > >> Linear charging does a good job with not-so-reliable power sources.
> > > >> Auto mode does not work well as it switches off when voltage drops
> > > >> momentarily.  Care must be taken not to over-charge.
> > > >
> > > > Can you explain how the user can "care not to over-charge"?
> > > 
> > > The following text reads:
> > > 
> > >     It was used with a bike hub dynamo since a year or so. In that case
> > >     there are automatically charging stops when the cyclist needs a break.
> > > 
> > > so: take a break from cycling occasionally.
> > 
> > If the charger does not exceed 4.2V, I'd not call it overcharge. (Yes, some clever
> > chargers actually let the battery drop below 4.2V when charge is done, but...)
> > 
> Yes, that is the case. Perhaps it is not to be called overcharge but
> it is said that lithium battery charging has to stop if in CV mode the
> current drops too low.  In automatic mode the charger does exactly
> that.
> I would not let a battery for days at 4.2V CV.mode although a lot
> of cheap chargers

Well, I agree that keeping battery at 4.2V constant voltage mode is
bad, but I'd not call it overcharge. If someone can fix the comment,
that would be nice.

> > If the charger _does_ exceed 4.2V, then the battery will explode. Don't do that. Don't
> > offer that to the user.
> > 
> > On a related note... I've just killed USB charger by overloading it. They are not protected.
> > 
> > I believe your automatically-pull-max-power really should stick to the well-known charging
> > currents (.5A, 1A, 1.7A), at the very minimum.
> > 
> The main reason for the patch was to prevent switching off charging
> when Vbus drops low. The reason was not to get out extremely much
> current out of the charger.
> The electrical characteristics of a  bicycle as a power source are.
> - the amount of current available changes
>    - 500mA at around 17km/h
> - you cannot destroy it by electrically overloading
> 
> If the current is set to e.g. 500mA and that linear charging mode is
> enabled, the battery gets the maximum current available (upto
> 500mA) regardless of the speed which is often changing.

Yes... I guess that makes sense for you, but I wonder if we should be
doing this by default. It seems a lot of cheap chargers can be easily
destroyed if you overload them.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
