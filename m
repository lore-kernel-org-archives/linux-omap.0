From: Tony Lindgren <tony@atomide.com>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Wed, 16 Jan 2019 07:09:56 -0800
Message-ID: <20190116150956.GN5544@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20190116135829.GA10426@amd>
 <20190116145904.GM5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116145904.GM5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190116 14:59]:
> * Pavel Machek <pavel@ucw.cz> [190116 13:58]:
> > And I wanted to ask -- did you figure out how to acknowledge the
> > SMSs? +CGNNA does not seem to do the job:
> > 
> > 07912470338016...
> > AT+CGNMA=1
> > +CGNMA:ERROR=9
> 
> Yeah the scripts in droid4-sms-tools git repo work for me for sending
> and receiving. They do not work with cdma currently as the format is
> different.
> 
> Maybe you've managed to change the mode of the modem to queue the
> messages with the at commands to the usb port?
> 
> You are reading and writing to /dev/motmdm9 for incoming sms right?

To debug, you can modprobe n_gsm debug=0xff and you'll see all the
packet data in dmesg, maybe email me the dmesg output of your ack
command packet data?

Or compare against what Android is doing, you can echo 0x7fffffff to
the ts27010 sysfs debug file somewhere to see similar packet data
with logcat -b radio.

Regards,

Tony
