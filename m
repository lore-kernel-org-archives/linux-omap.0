From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 10:22:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202041005270.9453@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <20120204163931.GH1275@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1202040943450.9453@utopia.booyaka.com> <20120204170114.GJ1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59875 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2BDRW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 12:22:28 -0500
In-Reply-To: <20120204170114.GJ1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:

> On Sat, Feb 04, 2012 at 09:49:57AM -0700, Paul Walmsley wrote:
> > There is indeed an argument here.  The decision of how to act in this 
> > situation needs to be up to the user of the serial port.
> > 
> > The default behavior needs to be what you state: to not lose characters.  
> > And indeed that is what it is in v3.3: the UART will not enter idle when 
> > the PM runtime autosuspend timeout is -1.  
> > 
> > But in cases where there is a protocol that can handle retries, the system 
> > integrator may well prefer the large power savings available by letting 
> > the chip enter device idle, and take the added delay in the retransmission 
> > process.
> 
> Rubbish.  Let's say I hook an OMAP platform up to a GPS, and the system
> integrator has decided to set the idle timeout on all UARTs to .5 sec.
> The GPS transmits data every second.  Yes, it effectively retries each
> second, but there's no way to receive its complete transmission _ever_.

No, that is not an example of a protocol with a retry.  That is an example 
of a protocol that has no provision for reliable data delivery.  Sending a 
new data string one second later is not a retry.

In such situations, the system integrator would just use the UART in the 
default (lossless) mode.  And if they don't, they'll have to deal with the 
consequences that they chose.  Those of us who ship battery-powered Linux 
devices are indeed capable of making this choice.

One could argue that the PM runtime autosuspend timeout is not the 
appropriate place to change this setting, and that it should be somewhere 
else.  That's fine.  But that's a separate issue from removing the 
functionality completely.


- Paul
