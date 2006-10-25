From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/4] PalmZ71 - OMAP310 Clocks
Date: Wed, 25 Oct 2006 14:38:35 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5084E3C9C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
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
To: Tony Lindgren <tony@atomide.com>, =?iso-8859-2?Q?Marek_Va=B9ut?= <marek.vasut@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

A real OMAP310 does not have a DSP.  Some early 1510s may have been sold =
as 310s.=20

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Tony Lindgren
> Sent: Wednesday, October 25, 2006 1:08 PM
> To: Marek Va=B9ut
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: [PATCH 1/4] PalmZ71 - OMAP310 Clocks
>=20
> * Marek Va=B9ut <marek.vasut@gmail.com> [061024 18:22]:
> > Hi,
> > this patch enables some clock on omap310.
>=20
> > diff -Naur linux-omap/arch/arm/mach-omap1/clock.h linux-omap-
> z71/arch/arm/mach-omap1/clock.h
> > --- linux-omap/arch/arm/mach-omap1/clock.h	2006-10-15
> 16:09:10.000000000 +0200
> > +++ linux-omap-z71/arch/arm/mach-omap1/clock.h	2006-10-20
> 21:56:49.000000000 +0200
> > @@ -282,7 +282,7 @@
> >  static struct clk dsp_ck =3D {
> >  	.name		=3D "dsp_ck",
> >  	.parent		=3D &ck_dpll1,
> > -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> > +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
> CLOCK_IN_OMAP16XX |
> >  			  RATE_CKCTL,
> >  	.enable_reg	=3D (void __iomem *)ARM_CKCTL,
> >  	.enable_bit	=3D EN_DSPCK,
> > @@ -295,7 +295,7 @@
> >  static struct clk dspmmu_ck =3D {
> >  	.name		=3D "dspmmu_ck",
> >  	.parent		=3D &ck_dpll1,
> > -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> > +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
> CLOCK_IN_OMAP16XX |
> >  			  RATE_CKCTL | ALWAYS_ENABLED,
> >  	.rate_offset	=3D CKCTL_DSPMMUDIV_OFFSET,
> >  	.recalc		=3D &omap1_ckctl_recalc,
> > @@ -306,7 +306,7 @@
> >  static struct clk dspper_ck =3D {
> >  	.name		=3D "dspper_ck",
> >  	.parent		=3D &ck_dpll1,
> > -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> > +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
> CLOCK_IN_OMAP16XX |
> >  			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
> >  	.enable_reg	=3D (void __iomem *)DSP_IDLECT2,
> >  	.enable_bit	=3D EN_PERCK,
> > @@ -320,7 +320,7 @@
> >  static struct clk dspxor_ck =3D {
> >  	.name		=3D "dspxor_ck",
> >  	.parent		=3D &ck_ref,
> > -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> > +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
> CLOCK_IN_OMAP16XX |
> >  			  VIRTUAL_IO_ADDRESS,
> >  	.enable_reg	=3D (void __iomem *)DSP_IDLECT2,
> >  	.enable_bit	=3D EN_XORPCK,
> > @@ -332,7 +332,7 @@
> >  static struct clk dsptim_ck =3D {
> >  	.name		=3D "dsptim_ck",
> >  	.parent		=3D &ck_ref,
> > -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> > +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
> CLOCK_IN_OMAP16XX |
> >  			  VIRTUAL_IO_ADDRESS,
> >  	.enable_reg	=3D (void __iomem *)DSP_IDLECT2,
> >  	.enable_bit	=3D EN_DSPTIMCK,
> > @@ -374,7 +374,7 @@
> >
> >  static struct clk tipb_ck =3D {
> >  	/* No-idle controlled by "tc_ck" */
> > -	.name		=3D "tibp_ck",
> > +	.name		=3D "tipb_ck",
> >  	.parent		=3D &tc_ck.clk,
> >  	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
> >  			  ALWAYS_ENABLED,
> > @@ -733,7 +733,7 @@
> >  static struct clk i2c_fck =3D {
> >  	.name		=3D "i2c_fck",
> >  	.id		=3D 1,
> > -	.flags		=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
> > +	.flags		=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
> CLOCK_IN_OMAP16XX |
> >  			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
> >  			  ALWAYS_ENABLED,
> >  	.parent		=3D &armxor_ck.clk,
>=20
> Hmm, I thought 310 did not have a DSP? Or is it only 710 that does not
> have a DSP?
>=20
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
