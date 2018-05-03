From: Tony Lindgren <tony@atomide.com>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Thu, 3 May 2018 07:22:40 -0700
Message-ID: <20180503142240.GQ98604@atomide.com>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
 <20180503090611.GA14451@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503090611.GA14451@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180503 09:08]:
> I'd like current_avg more, but if I cat it manually, it changes on
> order of seconds, and quite significantly... which suggest shorter
> polling interval would be needed.
> 
> user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> current_avg
> Thu May  3 09:33:05 CEST 2018
> -71000
> -218408
> user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> current_avg
> Thu May  3 09:33:06 CEST 2018
> -61000
> -200238
> user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> current_avg
> Thu May  3 09:33:06 CEST 2018
> -51000
> -209879
> user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> current_avg
> Thu May  3 09:33:07 CEST 2018
> -56000
> -72308
> user@devuan:/sys/class/power_supply/battery$ date; cat current_now
> current_avg
> Thu May  3 09:33:08 CEST 2018
> -37000
> -211362

I recall it just being calculated based on the time between
the reads. Hard to say what it does, -ENODOCS.. Maybe the mc13783
PMIC docs have something similar.

> > Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> > by your libbattery and it's low value and high value should be saved
> > to a file. Low should be saved when we get the battery low interrupt
> > and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> > High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
> > 
> > Then when you know the high value and low value, you can calculate
> > the remaining capacity based on the current value and
> > POWER_SUPPLY_POWER_AVG.
> 
> I'll look into that... but probably will do experiments with python,
> first.

Sure. The reason why I think we should not do it in the kernel in
addition to the earlier reasoning is that we don't have a place
to store the min and max values across reboot. I think there's
some flash on the battery over 1w bus, but it probably just
contains battery serial number or something and is not intended
for writing much to it. I guess the min and max values should be
really keyd based on this battery id in case the battery gets
changed.

Regards,

Tony
