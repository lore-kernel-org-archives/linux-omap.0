From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: deleting bootcmd boot argument
Date: Thu, 13 Jul 2006 04:15:46 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506945945@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Sanjiv Malik <sanjiv@faith.co.jp>, Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Ok.  I am currently away from my board so I can't test myself.

One way around this is if you corrupt your u-boot environment space.  If
its CRC comes up bad it will use a built in one which by default doesn't
auto boot.

Current 2430 u-boots use the first two sectors for u-boot and the third
sector for u-boot environment.  You should be able to use your Linux
level MTD access to whack the environment partition.  From there you
will have control again.

Also, I would think the CSSD flash burning facility could be used to do
the same thing.  Just specify the address of the 3d sector and write
some junk over the environment.

Regards,
Richard W.

> -----Original Message-----
> From: Sanjiv Malik [mailto:sanjiv@faith.co.jp]
> Sent: Thursday, July 13, 2006 1:27 PM
> To: Woodruff, Richard; Linux OMAP Open Source
> Subject: Re: deleting bootcmd boot argument
>=20
> Hello Richard,
>    Thanks for your email.
>    I tried the following steps as written by you. But still the kernel
is
> getting booted automatically. Iam not getting a u-boot prompt.
>=20
>    Currently iam connecting the OMAP 2430 board with the PC using a
serial
> (RS232 ) cable.
>=20
>    Iam using the Tera Term to send the messages to the OMAP board
through
> the PC.
>=20
>    I hold the space bar button of the UART console down (i.e. space
bar
> button on the PC ) as the  Tera Term is running on my PC. I reset the
> board,
> but still the kernel is getting booted automatically.
>=20
> Whether the above steps which iam following is correct??
> Can you mail me the proper steps??
>=20
> Thanks in advace
> Sanjiv
>=20
>=20
>=20
>=20
>=20
> ----- Original Message -----
> From: "Woodruff, Richard" <r-woodruff2@ti.com>
> To: "Sanjiv Malik" <sanjiv@faith.co.jp>; "Linux OMAP Open Source"
> <linux-omap-open-source@linux.omap.com>
> Sent: Thursday, July 13, 2006 4:37 PM
> Subject: RE: deleting bootcmd boot argument
>=20
>=20
> Hold your UART console space bar down and reset the board.  It should
> break you to a u-boot prompt.
>=20
> U-boot can be configured such that any key breaks it out, this is the
> default, or so a specific sequence of input data is required to break
> the boot process.
>=20
> If you have the space enabling the hush parser is quite good in that
you
> can really specify useful scripts to do all kinds of neat things in
this
> area.
>=20
> Regards,
> Richard W.
>=20
> > -----Original Message-----
> > From:
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
> >
>
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.co=
m
> ]
> > On Behalf Of Sanjiv Malik
> > Sent: Thursday, July 13, 2006 12:24 PM
> > To: Linux OMAP Open Source
> > Subject: deleting bootcmd boot argument
> >
> > Hello friends,
> >
> >      Currently iam facing with a problem on OMAP 2430.
> >
> >     The problem is as follows:
> >
> >     - I have set the u-boot environment variable "bootcmd" with the
> > booting
> >       address of Kernel from flash
> >         i.e. setenv bootcmd bootm 0x04060000.
> >     - I have also set one more u-boot environment variable
"bootdelay"
> to
> > 0
> >         i.e. set bootdelay 0
> >
> >     Due to these settings as soon as the board is switched ON, the
> linux
> > kernel from flash address is getting booted automatically through
> U-boot.
> >
> >     Now, iam not able to boot the linux kernel from TFTP server.
> >     Even iam not able to set the following TFTP boot arguments:
> >      i.e. setenv bootargs
> >           set server ip
> >      because the kernel from flash gets booted automatically.
> >
> >     Now, i wanna delete the bootcmd environment variable. May i know
> how
> > can
> > i delete it so that i can set these TFTP boot arguments??
> >
> >  Thanks in advance,
> >  Sanjiv
> >
> >
> >
> > ----- Original Message -----
> > From: "Mouhammad Tayseer Alquoatli" <idoit.ief@gmail.com>
> > To: "naga rajan" <nagubk82@gmail.com>
> > Cc: "Linux OMAP Open Source" <linux-omap-open-source@linux.omap.com>
> > Sent: Thursday, July 13, 2006 3:16 PM
> > Subject: Re: Flash recovery-regards
> >
> >
> > > On 7/13/06, naga rajan <nagubk82@gmail.com> wrote:
> > >>
> > >> Hi all,
> > >>
> > >>        I have a OSK5912 Revision D board. The u-boot in the flash
> got
> > >> corrupted.I like to regain the u-boot back to the flash. I tried
> with
> > OSK
> > >> flash recovery utility provided in "CE LINUX FORUM" but could not
> > >> download
> > >> the u-boot to the flash. Is there any contradiction between the
> board
> > >> revision and the flash recovery utility software?.
> > >>
> > >> Please provide a solution for this problem.
> > >
> > >
> > > Hi
> > > have you seen this:
> > > http://www.capgo.com/Resources/SoftwareDev/osk-newbie-guide.pdf
> > > one part is talking about installing a boot loader on a virgin
> system
> > > hope this helps
> > >
> > > Thanks in advance,
> > >> B.Nagarajan,
> > >> SANDS.
> > >> _______________________________________________
> > >> Linux-omap-open-source mailing list
> > >> Linux-omap-open-source@linux.omap.com
> > >> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > >>
> > >
> > >
> > >
> > > --
> > > Mouhammad Tayseer Alquoatli
> > > _______________________________________________
> > > Linux-omap-open-source mailing list
> > > Linux-omap-open-source@linux.omap.com
> > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > >
> >
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
