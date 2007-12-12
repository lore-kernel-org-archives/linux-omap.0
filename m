From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: 2420 2.6 open source kernel + color space coversion
Date: Wed, 12 Dec 2007 14:27:30 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A00145384F@dbde01.ent.ti.com>
References: <BAY119-W828D01D8E6A90E786AAD7F9640@phx.gbl>
	<7EAD1AEEA7621C45899FE99123E124A001487F2F@dbde01.ent.ti.com>
	<BAY119-W42FAF389579D5EABC5DAF5F9650@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <BAY119-W42FAF389579D5EABC5DAF5F9650@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: k c <omap_mails@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Yes the registers and offsets are same

=20

Regards,

Khasim

=20

________________________________

From: k c [mailto:omap_mails@hotmail.com]=20
Sent: Wednesday, December 12, 2007 2:22 PM
To: Syed Mohammed, Khasim; linux-omap-open-source@linux.omap.com
Subject: RE: 2420 2.6 open source kernel + color space coversion

=20

I can assume all the DSS register offsets are same between 2420 and 2430 =
right ?
=20
Regards,
k c





________________________________


> Subject: RE: 2420 2.6 open source kernel + color space coversion
> Date: Tue, 11 Dec 2007 23:20:13 +0530
> From: khasim@ti.com
> To: omap_mails@hotmail.com; linux-omap-open-source@linux.omap.com
>=20
>=20
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> > open-source-bounces@linux.omap.com] On Behalf Of k c
> > Sent: Tuesday, December 11, 2007 9:43 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: 2420 2.6 open source kernel + color space coversion
> >=20
> > Hi,
> >=20
> > In the 2.6.9 open source kernel for OMAP2420 there is no support to =
set
> > the display controller color conversion on the video pipeline. There =
are
> > not IOCTL's implemented for this. The 2430 open source kernel has an =
IOCTL
> > VIDIOC_S_OMAP2_COLORCONV implemented in
> > ./drivers/media/video/omap/omap24xxvout.c.
> >=20
> > Can anyone let me know if I can find that support for OMAP2420 or do =
I
> > have to implement that myself.
> >=20
>=20
> If you are looking for 2430 kind of dss functionality, then =
unfortunately yes, you have to port the 2430 DSS drivers back.=20
>=20
> But, it's quite straight. Copy the following files
>=20
> drivers/media/video/omap24xxvout.c
> drivers/media/video/omap24xxvout.h
> drivers/media/video/omap24xxvoutdef.h
> drivers/video/omap/omap24xxfb.c
> drivers/video/omap/omap2_disp_out.c
> arch/arm/plat-omap/display.c to drivers/video/omap/display.c
> include/asm-arm/arch-omap/display.h
> include/asm-arm/arch-omap/venc.h
>=20
> Corresponding makefiles and Kconfigs have to be updated.
>=20
> Regards,
> Khasim



________________________________

Live the life in style with MSN Lifestyle. Check out! Try it now! =
<http://content.msn.co.in/Lifestyle/Default>=20
