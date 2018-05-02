From: Tony Lindgren <tony@atomide.com>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Wed, 2 May 2018 07:41:58 -0700
Message-ID: <20180502144158.GJ98604@atomide.com>
References: <20180501183148.GA26996@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180501183148.GA26996@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180501 18:33]:
> Hi!
> 
> 4.17-rc1 is quite usable on droid 4; basically everything
> works. OHCI is running all the time, which means we burn a lot of
> power needlessly.

To work around that we can use n_gsm and and then suspend USB
device. That will need the modem wake gpio working that I'll
be sending patches for at some point.

And we should make cdc_wdm, qcaux and ohci support runtime PM
for autosuspend at some point. For *hci, we can make it work
along what Roger did in his earlier series here except by using
Linux generic wakeirq support:

https://lkml.org/lkml/2013/7/10/355

> Anyway, >5.5hours of standby with screen off, GSM on is already
> usable.

Just to rub that in, you do mean GSM usable for voice calls and
SMS with your unicsy_demo with mainline kernel plus the pending
LCD related patches, right? :)

> This is the core of code I'm using.
> 
> https://github.com/pavelmachek/unicsy_demo
> 
> Battery graphs are attached. I'm not sure if the battery was really
> close to empty at that point -- voltage curve should have different
> shape if that was the case. 

Cool. BTW, the value for POWER_SUPPLY_POWER_AVG should be quite
accurate for the whole device power consumption.

It comes from the shunt resistor measured by the PMIC. Sorry I don't
remember how often it needs to be polled but I'm guessing polling it
once a minute or so should be plenty.

Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
by your libbattery and it's low value and high value should be saved
to a file. Low should be saved when we get the battery low interrupt
and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.

Then when you know the high value and low value, you can calculate
the remaining capacity based on the current value and
POWER_SUPPLY_POWER_AVG.

Regards,

Tony
