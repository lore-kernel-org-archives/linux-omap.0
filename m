From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [RFC PATCH] OMAP: UART: Enable tx wakeup bit in wer
Date: Tue, 6 Mar 2012 15:35:59 +0530
Message-ID: <CAMrsUdJqmJ75=X_Qg3vQCr7zezs0jOK8L1ri8p5K=+6ZKsRFcg@mail.gmail.com>
References: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
 <alpine.DEB.2.00.1201251217120.5324@utopia.booyaka.com> <alpine.DEB.2.00.1203051321580.1430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58623 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758022Ab2CFKGU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Mar 2012 05:06:20 -0500
Received: by obbuo6 with SMTP id uo6so6753951obb.5
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 02:06:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1203051321580.1430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, Mar 6, 2012 at 1:53 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hello Govindraj
>
> Do you intend to update and repost this serial patch? =A0Or should so=
meone
> else deal with it? =A0It would be good to get support for this additi=
onal
> wakeup bit.

Thanks for reminding.
(I had got preempted with other activities, apologies for the delay)

I see two ways of adding this tx wake-up flag.

1.) passing a feature flag from pdata and populating the feature value =
to wer.

2.) Duplicating the uart1/2/3 hwmod for omap3430 without dev attrib
and uart1/2/3/4
     hwmod for omap3630 with dev attribs.

Approach-2 adds unnecessary code duplication in hwmod file with and wit=
hout
dev_attribs, So right now here is the patch to follow approach [1],

If its strongly recommended to use approach-2 will add it.
(My concern is the diffstat it might produce with approach-2)

--
Thanks,
Govindraj.R


[1]:

=46rom 867dfa7328b4219be259a204555a6baae82ec4df Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 6 Mar 2012 15:04:47 +0530
Subject: [PATCH] OMAP: UART: enable tx wake up capability for 3630 abov=
e socs

=46rom omap3630 above UART wer(wakeup enable reg) has TX
wakeup capability, enable the tx wakeup bit by passing
the required feature flag from pdata.
Also add missing wer reg restore from context restore function.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    3 +++
 arch/arm/plat-omap/include/plat/omap-serial.h |    7 +++++++
 drivers/tty/serial/omap-serial.c              |    8 +++++++-
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index f590afc..eb43996 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -357,6 +357,9 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata,
 	omap_up.dma_rx_poll_rate =3D info->dma_rx_poll_rate;
 	omap_up.autosuspend_timeout =3D info->autosuspend_timeout;

+	if (!cpu_is_omap24xx() && !cpu_is_omap3430())
+		omap_up.has_feature =3D UART_FEATURE_TX_WAKEUP_EN;
+
 	/* Enable the MDR1 Errata i202 for OMAP2430/3xxx/44xx */
 	if (!cpu_is_omap2420() && !cpu_is_ti816x())
 		omap_up.errata |=3D UART_ERRATA_i202_MDR1_ACCESS;
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h
b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..b4f42dc 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -61,6 +61,11 @@
 #define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
 #define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)

+#define OMAP_UART_TX_WAKEUP_EN		BIT(7)
+
+/* Feature flags */
+#define UART_FEATURE_TX_WAKEUP_EN	BIT(0)
+
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
@@ -70,6 +75,7 @@ struct omap_uart_port_info {
 	unsigned int		dma_rx_timeout;
 	unsigned int		autosuspend_timeout;
 	unsigned int		dma_rx_poll_rate;
+	unsigned int		has_feature;

 	int (*get_context_loss_count)(struct device *);
 	void (*set_forceidle)(struct platform_device *);
@@ -117,6 +123,7 @@ struct uart_omap_port {
 	unsigned char		dlh;
 	unsigned char		mdr1;
 	unsigned char		scr;
+	unsigned char		wer;

 	int			use_dma;
 	/*
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap=
-serial.c
index f809041..5d7330f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -577,8 +577,10 @@ static int serial_omap_startup(struct uart_port *p=
ort)
 	up->ier =3D UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);

+	up->wer |=3D OMAP_UART_WER_MOD_WKUP;
+
 	/* Enable module level wake up */
-	serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
+	serial_out(up, UART_OMAP_WER, up->wer);

 	pm_runtime_mark_last_busy(&up->pdev->dev);
 	pm_runtime_put_autosuspend(&up->pdev->dev);
@@ -1444,6 +1446,8 @@ static int serial_omap_probe(struct platform_devi=
ce *pdev)
 	}
 	up->uart_dma.uart_base =3D mem->start;
 	up->errata =3D omap_up_info->errata;
+	if (omap_up_info->has_feature & UART_FEATURE_TX_WAKEUP_EN)
+		up->wer |=3D OMAP_UART_TX_WAKEUP_EN;

 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx =3D dma_tx->start;
@@ -1569,6 +1573,8 @@ static void serial_omap_restore_context(struct
uart_omap_port *up)
 		serial_omap_mdr1_errataset(up, up->mdr1);
 	else
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
+
+	serial_out(up, UART_OMAP_WER, up->wer);
 }

 static int serial_omap_runtime_suspend(struct device *dev)
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
