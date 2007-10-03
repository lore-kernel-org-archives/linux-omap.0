From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: McBSP 2 - the return
Date: Wed, 3 Oct 2007 17:19:31 -0300
Message-ID: <ae36f8040710031319l2415ad3am39e5f4b25a18e737@mail.gmail.com>
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

Dear fellows,
Please I want to use McBSP2, to conenct a device throw this interface, i
create a nw device driver but on my dev kit (OSK 5912) I'm not seen any
signal in the McBSP2 pins

my driver is doing all the following:
//McBSP Initialization
    //omap_mcbsp_set_io_type(ads8xxx_dev->adc_dev, OMAP_MCBSP_IRQ_IO);

    result =3D omap_mcbsp_request(ads8xxx_dev->adc_dev);
    printk(KERN_INFO "ADS8XXX(%d):  omap_mcbsp_request  =3D
%d\n",__LINE__,result);
    /* if configured, then stop mcbsp */
    omap_mcbsp_stop(ads8xxx_dev->adc_dev);
    omap_mcbsp_config(ads8xxx_dev->adc_dev, &initial_config);
    omap_mcbsp_start(ads8xxx_dev->adc_dev);


until here it seems to be working, but when i try to read or write there is
no signal in the pins.

neither the clock sample rate are been generated.
here is my inital configuration:
static struct omap_mcbsp_reg_cfg initial_config =3D
{
    .spcr1 =3D RRDY | RINTM(0),
    .spcr2 =3D XRDY | FREE|SOFT | FRST | GRST | XINTM(0) | XEMPTY,
    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_16) | RWDLEN1(OMAP_MCBSP_WORD_16),
    .rcr2  =3D RFRLEN2(OMAP_MCBSP_WORD_16) | RWDLEN2(OMAP_MCBSP_WORD_16) |
RDATDLY(0),
    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_16) | XWDLEN1(OMAP_MCBSP_WORD_16),
    .xcr2  =3D XFRLEN2(OMAP_MCBSP_WORD_16) | XWDLEN2(OMAP_MCBSP_WORD_16) |
XDATDLY(0),
    .srgr1 =3D CLKGDV(200) | FWID(16),
    .srgr2 =3D CLKSM | FPER(200),
    //.mcr1 =3D
    //.mcr2 =3D
    .pcr0  =3D FSXM | FSRM| CLKXM | CLKRM,

};

Any help help is welcome
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
