From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Fri, 13 Apr 2012 16:39:42 -0700
Message-ID: <CA+Bv8Xbv0GKuzkRQtzXut_cjzZnF1Ynt8Fp3Z1uncOL42YupbQ@mail.gmail.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
	<1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
	<20120410161136.GF6487@atomide.com>
	<CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48885 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2DMXjo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 19:39:44 -0400
Received: by lbbgm6 with SMTP id gm6so2832285lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 16:39:42 -0700 (PDT)
In-Reply-To: <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

On Wed, Apr 11, 2012 at 4:50 AM, Raja, Govindraj <govindraj.raja@ti.com=
> wrote:
> On Tue, Apr 10, 2012 at 9:41 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> * Govindraj.R <govindraj.raja@ti.com> [120410 06:44]:
>>> --- a/arch/arm/mach-omap2/serial.c
>>> +++ b/arch/arm/mach-omap2/serial.c
>>> @@ -120,11 +120,63 @@ static void omap_uart_set_smartidle(struct pl=
atform_device *pdev) {}
>>> =C2=A0#endif /* CONFIG_PM */
>>>
>>> =C2=A0#ifdef CONFIG_OMAP_MUX
>>> -static void omap_serial_fill_default_pads(struct omap_board_data *=
bdata)
>>> +
>>> +#define OMAP_UART_DEFAULT_PAD_NAME_LEN =C2=A0 =C2=A0 =C2=A0 28
>>> +static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pad_name[OMAP_UART_D=
EFAULT_PAD_NAME_LEN] __initdata;
>>> +static struct omap_device_pad default_omap_uart_pads[2] __initdata=
;
>>
>> Won't the default_omap_uart_pads get overwritten for each port?
>> We need that information in the driver too for each port? Why don't =
you
>> just allocate bdata.pads in omap_serial_board_init as we now assume =
it's
>> needed for each port?
>>
>
> Yes can be part of omap_uart_state structure.
>
>>> +static void =C2=A0__init omap_serial_fill_default_pads(struct omap=
_board_data *bdata)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 struct omap_mux_partition *tx_partition =3D NULL, *=
rx_partition =3D NULL;
>>> + =C2=A0 =C2=A0 struct omap_mux *rx_mux =3D NULL, *tx_mux =3D NULL;
>>> +
>>> + =C2=A0 =C2=A0 if (bdata->id !=3D 2) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(rx_pad_name, O=
MAP_UART_DEFAULT_PAD_NAME_LEN,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0"uart%d_rx.uart%d_rx", bdata->id + 1, bdata->id + 1);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(tx_pad_name, O=
MAP_UART_DEFAULT_PAD_NAME_LEN,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0"uart%d_tx.uart%d_tx", bdata->id + 1, bdata->id + 1);
>>> + =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(rx_pad_name, O=
MAP_UART_DEFAULT_PAD_NAME_LEN,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "uart%d_rx_irrx.uart%d_rx_irrx", bdata->id + 1,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bdata->id + 1);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(tx_pad_name, O=
MAP_UART_DEFAULT_PAD_NAME_LEN,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "uart%d_tx_irtx.uart%d_tx_irtx", bdata->id + 1,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bdata->id + 1);
>>> + =C2=A0 =C2=A0 }
>>
>> This would be simpler with something like this (untested):
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *rx_fmt, *tx_fmt;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int uart_nr =3D bdata->id + 1;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bdata->id =3D=3D 2) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_fmt =3D "u=
art%d_rx.uart%d_rx";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tx_fmt =3D "u=
art%d_tx.uart%d_tx";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_fmt =3D "u=
art%d_rx_irrx.uart%d_rx_irrx";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tx_fmt =3D "u=
art%d_tx_irtx.uart%d_tx_irtx";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(rx_pad_name, OMAP_UART_DEFAULT_P=
AD_NAME_LEN, rx_fmt,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uart_nr, uart_nr);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(tx_pad_name, OMAP_UART_DEFAULT_P=
AD_NAME_LEN, tx_fmt,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uart_nr, uart_nr);
>>
>
> okay fine.
>
>>> + =C2=A0 =C2=A0 if (omap_mux_get_by_name(rx_pad_name, &rx_partition=
, &rx_mux) >=3D 0 &&
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 omap_mux_get_by_name
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (tx_pad_name, &tx_partition, &tx_mux) >=
=3D 0) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 tx_mode, rx_mode;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_mode =3D omap_mux_re=
ad(tx_partition, tx_mux->reg_offset);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_mode =3D omap_mux_re=
ad(rx_partition, rx_mux->reg_offset);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check if uart i=
s used in default tx/rx mode i.e. in mux mode0
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if yes then con=
figure rx pin for wake up capability
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(rx_mode & 0x07) &=
& !(tx_mode & 0x07)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_omap_uart_pads[0].name =3D rx_pad_name;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_omap_uart_pads[0].flags =C2=A0=3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD=
_WAKEUP;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_omap_uart_pads[0].enable =3D OMAP_PIN_INPUT |
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OMAP_MUX_MODE0;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_omap_uart_pads[0].idle =3D OMAP_PIN_INPUT |
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OMAP_MUX_MODE0;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_omap_uart_pads[1].name =3D tx_pad_name;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_omap_uart_pads[1].enable =3D OMAP_PIN_OUTPUT |
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OMAP_MUX_MODE0;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bdata->pads =3D default_omap_uart_pads;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bdata->pads_cnt =3D ARRAY_SIZE(default_omap_uart_pads);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> + =C2=A0 =C2=A0 }
>>> =C2=A0}
>>
>> Then looking at omap_serial_board_init, it still looks wrong:
>>
>> void __init omap_serial_board_init(struct omap_uart_port_info *info)
>> {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_uart_state *uart;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_board_data bdata;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(uart, &uart_list, nod=
e) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.id =3D =
uart->num;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.flags =3D=
 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.pads =3D=
 NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.pads_cn=
t =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_is_om=
ap44xx() || cpu_is_omap34xx())
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap_serial_fill_default_pads(&bdata);
>>
>> Why don't you fill the pads for omap2? It has the same pads, althoug=
h
>> it does not have the serial wake-up events working.
>>
>> And why don't you exit if omap_serial_fill_default_pads fails for th=
e
>> no info case?
>>
>> Shouldn't it be something like:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0res =3D omap_serial_fill_default_pads(&bdata);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!res)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0port =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0port =3D &info[uart->num];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_serial_i=
nit_port(&bdata, port);
>>
>
> Yes if filling of default pads fails we can avoid registering that po=
rt
> however I think that should not depend on availability of port info.
>
> Here [1] is the updated patch.
>
> --
> Thanks,
> Govindraj.R
>
>
> [1]:
>
>
> From ea06c7d5014b68f622b3e2ca226e5a5194d48e9a Mon Sep 17 00:00:00 200=
1
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Tue, 10 Apr 2012 18:21:52 +0530
> Subject: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins a=
nd
> =C2=A0configure rx wakeup
>
> Default pad populating procedure should first probe whether the uart
> pins are available as uart tx/rx pins if yes then we can configure th=
em
> and use rx pin for wakeup capability.
>
> Utilise the mux api available to probe the availability of mux pins
> in uart mode.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Russ Dill <russ.dill@gmail.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>
Tested-by: Russ Dill <russ.dill@ti.com>

