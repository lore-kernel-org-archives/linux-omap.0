From: Tony Lindgren <tony@atomide.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 10:59:22 -0800
Message-ID: <20120204185922.GK20333@atomide.com>
References: <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
 <20120204163931.GH1275@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com>
 <20120204170114.GJ1275@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1202041005270.9453@utopia.booyaka.com>
 <20120204174715.GK1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120204174715.GK1275@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 09:16]:
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

The default should always be the lossless mode. If the clocks for the
serial port are cut off based on a timer, the timer should be port
specific, and default to 0.

Then if some app using the port wants to intentionall enable automatic
disabling of the clocks, it can still do it.

Regards,

Tony
