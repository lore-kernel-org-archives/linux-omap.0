From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
Date: Mon, 9 Apr 2012 16:38:59 +0530
Message-ID: <CAMrsUdKs21qtrWX0i44fvm7U2JW0L=2NgmZBHAZGmwp03XFm6w@mail.gmail.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com> <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com> <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
 <20120406181556.GC15734@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:52899 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756169Ab2DILJX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Apr 2012 07:09:23 -0400
Received: by obfk16 with SMTP id k16so6749282obf.23
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 04:09:22 -0700 (PDT)
In-Reply-To: <20120406181556.GC15734@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Tony,

On Fri, Apr 6, 2012 at 11:45 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Raja, Govindraj <govindraj.raja@ti.com> [120405 23:08]:
>> On Thu, Apr 5, 2012 at 10:28 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> >
>> > Hmm I don't think any muxing was done automatically unless
>> > omap_serial_init_port was being called with pins.
>>
>> Muxing was happening even if we don't call omap_serial_init_port
>> rx pin was muxed for wakeup capability for all uart pins
>
> OK, but that was only for the wake-up muxing? That sounds risky
> too for some boards as the board may be using alternative uart
> pins instead of the default ones.
>
>> omap_uart_idle_init =3D> was populating padconf offset value for ech=
 uart
>> which was used in omap_uart_enable/disable_wakeup functions.
>> This mechanism was keeping PM happening for all boards.
>
> OK, that's safe if we also bail out for the cases where the default
> uart pins are not muxed to serial functionality to start with.
>
> So to summarize, the right fix is to:
>
> 1. Only do muxing of uarts from other modes to uart mode if
> =A0 omap_serial_init_port is being called with the board specific
> =A0 mux options for the port in question.
>
> 2. Bail out early in omap_serial_init for each port that does not
> =A0 have it's default uart pins already muxed to uart functionality.
>
> 3. For the uart ports configured in #1 or #2 above, allow dynamic
> =A0 remuxing of the wake-up capability but don't touch the others.
>

Thanks for the review and suggestions, here is the patch [1] to do the =
same.

I tested this patch on beagle-xm where uart pin mux was causing clash
with usb ehci hub gpio nrest pin, now with this patch smsc hub + ethern=
et
get enumerated.

--
Thanks,
Govindraj.R


[1]:

=46rom 37850b9e80fc4dac050bff5b6dbb67c245be43cc Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Mon, 9 Apr 2012 15:16:52 +0530
Subject: [PATCH] ARM: OMAP2+: UART: Fix usage of default uart pads.

The following commit:
(7496ba3  ARM: OMAP2+: UART: Add default mux for all uarts)
added default pads for all uarts. But not all boards tend to
use all uarts and most of unused uart pins are muxed for
other purpose. This commit breaks the modules which where trying
to use unused uart pins on their boards.

So check for the availability of uart pins before filling the pads
if both tx and rx are available as uart pins then use them for
filling as default pads where rx pin is muxed dynamically for
rx wakeup capability.

However the board file owners can use omap_serial_init_port
and pass mux data part of board data for board specific use cases.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c    |    2 +-
 arch/arm/mach-omap2/mux.h    |   10 +++
 arch/arm/mach-omap2/serial.c |  158 ++++++++++++----------------------=
--------
 3 files changed, 56 insertions(+), 114 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 65c3391..5334914 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -217,7 +217,7 @@ static int __init _omap_mux_get_by_name(struct
omap_mux_partition *partition,
 	return -ENODEV;
 }

-static int __init
+int __init
 omap_mux_get_by_name(const char *muxname,
 			struct omap_mux_partition **found_partition,
 			struct omap_mux **found_mux)
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 69fe060..461b90d 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -225,8 +225,18 @@ omap_hwmod_mux_init(struct omap_device_pad
*bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);

+int omap_mux_get_by_name(const char *muxname,
+                        struct omap_mux_partition **found_partition,
+                        struct omap_mux **found_mux);
 #else

+static inline int omap_mux_get_by_name(const char *muxname,
+                        struct omap_mux_partition **found_partition,
+                        struct omap_mux **found_mux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 0cdd359..30a0f4e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -120,127 +120,59 @@ static void omap_uart_set_smartidle(struct
platform_device *pdev) {}
 #endif /* CONFIG_PM */

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
+#define OMAP_UART_DEFAULT_PAD_NAME_LEN	28
+static char __initdata rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
+				tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN];

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
+static void  __init omap_serial_fill_default_pads(struct
omap_board_data *bdata)
+{
+	struct omap_mux_partition *tx_partition =3D NULL, *rx_partition =3D N=
ULL;
+	struct omap_mux *rx_mux =3D NULL, *tx_mux =3D NULL;
+	struct omap_device_pad default_omap_uart_pads[2];
+
+	if (bdata->id !=3D 2) {
+		snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			 "uart%d_rx.uart%d_rx", bdata->id + 1, bdata->id + 1);
+		snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			 "uart%d_tx.uart%d_tx", bdata->id + 1, bdata->id + 1);
+	} else {
+		snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			"uart%d_rx_irrx.uart%d_rx_irrx", bdata->id + 1,
+			bdata->id + 1);
+		snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
+			"uart%d_tx_irtx.uart%d_tx_irtx", bdata->id + 1,
+			bdata->id + 1);
+	}

-static struct omap_device_pad default_omap4_uart4_pads[] __initdata =3D=
 {
-	{
-		.name	=3D "uart4_tx.uart4_tx",
-		.enable	=3D OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
-	},
+	if (omap_mux_get_by_name(rx_pad_name, &rx_partition, &rx_mux) >=3D 0 =
&&
+		omap_mux_get_by_name(tx_pad_name, &tx_partition, &tx_mux) >=3D 0)
 	{
-		.name	=3D "uart4_rx.uart4_rx",
-		.flags	=3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-		.idle	=3D OMAP_PIN_INPUT | OMAP_MUX_MODE0,
-	},
-};
-
-static void omap_serial_fill_default_pads(struct omap_board_data *bdat=
a)
-{
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
+		u16 tx_mode, rx_mode;
+
+		tx_mode =3D omap_mux_read(tx_partition, tx_mux->reg_offset);
+		rx_mode =3D omap_mux_read(rx_partition, rx_mux->reg_offset);
+
+		if (!(rx_mode & 0x07) && !(tx_mode & 0x07)) {
+			default_omap_uart_pads[0].name =3D rx_pad_name;
+			default_omap_uart_pads[0].flags  =3D
+				OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP;
+			default_omap_uart_pads[0].enable =3D OMAP_PIN_INPUT |
+								OMAP_MUX_MODE0;
+			default_omap_uart_pads[0].idle =3D OMAP_PIN_INPUT |
+								OMAP_MUX_MODE0;
+
+			default_omap_uart_pads[1].name =3D tx_pad_name;
+			default_omap_uart_pads[1].enable =3D OMAP_PIN_OUTPUT |
+								OMAP_MUX_MODE0;
+			bdata->pads =3D default_omap_uart_pads;
+			bdata->pads_cnt =3D ARRAY_SIZE(default_omap_uart_pads);
 		}
-		break;
-	default:
-		break;
 	}
 }
 #else
-static void omap_serial_fill_default_pads(struct omap_board_data *bdat=
a) {}
+static void __init omap_serial_fill_default_pads(struct omap_board_dat=
a *bdata)
+{}
 #endif

 char *cmdline_find_option(char *str)
--=20
1.7.9
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
