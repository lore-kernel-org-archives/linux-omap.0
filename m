From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap-serial RX DMA polling?
Date: Mon, 23 Jan 2012 03:47:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com> <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-781067979-1327315643=:29673"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36277 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab2AWKrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 05:47:24 -0500
In-Reply-To: <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: govindraj.raja@ti.com, khilman@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-781067979-1327315643=:29673
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Jan 2012, Govindraj wrote:

> On Mon, Jan 23, 2012 at 6:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > while trying to track down some of the serial-related PM issues in
> > v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 microsecond
> > polling timer when DMA is enabled (uart_dma.rx_timer) (!) =A0This seems
> > quite broken from both the DMA and PM points of view.
>=20
> Poll rate is used for doing tty_insert_flip_string for pushing data to=20
> user space to keep faster response to any client device over uart, some=
=20
> Bt chips expect faster response when data on uart arrives and packet=20
> should be pushed out immediately.

Hmm.  Let's say that the BT transceiver uses the fastest transmission rate=
=20
supported by the OMAP UARTs -- 3,686,400 bits per second, according to=20
Table 17-1 in the 34xx TRM vZR.  So the RX poll timer would go off about=20
~2.7 times per input character[1].  That seems like overkill...

For minimum receive latency, how about calling tty_insert_flip_string()=20
from the RX DMA callback, and using a smaller transfer count?  Or even=20
better, use PIO for the receive path and set the RX FIFO threshold to 1?

No poll timer should be needed in either case.


- Paul

1. At 10 line bits per character (start + byte + stop), each character=20
should take about 2.7 microseconds to transfer (the reciprocal of (3 686=20
400 line bits per second / 10 line bits per character / 1 000 000=20
microseconds per second)).

--155748971-781067979-1327315643=:29673--
