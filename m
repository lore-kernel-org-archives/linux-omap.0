From: Paul Walmsley <paul@pwsan.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 19:39:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031913101.9453@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <20120203231113.25ae2d3a@notabene.brown> <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com> <alpine.DEB.2.00.1202031731500.27947@utopia.booyaka.com> <EF62F09C0797D947AD4180A1043C0DF73493107B@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73493107B@DLEE10.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, Woodruff, Richard wrote:

> There have been errata over time in this area. Several I hit were 
> updated at 3630 time. UART did get IER2 but I don't recall all details 
> for UART.  Probably that is not being used.

Govindraj sent an RFC patch a few days ago to add IER2, which is good, but 
we're still awaiting the followup patch for it.

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Friday, February 03, 2012 7:00 PM
> 
> > What's particularly remarkable is that it looks like the UARTs will
> > idle-ack while their transmit FIFOs have data in them (!)
> 
> Generally a module can ACK its ICLK if it is not used internally. The 
> FCLK can push data out with out ICLK and is controlled separately always 
> (omap4 changed encoding, to optional clock). This allows interconnect to 
> idle during tx to save power. 

Yep, that's a good point.  Unfortunately the PER has a hardware sleep 
dependency with the CORE_L3 clockdomain on OMAP3... so I'm not sure how 
much power we'd be able to save.  Perhaps some: it appears that the UART3 
functional clock comes from the CORE_L4 clockdomain.  So it might be worth 
implementing some extra intelligence here.  The kernel code is disabling 
both the ICLK and the FCLK simultaneously, so that may not be optimal in 
this situation.

In the short-term, on the kernel side, we should just keep the PM runtime 
count non-zero when the UART is transmitting.  Since we can get an 
interrupt when the TX is done, or close to being done anyway, we can just 
disable the clocks at that point.  Not ideal, but should work.

> The trick is to ensure all module wakeup plumbing is enabled so a 
> functional tx irq will flow.  Audits last showed several drivers missing 
> steps (omap specific). Some drivers seemed to rely on static 
> dependencies or coincident neighbor activity to allow their functional 
> interrupt to flow... to many interdependent custom details... and yes 
> some errata.

Yeah.  I think we've got an acceptable workaround for the missing TX 
wakeup problem.  And we've got a somewhat unpleasant workaround for the 
missing RX timeout wakeup problem.   Now we just need to put together a 
strategy for the idle-during-TX problem...

> Anyway, even with all SOC specific wake bits you may lose the character 
> with latency of restart. Point I was raising was external chip hook can 
> not be neglected as its part of equation.

Indeed.

Thanks for the info -- it's always nice to see your posts on the lists --


- Paul
