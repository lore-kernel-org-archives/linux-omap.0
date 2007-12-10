From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Sun, 9 Dec 2007 21:34:23 -0800
Message-ID: <200712092134.23712.david-b@pacbell.net>
References: <5573C19A4BBDB441BED2A44157E9705302A4C387@dlee12.ent.ti.com>
	<200711231226.44592.david-b@pacbell.net>
	<5573C19A4BBDB441BED2A44157E9705302C29F01@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5573C19A4BBDB441BED2A44157E9705302C29F01@dlee12.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 07 December 2007, Hunter, Jon wrote:
> ep1in (hw1): 1buf dma, csr b404 maxp 0200

That's the same for both UDP and TCP cases:

  8000 - AutoSet TxPktRdy after loading a complete packet
  2000 - Mode TX (probably irrelevant here)
  1000 - DMAReqEnab
  0400 - DMAReqMode 1 (vs 0)
  0004 - Underrun ... got IN packet with empty fifo

And the queues are sitting there with packets marked as
having transmitted no bits.

That underrun bit looks suspicious.  ISTR having issues
with it before; it's stupid, there's basically no point
in the hardware even reporting such a routine case (no
sane driver could afford to care about it); it's only
there to cause trouble.

Understanding that the x430 uses Mentor's DMA engine
and that code has AFAIK not been stressed ... maybe it
has to learn more about how to ignore bogus faults.

I don't see signs of the 0080 Incomptx bit being set.


> ep1out (hw1): 1buf dma, csr 2003 maxp 0200
>=A0=A0=A0=A0=A0=A0=A0=A0req c1e9a8e0, 512/1536

Again, same for UDP and TCP.

 0200 - DmaReqEnab (note gratuitous difference from TX side)
 0002 - FifoFull
 0001 - RxPktRdy

There what's odd is that nothing seems to have emptied the
FIFO.  I've not looked at the Mentor DMA engine, but I'd kind
of hope that it's more sane than CPPI ... so that one could
let it offload entire IEEE 802 packets without needing to
wake up the CPU after each packet.

You did say the issue was on the TX side, not the RX side?
The "obvious problem" here is on the RX side, not TX...

- Dave
