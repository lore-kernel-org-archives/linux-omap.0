From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: McBSP 2 yet
Date: Tue, 16 Oct 2007 20:33:03 -0200
Message-ID: <ae36f8040710161533x2d4fad0amc4136a75ba6d287c@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
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

Please I have configured the McBSP to be an Master controller of devices, t=
o
read and write an ADC from texas (throw device driver).
But the problem is my McBSP registers seem to be correct, but there is no
signal in the pins what could it be ?
I made a simple modification int he code of mcbsp.c to test if it is the
problem, on line 295
I modified the code from
if (id =3D=3D OMAP_MCBSP1 || id =3D=3D OMAP_MCBSP3)
to
if (id =3D=3D OMAP_MCBSP1 || id =3D=3D OMAP_MCBSP2 || id =3D=3D OMAP_MCBSP3=
)

in function omap_mcbsp_request, to test if it is the problem, someone else
is using McBSP2 ?
Someone Make McBSP2 works without any modification ?
Someone could help ?
They want that I submit my device driver ? (maybe)
But it still not yet finished.
Someone could help, I'm insisting in this topic but this is important for m=
y
project I need to connect an ADC ADS8343B on McBSP2 to read and write in
this ADC.
Thanks for any Help.
My McBSP2 registers (again):
static struct omap_mcbsp_reg_cfg initial_config =3D
{
    .spcr1 =3D RRDY | RINTM(0),
    .spcr2 =3D XRDY | FREE | SOFT | FRST | XINTM(0) | XEMPTY,
    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_16) | RWDLEN1(OMAP_MCBSP_WORD_16),
    .rcr2  =3D RFRLEN2(OMAP_MCBSP_WORD_16) | RWDLEN2(OMAP_MCBSP_WORD_16) |
RDATDLY(0),
    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_16) | XWDLEN1(OMAP_MCBSP_WORD_16),
    .xcr2  =3D XFRLEN2(OMAP_MCBSP_WORD_16) | XWDLEN2(OMAP_MCBSP_WORD_16) |
XDATDLY(0),
    .srgr1 =3D CLKGDV(10) | FWID(16),
    .srgr2 =3D CLKSM | FPER(200),
    /* Slave CLKXP | CLKRP, */
    .pcr0  =3D FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP, /* Master
according board-osk.c */
};

this is working on a DSK DSP dev kit the strange is in OMAP it is not,
according my intern.
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
