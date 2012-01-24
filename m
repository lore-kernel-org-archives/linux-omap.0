From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: omap-serial RX DMA polling?
Date: Tue, 24 Jan 2012 12:10:18 +0530
Message-ID: <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
 <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
 <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com> <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
 <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: govindraj.raja@ti.com, khilman@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 24, 2012 at 1:18 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 23 Jan 2012, Govindraj wrote:
>
>> On Mon, Jan 23, 2012 at 4:17 PM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> > On Mon, 23 Jan 2012, Govindraj wrote:
>> >
>> >> On Mon, Jan 23, 2012 at 6:03 AM, Paul Walmsley <paul@pwsan.com> w=
rote:
>> >> >
>> >> > while trying to track down some of the serial-related PM issues=
 in
>> >> > v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 micr=
osecond
>> >> > polling timer when DMA is enabled (uart_dma.rx_timer) (!) =A0Th=
is seems
>> >> > quite broken from both the DMA and PM points of view.
>> >>
>> >> Poll rate is used for doing tty_insert_flip_string for pushing da=
ta to
>> >> user space to keep faster response to any client device over uart=
, some
>> >> Bt chips expect faster response when data on uart arrives and pac=
ket
>> >> should be pushed out immediately.
>> >
>> > Hmm. =A0Let's say that the BT transceiver uses the fastest transmi=
ssion rate
>> > supported by the OMAP UARTs -- 3,686,400 bits per second, accordin=
g to
>> > Table 17-1 in the 34xx TRM vZR. =A0So the RX poll timer would go o=
ff about
>> > ~2.7 times per input character[1]. =A0That seems like overkill...
>>
>> Yes correct, Looks like the poll rate is to aggressive
>> it should be calculated based on baud rate provided from user apace
>> in termios function.
>>
>> I had a patch to do the same in termios but,
>> if you have something similar you can post out as I am currently bus=
y with
>> some other activities and may take more time.
>>
>> > For minimum receive latency, how about calling tty_insert_flip_str=
ing()
>> > from the RX DMA callback, and using a smaller transfer count? =A0O=
r even
>> > better, use PIO for the receive path and set the RX FIFO threshold=
 to 1?
>> >
>> > No poll timer should be needed in either case.
>>
>> I remember doing similar excercise with BT + uart on zoom board
>> but performance numbers where impacted.
>>
>> I made buffer size as 1 byte and removed polling function and got rx=
_callback
>> for every byte completion and pushed same to tty layer.
>>
>> BT FTP throughput got impacted a lot.
>
> The point is that if you want tty_insert_flip_string() to be called a=
fter
> every character is received, there seems little point in using RX DMA=
=2E
> It should be less efficient than PIO. =A0And the current way that it =
is used
> is pointless from a power management point of view.
>

Yes, Its between power and performance, current way gives a better
response for most devices. (specially while downloading the firmware fo=
r
external chip initialization and other use cases)

> In general, RX DMA would seem to be inappropriate for a latency-sensi=
tive
> application, unless the application can somehow communicate how many =
bytes
> it's expecting so the driver can adjust its DMA transfer size.
>

Yes I had done that long time back, gives a little edge for
throughput(probably even PM
but haven't checked though) but many users of driver are hesitant to
modify their user space
apps to pass buffer size (modify the bt stack or the gps stack) and
sometimes even those
stacks are unaware of incoming sizes.

Many expect to work as is when hooked up to the user space stack withou=
t
any changes.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
