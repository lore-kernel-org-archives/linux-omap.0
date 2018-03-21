From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.16-rc5 on Motorola Droid 4
Date: Wed, 21 Mar 2018 14:57:33 -0700
Message-ID: <20180321215733.GE5799@atomide.com>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
 <20180321203137.GA23637@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321203137.GA23637@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180321 20:32]:
> Hi!
> 
> > > Maybe get somebody to help you locally with the debug cable
> > > soldering? :)
> > 
> > I suppose people from your hackerspace can help you. It's really
> > easy to do. Soldering can be avoided btw. You can just use a pair
> > of scissors to cut a USB -> Micro USB cable and use a knife to remove
> > isolation. Then screw each of the 4 wires into a terminal strip.
> > There are USB-TTL adapters available, that have an attached cable.
> > If you also cut the connector from such a cable and connect it to
> > the other side of the terminal strip you are done. No soldering
> > involved ;)
> 
> Hm. How big no-no is connecting USB-TTL adapter to D+/D- pins? Because
> that's what I could do "easily" and seems to work ;-).

Well if the VBUS line is not connected the PMIC is muxed
to USB carkit mode so the lines go to the UART on the SoC
through some level shifter. If it works it should not cause
any issues, the symptoms I saw earlier was corrupted UART
console and noticed that what worked best for me was 3.3V
ftdi based devices out of the collection of random pl2303
and ftdi cables I had around.

I guess somebody could try to measure the uart lines with
a scope with nothing connected and sending out data from
droid 4. Or look at the carkit spec for the UART voltage
levels.

Regards,

Tony
