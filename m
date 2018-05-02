From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Wed, 2 May 2018 21:10:49 +0200
Message-ID: <20180502191049.ximiyccwfkjqcj7m@devuan>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502144158.GJ98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > Anyway, >5.5hours of standby with screen off, GSM on is already
> > usable.
> 
> Just to rub that in, you do mean GSM usable for voice calls and
> SMS with your unicsy_demo with mainline kernel plus the pending
> LCD related patches, right? :)

Plus some other patches, yes.

> > This is the core of code I'm using.
> > 
> > https://github.com/pavelmachek/unicsy_demo
> > 
> > Battery graphs are attached. I'm not sure if the battery was really
> > close to empty at that point -- voltage curve should have different
> > shape if that was the case. 
> 
> Cool. BTW, the value for POWER_SUPPLY_POWER_AVG should be quite
> accurate for the whole device power consumption.

Aha, I was looking in the wrong directory. Yes, these look useful.

> It comes from the shunt resistor measured by the PMIC. Sorry I don't
> remember how often it needs to be polled but I'm guessing polling it
> once a minute or so should be plenty.

Ok. I normally do once in 30 seconds.

> Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> by your libbattery and it's low value and high value should be saved
> to a file. Low should be saved when we get the battery low interrupt
> and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
> 
> Then when you know the high value and low value, you can calculate
> the remaining capacity based on the current value and
> POWER_SUPPLY_POWER_AVG.

Ok, more stuff on TODO list. I actually use python hacks, and not
libbattery now.

Is this one correct?

voltage_min_design:3100000

I believe you mentioned flash stops working at 3.3V. What is important
from my point of view is to shut the system down when the battery is
low. I believe that still needs to be implemented.

Is it appropriate to shutdown at POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL?
But then libbattery will race with shutdown to save the thresholds...

I also have some hacks to allow configuration of the full
voltage. Charging to 4.35V is pretty agressive, and I believe baterry
will be damaged less if we only charge to 4.1V.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
