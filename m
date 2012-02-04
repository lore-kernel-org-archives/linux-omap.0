From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 17:01:14 +0000
Message-ID: <20120204170114.GJ1275@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <20120204163931.GH1275@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42677 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2BDRBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 12:01:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Feb 04, 2012 at 09:49:57AM -0700, Paul Walmsley wrote:
> There is indeed an argument here.  The decision of how to act in this 
> situation needs to be up to the user of the serial port.
> 
> The default behavior needs to be what you state: to not lose characters.  
> And indeed that is what it is in v3.3: the UART will not enter idle when 
> the PM runtime autosuspend timeout is -1.  
> 
> But in cases where there is a protocol that can handle retries, the system 
> integrator may well prefer the large power savings available by letting 
> the chip enter device idle, and take the added delay in the retransmission 
> process.

Rubbish.  Let's say I hook an OMAP platform up to a GPS, and the system
integrator has decided to set the idle timeout on all UARTs to .5 sec.
The GPS transmits data every second.  Yes, it effectively retries each
second, but there's no way to receive its complete transmission _ever_.

So, if this is allowed, OMAP is broken.  Plain and simple.

> As in many power management situations, the choice needs to be up to the 
> user of the serial port or the system administrator, with the default 
> mode being to not lose data.  We must not remove that choice from them, 
> otherwise they will just hack it in later.

And then they'll whinge that they get lost characters and abandon the
attempt.  Good, they learnt that the hardware is broken, and they
learnt why it's not implemented.
