From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sun, 5 Feb 2012 15:37:21 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF734934E36@DLEE10.ent.ti.com>
References: <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
 <20120204163931.GH1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204163931.GH1275@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, NeilBrown <neilb@suse.de>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Saturday, February 04, 2012 10:40 AM

> It is entirely unacceptable to drop characters on a serial port through
> the use of PM.  Many serial protocols just will not cope with that kind
> of behaviour - yes, serial protocols may have retry built-in, but will
> they retry _before_ the port re-idles and the PLL shuts down?  Can you
> be sure?

What is acceptable depends on the hardware and applications stack ups being used. There are ways to work around issues along whole path in SW and HW.  There is no single setup which makes all combinations work. Some old PC chassis may define 1 of many standards but they probably were not defined with very low power tradeoffs in mind.

If the board designer hooks up all possible serial signals for uart/rs232/rs422/standard-xyz or just rx/tx, or adds some glue logic, or adds smart peripheral, or ..., there are will be constraints and ways to cope with issue being discussed.

For most OMAP reference platforms the HW design links available UARTs with likely peripherals used in that timeframe. When it comes to making each UART work with PM some changes are usually needed per interface. Depending on the given stack up (to include bugs/limitations) some per interface tweak is always needed. It might be as you say you have to defeat PM on a port and only release after protocol handshaking with some modem firmware or it might be the debug UART expectation is lowered and allowed to work in a lossy mode so as not to destroy platform power for non-production port.

[x] What is acceptable depends is not black and white.  Is there some QOS mapping which can be set per channel which allows runtime PM to pick a best chose (which may allow for loss and frame issues)?.

Regards,
Richard W.

