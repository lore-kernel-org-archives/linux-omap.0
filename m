From: Hingkwan Huen <hkh@cypress.com>
Subject: RE: Building kenel error
Date: Fri, 18 Aug 2006 09:24:52 -0700
Message-ID: <1155918292.2949.25.camel@localhost.localdomain>
References: <EA12F909C0431D458B9D18A176BEE4A5072DA5F6@dlee02.ent.ti.com>
Reply-To: hkh@cypress.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5072DA5F6@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Richard,
I never had success of using gcc-4.0.2 and later on 2.6.16/17 kernel. So
I just stick with the older gcc-3.4.1. Which version of tool chain are
you using for 2.6.16 or 2.6.17 kernel? Any advantages of using the later
version of the compiler?
Thanks,
kwan

On Fri, 2006-08-18 at 07:04 -0500, Woodruff, Richard wrote:
> That kernel is too old to be built on the latest compiler.  It will lik=
ely build with out incident with a 3.4.x compiler or earlier.  The main k=
ernel will have a number of patches which makes it go using a 4.x compile=
r.  These would need to be back ported in order to use that tool chain.
>=20
> Regards,
> Richard W.
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-oma=
p-
> > open-source-bounces@linux.omap.com] On Behalf Of kabbin
> > Sent: Friday, August 18, 2006 4:19 AM
> > To: Linux-omap-open-source@linux.omap.com
> > Subject: Building kenel error
> >=20
> >=20
> > Dear all:
> >   I use arm-linux-gcc-4.0.2-glibc-2.3.6 to build linux kernel from
> > http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-
> > omap2430.tgz
> >=20
> > # make clean
> > # make omap_h4_2420_defconfig
> > # make uImage
> >=20
> > and I got :
> > arch/arm/mach-omap2/clock24xx.c: In function =EE=A5=96'clk_safe':
> > arch/arm/mach-omap2/clock24xx.c:1365: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1366: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1370: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1371: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1378: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1379: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1383: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1384: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1388: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1392: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1396: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1397: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1401: error: case label does not redu=
ce to
> > an integer constant
> > arch/arm/mach-omap2/clock24xx.c:1402: error: case label does not redu=
ce to
> > an integer constant
> > make[1]: *** [arch/arm/mach-omap2/clock24xx.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> >=20
> >=20
> > Is this a well-known bug? And do I need to find a patch for it?
> > Thanks for your help.
> > BEST REGARDS.
> >=20
> >=20
> > ___________________________________________________
> >  =E6=9C=80=E6=96=B0=E7=89=88 Yahoo!=E5=A5=87=E6=91=A9=E5=8D=B3=E6=99=82=
=E9=80=9A=E8=A8=8A 7.0=EF=BC=8C=E5=85=8D=E8=B2=BB=E7=B6=B2=E8=B7=AF=E9=9B=
=BB=E8=A9=B1=E4=BB=BB=E4=BD=A0=E6=89=93=EF=BC=81
> >  http://messenger.yahoo.com.tw/
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
