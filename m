From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 16:39:31 +0000
Message-ID: <20120204163931.GH1275@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 04, 2012 at 06:00:56PM +0200, Grazvydas Ignotas wrote:
> It's case 1. What I wanted to say is that first char is most often
> nicely dropped and does not get into the terminal, so I can just type
> the command after it. But in some cases terminal gets corrupted char
> instead, so I must then first get rid of it somehow to successfully
> send a command, which is annoying a bit. I thought that maybe there is
> code somewhere that gets rid of first bad char received and maybe it
> can be tuned, but judging on further discussions it's all done by
> hardware?

If it's the case that the UART bitclock is derived from a PLL which is
shutdown while idle, then no matter which way you look at it - if the
port is open, and therefore the port is expecting to transfer data,
the port must _never_ be allowed to go into any low power state, period.

If it does, then the PLL stops, and it takes time for the PLL to re-lock.
That time will cause a character to be dropped, which is exactly what
people are reporting in this thread.

Moreover, if that then means that the OMAP CPU cores can't be put into a
low power state, then that's the hit that _has_ to be taken because of
the design of the hardware.

It is entirely unacceptable to drop characters on a serial port through
the use of PM.  Many serial protocols just will not cope with that kind
of behaviour - yes, serial protocols may have retry built-in, but will
they retry _before_ the port re-idles and the PLL shuts down?  Can you
be sure?

If you can't, then you can't do PM in this area while the port is open.
Runtime power management is _supposed_ to be transparent.  If it isn't,
it's a bug plain and simple, which blocks the ability for the device to
even _use_ runtime power management.

There's no absolutely argument here.  OMAP's hardware auto idle on the
UART which results in characters being dropped is quite clearly broken.

So, what I suggest is reverting back to standard FIFO thresholds, and
then doing the PM in software: if the kernel transmit buffer holds
characters, or the device FIFO contains characters, PM on the transmit
side must be denied.  If the port is _open_, PM on the receive side
must be denied.  If you don't have a distinction between the transmit
and receive sides, then that becomes a very simple rule: if the port is
open, runtime PM of the serial port is denied and the port must remain
active all the time that it's open.  It's that simple, no ifs or buts.

Anything else, which results in characters lost, is buggy.
