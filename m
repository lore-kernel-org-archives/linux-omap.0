From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Thu, 11 Sep 2014 10:35:43 -0400
Message-ID: <5411B33F.10405@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <54119AAA.9080907@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 09/11/2014 08:50 AM, Sebastian Andrzej Siewior wrote:
> On 09/11/2014 02:32 PM, Peter Hurley wrote:
>> On 09/11/2014 07:42 AM, Sebastian Andrzej Siewior wrote:
>>> I also need a watchdog timer for TX since it seems that on omap3 th=
e
>>> DMA engine suddenly forgets to continue with DMA=E2=80=A6
>>
>> One difference I noticed between the omap driver and the 8250 driver=
 is
>> the way modem status interrupts are handled.
>>
>> The omap driver only checks modem status for the UART_IIR_MSI interr=
upt type.
>> The 8250 driver checks modem status at every interrupt (other than N=
O_INT).
>>
>> I think the UART_MSR_DCTS bit always reflects that the CTS input has=
 changed
>> between reads of the MSR _even if auto CTS is on_. So perhaps the ha=
rdware
>> is being stopped by uart_handle_cts_change() when auto CTS is on?
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
>=20
> I remember also that I disabled the HW/SW float control just to make
> sure it is not it.

Ok.

I do need to find out if omap hardware sets UART_MSR_DCTS when auto CTS
is on. Would you mind running the debug patch below with HW flow contro=
l on?

Regards,
Peter Hurley

--- >% ---
Subject: [DEBUG] serial: does OMAP set UART_LSR_DCTS while autoCTS is o=
n?

** debug patch only **

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
index 5a78f69..1579a20 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2783,6 +2783,9 @@ void uart_handle_cts_change(struct uart_port *upo=
rt, unsigned int status)
 	uport->icount.cts++;
=20
 	if (tty_port_cts_enabled(port)) {
+
+		WARN_ON_ONCE(uport->flags & UPF_HARD_FLOW);
+
 		if (tty->hw_stopped) {
 			if (status) {
 				tty->hw_stopped =3D 0;
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
