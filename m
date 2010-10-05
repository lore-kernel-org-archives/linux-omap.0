From: Paul Walmsley <paul@pwsan.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 11:26:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010051021350.13816@utopia.booyaka.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com> <4CA9C5F6.7060902@ti.com> <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
 <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com> <87wrpy0xp3.fsf@deeprootsystems.com> <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com> <87iq1hzt3u.fsf@deeprootsystems.com> <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com>
 <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com> <4CAACFFF.9040702@ti.com> <alpine.DEB.2.00.1010050117390.13816@utopia.booyaka.com> <4CAAF126.5080206@ti.com> <alpine.DEB.2.00.1010050346130.13816@utopia.booyaka.com> <4CAAF6B4.4030708@ti.com>
 <alpine.DEB.2.00.1010050400210.13816@utopia.booyaka.com> <4CAB077F.5020806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36455 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab0JER0X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 13:26:23 -0400
In-Reply-To: <4CAB077F.5020806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pramod <pramod.gurav@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 5 Oct 2010, Pramod wrote:

> On Tuesday 05 October 2010 03:33 PM, Paul Walmsley wrote:
> > 
> > Looks to me like it boots fine.  If you had hwmod debugging enabled, your
> > kernel should have crashed after
> > 
> > omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
> > omap-hsuart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
> > omap-hsuart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
> > 
> > ... but it didn't crash there.  I'm not seeing any hwmod debug messages
> > though, so you probably don't have DEBUG defined in omap_hwmod.c.
> > 
> > So, I suspect whatever problem you're seeing is unrelated to the problem
> > that the patch was intended to solve.
> > 
> > 
> > - Paul
> 
> The hwmod debug messages will be seen when I enable them on the go with:
> echo -n 'file omap_hwmod.c +p' > /debug/dynamic_debug/control
> 
> This will show lots of logs as below ending with UART3 clock disabling and a
> hang.
> 
> omap_hwmod:omap_hwmod: uart1: idling
> omap_hwmod:omap_hwmod: uart1: disabling clocks
> omap_hwmod:omap_hwmod: uart2: idling
> omap_hwmod:omap_hwmod: uart2: disabling clocks
> omap_hwmod:omap_hwmod: uart1: enabling
> omap_hwmod:omap_hwmod: uart1: enabling clocks
> omap_hwmod:omap_hwmod: uart2: enabling
> omap_hwmod:omap_hwmod: uart2: enabling clocks
> omap_hwmod:omap_hwmod: uart3: idling
> omap_hwmod:omap_hwmod: uart3: disabling clock

OK, the problem here is probably with the real serial console generating 
messages while the hwmod is idle, not earlyconsole/bootconsole.  The patch 
could be extended to fix that, but it doesn't address that right now.  Why 
don't you take a shot at doing that?

In this context, the real serial console is only part of the problem.  
For a complete fix, I suspect that one would have to tinker with the OMAP 
UART driver or serial core, since other drivers beyond the real console 
may be using the serial port (e.g. Bluetooth).

Also, thinking about this issue further, there needs to be an additional 
fix at least in omap_serial_init_port() to ensure that the UART TX FIFO is 
completely drained before it starts messing around with the underlying 
hwmod.  Similarly, whenever the PM runtime conversion is done for 
drivers/serial/omap-serial.c, it will need to ensure that the TX FIFO has 
drained before going to idle.


regards,

- Paul
