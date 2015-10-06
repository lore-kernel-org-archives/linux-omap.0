From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] twl4030_charger: add software controlled linear
 charging mode.
Date: Tue, 6 Oct 2015 16:34:07 +0200
Message-ID: <20151006143407.GA24518@xo-6d-61-c0.localdomain>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.27784.stgit@noble>
 <20150915112825.GA10704@amd>
 <87bncjjesu.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87bncjjesu.fsf@notabene.neil.brown.name>
Sender: linux-pm-owner@vger.kernel.org
To: Neil Brown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> Pavel Machek <pavel@ucw.cz> writes:
> > On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> >> 
> >> Add a 'continuous' option for usb charging which enables
> >> the "linear" charging mode of the twl4030.
> >> 
> >> Linear charging does a good job with not-so-reliable power sources.
> >> Auto mode does not work well as it switches off when voltage drops
> >> momentarily.  Care must be taken not to over-charge.
> >
> > Can you explain how the user can "care not to over-charge"?
> 
> The following text reads:
> 
>     It was used with a bike hub dynamo since a year or so. In that case
>     there are automatically charging stops when the cyclist needs a break.
> 
> so: take a break from cycling occasionally.

If the charger does not exceed 4.2V, I'd not call it overcharge. (Yes, some clever
chargers actually let the battery drop below 4.2V when charge is done, but...)

If the charger _does_ exceed 4.2V, then the battery will explode. Don't do that. Don't
offer that to the user.

On a related note... I've just killed USB charger by overloading it. They are not protected.

I believe your automatically-pull-max-power really should stick to the well-known charging
currents (.5A, 1A, 1.7A), at the very minimum.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