> ---
> =C2=A0arch/arm/mach-omap2/mux.c =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
> =C2=A0arch/arm/mach-omap2/mux.h =C2=A0 =C2=A0| =C2=A0 10 ++++++
> =C2=A0arch/arm/mach-omap2/serial.c | =C2=A0 73 ++++++++++++++++++++++=
+++++++++++++++++--
> =C2=A03 files changed, 80 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 65c3391..d937ddd 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -217,8 +217,7 @@ static int __init _omap_mux_get_by_name(struct
> omap_mux_partition *partition,
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
> @@ -225,8 +225,18 @@ omap_hwmod_mux_init(struct omap_device_pad
> *bpads, int nr_pads);
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
> index 2e351f5..9d62cae 100644
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
> @@ -120,11 +121,75 @@ static void omap_uart_set_smartidle(struct
> platform_device *pdev) {}
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
> =C2=A0{
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
> +static int =C2=A0__init omap_serial_fill_default_pads(struct omap_bo=
ard_data *bdata,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct omap_uart_state *uart)
> +{
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
07) && !(tx_mode & 0x07)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_serial_fill_uart_tx_rx_pads(bdata, uart);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> =C2=A0}
> =C2=A0#else
> -static void omap_serial_fill_default_pads(struct omap_board_data *bd=
ata) {}
> +static int __init omap_serial_fill_default_pads(struct omap_board_da=
ta *bdata
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct =
omap_uart_state *uart)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> =C2=A0#endif
>
> =C2=A0char *cmdline_find_option(char *str)
> @@ -289,8 +354,8 @@ void __init omap_serial_board_init(struct
> omap_uart_port_info *info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.pads =3D=
 NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bdata.pads_cnt=
 =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap44x=
x() || cpu_is_omap34xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 omap_serial_fill_default_pads(&bdata);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_serial_fi=
ll_default_pads(&bdata, uart))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0omap_serial_init_port(&bdata, NULL);
> --
> 1.7.9
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
