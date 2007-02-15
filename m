From: Diogo Scolari <diogoscolari@yahoo.com.br>
Subject: RE: McBSP usage inside DSP processor
Date: Thu, 15 Feb 2007 17:54:58 +0000 (GMT)
Message-ID: <483869.13204.qm@web55306.mail.re4.yahoo.com>
References: <5DF83221BE20114E9C331F665ACBC08002976B7E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08002976B7E@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, OMAP <Linux-omap-open-source@linux.omap.com>, dspgateway-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Hi Senthil

Thank you for your reply.

We would like to use the McBSP1, which is used by DSP
only. We think we don`t need to modifie the ARM driver
source code. Is this correct? Or we need really create
an application that will run on ARM side to pool the
McBSP and repass the colected data to DSP side?

Thanks=20

Diogo=20

--- "Guruswamy, Senthilvadivu" <svadivu@ti.com>
escreveu:

> Hi,
>=20
>=20
> Couple of points to be noted for Mcbsp usage in DSP.
> 	1.  The Mcbsp instance say Mcbsp2 should be a
> module shared between ARM and DSP, or only for DSP.
> 	2.  If the Mcbsp instance is a shared one among
> DSP/ARM, then the base address of the Mcbsp to
> access from DSP would be different from that of the
> arm.  Although the offsets of the registers like
> pcr, spcr, remain the same.
> 	3.  The IRQ line also would be obviously different
> for DSP.
>=20
> All these changes should be made in the arm Mcbsp
> driver to make it work from DSP.
>=20
> Regards,
> Senthil.
>=20
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
>
[mailto:linux-omap-open-source-bounces@linux.omap.com]
> On Behalf Of Lu=EDs Vit=F3rio Cargnini
> Sent: Tuesday, February 13, 2007 10:46 PM
> To: OMAP; dspgateway-devel@lists.sourceforge.net
> Subject: McBSP usage inside DSP processor
>=20
> Dears:
> I and my colleague are developing an application
> that will need to access an
> AD/DA, from DSP processor, we are trying the McBSP
> functions MCBSP_init(),
> read an write and so on. But we are having
> difficulties on execute this.
> Someone knows how to access an McBSP inside DSP side
> ?
> we are using DSPGateway.
> Something that we note is that MCBSP_init() do not
> exist and are always
> generating an error on compilation but CSL_init()
> works; someone could give
> some info about it ?
>=20
> here follow an code been developed by us:
> #define CHIP_5510PG2_2 1
>=20
> #include <std.h>
> #include <stdint.h>
> #include <math.h>
> #include <csl.h>
> #include <csl_dma.h>
> #include <csl_emif.h>
> #include <csl_irq.h>
> #include <csl_timer.h>
> #include <csl_mcbsp.h>
>=20
> #include "tokliBIOS.h"
>=20
> #define MCBSP_DEV0 (0)
> #define MCBSP_DEV1 (1)
> #define MCBSP_DEV2 (2)
>=20
> #define BUFSIZ (0x10000/2)
>=20
>=20
> int count;
> void write_isr(void);
>=20
> MCBSP_Handle fd;
> MCBSP_Config configuracao =3D { /*tudo uint16*/
> 0x0200,      //spcr1
> 0x1800,      //spcr2
> 0x0000,      //rcr1
> 0x0020,      //rcr2
> 0x0000,      //xcr1
> 0x0060,      //xcr2
> 0x3249,      //srgr1
> 0x03FF,      //srgr2
> 0x0040,      //mcr1
> 0x00A0,      //mcr2
> 0x00E0,      //pcr
> 0x0000,      //rcera
> 0x0000,      //rcerb
> 0x0000,      //rcerc
> 0x0000,      //rcerd
> 0x0000,      //rcere
> 0x0000,      //rcerf
> 0x0000,      //rcerg
> 0x0000,       //rcerh
> 0x0000,       //xcera
> 0x0000,       //xcerb
> 0x0000,       //xcerc
> 0x0000,       //xcerd
> 0x0000,       //xcere
> 0x0000,       //xcerf
> 0x0000,       //xcerg
> 0x0000       //xcerh
> };
>=20
> void write_isr(void)
> {
> while(!MCBSP_xrdy(fd));
> MCBSP_write16(fd, 1);
> while(!MCBSP_rrdy(fd));
> count =3D MCBSP_read16(fd);//o maximo eh 65536
> }
>=20
> static Uns mm_rcv_bksnd(struct dsptask *task, Uns
> bid, Uns cnt)
> {
>     Int i;
>     Uns *ipbp =3D ipbuf_d[bid];
>     Uns off, len;
>     #define OFF    0    /* arbitrary */
>     Uns bid2;
>     uint16_t  *addr =3D task->udata;
>=20
>     if (cnt !=3D 2)
>     {
>         //dbg(task, "[DSP]: illegal data cnt: %d\n",
> cnt);
>         unuse_ipbuf(task, bid);
>         return 0;
>     }
>=20
>     off =3D ipbp[0];    /* offset within the mapped
> space */
>     len =3D ipbp[1];    /* len (in word count) */
>     unuse_ipbuf(task, bid);
>=20
>     CSL_init();//inicializa a tudo
>     fd =3D MCBSP_open(MCBSP_DEV1,
> MCBSP_OPEN_RESET);//ok
>     MCBSP_reset(fd);
>     MCBSP_config(fd,&configuracao);
>     IRQ_clear(IRQ_EVT_INT1);
>         IRQ_configArgs(IRQ_EVT_INT1, write_isr, 0,
> 0, 0);
>         IRQ_enable(IRQ_EVT_INT1);   /* enable MCBSP1
> transmit ready
> interrupt */
>     MCBSP_start(fd, MCBSP_RCV_START |
> MCBSP_XMIT_START | MCBSP_SRGR_START |
> MCBSP_SRGR_FRAMESYNC, 0x0010);
>=20
>     MCBSP_write16(fd,79);
>     busywait(2000000L);
>=20
>     while(!MCBSP_rrdy(fd));
>     count =3D MCBSP_read16(fd);//o maximo eh 65536
>     bid2 =3D get_free_ipbuf(task);
>     //if(bid2 =3D=3D MBCMD_BID_NULL)
>     //    return MBCMD_EID_STVBUF;
>     ipbp =3D ipbuf_d[bid2];
>     ipbp[0] =3D OFF;
>     ipbp[1] =3D count;
>     bksnd(task, bid2, 2);
>=20
>     return 0;
> }
>=20
> --=20
>
-------------------------------------------------------------------------=
-----
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS
> Electrical Engineer Faculty
> Ipiranga Avenue, 6681 - Building 30
> P.O. Box: 90619-900 - Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
>
-------------------------------------------------------------------------=
--------
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20


__________________________________________________
Fale com seus amigos  de gra=E7a com o novo Yahoo! Messenger=20
http://br.messenger.yahoo.com/=20
