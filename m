From: Tony Lindgren <tony@atomide.com>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Fri, 4 May 2018 13:38:19 -0700
Message-ID: <20180504203819.GF98604@atomide.com>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
 <20180503090611.GA14451@amd>
 <20180503142240.GQ98604@atomide.com>
 <20180504202044.GC22519@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504202044.GC22519@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180504 20:22]:
> Hi!
> 
> > > user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> > > current_avg
> > > Thu May  3 09:33:07 CEST 2018
> > > -56000
> > > -72308
> > > user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> > > current_avg
> > > Thu May  3 09:33:08 CEST 2018
> > > -37000
> > > -211362
> > 
> > I recall it just being calculated based on the time between
> > the reads. Hard to say what it does, -ENODOCS.. Maybe the mc13783
> > PMIC docs have something similar.
> 
> Hmm. current_avg is world readable; if it does changes to the
> hardware, that's somehow bad.

No it just calls cpcap_battery_cc_get_avg_current() that calculates
the average from last time it got sampled based on number of samples
collected between the two reads. Seems to match what I see on my
power supply here.

> But I guess I can sample charge_counter every minute or so and get
> what I need?

Not sure what the max time range is for the PMIC, but yeah I'd
assume once a minute is duoable. Maybe compare it to the chart
you already have?

> > > > Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> > > > by your libbattery and it's low value and high value should be saved
> > > > to a file. Low should be saved when we get the battery low interrupt
> > > > and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> > > > High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
> > > > 
> > > > Then when you know the high value and low value, you can calculate
> > > > the remaining capacity based on the current value and
> > > > POWER_SUPPLY_POWER_AVG.
> > > 
> > > I'll look into that... but probably will do experiments with python,
> > > first.
> > 
> > Sure. The reason why I think we should not do it in the kernel in
> > addition to the earlier reasoning is that we don't have a place
> > to store the min and max values across reboot. I think there's
> > some flash on the battery over 1w bus, but it probably just
> > contains battery serial number or something and is not intended
> > for writing much to it. I guess the min and max values should be
> > really keyd based on this battery id in case the battery gets
> > changed.
> 
> I agree this should not be done in kernel as it requires persistent
> storage.
> 
> Battery is not user-replacable (and this will recalibrate itself on
> charge/discharge cycle) so.. I don't think keying is strictly
> neccessary for D4.

Yeah right, that can be added later on if needed if you just
plan accordingly. It's replaceable with a T5 after you peel off the
sticker from the corners :)

Regards,

Tony
