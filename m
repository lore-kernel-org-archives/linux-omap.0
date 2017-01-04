From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Thu, 5 Jan 2017 00:27:49 +0200
Message-ID: <20170104222749.4xmyws6zcifeicz5@raspberrypi-2.musicnaut.iki.fi>
References: <201701012054.54505@pali>
 <20170102184945.m6maflaoihumd7nt@raspberrypi-2.musicnaut.iki.fi>
 <201701022101.01341@pali>
 <2036063.jAbaHqGlp2@saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2036063.jAbaHqGlp2@saturn>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg Reisenweber <joerg@openmoko.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Jan 02, 2017 at 10:05:39PM +0100, joerg Reisenweber wrote:
> On Mon 02 January 2017 21:01:01 Pali Rohár wrote:
> > On Monday 02 January 2017 19:49:45 Aaro Koskinen wrote:
> > > The schematic shows ECI(5:0), but only 3 are connected/used. There
> > > were 3 other GPIOs reserved but not used in the final product.
> > 
> > Are you sure that this is truth (maybe you have some information)? Or
> > you just looked at schematic and deduced this observation (as other
> > people too)?
> > 
> > Joerg already told us that RX51 schematic does not 100% match production
> > N900 and e.g. there is missing UART3 pins...
> 
> We found this, see https://irclog.whitequark.org/neo900/2017-01-01 (has a lot 
> of possibly useful references/links)
> The question is if pin AA3 aka GPIO_178 is actually NotConnected in N900 or 
> it's just an omission in schematics and there's actually some more 'stealth 
> hardware' in N900 that doesn't show up in docs, just like the testpoint UART 
> console http://wiki.maemo.org/N900_Hardware_Hacking#Debug_ports which also are 
> missing in schematics.
> 
> 
> > What we know that gpio 178 is *already* controlled and changed by
> > production Nokia kernel running on production N900 devices (as I wrote
> > in first email).
> 
> I could use one of the unpopulated N900 PCB and solder a wire to the OMAP AA3 
> pad, then try to make sure it's not connected to anything, or if it is then 
> find out about the details of this.
> But I'm reluctant to do this, since it's an error prone and (in case of N/C) 
> not verifiable procedure, so I'd appreciate any further info, whether from 
> historical anecdote or from sourcecode review and conclusions, regarding that.

Even if the published production kernel source controls GPIO 178, it
does not mean the production device has it connected, as the same kernel
also supported many older in-house prototype versions of the hardware
(and some of those had it connected).

Probably the easiest test would be to take the final published source,
and then comment out all the GPIO 178 related code and build and run
the kernel on the production device. Then see if you can observe any
difference in behaviour.

A.
