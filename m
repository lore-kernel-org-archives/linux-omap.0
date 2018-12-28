From: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Fri, 28 Dec 2018 15:34:17 -0800
Message-ID: <20181228233417.GD6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
 <20181228232536.GA7355@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228232536.GA7355@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181228 23:25]:
> So this would be "text mode": AT+CMGF=1. And I'd actually expect
> auto-ack to be the default on ttyUSB4, but in any case this is the
> command that controls it is: AT+CNMI=1,2,2,1,0.

OK thanks. These are not available for /dev/motmdm* files AFAIK.

> So... 57h would be very nice, and even 25h is cool. IIRC original
> motorola firmware does something like 100hours, and cyanogenmod is
> closer to 24h...

Well I got things down to about 55mW during idle but that still needs
more work. So that would be in theory idle battery life of:

(1735mWh * 3.8V) / 55mW = 119.87h (4.99d)

> Note that there's something in the sysfs that allows "precise"
> measurements. Aha, it is "charge_counter" on droid4.
> 
> (I even have some software to do the monitoring and display the
> graphs. unicsy_demo/monitor/batmond).

Oh nice, I'll give that a try.

Regards,

Tony
