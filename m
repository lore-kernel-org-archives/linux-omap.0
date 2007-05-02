From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Pending April patches
Date: Wed, 2 May 2007 13:00:15 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429E55356@dlee13.ent.ti.com>
References: <46374339.4030102@googlemail.com><20070502084714.4a23397d.jarkko.nikula@nokia.com><57314e840705012317m45e2d42y3120f2247393d8f7@mail.gmail.com><5d5443650705020134n55148159i4d30a35b12695a66@mail.gmail.com><57314e840705020149v194e4807j886a7efaa15f324@mail.gmail.com><5d5443650705020246v3e4427b9t9290d3e18de4ff4b@mail.gmail.com><57314e840705020407q4823911i508d7ad24da47302@mail.gmail.com>
	<20070502172108.GD3520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070502172108.GD3520@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Well the TI trees are also based on older snapshots of the linux-omap
tree.
>=20
> Ideally there would be only minimal lag between the linux-omap tree
and
> TI's product snapshot trees of course.

The root of all 2.6 trees is kernel.org, then linux-omap tree.  The TI
_downloadable_ trees branch off at a point in time as Tony said, usually
for pre/new-silicon or other major engagements which are not easily done
on the live tree.  Then beyond that you will have vendor trees like
MontaVista or WindRiver. These vendors combine aspects off all trees
into their final bundles. In cases I'm familiar with these final trees
are what go into production in multi-million quantities.

Depending on your _goals_ and _capabilities_ trees anywhere along the
line can be useful for you.

2.4 trees in production devices pre-date the omap-linux tree but
otherwise have a similar flow.

Regards,
Richard W.
