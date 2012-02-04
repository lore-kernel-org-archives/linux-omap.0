From: Paul Walmsley <paul@pwsan.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 17:59:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031731500.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <20120203231113.25ae2d3a@notabene.brown> <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, Woodruff, Richard wrote:

> When you have aggressive PM working at the SOC level you many times lost 
> a character on UART every since OMAP2. A strange but true statement is 
> it is nice to see it losing a character on mainline as it as in 
> indication that PM is likely working.

We've been losing wakeup characters in mainline for many years now ;-)

> One irritation was some internal interrupt sources were not linked to 
> low power wakeup events. If you were in interrupt mode and got 
> characters below watermark you could sleep before interrupt status 
> showed up (as you had to wait several frame times before functional 
> interrupt asserted) but there was no wake at anticipated frame timeout 
> because lack of linking of internal event to wake event.

Indeed, it seems that we are just now working around these wakeup-related 
bugs.  Kind of surprising that no errata showed up for them.

What's particularly remarkable is that it looks like the UARTs will 
idle-ack while their transmit FIFOs have data in them (!)


- Paul
