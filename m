From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Re: Help with McBSP of OSK 5912
Date: Wed, 11 Jul 2007 22:41:02 -0300
Message-ID: <ae36f8040707111841l40c841f6q222dab011027f4b0@mail.gmail.com>
References: <ae36f8040707111158s39061553ybb964d3aecd76a76@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C4701502CBE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701502CBE@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

wow wait I dont wanna use an audio device just an ADC ADS8343, i want to us=
e
CLKR as GPIO and others pins as McBSP normally but where could I found a
matrix configuration of which values set in each  one of the registers ?

On 7/11/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> >
> >Please I need some help. I  want to use the McBSP2 of OMAP 5912 to
> connect
> >an ADC and communicate with it. I found some dificulty in configurate th=
e
> >McBSP2 port please someone could help me ?
> >The struct that must be set to configure McBSP is the following:
> >static struct omap_mcbsp_reg_cfg initial_config =3D
> >{
> >    .spcr2 =3D 0xffff,
> >    .spcr1 =3D 0xffff,
> >    .rcr2  =3D RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8)
> >|RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
> >    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
> >    .xcr2  =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
> >XWDLEN2(OMAP_MCBSP_WORD_16) |XDATDLY(0) |
> >             XFIG,
> >    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
> >    .srgr1 =3D 0xffff,
> >    .srgr2 =3D GSYNC | CLKSP | FSGM | 0xffff,
> >    .pcr0  =3D RIOEN,
> >};
> >
> >
> >I want ot use the McBSP2 Pins (six pins available on osk 5912 dev kit)
> but
> >CLKR I want to use as general purpose I/O that is it.
> >Thanks.
> >
>
> You should set FUNC_MUX_CTRL registers to configure McBSP2.clkr as GPIO
> pin. Along with this if you also need Full duplex transfer then I think y=
ou
> have to put McBSP2 as Master and audio codec as slave. Then generate Clkr
> from Sampling rate generator instead of Audio codec.
>
> Regards,
> Khasim
>
>
>
>


--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
