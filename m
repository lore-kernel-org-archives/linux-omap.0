From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Thu, 11 Sep 2014 17:11:14 +0200
Message-ID: <20140911151114.GD28458@ci00147.xsens-tech.local>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300>
 <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com>
 <54119AAA.9080907@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54119AAA.9080907@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 11, 2014 at 02:50:50PM +0200, Sebastian Andrzej Siewior wro=
te:
> On 09/11/2014 02:32 PM, Peter Hurley wrote:
> > On 09/11/2014 07:42 AM, Sebastian Andrzej Siewior wrote:
> >> I also need a watchdog timer for TX since it seems that on omap3 t=
he
> >> DMA engine suddenly forgets to continue with DMA=E2=80=A6
> >=20
> > One difference I noticed between the omap driver and the 8250 drive=
r is
> > the way modem status interrupts are handled.
> >=20
> > The omap driver only checks modem status for the UART_IIR_MSI inter=
rupt type.
> > The 8250 driver checks modem status at every interrupt (other than =
NO_INT).
> >=20
> > I think the UART_MSR_DCTS bit always reflects that the CTS input ha=
s changed
> > between reads of the MSR _even if auto CTS is on_. So perhaps the h=
ardware
> > is being stopped by uart_handle_cts_change() when auto CTS is on?
>=20
> I doubt that. What I see from a timer debug is that the TX-FIFO level
> is at 0, the DMA transfer for say 1024 bytes start.
> The FIFO is filled to 64bytes and refilled so it doesn't drop below 5=
0.
> At the time of the stall I see that the DMA engine has outstanding
> bytes which it should transfer and the TX FIFO is empty. If hardware
> flow control stops the transfer, I would expect that the DMA engine
> still fills the TX-FIFO until 64 and then waits. But it doesn't.
> Writing bytes into the FIFO leads to bytes beeing sent (and I see the=
m
> on the other side) but the DMA transfer is still on hold. Canceling t=
he
> DMA transfer and re-programming the remaining bytes transfers the
> remaining bytes.
>=20
> The odd thing is that I only triggered it with "less file". It doesn'=
t
> happen on regular console interaction or "cat large-file". And it onl=
y
> triggers on beagle board xm (omap34xx) and I wasn't able to reproduce
> it on am335x or dra7. The latter shares the same DMA engine as beagle
> board xm.

I can still reproduce it on am335x. I can get out of it as soon as
something else gets written to the console though.

# echo "<3>something" >/dev/kmsg

=46rans


>=20
> I remember also that I disabled the HW/SW float control just to make
> sure it is not it.
>=20
> >=20
> > Regards,
> > Peter Hurley
> >=20
> > [The UPF_HARD_FLOW thing was pretty much just done for omap even th=
ough
> > 8250 already had auto CTS/auto RTS. Serial core hardware flow contr=
ol support
> > needs a redo as drivers have pretty much tacked stuff on randomly.]
>=20
> Sebastian
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
