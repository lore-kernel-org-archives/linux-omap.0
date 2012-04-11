From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Wed, 11 Apr 2012 17:20:11 +0530
Message-ID: <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-3-git-send-email-govindraj.raja@ti.com> <20120410161136.GF6487@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:35194 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667Ab2DKLud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:50:33 -0400
Received: by obbtb18 with SMTP id tb18so1598573obb.33
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 04:50:32 -0700 (PDT)
In-Reply-To: <20120410161136.GF6487@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>

On Tue, Apr 10, 2012 at 9:41 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Govindraj.R <govindraj.raja@ti.com> [120410 06:44]:
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -120,11 +120,63 @@ static void omap_uart_set_smartidle(struct pla=
tform_device *pdev) {}
>> =A0#endif /* CONFIG_PM */
>>
>> =A0#ifdef CONFIG_OMAP_MUX
>> -static void omap_serial_fill_default_pads(struct omap_board_data *b=
data)
>> +
>> +#define OMAP_UART_DEFAULT_PAD_NAME_LEN =A0 =A0 =A0 28
>> +static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN=
] __initdata;
>> +static struct omap_device_pad default_omap_uart_pads[2] __initdata;
>
> Won't the default_omap_uart_pads get overwritten for each port?
> We need that information in the driver too for each port? Why don't y=
ou
> just allocate bdata.pads in omap_serial_board_init as we now assume i=
t's
> needed for each port?
>

Yes can be part of omap_uart_state structure.

