From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [RFC/PATCH  1/4] MMC/SD Controller driver for OMAP2430
Date: Sat, 8 Dec 2007 21:18:45 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A00145327D@dbde01.ent.ti.com>
References: <003601c838d6$c451c870$fe8818ac@ent.ti.com>
	<47595E6E.3000503@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <47595E6E.3000503@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, Pierre Ossman <drzeus@drzeus.cx>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Carlos Aguiar
> Sent: Friday, December 07, 2007 8:24 PM
> To: Chikkature Rajashekar, Madhusudhan
> Cc: linux-omap@vger.kernel.org; linux-omap-open-source@linux.omap.com;
> linux-arm-kernel@lists.arm.linux.org.uk; 'Pierre Ossman'
> Subject: Re: [RFC/PATCH 1/4] MMC/SD Controller driver for OMAP2430
>=20
> ext Madhusudhan Chikkature Rajashekar wrote:
> > This patch adds MMC controller driver for OMAP2430/3430.
> >
> > Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> >
> > ---
> >  drivers/mmc/host/Makefile     |    9
> >  drivers/mmc/host/omap_hsmmc.c |  985
> ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 993 insertions(+), 1 deletion(-)
> >
> > Index: linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

<snip>

> >
> Hi Madhu,
>=20
> I'd rather see this code using multislot structures and omap.c instead
> of defining a whole new codebase for omap2430 and/or omap3.
>=20
> BR,
>=20
> Carlos.
>=20
>=20
Hi Carlos,

Thanks for comments.

I remember we had discussed this before as well, as communicated before =
the MMC/SD controller on OMAP2430 and 3430 processors is completely =
different( in Register width, bits, offsets, configuration etc) from =
OMAP2420 and OMAP1 platforms. It's not recommended to add new MMC =
controller functionality to existing omap.c.=20

Yes we will definitely use multi-slot structures. We can add multi-slot =
support after we get formal approval of this code base.

Thanks & Regards,
Khasim
