From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 20:56:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202032050560.9453@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
 <20120204085940.2de44594@notabene.brown> <alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com> <20120204110131.7378b8fe@notabene.brown> <alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com> <20120204140923.063706c8@notabene.brown>
 <alpine.DEB.2.00.1202032014170.9453@utopia.booyaka.com> <20120204144353.0803fe23@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204144353.0803fe23@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, NeilBrown wrote:

> I have to set autosuspend_delay_ms for omap_uart.3 as well before the
> behaviour is significant.
> But then I see no output corruption.  Lots of input corruption of course but
> the output looks fine.

OK.  Is the input corruption at the beginning of the pasted buffer, or the 
middle?  And this is with CPUIdle enabled?

With CPUIdle disabled here, what I thought was output corruption occurs in 
the middle of the pasted buffer occasionally.  But it might be input 
corruption, if the CPU manages to empty the RX FIFO while the TX FIFO is 
empty.


- Paul
