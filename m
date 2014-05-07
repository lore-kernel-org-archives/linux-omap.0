From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [jenny.tc@intel.com: [RFC] power_supply: Introduce generic psy
 charging driver]
Date: Wed, 7 May 2014 15:23:47 +0200
Message-ID: <20140507132347.GA21687@amd.pavel.ucw.cz>
References: <20140429062526.GA12879@jenny-desktop>
 <20140505124745.GC16461@amd.pavel.ucw.cz>
 <20140507084655.GA25243@jenny-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140507084655.GA25243@jenny-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny Tc <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, cbouatmailru@gmail.com, anton.vorontsov@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > > +#define PSY_MAX_CV(psy) \
> > > +		psy_get_ps_int_property(psy,\
> > > +			POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX)
> > > +#define PSY_VOLTAGE_NOW(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW)
> > > +#define PSY_VOLTAGE_OCV(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_VOLTAGE_OCV)
> > > +#define PSY_CURRENT_NOW(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW)
> > > +#define PSY_STATUS(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_STATUS)
> > > +#define PSY_TEMPERATURE(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_TEMP)
> > > +#define PSY_BATTERY_TYPE(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_TECHNOLOGY)
> > > +#define PSY_ONLINE(psy) \
> > > +		psy_get_ps_int_property(psy, POWER_SUPPLY_PROP_ONLINE)
> > 
> > This looks like bad idea. Just opencode it.
> 
> This was to make it more readable, and avoids open codes in multiple places.
> Initially Anton had positive thoughts about this. Isn't it more readable with
> the macros?

Well... I'd expect PSY_ONLINE() macro to do something like (psy &
0x01), not call function. Yes, it is shorter, but IMO it is not
clearer.

But if Anton likes it...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
