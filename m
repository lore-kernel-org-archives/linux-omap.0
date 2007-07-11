From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Help with McBSP of OSK 5912
Date: Wed, 11 Jul 2007 15:58:55 -0300
Message-ID: <ae36f8040707111158s39061553ybb964d3aecd76a76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Please I need some help. I  want to use the McBSP2 of OMAP 5912 to connect
an ADC and communicate with it. I found some dificulty in configurate the
McBSP2 port please someone could help me ?
The struct that must be set to configure McBSP is the following:
static struct omap_mcbsp_reg_cfg initial_config =3D
{
    .spcr2 =3D 0xffff,
    .spcr1 =3D 0xffff,
    .rcr2  =3D RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8)
|RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
    .xcr2  =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
XWDLEN2(OMAP_MCBSP_WORD_16) |XDATDLY(0) |
             XFIG,
    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
    .srgr1 =3D 0xffff,
    .srgr2 =3D GSYNC | CLKSP | FSGM | 0xffff,
    .pcr0  =3D RIOEN,
};


I want ot use the McBSP2 Pins (six pins available on osk 5912 dev kit) but
CLKR I want to use as general purpose I/O that is it.
Thanks.

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
