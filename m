From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: new PRCM breakage: 2430 FB
Date: Mon, 11 Jun 2007 22:58:30 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429012C43D6@dlee13.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011217D9@dlee13.ent.ti.com><46689339.5000304@mvista.com>
	<Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> > omapfb omapfb: soft reset failed
> >
> > omapfb omapfb: controller initialization failed (-19)
>=20
> Hi Kevin,
>=20
> the 'soft reset failed' message is coming from
> drivers/video/omap/dispc.c:1391.
>=20
> The only PRCM-related code near that function is the display clock
> enable code, which, as Khasim mentioned, uses dss_ick, dss1_fck, and
> dss_54m_fck.  I just went back and checked the PRCM changes for those
> three clocks and omap2_clk_enable(), and they look good.

The 2420 usually gives something like that for DSS.

If you just look at the IDLST bit it won't show accessible.  The DSS is =
supposed to be a combination initiator/target.  However the target side =
is not internally hooked up.

The status bit won't show proper status unless the DSS initiator is out =
of mute.  I've found a write to the OCP wrapper will result in it coming =
to life.  This was one of the exceptions when compared to other modules. =
 There is a deterministic wait time which can be applied after turning =
on clocks.

Generally, after sleep you apply this, and then do the write to wake.  =
If you do a read you will get an abort.

Regards,
Richard W.
