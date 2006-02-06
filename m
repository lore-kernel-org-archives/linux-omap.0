From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAPFB_FILLRECT and friends
Date: Mon, 6 Feb 2006 07:36:55 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5042DCC28@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>, ext Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> $ git checkout -b <branch> <commit id>
>=20
> > Was this stuff once there and later removed (it
> > doesn't seem to be in tip of tree) and if so, why?
>=20
> Yes, I removed it because later performance testing showed no
> improvement whatsoever when using DMA for SDRAM - SDRAM transfers
> compared to using MPU bursts.
>=20
> Being a dead code I didn't see any reason leaving it in the driver.

Generally unless the MPU overhead is high, using DMA usually drops the
CPU load even if the performance is equivalent.  Ideally test runs
capturing raw throughput, cpu load, and power usage would happen along
with such tweaks.  The results may vary across CPUs as internals are not
all equal even though the register set may be close.

Regards,
Richard W.
