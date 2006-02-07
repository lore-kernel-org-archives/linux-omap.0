From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAPFB_FILLRECT and friends
Date: Tue, 7 Feb 2006 07:57:44 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A504365210@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >  Ideally test runs
> > capturing raw throughput, cpu load, and power usage would happen
along
> > with such tweaks.
> >  The results may vary across CPUs as internals are not
> > all equal even though the register set may be close.
>=20
> I've made the measurements on OMAP1610/1710 platforms. What I wanted
to
> see is that using the DMA will indeed offload the MPU. In reality the
> MPU was practically stalled, I assume because of SDRAM or system
> bandwidth limitation and the fact the we have a cache flush between
> context switches.

2420 and 2430 have much greater bandwidth though the L3 interconnects to
the DDR (16/17xx < 2420 < 2430 in this regard).  And v6 doesn't flush
caches nearly as much so many of these effects are gone.

At preset on OMAP2 we do make test runs which measure throughput, cpu
load, and power per device.  I think in all cases we have measured the
expected reduced cpu load when the DMA portion was enabled (but not
always performance given the speed of the peripheral).=20

I would expect this code to be useful in OMAP2 for sure.

Regards,
Richard W.
