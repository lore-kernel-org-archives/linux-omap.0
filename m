From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 20:16:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202032014170.9453@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
 <20120204085940.2de44594@notabene.brown> <alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com> <20120204110131.7378b8fe@notabene.brown> <alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com> <20120204140923.063706c8@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204140923.063706c8@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, NeilBrown wrote:

> On Fri, 3 Feb 2012 19:06:19 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> > 
> > Here's a patch that helps.  It seems to work down to an 
> > autosuspend_delay_ms of 1 ms.  Without it, the best I can get is 8 ms.
> > 
> > Of course, ideally it should work fine at autosuspend_delay_ms = 0, so 
> > likely there's some other infelicity that we're currently missing.
> > 
> > Neil, care to give this a test and confirm it on your setup?
> 
> Yes, that seems to make the output corruption go away.

Cool, thanks for the test :-)

> Even with small autosuspend_delay_ms down to 0 it doesn't corrupt output,
> but as the first input byte is corrupted, I cannot really type with those
> setting (so I ssh to gain control again).

Could you try pasting in a buffer from another window?  If I paste in the 
buffer at the bottom of this message a few times, I see some output 
corruption. 


- Paul


 
;
;
;
;
cat  /sys/devices/platform/omap/omap_uart.2/power/autosuspend_delay_ms
echo 0 > /sys/devices/platform/omap/omap_uart.2/power/autosuspend_delay_ms
cat /proc/interrupts
;

