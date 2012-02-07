From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Tue, 7 Feb 2012 01:00:59 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF734938E89@DLEE10.ent.ti.com>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
	<20120203231113.25ae2d3a@notabene.brown>
	<EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
 <20120204133101.1ab3500f@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204133101.1ab3500f@notabene.brown>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, Greg KH <gregkh@suse.de>, "greg@kroah.com" <greg@kroah.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> From: NeilBrown [mailto:neilb@suse.de]
> Sent: Friday, February 03, 2012 8:31 PM

> So... if flow control is available, then when we idle the uart we should
> set <snip> ...

Yes I think you can improve situation with such tricks.

Unfortunately there are a few types of low-power idle wakeups which muddy the water when trying to understand TRMs.

- The IOpad type wakes are the ones being discussed now. These are used in conjunction with isolation rings which stop external signals from propagating into chip and causing undefined things. This protection is used to enable OFF mode (but can be armed outside of from 34xx+ and beyond). The wakeup event here travels through pins to wakeup domain then to prcm which reactivates subdomains and signals can then reflow (if there are still valid). You get IOpad status which can map to function.

- A shade of idle up is module idle wakes. Here if the isolation latch is not enabled you need to program omap-ocp&ip wake-function wrappers in uart itself. Here the wake signal comes through pads to uart-ip then it signals prcm to reflow signals.

- A wakeup which no one seems to use above this is the 16x50 UART has some internal sleep/wake features. The generic linux driver might know these but they are rarely used.
 
> > Outside of debug console, this loss has not been huge. Protocols like
> irda would retransmit their magic wake packets. You can move between DMA
> and interrupt modes with activity. So far there has been a work around per
> attached device.
> 
> What about bluetooth?  HCI/UART doesn't seem to have a lot of error
> handling.  Maybe it has enough though.
> (I have bluetooth on UART1 ... of course we might not have the same
> problems
> on UART1 .. I haven't played with bluetooth much yet).

I heard of solutions but don't recall as I personally didn't donate blood to get them working. I recall some activity timer + wake packets but would have to dig up old PPTs.

Regards,
Richard W.

