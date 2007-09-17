From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: doubt aabout McBSP interruptions
Date: Mon, 17 Sep 2007 13:55:44 -0300
Message-ID: <ae36f8040709170955n5dfcc1b3y9f91f0753377c101@mail.gmail.com>
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

Please someone could help ?
Dear fellows, look this two functions:
static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
{
    struct omap_mcbsp * mcbsp_tx =3D (struct omap_mcbsp *)(dev_id);

    DBG("TX IRQ callback : 0x%x\n", OMAP_MCBSP_READ(mcbsp_tx->io_base,
SPCR2));

    complete(&mcbsp_tx->tx_irq_completion);
    return IRQ_HANDLED;
}

static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
{
    struct omap_mcbsp * mcbsp_rx =3D (struct omap_mcbsp *)(dev_id);

    DBG("RX IRQ callback : 0x%x\n", OMAP_MCBSP_READ(mcbsp_rx->io_base,
SPCR2));

    complete(&mcbsp_rx->rx_irq_completion);
    return IRQ_HANDLED;
}

what exactly parameter irq does ?

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
