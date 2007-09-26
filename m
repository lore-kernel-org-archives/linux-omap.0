From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: [PATCH 01/01] arch/arm/plat-omap/mcbsp.c
Date: Wed, 26 Sep 2007 00:25:13 -0300
Message-ID: <ae36f8040709252025o3325b001k75d133411812f923@mail.gmail.com>
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

this patch modify the McBSP interrupt handling behavior turning the irq of
McBSP ports shared and it is working, I'm deveolping a device driver and
percepted that this is a change necessary for new device drivers could been
implemented to tak advantage of McBSP and could use it, example is ADC
communications throw McBSP interface for example, this modification do not
harm the kernel and add more felxibility and functionality to the kernel.

-- linux-omap-2.6/arch/arm/plat-omap/mcbsp.c   2007-03-12
16:44:03.501890844-0300
+++ linux-omap-2.6-instramed/arch/arm/plat-omap/mcbsp.c 2007-09-25 23:58:
39.324154145 -0300

 static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
@@ -304,7 +320,7 @@ int omap_mcbsp_request(unsigned int id)

        if (mcbsp[id].io_type =3D=3D OMAP_MCBSP_IRQ_IO) {
                /* We need to get IRQs here */
-               err =3D request_irq(mcbsp[id].tx_irq,
omap_mcbsp_tx_irq_handler, 0,
+               err =3D request_irq(mcbsp[id].tx_irq,
omap_mcbsp_tx_irq_handler, IRQF_SHARED,
                                  "McBSP",
                                  (void *) (&mcbsp[id]));
                if (err !=3D 0) {
@@ -315,8 +331,7 @@ int omap_mcbsp_request(unsigned int id)

                init_completion(&(mcbsp[id].tx_irq_completion));

-
-               err =3D request_irq(mcbsp[id].rx_irq,
omap_mcbsp_rx_irq_handler, 0,
+               err =3D request_irq(mcbsp[id].rx_irq,
omap_mcbsp_rx_irq_handler, IRQF_SHARED,
                                  "McBSP",
                                  (void *) (&mcbsp[id]));
                if (err !=3D 0) {


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
