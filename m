From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Fri, 11 May 2012 01:34:17 -0700
Message-ID: <CA+Bv8XbDVW_XbUbKyTziyw5LjxbymYKNWhFySBhaMeT22b-Bxw@mail.gmail.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64979 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074Ab2EKIeT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 04:34:19 -0400
Received: by lbbgm6 with SMTP id gm6so1713438lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 01:34:17 -0700 (PDT)
In-Reply-To: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

On Thu, May 10, 2012 at 6:05 AM, Govindraj.R <govindraj.raja@ti.com> wr=
ote:
> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> The commit (bce492c0 =C2=A0ARM: OMAP2+: UART: Fix incorrect populatio=
n of
> default uart pads) removed default uart pads that where getting popul=
ated
> and which was making rx pin wakeup capable. If uart pads was used in
> different mode by any other module then it would fail since the defau=
lt
> pads took over all the uart pins forcefully. With removal of default =
pads
> the rx_pad wakeup for console uart while waking up from off mode is b=
roken.
>
> Utilise the mux api available to probe the availability of mux pins
> in uart mode and probe for availability of uart pin in mux mode0
> if uart is available as uart pin itself then configure rx pin
> as wakeup capable.
>
> This patch itself doesn't cater to all boards. Boards using uart rx w=
akeup
> mechanism should ensure the usage of omap_serial_init_port by configu=
ring
> required uart ports and pass necessary mux data, till then this probi=
ng of
> uart pins can cater to enabling of rx pad wakeup to most of the board=
s.
>
> This patch can also throw some boot warning from _omap_mux_get_by_nam=
e
> if pin is requested for availability is not present while dynamically=
 probing
> the uart pins availability such boot warnings can be addressed only w=
hen board
> files are patched with omap_serial_init_port calls passing the right =
pads
> needed for a given port.
>
> Discussion Threads for reference:
> http://www.spinics.net/lists/linux-omap/msg69859.html
> http://www.spinics.net/lists/linux-omap/msg68659.html
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Russ Dill <russ.dill@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Ameya Palande <ameya.palande@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>
> Patching of all board files would be difficult as even I am not aware=
 of all
