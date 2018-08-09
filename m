From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4: suspend to RAM?
Date: Thu, 9 Aug 2018 01:22:29 -0700
Message-ID: <20180809082229.GU99251@atomide.com>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
 <20180727113214.GA32069@amd>
 <20180808090512.GQ99251@atomide.com>
 <20180808213204.GD15831@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808213204.GD15831@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180808 21:35]:
> On Wed 2018-08-08 02:05:12, Tony Lindgren wrote:
> > Then for deeper idle modes, you need to also idle UARTs, and unbind or
> > unload USB related modules. You should get to something like 160mW
> > power consumption with mdm6600 enabled and SoC suspended that way.
> 
> That's slightly interesting. echo mem > /sys/power/state should do all
> the work, right? Disable UARTs etc. Plus, is 160mW still a bit high?

Yes suspend will do it, you still need to configure wake-up events
though at least for the UARTs. I think I got enabled mdm6600 to low-power
state after connecting over UART ts27010 and then suspending OHCI:

        ohci=$(find /sys/bus/platform/devices -name \*.ohci)
        devices=$(find ${ohci}/ -type d -name control)
        for device in ${devices}; do
                echo -n "auto" > ${device}/level
                echo -n "control" > ${device}/level
        done

        echo "usb-phy@1" > /sys/bus/platform/drivers/phy-mapphone-mdm6600/unbind

For power consumption, 160mW is high yeah. We currently cannot hit core
retention on omap4 until some GPIO issues are fixed. I've been trying to
think for a good fix for that, but need to debug it more when I get a chance.

>From few months ago, I recall I got droid4 to run at around 65mW idle
with WLAN connected and modem off with my test hacks. With modem on
and USB suspended I think I got to around 100mW.

Then I recall measuring droid4 with stock android in flight mode
measuring at around 15 - 30mW. But that requires off mode to work on
omap4, maybe we'll get to that too at some point after core retention.

Regards,

Tony
