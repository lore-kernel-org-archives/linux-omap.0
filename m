From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: [PATCH] arch/arm/plat-omap/mcbsp.c
Date: Wed, 10 Oct 2007 00:43:30 -0300
Message-ID: <ae36f8040710092043w58ee96e1q9b81aff60450fae7@mail.gmail.com>
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
To: Tony Lindgren <tony@atomide.com>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Lu=EDs Vit=F3rio Cargnini <lvcargnini@gmail.com>

--- /home/lvcargnini/puc/instramed/linux-omap-2.6/arch/arm/plat-omap/mcbsp.=
c
2007-03-12 16:44:03.501890844 -0300
+++ /home/lvcargnini/puc/instramed/linux-omap-2.6.23/arch/arm/plat-omap/mcb=
sp.c
2007-10-02 03:31:12.399296934 -0300
@@ -304,7 +304,7 @@ int omap_mcbsp_request(unsigned int id)

        if (mcbsp[id].io_type =3D=3D OMAP_MCBSP_IRQ_IO) {
                /* We need to get IRQs here */
-               err =3D request_irq(mcbsp[id].tx_irq,
omap_mcbsp_tx_irq_handler, 0,
+               err =3D request_irq(mcbsp[id].tx_irq,
omap_mcbsp_tx_irq_handler, IRQF_SHARED,
                                  "McBSP",
                                  (void *) (&mcbsp[id]));
                if (err !=3D 0) {
@@ -316,7 +316,7 @@ int omap_mcbsp_request(unsigned int id)
                init_completion(&(mcbsp[id].tx_irq_completion));


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
