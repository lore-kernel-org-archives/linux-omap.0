From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
Date: Fri, 15 Aug 2014 21:27:59 +0200
Message-ID: <53EE5F3F.2000707@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-6-git-send-email-bigeasy@linutronix.de> <20140815183731.GI17769@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140815183731.GI17769@csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 08/15/2014 08:37 PM, Lennart Sorensen wrote:
> On Fri, Aug 15, 2014 at 07:42:33PM +0200, Sebastian Andrzej Siewior w=
rote:
>> This patch provides a 8250-core based UART driver for the internal O=
MAP
>> UART. The long term goal is to provide the same functionality as the
>> current OMAP uart driver and DMA support.
>> I tried to merge omap-serial code together with the 8250-core code.
>> There should should be hardly a noticable difference. The trigger le=
vels
>> are different compared to omap-serial:
>> - omap serial
>>   TX: Interrupt comes after TX FIFO has room for 16 bytes.
>>       TX of 4096 bytes in one go results in 256 interrupts
>>
>>   RX: Interrupt comes after there is on byte in the FIFO.
>                                        one
>>       RX of 4096 bytes results in 4096 interrupts.
>>
>> - this driver
>>   TX: Interrupt comes once the TX FIFO is empty.
>>       TX of 4096 bytes results in 65 interrupts. That means there wi=
ll
>>       be gaps on the line while the driver reloads the FIFO.
>=20
> Any idea how long the gap is likely to be?  Probably not much.  I lik=
e
> the reduction in the number of interrupts.

If you want to change this to reduce the gap, then you have first
change 8250 core code. Currently it waits until the shift register is
empty.
On the other hand if you use DMA then it can handle transfers > 64bytes
in one go and you can start transfers while the FIFO is not completely
empty.

> I suppose if you did an interrupt when half empty or 3/4 empty, you
> would avoid the gap, and only increase the interrupt amount a little =
bit.
> Waiting until completely empty gives you larger dma transfers and les=
s
> interrupts, but reduces your effective bandwidth on the port.  Is tha=
t
> really the right tradeoff?  I think the original driver behaviour the=
re
> was fairly sane, although the 16 byte value could perhaps be increase=
d
> to 32 or 48.

If you use DMA. You program one transfer says 100 bytes. You get an
dma-transfer complete once the 100 bytes are transfered which means the
=46IFO has 63 bytes. From this point on you could enqueue the next
transfer with say another 100 bytes. In that scenario you don't see the
gap.

You get only to the gap if you use the non-DMA mode (and not UARTs
support DMA). In that case, yes waiting till there only 16 bytes before
starting the refill would make sense if you want to utilize the port by
100%. But as I said in 0/15, you need to teach the core this first.
Otherwise it will return doing nothing until the shift register is
empty (i.e. until the FIFO is completely empty).

>>   RX: Interrupt comes once there are 48 bytes in the FIFO or less ov=
er
>>       "longer" time frame. We have
>>           1 / 11520 * 10^3 * 16 =3D> 1.38=E2=80=A6 ms
>>       1.38ms to react and purge the FIFO on 115200,8N1. Since the ot=
her
>>       driver fired after each byte it had ~5.47ms time to react. Thi=
s
>>       _may_ cause problems if one relies on no missing bytes and has=
 no
>>       flow control. On the other hand we get only 85 interrupts for =
the
>>       same amount of data.
>=20
> Hmm, so if this was 32 instead of 48, it would double the amount of
> time you have to react, while only increasing the interrupt rate by 5=
0%
> (1 every 32 rather than 1 every 48).  Could be interesting to tweak t=
o
> get the balance just right.  Maybe it could have an optional dtb entr=
y
> to control it if you don't like the default or is there a way to chan=
ge
> it from user space already?

There is patch in Greg's tty tree already where you are able to
configure the RX trigger level. We could wire this up once we agree
which levels we want support. The OMAP supports all levels from 1=E2=80=
=A663.

> I know for our system we would like to be able to tolerate 1ms at 230=
400
> without data loss.

Yes, true. However this is only an issue without HW control. With DMA
the buffer is slightly larger. The DMA engine starts the transfer on
its own once there 48 bytes in the FIFO (except in the few cases where
it does not).

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