> omap-board schematics and uart port usage. So individual board file c=
an be
> enabled accordingly for uart usage by calling omap_serial_init_port c=
all
> with right mux data.
>
> for testing: Patch based on v3.4-rc6
> (tested on beagle-xm for off mode rx wakeup)
> Patch targeted for v3.5
>
> =C2=A0arch/arm/mach-omap2/mux.c =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
> =C2=A0arch/arm/mach-omap2/mux.h =C2=A0 =C2=A0| =C2=A0 10 ++++++
> =C2=A0arch/arm/mach-omap2/serial.c | =C2=A0 65 ++++++++++++++++++++++=
+++++++++++++++++--
> =C2=A03 files changed, 72 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 65c3391..d937ddd 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -217,8 +217,7 @@ static int __init _omap_mux_get_by_name(struct om=
ap_mux_partition *partition,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> =C2=A0}
>
> -static int __init
> -omap_mux_get_by_name(const char *muxname,
> +int __init omap_mux_get_by_name(const char *muxname,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct omap_mux_partition **found_partition,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct omap_mux **found_mux)
> =C2=A0{
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index 69fe060..68927f1 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -225,8 +225,18 @@ omap_hwmod_mux_init(struct omap_device_pad *bpad=
s, int nr_pads);
> =C2=A0*/
> =C2=A0void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)=
;
>
> +int omap_mux_get_by_name(const char *muxname,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_mux_pa=
rtition **found_partition,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_mux **=
found_mux);
> =C2=A0#else
>
> +static inline int omap_mux_get_by_name(const char *muxname,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_mux_pa=
rtition **found_partition,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_mux **=
found_mux)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> =C2=A0static inline int omap_mux_init_gpio(int gpio, int val)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index 9fc2f44..c097317 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -57,6 +57,7 @@ struct omap_uart_state {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head node;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_hwmod *oh;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_device_pad default_omap_uart_pads[=
2];
> =C2=A0};
>
> =C2=A0static LIST_HEAD(uart_list);
> @@ -126,11 +127,68 @@ static void omap_uart_set_smartidle(struct plat=
form_device *pdev) {}
> =C2=A0#endif /* CONFIG_PM */
>
> =C2=A0#ifdef CONFIG_OMAP_MUX
> -static void omap_serial_fill_default_pads(struct omap_board_data *bd=
ata)
> +
> +#define OMAP_UART_DEFAULT_PAD_NAME_LEN 28
> +static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pad_name[OMAP_U=
ART_DEFAULT_PAD_NAME_LEN] __initdata;
> +
> +static void =C2=A0__init
> +omap_serial_fill_uart_tx_rx_pads(struct omap_board_data *bdata,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_uart_state *uart)
> +{
> + =C2=A0 =C2=A0 =C2=A0 uart->default_omap_uart_pads[0].name =3D rx_pa=
d_name;
> + =C2=A0 =C2=A0 =C2=A0 uart->default_omap_uart_pads[0].flags =3D OMAP=
_DEVICE_PAD_REMUX |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP_DEVICE_PAD_WAKEUP=
;
> + =C2=A0 =C2=A0 =C2=A0 uart->default_omap_uart_pads[0].enable =3D OMA=
P_PIN_INPUT |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP_MUX_MODE0;
> + =C2=A0 =C2=A0 =C2=A0 uart->default_omap_uart_pads[0].idle =3D OMAP_=
PIN_INPUT | OMAP_MUX_MODE0;
> + =C2=A0 =C2=A0 =C2=A0 uart->default_omap_uart_pads[1].name =3D tx_pa=
d_name;
> + =C2=A0 =C2=A0 =C2=A0 uart->default_omap_uart_pads[1].enable =3D OMA=
P_PIN_OUTPUT |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP_MUX_MODE0;
> + =C2=A0 =C2=A0 =C2=A0 bdata->pads =3D uart->default_omap_uart_pads;
> + =C2=A0 =C2=A0 =C2=A0 bdata->pads_cnt =3D ARRAY_SIZE(uart->default_o=
map_uart_pads);
> +}
> +
> +static void =C2=A0__init omap_serial_check_wakeup(struct omap_board_=
data *bdata,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct omap_uart_state *uart)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 struct omap_mux_partition *tx_partition =3D NU=
LL, *rx_partition =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_mux *rx_mux =3D NULL, *tx_mux =3D =
NULL;
> + =C2=A0 =C2=A0 =C2=A0 char *rx_fmt, *tx_fmt;
> + =C2=A0 =C2=A0 =C2=A0 int uart_nr =3D bdata->id + 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (bdata->id !=3D 2) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_fmt =3D "uart%d=
_rx.uart%d_rx";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_fmt =3D "uart%d=
_tx.uart%d_tx";
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_fmt =3D "uart%d=
_rx_irrx.uart%d_rx_irrx";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_fmt =3D "uart%d=
_tx_irtx.uart%d_tx_irtx";
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NA=
ME_LEN, rx_fmt,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uart_nr, uart_nr);
> + =C2=A0 =C2=A0 =C2=A0 snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NA=
ME_LEN, tx_fmt,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uart_nr, uart_nr);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (omap_mux_get_by_name(rx_pad_name, &rx_part=
ition, &rx_mux) >=3D 0 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_mux_get_by_name
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (tx_pad_name, &tx_partition, &tx_mu=
x) >=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 tx_mode, rx_mo=
de;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_mode =3D omap_m=
ux_read(tx_partition, tx_mux->reg_offset);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_mode =3D omap_m=
ux_read(rx_partition, rx_mux->reg_offset);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check if u=
art is used in default tx/rx mode i.e. in mux mode0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if yes the=
n configure rx pin for wake up capability
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(rx_mode & 0x=
07) && !(tx_mode & 0x07))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_serial_fill_uart_tx_rx_pads(bdata, uart);

I realize the comment makes it clear, but it'd probably be better to
just make the code clear. I noticed mux.h has a OMAP_MODE_GPIO(x)
macro for testing if a mux is in mode4. Perhaps its time to start
expanding on that, at least with a macro like:

#define OMAP_MUX_MODE(x) ((x) & OMAP_MUX_MODE7)

So you can do a OMAP_MUX_MODE(rx_mode) =3D=3D OMAP_MUX_MODE0

> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0}
> =C2=A0#else
> -static void omap_serial_fill_default_pads(struct omap_board_data *bd=
ata) {}
> +static void __init omap_serial_check_wakeup(struct omap_board_data *=
bdata
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_uart_s=
tate *uart) {}
> =C2=A0#endif
>
> =C2=A0char *cmdline_find_option(char *str)
> @@ -295,8 +353,7 @@ void __init omap_serial_board_init(struct omap_ua=
rt_port_info *info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.pads =3D=
 NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.pads_cnt=
 =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap44x=
x() || cpu_is_omap34xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_serial_fill_default_pads(&bdata);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_serial_check_=
wakeup(&bdata, uart);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap_serial_init_port(&bdata, NULL);
> --
> 1.7.9
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
