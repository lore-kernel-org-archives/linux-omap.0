From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 12:24:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202041211150.9453@utopia.booyaka.com>
References: <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <20120204163931.GH1275@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com> <20120204170114.GJ1275@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202041005270.9453@utopia.booyaka.com>
 <20120204174715.GK1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204174715.GK1275@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:

> On Sat, Feb 04, 2012 at 10:22:27AM -0700, Paul Walmsley wrote:
> > No, that is not an example of a protocol with a retry.  That is an example 
> > of a protocol that has no provision for reliable data delivery.  Sending a 
> > new data string one second later is not a retry.
> > 
> > In such situations, the system integrator would just use the UART in the 
> > default (lossless) mode.  And if they don't, they'll have to deal with the 
> > consequences that they chose.  Those of us who ship battery-powered Linux 
> > devices are indeed capable of making this choice.
> 
> Okay, lets see.  You're making a battery powered Linux device.  It has
> a standard RS232 serial port available, and you allow users to load
> 'apps' onto it.
> 
> Do you run the serial ports in lossless mode?

Not every serial port is available to arbitrary 'apps.'.  Not every 
battery-powered Linux device allows users to run arbitrary 'apps.'

On devices that do allow users to load arbitrary 'apps,' and that allow 
those 'apps' to have direct access to the serial ports, I personally 
believe that system integrators should not change the default OMAP serial 
setting, which is to run the serial ports in lossless mode.

Here is another example.  Suppose someone builds a GPS receiver with an 
OMAP that is capable of sending NMEA position sentences, once per second, 
to a remotely connected serial device.  No receive traffic is expected on 
that port.

The position you seem to be advocating is that the mainline Linux kernel 
should not support any ability to allow the system integrator to 
affirmatively instruct the SoC to enter device idle between those position 
sentences.  This will cause the SoC to consume energy to losslessly 
handle an incoming serial character that will never come.  Is that really 
what you're advocating?


- Paul
