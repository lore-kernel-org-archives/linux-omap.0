From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
Date: Fri, 15 Aug 2014 14:37:31 -0400
Message-ID: <20140815183731.GI17769@csclub.uwaterloo.ca>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408124563-31541-6-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 15, 2014 at 07:42:33PM +0200, Sebastian Andrzej Siewior wro=
te:
> This patch provides a 8250-core based UART driver for the internal OM=
AP
> UART. The long term goal is to provide the same functionality as the
> current OMAP uart driver and DMA support.
> I tried to merge omap-serial code together with the 8250-core code.
> There should should be hardly a noticable difference. The trigger lev=
els
> are different compared to omap-serial:
> - omap serial
>   TX: Interrupt comes after TX FIFO has room for 16 bytes.
>       TX of 4096 bytes in one go results in 256 interrupts
>=20
>   RX: Interrupt comes after there is on byte in the FIFO.
                                       one
>       RX of 4096 bytes results in 4096 interrupts.
>=20
> - this driver
>   TX: Interrupt comes once the TX FIFO is empty.
>       TX of 4096 bytes results in 65 interrupts. That means there wil=
l
>       be gaps on the line while the driver reloads the FIFO.

Any idea how long the gap is likely to be?  Probably not much.  I like
the reduction in the number of interrupts.

I suppose if you did an interrupt when half empty or 3/4 empty, you
would avoid the gap, and only increase the interrupt amount a little bi=
t.
Waiting until completely empty gives you larger dma transfers and less
interrupts, but reduces your effective bandwidth on the port.  Is that
really the right tradeoff?  I think the original driver behaviour there
was fairly sane, although the 16 byte value could perhaps be increased
to 32 or 48.

>   RX: Interrupt comes once there are 48 bytes in the FIFO or less ove=
r
>       "longer" time frame. We have
>           1 / 11520 * 10^3 * 16 =3D> 1.38=E2=80=A6 ms
>       1.38ms to react and purge the FIFO on 115200,8N1. Since the oth=
er
>       driver fired after each byte it had ~5.47ms time to react. This
>       _may_ cause problems if one relies on no missing bytes and has =
no
>       flow control. On the other hand we get only 85 interrupts for t=
he
>       same amount of data.

Hmm, so if this was 32 instead of 48, it would double the amount of
time you have to react, while only increasing the interrupt rate by 50%
(1 every 32 rather than 1 every 48).  Could be interesting to tweak to
get the balance just right.  Maybe it could have an optional dtb entry
to control it if you don't like the default or is there a way to change
it from user space already?

I know for our system we would like to be able to tolerate 1ms at 23040=
0
without data loss.

--=20
Len Sorensen
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
