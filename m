From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: omap clock.h question
Date: Tue, 7 Feb 2006 16:57:58 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A504365C2E@dlee02.ent.ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> * Woodruff, Richard <r-woodruff2@ti.com> [060207 14:07]:
> > > I believe he meant just to hide the clock number for mmc 1 or 2.
But I
> > > guess we still need to have different naming for omap1 and omap2.
> >
> > Like I was saying you could hide both the slot and the names.
> >
> >  for(i=3Ddata.slot[slot].num_clks; i>0; i--)
> >  {
> > 	ck =3D clk_get(data.slot.clk_name[i-1])
> > 	if(ck !=3D NULL)
> > 	clk_enabl(ck);
> >  }
> >
> > That way we don't care the name or how many.  It gets rid of some if
> > statements anyway.
>=20
> But one of the clocks can be off more often than the other from PM
point
> of view.

Perhaps, but probably not for OMAP2.  The I clocks and the F clock
enables are local to the module. Enabling an F or an I clock doesn't
mean the parent which supplies it is active. It will open up a gate of
sorts and raise a clock request.  If that parent source is running then
it can propagate into the functional block.

I don't think OMAP1 does it quite like this.  The source clock doesn't
have the module level gating. =20

Seems like in theory you and run some modules with their I clock off and
the F clock on, though I doubt you would do it much in practice.  You
can just set your I clock to auto idle and it will raise and lower its
clock request automatically as needed, effectively doing the same.

Regards,
Richard W.
