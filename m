From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 14:42:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031432080.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <20120203231113.25ae2d3a@notabene.brown> <alpine.DEB.2.00.1202031243270.27947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1202031243270.27947@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

One correction on this part...

On Fri, 3 Feb 2012, Paul Walmsley wrote:

> On Fri, 3 Feb 2012, NeilBrown wrote:
> 
> > My theory is that there is a delay between the falling RX line waking the
> > system up, and the CPU enabling the UART - whether enabling the clocks or
> > doing a full config, I am not sure - though I think the former.
> > 
> > Maybe if we could enable the UART clocks immediately after returning from the
> > WFI instruction we could avoid the corruption....
> 
> The PRCM should be re-enabling the UART's functional clock itself, with no 
> kernel involvement.  The sequence should go something like this 
> (simplified):
> 
> 1. I/O wakeup occurs
> 
> 2. CORE & PER powerdomains are awakened
> 
> 3. The UART notices an event on its input lines and deasserts its idle-ack

It just occurred to me that, supposedly, the only UART input line that is 
attached to the SWAKEUP signal is CTS.  So the UART may not in fact be 
able to deassert its idle-ack autonomously at this point.

So you might want to give your clock re-enable after WFI idea a shot!  It 
would be interesting if it helps.

I regret the oversight, 


- Paul
