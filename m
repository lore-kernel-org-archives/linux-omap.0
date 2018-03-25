From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Sun, 25 Mar 2018 08:45:12 -0700
Message-ID: <20180325154512.GC5700@atomide.com>
References: <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180324200224.GA17857@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180324 20:03]:
> On Sat 2018-03-24 07:25:17, Tony Lindgren wrote:
> > * Dan Williams <dcbw@redhat.com> [180324 14:00]:
> > > On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> > > > Does ofonod work for you? I could not get that one to work...
> > > 
> > > Because it's looking for a Gobi modem but the MDM6600 isn't one and
> > > doesn't expose that layout (and doesn't really need to anyway).  I
> > > don't think ofono has a generic QMI driver, so you'd either need to for
> > > ce it to use the telitqmi or quectelqmi drivers, or write your own
> > > generic QMI one.
> > 
> > We also get five USB uarts if we add the device id with something
> > like the patch below. I don't quite get why we get five UARTS?
> 
> Not sure, either. Often more than one uart is useful, you get AT
> commands on one, while GPRS data flow on some other. 
> 
> > Also not sure if we should be using drivers/usb/serial/qcaux.c
> > instead of qcserial.c?
> > 
> > And from what I recall trying it out, adding the USB UARTs
> > somehow confused ModemManager I think, that needs to be retested
> > though :)
> > 
> > And the USB UARTs added do not offer the same set of AT commands
> > as the n_gsm serial mux.
> 
> Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> to react to AT commands, and in particular reacts to ADT123; (; is
> important).

Is that to dial a voice call?

> AT+CMGF=1
> AT+CMGS="123"
> foo^Z
> 
> Works for SMS sending. Good.

So what do you use for reading notifying and reading sms?

> Now, if someone knows what needs to be done to get GSM audio working,
> let me know. That's something I'd really like.

I think it's the cpcap based config to route voice call audio
to SoC, Sebastian knows the details :)

The way to figure that one out is to dump the cpcap registers
before and during voice call on android with cpcaprw, then
diff the output for the audio registers. Probably some SoC
registers need to be diffed too with rwmem or similar tool
for the mcbsp instance(s) used.

Regards,

Tony
