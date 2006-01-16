From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] Palm TE Touchscreen and fixes
Date: Mon, 16 Jan 2006 17:41:50 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A503E44775@dlee02.ent.ti.com>
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
To: andrzej zaborowski <balrogg@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The 310 shouldn't have a DSP, however early chips may have had one (1510
perhaps with a mask tweak).

Regards,
Richard W.
=20
> Hi there,
>=20
> > Regarding changes to clock.[ch], we should have CLOCK_IN_OMAP1510
and
> > CLOCK_IN_OMAP3XX separate. At least the DSP clocks should not be on
310
> > because it does not have a DSP AFAIK. They may be also other clocks
that
> > are not on 310.
> >
> > Could you please redo the clock.[ch] patch so it adds
CLOCK_IN_OMAP3XX,
> > and masks it only for the clocks you think you have on 310?
> >
> > Or if you don't know which clocks are on both 310 and 1510, you
could
> > just leave out DSP clocks for now, and enable all other 1510 clocks
> > also for 310.
>=20
> Indeed, I don't know which clocks are there and I don't know if the
> board has a DSP or not. There is no real documentation for OMAP310
> publicly availiable. The product page
>
(http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId
=3D6
> 123&navigationId=3D11997&path=3Dtemplatedata/cm/product/data/omap_310)
> doesn't mention DSP, except the line
> "Digital Phase-Locked Loop (DPLL) for MPU/DSP/TC Clocking Control",
> however it is said that OMAP310 is similar to OMAP5910
> (http://focus.ti.com/docs/prod/folders/print/omap5910.html) which is
> fully documented and this one definitely has a DSP.
> After disabling the DSP related clocks and the DSP initialisation,
> McBSP fails to initialise with the message: "mcbsp: could not acquire
> dsp_ck handle", nevertheless the kernel still boots and everything
> works fine. (It feels bad not knowing what's inside your computer.)
> I'm attaching the same patch but with CLOCK_IN_OMAP1510 and
> CLOCK_IN_OMAP310 separate and everything DSP-related turned off.
> Regards,
> --
> balrog 2oo6
>=20
> Dear Outlook users: Please remove me from your address books
> http://www.newsforge.com/article.pl?sid=3D03/08/21/143258
