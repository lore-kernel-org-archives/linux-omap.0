From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap-serial RX DMA polling?
Date: Mon, 23 Jan 2012 12:48:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com> <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com> <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
 <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1786668121-1327348134=:29673"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: govindraj.raja@ti.com, khilman@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1786668121-1327348134=:29673
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Jan 2012, Govindraj wrote:

> On Mon, Jan 23, 2012 at 4:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Mon, 23 Jan 2012, Govindraj wrote:
> >
> >> On Mon, Jan 23, 2012 at 6:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >> >
> >> > while trying to track down some of the serial-related PM issues in
> >> > v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 microseco=
nd
> >> > polling timer when DMA is enabled (uart_dma.rx_timer) (!) =A0This se=
ems
> >> > quite broken from both the DMA and PM points of view.
> >>
> >> Poll rate is used for doing tty_insert_flip_string for pushing data to
> >> user space to keep faster response to any client device over uart, som=
e
> >> Bt chips expect faster response when data on uart arrives and packet
> >> should be pushed out immediately.
> >
> > Hmm. =A0Let's say that the BT transceiver uses the fastest transmission=
 rate
> > supported by the OMAP UARTs -- 3,686,400 bits per second, according to
> > Table 17-1 in the 34xx TRM vZR. =A0So the RX poll timer would go off ab=
out
> > ~2.7 times per input character[1]. =A0That seems like overkill...
>=20
> Yes correct, Looks like the poll rate is to aggressive
> it should be calculated based on baud rate provided from user apace
> in termios function.
>=20
> I had a patch to do the same in termios but,
> if you have something similar you can post out as I am currently busy wit=
h
> some other activities and may take more time.
>=20
> > For minimum receive latency, how about calling tty_insert_flip_string()
> > from the RX DMA callback, and using a smaller transfer count? =A0Or eve=
n
> > better, use PIO for the receive path and set the RX FIFO threshold to 1=
?
> >
> > No poll timer should be needed in either case.
>=20
> I remember doing similar excercise with BT + uart on zoom board
> but performance numbers where impacted.
>=20
> I made buffer size as 1 byte and removed polling function and got rx_call=
back
> for every byte completion and pushed same to tty layer.
>=20
> BT FTP throughput got impacted a lot.

The point is that if you want tty_insert_flip_string() to be called after=
=20
every character is received, there seems little point in using RX DMA. =20
It should be less efficient than PIO.  And the current way that it is used=
=20
is pointless from a power management point of view.

In general, RX DMA would seem to be inappropriate for a latency-sensitive=
=20
application, unless the application can somehow communicate how many bytes=
=20
it's expecting so the driver can adjust its DMA transfer size.


- Paul
--155748971-1786668121-1327348134=:29673--
