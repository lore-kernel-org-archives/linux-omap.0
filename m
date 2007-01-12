From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Processing of command line mem=32M
Date: Fri, 12 Jan 2007 12:38:43 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50956BDB1@dlee02.ent.ti.com>
References: <ae36f8040701120820sbfbff61jeeaf10d73b387265@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <ae36f8040701120820sbfbff61jeeaf10d73b387265@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>, Raghunandan Dhongadi <dk.raghu@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Yes, what you said is true but not his point.

If he gives the command argument mem=3Dxyz the system does not boot.  =
This is because of an off by one in a call to an mcr which generates a =
fatal error.

Regards,
Richard W.

> It looks simple, allocate all memory normally to ARM during boot, in
> execution time make an MMAP in DSPGateway in 64 Mb, and that is, a 64 =
Mb
> of
> area to DSP, that could be accessed by ARM too.
>=20
> On 1/12/07, Raghunandan Dhongadi <dk.raghu@gmail.com> wrote:
> >
> > Hello All,
> >
> > I have Linux kernel 2.6.14-7 for OMAP2430 SDP board. The SDP has =
128MB
> > of SDRAM memory. I want to share the 128MB into 64MB for ARM core =
and
> > 64MB for DSP core.
> > I am giving the kernel command line parameter "mem=3D64M" but with =
this
> > the boot process
> > stops at "Uncompressing Kernel".
> >
> > But if I give a minimum of "mem=3D113M" it boots fine. Wanted to =
know
> > where does the processing of command line parameters happen and what
> > could be the issue ?
> >
> > Warm Regards,
> > Raghu
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>=20
>=20
>=20
> --
> =
-------------------------------------------------------------------------=
-
> ----
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS
> Electrical Engineer Faculty
> Ipiranga Avenue, 6681 - Building 30
> P.O. Box: 90619-900 - Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> =
-------------------------------------------------------------------------=
-
> -------
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
