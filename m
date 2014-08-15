From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
Date: Fri, 15 Aug 2014 22:20:53 +0200
Message-ID: <53EE6BA5.2060101@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-6-git-send-email-bigeasy@linutronix.de> <20140815183731.GI17769@csclub.uwaterloo.ca> <53EE5F3F.2000707@linutronix.de> <20140815193352.GC17765@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140815193352.GC17765@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 08/15/2014 09:33 PM, Lennart Sorensen wrote:
>> On the other hand if you use DMA then it can handle transfers > 64by=
tes
>> in one go and you can start transfers while the FIFO is not complete=
ly
>> empty.
>=20
> You can dma more than the fifo size?

Yes. The UART asserts the DMA line as long as there is room for
$TRESHOLD number of bytes. So we never overflow the FIFO. That is why w=
e
can't take any DMA channel but only *the* one.

>> There is patch in Greg's tty tree already where you are able to
>> configure the RX trigger level. We could wire this up once we agree
>> which levels we want support. The OMAP supports all levels from 1=E2=
=80=A663.
>=20
> All? or just every 4 (that's what I just read in the DRA7xx docs).

All. Take a look at the RX_TRIGGER constant while comparing source vs
manual :)

Sebastian
