From: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Mon, 31 Dec 2018 14:20:13 -0800
Message-ID: <20181231222013.GH6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228222805.GC6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [181228 22:28]:
> With droid4-pending-mdm-v4.20 branch in the following state:
> 
> - UARTs idled
> - LCD blanked (well no drivers yet droid4-sms-read.rb)
> - MUSB and EHCI USB modules unloaded
> - OHCI loaded with all the children in autosuspend via sysfs
> - WLAN connected
> - busybox acpid stopped (yup, it keeps polling something???)
> - MDM6600 online with AT+CFUN=1 on /dev/motmdm1
> - MDM6600 notifications disabled with AT+SCRN=0 on /motmdm1
> - droid4-sms-read.rb running

So I tracked down what I thought is a busybox acpid issue, I was
wrong. There's nothing wrong with busybox acpid, sorry for
blaming a wrong culprit.

We have acpid keep the device open for
/dev/input/by-path/platform-48072000.i2c-event open, which
seems to keep atmel_mxt_ts and i2c busy.

Things idle fine after I rmmod atmel_mxt_ts after blanking
the screen.

Regards,

Tony
