From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 14:04:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031347590.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <20120204074427.5091fef5@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60627 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757874Ab2BCVEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 16:04:46 -0500
In-Reply-To: <20120204074427.5091fef5@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 4 Feb 2012, NeilBrown wrote:

> On Fri, 3 Feb 2012 12:42:22 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
>
> > Case 1 is expected and is almost certainly not a bug.  As Neil mentioned 
> > it should be bps-rate dependent.  It occurs when the first character 
> > transmitted to the OMAP wakes the chip up via I/O ring/chain wakeup.
> > I/O ring/chain wakeup is driven by a 32KiHz clock and is therefore 
> > relatively high-latency.  So this could easily cause the first character 
> > or first few characters to be lost or corrupted, depending on the exact 
> > sequence of events, the low power state that the chip was in, etc.
> 
> A 32KiHz cycles every 30mSec.
> At 115200 bps, there is one bit every 8.7 microseconds.
> 
> When I type "return" - which looks like 0101100001111... on the wire,
> I see '0xC3' which looks like 011000011111... on the wire.
> So we lost exactly 2 bits, or a delay around 17 microseconds.
> 
> I find it hard to reconcile that delay with the cause being a 32KiHZ clock.

If you're not disabling the HF clock oscillator via the AUTOEXTCLKMODE 
bits, the wakeup logic may be getting clocked by the sys_clk, which is 
quite a bit faster.  That might explain the corruption patterns you're 
seeing.


- Paul
