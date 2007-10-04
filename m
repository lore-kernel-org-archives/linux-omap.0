From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: McBSP 2 - the return
Date: Thu, 4 Oct 2007 10:42:16 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003AAD0AA@dbde01.ent.ti.com>
References: <ae36f8040710031319l2415ad3am39e5f4b25a18e737@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <ae36f8040710031319l2415ad3am39e5f4b25a18e737@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Luis,

Please check if you are operating Mcbsp2 in Master or Slave mode.
Since you are touching SRGR with CLKSM bit, it seems that Mcbsp2 is in =
master mode.  In this case Sample rate generator has to be started after =
config.
 So DO NOT enable GRST in config      .spcr2 =3D XRDY | FREE|SOFT | FRST =
| GRST | XINTM(0) | XEMPTY,
Instead configure like .spcr2 =3D XRDY | FREE|SOFT | FRST | XINTM(0) | =
XEMPTY,


Regards,
Senthil

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of =
Lu=EDs Cargnini
Sent: Thursday, October 04, 2007 1:50 AM
To: OMAP
Subject: McBSP 2 - the return

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


until here it seems to be working, but when i try to read or write there =
is
no signal in the pins.

neither the clock sample rate are been generated.
here is my inital configuration:
static struct omap_mcbsp_reg_cfg initial_config =3D
{
    .spcr1 =3D RRDY | RINTM(0),
    .spcr2 =3D XRDY | FREE|SOFT | FRST | GRST | XINTM(0) | XEMPTY,
    .rcr1  =3D RFRLEN1(OMAP_MCBSP_WORD_16) | =
RWDLEN1(OMAP_MCBSP_WORD_16),
    .rcr2  =3D RFRLEN2(OMAP_MCBSP_WORD_16) | RWDLEN2(OMAP_MCBSP_WORD_16) =
|
RDATDLY(0),
    .xcr1  =3D XFRLEN1(OMAP_MCBSP_WORD_16) | =
XWDLEN1(OMAP_MCBSP_WORD_16),
    .xcr2  =3D XFRLEN2(OMAP_MCBSP_WORD_16) | XWDLEN2(OMAP_MCBSP_WORD_16) =
|
XDATDLY(0),
    .srgr1 =3D CLKGDV(200) | FWID(16),
    .srgr2 =3D CLKSM | FPER(200),
    //.mcr1 =3D
    //.mcr2 =3D
    .pcr0  =3D FSXM | FSRM| CLKXM | CLKRM,

};

Any help help is welcome
--=20
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
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