>> +static void =A0__init omap_serial_fill_default_pads(struct omap_boa=
rd_data *bdata)
>> =A0{
>> + =A0 =A0 struct omap_mux_partition *tx_partition =3D NULL, *rx_part=
ition =3D NULL;
>> + =A0 =A0 struct omap_mux *rx_mux =3D NULL, *tx_mux =3D NULL;
>> +
>> + =A0 =A0 if (bdata->id !=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(rx_pad_name, OMAP_UART_DEFAULT_PA=
D_NAME_LEN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"uart%d_rx.uart%d_rx", =
bdata->id + 1, bdata->id + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(tx_pad_name, OMAP_UART_DEFAULT_PA=
D_NAME_LEN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"uart%d_tx.uart%d_tx", =
bdata->id + 1, bdata->id + 1);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(rx_pad_name, OMAP_UART_DEFAULT_PA=
D_NAME_LEN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "uart%d_rx_irrx.uart%d_rx_=
irrx", bdata->id + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata->id + 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snprintf(tx_pad_name, OMAP_UART_DEFAULT_PA=
D_NAME_LEN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "uart%d_tx_irtx.uart%d_tx_=
irtx", bdata->id + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata->id + 1);
>> + =A0 =A0 }
>
> This would be simpler with something like this (untested):
>
> =A0 =A0 =A0 =A0char *rx_fmt, *tx_fmt;
> =A0 =A0 =A0 =A0int uart_nr =3D bdata->id + 1;
>
> =A0 =A0 =A0 =A0if (bdata->id =3D=3D 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_fmt =3D "uart%d_rx.uart%d_rx";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tx_fmt =3D "uart%d_tx.uart%d_tx";
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_fmt =3D "uart%d_rx_irrx.uart%d_rx_i=
rrx";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tx_fmt =3D "uart%d_tx_irtx.uart%d_tx_i=
rtx";
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, =
rx_fmt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_nr, uart_nr);
> =A0 =A0 =A0 =A0snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, =
tx_fmt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_nr, uart_nr);
>

okay fine.

>> + =A0 =A0 if (omap_mux_get_by_name(rx_pad_name, &rx_partition, &rx_m=
ux) >=3D 0 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_get_by_name
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (tx_pad_na=
me, &tx_partition, &tx_mux) >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 tx_mode, rx_mode;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_mode =3D omap_mux_read(tx_partition, tx=
_mux->reg_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_mode =3D omap_mux_read(rx_partition, rx=
_mux->reg_offset);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if uart is used in default tx/r=
x mode i.e. in mux mode0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* if yes then configure rx pin for wake=
 up capability
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(rx_mode & 0x07) && !(tx_mode & 0x07)=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default_omap_uart_pads[0].=
name =3D rx_pad_name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default_omap_uart_pads[0].=
flags =A0=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DEVIC=
E_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default_omap_uart_pads[0].=
enable =3D OMAP_PIN_INPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MUX_MODE0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default_omap_uart_pads[0].=
idle =3D OMAP_PIN_INPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MUX_MODE0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default_omap_uart_pads[1].=
name =3D tx_pad_name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default_omap_uart_pads[1].=
enable =3D OMAP_PIN_OUTPUT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_MUX_MODE0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata->pads =3D default_om=
ap_uart_pads;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata->pads_cnt =3D ARRAY_=
SIZE(default_omap_uart_pads);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> =A0}
>
> Then looking at omap_serial_board_init, it still looks wrong:
>
> void __init omap_serial_board_init(struct omap_uart_port_info *info)
> {
> =A0 =A0 =A0 =A0struct omap_uart_state *uart;
> =A0 =A0 =A0 =A0struct omap_board_data bdata;
>
> =A0 =A0 =A0 =A0list_for_each_entry(uart, &uart_list, node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata.id =3D uart->num;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata.flags =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata.pads =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata.pads_cnt =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap44xx() || cpu_is_omap34=
xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_fill_defau=
lt_pads(&bdata);
>
> Why don't you fill the pads for omap2? It has the same pads, although
> it does not have the serial wake-up events working.
>
> And why don't you exit if omap_serial_fill_default_pads fails for the
> no info case?
>
> Shouldn't it be something like:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res =3D omap_serial_fi=
ll_default_pads(&bdata);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!res)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port =3D &info[uart->n=
um];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_init_port(&bdata, port);
>

Yes if filling of default pads fails we can avoid registering that port
however I think that should not depend on availability of port info.

Here [1] is the updated patch.

--
Thanks,
Govindraj.R


[1]:


=46rom ea06c7d5014b68f622b3e2ca226e5a5194d48e9a Mon Sep 17 00:00:00 200=
1
=46rom: "Govindraj.R" <govindraj.raja@ti.com>
Date: Tue, 10 Apr 2012 18:21:52 +0530
Subject: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup

Default pad populating procedure should first probe whether the uart
pins are available as uart tx/rx pins if yes then we can configure them
and use rx pin for wakeup capability.

Utilise the mux api available to probe the availability of mux pins
in uart mode.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Russ Dill <russ.dill@gmail.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c    |    3 +-
 arch/arm/mach-omap2/mux.h    |   10 ++++++
 arch/arm/mach-omap2/serial.c |   73 ++++++++++++++++++++++++++++++++++=
+++++--
 3 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 65c3391..d937ddd 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -217,8 +217,7 @@ static int __init _omap_mux_get_by_name(struct
omap_mux_partition *partition,
 	return -ENODEV;
 }

-static int __init
-omap_mux_get_by_name(const char *muxname,
+int __init omap_mux_get_by_name(const char *muxname,
 			struct omap_mux_partition **found_partition,
 			struct omap_mux **found_mux)
 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 69fe060..68927f1 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -225,8 +225,18 @@ omap_hwmod_mux_init(struct omap_device_pad
*bpads, int nr_pads);
  */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);

+int omap_mux_get_by_name(const char *muxname,
+		struct omap_mux_partition **found_partition,
+		struct omap_mux **found_mux);
 #else

+static inline int omap_mux_get_by_name(const char *muxname,
+		struct omap_mux_partition **found_partition,
+		struct omap_mux **found_mux)
+{
+	return 0;
+}
+
 static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 2e351f5..9d62cae 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -57,6 +57,7 @@ struct omap_uart_state {

 	struct list_head node;
 	struct omap_hwmod *oh;
+	struct omap_device_pad default_omap_uart_pads[2];
 };

 static LIST_HEAD(uart_list);
@@ -120,11 +121,75 @@ static void omap_uart_set_smartidle(struct
platform_device *pdev) {}
 #endif /* CONFIG_PM */

 #ifdef CONFIG_OMAP_MUX
-static void omap_serial_fill_default_pads(struct omap_board_data *bdat=
a)
+
+#define OMAP_UART_DEFAULT_PAD_NAME_LEN	28
+static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
+		tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN] __initdata;
+
+static void  __init
+omap_serial_fill_uart_tx_rx_pads(struct omap_board_data *bdata,
+				struct omap_uart_state *uart)
 {
+	uart->default_omap_uart_pads[0].name =3D rx_pad_name;
+	uart->default_omap_uart_pads[0].flags =3D OMAP_DEVICE_PAD_REMUX |
+							OMAP_DEVICE_PAD_WAKEUP;
+	uart->default_omap_uart_pads[0].enable =3D OMAP_PIN_INPUT |
+							OMAP_MUX_MODE0;
+	uart->default_omap_uart_pads[0].idle =3D OMAP_PIN_INPUT | OMAP_MUX_MO=
DE0;
+	uart->default_omap_uart_pads[1].name =3D tx_pad_name;
+	uart->default_omap_uart_pads[1].enable =3D OMAP_PIN_OUTPUT |
+							OMAP_MUX_MODE0;
+	bdata->pads =3D uart->default_omap_uart_pads;
+	bdata->pads_cnt =3D ARRAY_SIZE(uart->default_omap_uart_pads);
+}
+
+static int  __init omap_serial_fill_default_pads(struct omap_board_dat=
a *bdata,
+						struct omap_uart_state *uart)
+{
+	struct omap_mux_partition *tx_partition =3D NULL, *rx_partition =3D N=
ULL;
+	struct omap_mux *rx_mux =3D NULL, *tx_mux =3D NULL;
+	char *rx_fmt, *tx_fmt;
+	int uart_nr =3D bdata->id + 1;
+
+	if (bdata->id !=3D 2) {
+		rx_fmt =3D "uart%d_rx.uart%d_rx";
+		tx_fmt =3D "uart%d_tx.uart%d_tx";
+	} else {
+		rx_fmt =3D "uart%d_rx_irrx.uart%d_rx_irrx";
+		tx_fmt =3D "uart%d_tx_irtx.uart%d_tx_irtx";
+	}
+
+	snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, rx_fmt,
+			uart_nr, uart_nr);
+	snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, tx_fmt,
+			uart_nr, uart_nr);
+
+	if (omap_mux_get_by_name(rx_pad_name, &rx_partition, &rx_mux) >=3D 0 =
&&
+			omap_mux_get_by_name
+				(tx_pad_name, &tx_partition, &tx_mux) >=3D 0) {
+		u16 tx_mode, rx_mode;
+
+		tx_mode =3D omap_mux_read(tx_partition, tx_mux->reg_offset);
+		rx_mode =3D omap_mux_read(rx_partition, rx_mux->reg_offset);
+
+		/*
+		 * Check if uart is used in default tx/rx mode i.e. in mux mode0
+		 * if yes then configure rx pin for wake up capability
+		 */
+		if (!(rx_mode & 0x07) && !(tx_mode & 0x07)) {
+			omap_serial_fill_uart_tx_rx_pads(bdata, uart);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
 }
 #else
-static void omap_serial_fill_default_pads(struct omap_board_data *bdat=
a) {}
+static int __init omap_serial_fill_default_pads(struct omap_board_data=
 *bdata
+					struct omap_uart_state *uart)
+{
+	return 0;
+}
 #endif

 char *cmdline_find_option(char *str)
@@ -289,8 +354,8 @@ void __init omap_serial_board_init(struct
omap_uart_port_info *info)
 		bdata.pads =3D NULL;
 		bdata.pads_cnt =3D 0;

-		if (cpu_is_omap44xx() || cpu_is_omap34xx())
-			omap_serial_fill_default_pads(&bdata);
+		if (omap_serial_fill_default_pads(&bdata, uart))
+			continue;

 		if (!info)
 			omap_serial_init_port(&bdata, NULL);
--=20
1.7.9
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
