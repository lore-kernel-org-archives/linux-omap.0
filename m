From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: Help with McBSP of OSK 5912
Date: Wed, 11 Jul 2007 21:35:22 -0500
Message-ID: <D2AA76D761FD63448DAD827F5671A739115054@dlee16.ent.ti.com>
References: <ae36f8040707111158s39061553ybb964d3aecd76a76@mail.gmail.com><9C23CDD79DA20A479D4615857B2E2C4701502CBE@dlee13.ent.ti.com>
	<ae36f8040707111841l40c841f6q222dab011027f4b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

=20
http://www.ti.com/litv/pdf/spru752c =
<http://www.ti.com/litv/pdf/spru752c>=20
=20
See table 10 and onwards to find out the pin configuration info.
=20
 Cheers,
 Ishigami

________________________________

From: Lu=EDs Vit=F3rio Cargnini [mailto:lvcargnini@ieee.org]
Sent: Wed 7/11/2007 18:41
To: Syed Mohammed, Khasim
Cc: OMAP
Subject: Re: Help with McBSP of OSK 5912



wow wait I dont wanna use an audio device just an ADC ADS8343, i want to =
use
CLKR as GPIO and others pins as McBSP normally but where could I found a
matrix configuration of which values set in each  one of the registers ?

On 7/11/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> >
> >Please I need some help. I  want to use the McBSP2 of OMAP 5912 to
> connect
> >an ADC and communicate with it. I found some dificulty in configurate =
the
> >McBSP2 port please someone could help me ?
> >The struct that must be set to configure McBSP is the following:
> >static struct omap_mcbsp_reg_cfg initial_config =3D
> >{
> >    .spcr2 =3D 0xffff,
> >    .spcr1 =3D 0xffff,
> >    .rcr2  =3D RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8)
> >|RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
> >    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_8) | =
RWDLEN1(OMAP_MCBSP_WORD_16),
> >    .xcr2  =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
> >XWDLEN2(OMAP_MCBSP_WORD_16) |XDATDLY(0) |
> >             XFIG,
> >    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_8) | =
XWDLEN1(OMAP_MCBSP_WORD_16),
> >    .srgr1 =3D 0xffff,
> >    .srgr2 =3D GSYNC | CLKSP | FSGM | 0xffff,
> >    .pcr0  =3D RIOEN,
> >};
> >
> >
> >I want ot use the McBSP2 Pins (six pins available on osk 5912 dev =
kit)
> but
> >CLKR I want to use as general purpose I/O that is it.
> >Thanks.
> >
>
> You should set FUNC_MUX_CTRL registers to configure McBSP2.clkr as =
GPIO
> pin. Along with this if you also need Full duplex transfer then I =
think you
> have to put McBSP2 as Master and audio codec as slave. Then generate =
Clkr
> from Sampling rate generator instead of Audio codec.
>
> Regards,
> Khasim
>
>
>
>


--
-------------------------------------------------------------------------=
-----
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 - Building 30
P.O. Box: 90619-900 - Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
-------------------------------------------------------------------------=
--------
