From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: Help regarding X-loader
Date: Wed, 20 Jun 2007 10:48:32 +0530
Message-ID: <0A50DBE80DD6674E94F7269DC964A7B6093EA3@dbde01.ent.ti.com>
References: <c656a4d20706192214g15dc9a58le65053fa6aa9625@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20706192214g15dc9a58le65053fa6aa9625@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: arun c <arun.edarath@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Arun,

 Whether you use X-loader or u-boot, and whether you use NOR flash or
NAND flash, you may need to typically adapt the SDRC setup to match the
POP memory you have on your system.

Regards,
Sriram.

=20

> -----Original Message---
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of arun c
> Sent: Wednesday, June 20, 2007 2:15 PM
> To: Linux-omap-open-source@linux.omap.com
> Subject: Re: Help regarding X-loader
>=20
> Hi all,
>=20
> Sriram thank you very much for the reply. I got a breif idea.
>=20
> I found X-loader source code in linux.omap.com for omap2430SDP.
> My board is having a processor with pop memory.
>=20
> can i directly use this x-loder for my board with out any
> modifications?
>=20
> Thanks in advance
> Arun
>=20
>=20
> On 6/20/07, Sriram, Kannan <ksriram@ti.com> wrote:
> >
> > Arun,
> >
> >  You need the X-loader only in case of a NAND based system. For NOR
> > flash based systems, you don't need an X-loader.
> >
> >  The X-loader is typically a "pre-boot" boot-loader, whose only job
is
> > to perform basic platform setup (clock setup, pin-muxing, and memory
> > configuration), and load the u-boot from NAND flash -> external
SDRAM.
> > This is because u-boot cannot do XIP on NAND based systems.
> >
> > Regards,
> > Sriram.
> >
> > > -----Original Message-----
> > > From: linux-omap-open-source-bounces@linux.omap.com
> > [mailto:linux-omap-
> > > open-source-bounces@linux.omap.com] On Behalf Of arun c
> > > Sent: Wednesday, June 20, 2007 1:50 PM
> > > To: linux-omap-open-source@linux.omap.com
> > > Subject: Help regarding X-loader
> > >
> > > Hi all,
> > >
> > > I am a new guy stepping into the world of porting.
> > >
> > > My aim is to port linux to omap2430SDP with pop memory processor
> > board.
> > > I want to use U-boot as my bootloader.But i came to know that it
> > > requires one more
> > > thing called X-loader. I don't understand why it need X-loader.
Does
> > > anybody here
> > > know the answer please help me. It will be very helpful if
somebody is
> > > giving me
> > > a brief description about the working of x-loader.
> > >
> > >
> > > Thanks in advance
> > > Arun
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
