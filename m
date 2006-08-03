From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 3 Aug 2006 09:20:21 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506F16A6C@dlee02.ent.ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Tony,

> The reason I did not send h4 smc91x gpmc yet is that we should update
it
> to use gpmc_cs_set_timings() to have a nice example available for
> others :)

So your reasoning for not including was you want something perfect to
start with?  That bar seems a bit high especially when what is there is
broken. The below is pretty nice, I don't know that this approach works
for all parts which can be connected given the interface, but it should
work well for many.

In general I certainly favor having something which works, then evolving
it into something nicer.  This can result in cut and past proliferation;
however there are not that many boards.  Once one is done nicely the
others can be manually updated with out huge effort.  Which OMAP1 port
currently uses this style?  If it does at what point did it start doing
this (probably not the first pass)?

As far as 2420 vs. 2420POP vs. 2422 vs. 2423 unfortunately early chips
did not follow a common schema, later ones do, doing things which
captures them all can be messy.  The mechanism in the OMAP1 port was not
constructed to work with the multi-stage check which is now necessary.
This simple example highlights one basic issue.  The current level of
code sharing as the processors diverge can make it harder to add trivial
code with out breaking other ones.  This will slow the tree's adoption
of new chips.  It is hard to say what the sharing balance should be.  If
chips have a long lifetime then code sharing at the low level seems
pretty good, if they only live for a couple of years adding some extra
indirection and maintaining high levels of sharing in the old ones
starts to lose its value.  Production volume vendor time lines and their
compromises does force branching and fragmentation.  Perhaps one tree
can not and should not meet all needs.  Keeping high level interface
compatibly is really good the level of low level can be less.

One measure might be I know of several vendors in production of OMAP2
chips for over a year using less well structured trees.  I don't think
the same can happen from this tree yet.  Now, those less well structured
trees many not have been able to exist with out a good branch off point
which this tree provides...  balance...

Thanks for the good work.
=20
> Could you try something like the sample code below for h4? You most
likely
> need to modify the values, but this is how Juha intended the gpmc
being
> used.
>=20
> static int __init smc91x_set_async_mode(int cs)
> {
> 	struct gpmc_timings t;
> 	u32 reg;
>=20
> 	memset(&t, 0, sizeof(t));
> 	t.sync_clk =3D 0;
> 	t.cs_on =3D 0;
> 	t.adv_on =3D gpmc_round_ns_to_ticks(1);
>=20
> 	/* Read */
> 	t.adv_rd_off =3D t.adv_on + gpmc_round_ns_to_ticks(7);
> 	t.oe_on =3D t.adv_rd_off + gpmc_round_ns_to_ticks(1);
> 	t.access =3D t.oe_on + gpmc_round_ns_to_ticks(1);
> 	t.oe_off =3D t.access + gpmc_round_ns_to_ticks(1);
> 	t.cs_rd_off =3D t.oe_off;
> 	t.rd_cycle =3D t.cs_rd_off + gpmc_round_ns_to_ticks(1);
>=20
> 	/* Write */
> 	t.adv_wr_off =3D t.adv_on + gpmc_round_ns_to_ticks(7);
> 	t.we_on =3D t.adv_wr_off + gpmc_round_ns_to_ticks(1);
> 	t.we_off =3D t.we_on + gpmc_round_ns_to_ticks(1);
> 	t.cs_wr_off =3D t.we_off + gpmc_round_ns_to_ticks(1);
> 	t.wr_cycle =3D t.cs_wr_off + gpmc_round_ns_to_ticks(1);
>=20
> 	reg =3D	GPMC_CONFIG1_PAGE_LEN(2) |
> 		GPMC_CONFIG1_WAIT_READ_MON |
> 		GPMC_CONFIG1_WAIT_WRITE_MON |
> 		GPMC_CONFIG1_WAIT_PIN_SEL(2) |
> 		GPMC_CONFIG1_READTYPE_ASYNC |
> 		GPMC_CONFIG1_WRITETYPE_ASYNC |
> 		GPMC_CONFIG1_DEVICESIZE_16 |
> 		GPMC_CONFIG1_DEVICETYPE_NOR |
> 		GPMC_CONFIG1_MUXADDDATA;

Regards,
Richard W.
