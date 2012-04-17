From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default
 uart pads
Date: Tue, 17 Apr 2012 10:50:46 -0700
Message-ID: <20120417175046.GE21106@atomide.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-2-git-send-email-govindraj.raja@ti.com>
 <CA+Bv8XZ9D35RGX7Nub8YH5fk9j4mWUnVFAz036DJfNkq2Hwx6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52056 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2DQRuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 13:50:51 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XZ9D35RGX7Nub8YH5fk9j4mWUnVFAz036DJfNkq2Hwx6g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

* Russ Dill <russ.dill@gmail.com> [120413 16:17]:
> On Tue, Apr 10, 2012 at 6:40 AM, Govindraj.R <govindraj.raja@ti.com> =
wrote:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> >
> > The following commit:
> > (7496ba3 =C2=A0ARM: OMAP2+: UART: Add default mux for all uarts)
> > added default pads for all uarts. But not all boards tend to
> > use all uarts and most of unused uart pins are muxed for
> > other purpose. This commit breaks the modules which where trying
> > to use unused uart pins on their boards.
> >
> > So remove the default pads adding.
> >
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Russ Dill <russ.dill@gmail.com>
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>=20
> Acked-by: Russ Dill <russ.dill@ti.com>

Applying this into fixes with the updated comments as below.

Tony


=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 17 Apr 2012 10:35:47 -0700
Subject: [PATCH] ARM: OMAP2+: UART: Fix incorrect population of default=
 uart pads

Commit (7496ba3  ARM: OMAP2+: UART: Add default mux for all uarts)
wrongly added muxing of default pads for all uarts. This causes
breakage on multiple boards using uart pins for alternate functions.

=46or example, on zoom3 random oopses can be seen with nfsroot as
the smsc911x ethernet FIFO timings on GPMC bus are controlled
by gpmc_wait2 and gpmc_wait3 pins. This means we can't mux these
pads to uart4 functionality as commit 7496ba3 was doing.

Not all boards tend to use all uarts and most of unused uart pins
are muxed for other purpose. This commit breaks the modules which
where trying to use unused uart pins on their boards.

So remove the default pad muxing. Note that this is not a complete
fix, as we now rely on bootloader set muxing for the uart wake-up
events. Further patching is needed to enable wake-up events for
uarts that are already muxed to uart mode.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Acked-by: Russ Dill <russ.dill@gmail.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
[tony@atomide.com: updated comments to describe oops on zoom3]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 0cdd359..2e351f5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -120,124 +120,8 @@ static void omap_uart_set_smartidle(struct platfo=
rm_device *pdev) {}
 #endif /* CONFIG_PM */
=20
 #ifdef CONFIG_OMAP_MUX
-static struct omap_device_pad default_uart1_pads[] __initdata =3D {
-	{
-		.name	=3D "uart1_cts.uart1_cts",
-		.enable	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart1_rts.uart1_rts",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart1_tx.uart1_tx",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart1_rx.uart1_rx",
-		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-		.idle	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-};
-
-static struct omap_device_pad default_uart2_pads[] __initdata =3D {
-	{
-		.name	=3D "uart2_cts.uart2_cts",
-		.enable	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart2_rts.uart2_rts",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart2_tx.uart2_tx",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart2_rx.uart2_rx",
-		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-		.idle	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-};
-
-static struct omap_device_pad default_uart3_pads[] __initdata =3D {
-	{
-		.name	=3D "uart3_cts_rctx.uart3_cts_rctx",
-		.enable	=3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart3_rts_sd.uart3_rts_sd",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart3_tx_irtx.uart3_tx_irtx",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart3_rx_irrx.uart3_rx_irrx",
-		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-		.idle	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-	},
-};
-
-static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata=
 =3D {
-	{
-		.name   =3D "gpmc_wait2.uart4_tx",
-		.enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "gpmc_wait3.uart4_rx",
-		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE2,
-		.idle	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE2,
-	},
-};
-
-static struct omap_device_pad default_omap4_uart4_pads[] __initdata =3D=
 {
-	{
-		.name	=3D "uart4_tx.uart4_tx",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
-	{
-		.name	=3D "uart4_rx.uart4_rx",
-		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-		.idle	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-	},
-};
-
 static void omap_serial_fill_default_pads(struct omap_board_data *bdat=
a)
 {
-	switch (bdata->id) {
-	case 0:
-		bdata->pads =3D default_uart1_pads;
-		bdata->pads_cnt =3D ARRAY_SIZE(default_uart1_pads);
-		break;
-	case 1:
-		bdata->pads =3D default_uart2_pads;
-		bdata->pads_cnt =3D ARRAY_SIZE(default_uart2_pads);
-		break;
-	case 2:
-		bdata->pads =3D default_uart3_pads;
-		bdata->pads_cnt =3D ARRAY_SIZE(default_uart3_pads);
-		break;
-	case 3:
-		if (cpu_is_omap44xx()) {
-			bdata->pads =3D default_omap4_uart4_pads;
-			bdata->pads_cnt =3D
-				ARRAY_SIZE(default_omap4_uart4_pads);
-		} else if (cpu_is_omap3630()) {
-			bdata->pads =3D default_omap36xx_uart4_pads;
-			bdata->pads_cnt =3D
-				ARRAY_SIZE(default_omap36xx_uart4_pads);
-		}
-		break;
-	default:
-		break;
-	}
 }
 #else
 static void omap_serial_fill_default_pads(struct omap_board_data *bdat=
a) {}
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
