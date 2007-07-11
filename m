From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Help with McBSP of OSK 5912
Date: Wed, 11 Jul 2007 14:20:55 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701502CBE@dlee13.ent.ti.com>
References: <ae36f8040707111158s39061553ybb964d3aecd76a76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <ae36f8040707111158s39061553ybb964d3aecd76a76@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?iso-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>
>Please I need some help. I  want to use the McBSP2 of OMAP 5912 to =
connect
>an ADC and communicate with it. I found some dificulty in configurate =
the
>McBSP2 port please someone could help me ?
>The struct that must be set to configure McBSP is the following:
>static struct omap_mcbsp_reg_cfg initial_config =3D
>{
>    .spcr2 =3D 0xffff,
>    .spcr1 =3D 0xffff,
>    .rcr2  =3D RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8)
>|RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
>    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_8) | =
RWDLEN1(OMAP_MCBSP_WORD_16),
>    .xcr2  =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
>XWDLEN2(OMAP_MCBSP_WORD_16) |XDATDLY(0) |
>             XFIG,
>    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_8) | =
XWDLEN1(OMAP_MCBSP_WORD_16),
>    .srgr1 =3D 0xffff,
>    .srgr2 =3D GSYNC | CLKSP | FSGM | 0xffff,
>    .pcr0  =3D RIOEN,
>};
>
>
>I want ot use the McBSP2 Pins (six pins available on osk 5912 dev kit) =
but
>CLKR I want to use as general purpose I/O that is it.
>Thanks.
>

You should set FUNC_MUX_CTRL registers to configure McBSP2.clkr as GPIO =
pin. Along with this if you also need Full duplex transfer then I think =
you have to put McBSP2 as Master and audio codec as slave. Then generate =
Clkr from Sampling rate generator instead of Audio codec.=20

Regards,
Khasim
