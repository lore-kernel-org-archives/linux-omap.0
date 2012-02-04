From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 09:49:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <20120204163931.GH1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47515 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2BDQt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 11:49:57 -0500
In-Reply-To: <20120204163931.GH1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:

> If you can't, then you can't do PM in this area while the port is open.
> Runtime power management is _supposed_ to be transparent.  If it isn't,
> it's a bug plain and simple, which blocks the ability for the device to
> even _use_ runtime power management.
> 
> There's no absolutely argument here.  OMAP's hardware auto idle on the
> UART which results in characters being dropped is quite clearly broken.
> 
> So, what I suggest is reverting back to standard FIFO thresholds, and
> then doing the PM in software: if the kernel transmit buffer holds
> characters, or the device FIFO contains characters, PM on the transmit
> side must be denied.  If the port is _open_, PM on the receive side
> must be denied.  If you don't have a distinction between the transmit
> and receive sides, then that becomes a very simple rule: if the port is
> open, runtime PM of the serial port is denied and the port must remain
> active all the time that it's open.  It's that simple, no ifs or buts.
> 
> Anything else, which results in characters lost, is buggy.

There is indeed an argument here.  The decision of how to act in this 
situation needs to be up to the user of the serial port.

The default behavior needs to be what you state: to not lose characters.  
And indeed that is what it is in v3.3: the UART will not enter idle when 
the PM runtime autosuspend timeout is -1.  

But in cases where there is a protocol that can handle retries, the system 
integrator may well prefer the large power savings available by letting 
the chip enter device idle, and take the added delay in the retransmission 
process.

As in many power management situations, the choice needs to be up to the 
user of the serial port or the system administrator, with the default 
mode being to not lose data.  We must not remove that choice from them, 
otherwise they will just hack it in later.


- Paul
