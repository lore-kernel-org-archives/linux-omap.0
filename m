From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 00:23:09 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120203231113.25ae2d3a@notabene.brown>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Greg KH <gregkh@suse.de>, "greg@kroah.com" <greg@kroah.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of NeilBrown

> > Not sure if it's the same problem but with 3530 on 3.2 with
> > sleep_timeout set, I usually get first char dropped (as expected) but
> > sometimes I get corrupted char instead too. Corrupt char seems to
> > almost always happen if I set cpufreq to powersave, on performace it's
> > almost always ok, so maybe it's some timing problem,
> 
> I see that too - I'm glad someone else does :-)

When you have aggressive PM working at the SOC level you many times lost a character on UART every since OMAP2. A strange but true statement is it is nice to see it losing a character on mainline as it as in indication that PM is likely working.

If you just hook up simple RX and TX lines and not other flow control it is very likely especially with older OMAPs you can lose the 'wake' character on debug console. The UART operates on a derived clock from a 96MHz DPLL which was probably stopped. When the wakeup event hits the IO ring many internals may need to repower and its source DPLL needs to relock. This all can take a while and you can lose the start bit at high baud rate. If you use flow control you might be able to get ahead of it.

As the silicon process has shrunk from 90nm (omap2) to 65nm (omap3) to 45nm (omap4) the DPLL relock times have dropped a lot. With certain DPLL parameters it could take hundreds of uS to relock in OMAP2. And there are more variables to latency stack up than just DPLL. Most of these have improved (gotten smaller) over time.

Always the hack for debug console was activity timer along with denying idle while SW and HW TX FIFOs had characters in them. This made debug console useable.

One irritation was some internal interrupt sources were not linked to low power wakeup events. If you were in interrupt mode and got characters below watermark you could sleep before interrupt status showed up (as you had to wait several frame times before functional interrupt asserted) but there was no wake at anticipated frame timeout because lack of linking of internal event to wake event.

Outside of debug console, this loss has not been huge. Protocols like irda would retransmit their magic wake packets. You can move between DMA and interrupt modes with activity. So far there has been a work around per attached device.

If your screen blanks and you hit a char to wakeup, do you expect to see the character or do you throw it away?  You can set some timeout or policy to deny lower c-states which can ensure a debug console doesn't have any issue.  If your application is a phone it is not likely something you would do.

Maybe your issue today is due to some other software bug... but at the end of the trail you still may have an issue unless your attached hardware accommodates.

Regards,
Richard W.


