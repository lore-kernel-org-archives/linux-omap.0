From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 03/12] OMAP2+: Serial: Add default mux for all uarts.
Date: Wed, 4 May 2011 16:04:16 +0530
Message-ID: <BANLkTikcCHUP8j_z1A6mfmjj6_i9P-HN-g@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-4-git-send-email-govindraj.raja@ti.com> <20110504100051.GZ2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59300 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1EDKej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:34:39 -0400
In-Reply-To: <20110504100051.GZ2092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, May 4, 2011 at 3:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>> Add default mux data for all uarts if mux info is not passed from
>> board file to avoid breaking any board support.
>
> This should only happen if omap_serial_init is called,
> then boards can still use platform data with omap_serial_init_port.

Yes correct thats how its designed with this patch series.
One can use omap_serial_init to initialize all uarts
or use omap_serial_init_port for individual uart.

Default pads are filled only if board uses omap_serial_init(NULL);
to initialize all uarts.

>
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -66,6 +66,129 @@ static struct omap_device_pm_latency omap_uart_l=
atency[] =3D {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> +#ifdef CONFIG_OMAP_MUX
>> +static struct omap_device_pad default_uart1_pads[] __initdata =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart1_cts.uart1_cts",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_M=
UX_MODE0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart1_rts.uart1_rts",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart1_tx.uart1_tx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart1_rx.uart1_rx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D OMAP_DEVICE_PAD_REMUX | OMAP=
_DEVICE_PAD_WAKEUP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_M=
UX_MODE0,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_device_pad default_uart2_pads[] __initdata =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart2_cts.uart2_cts",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_M=
UX_MODE0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart2_rts.uart2_rts",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart2_tx.uart2_tx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart2_rx.uart2_rx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D OMAP_DEVICE_PAD_REMUX | OMAP=
_DEVICE_PAD_WAKEUP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_M=
UX_MODE0,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_device_pad default_uart3_pads[] __initdata =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_cts_rctx.uart3_cts_rc=
tx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_M=
UX_MODE0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_rts_sd.uart3_rts_sd",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_tx_irtx.uart3_tx_irtx=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart3_rx_irrx.uart3_rx_irrx=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D OMAP_DEVICE_PAD_REMUX | OMAP=
_DEVICE_PAD_WAKEUP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT | OMAP_MUX_MODE=
0,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_device_pad default_omap36xx_uart4_pads[] __initd=
ata =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "gpmc_wait2.uart4_tx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "gpmc_wait3.uart4_rx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D OMAP_DEVICE_PAD_REMUX | OMAP=
_DEVICE_PAD_WAKEUP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT | OMAP_MUX_MODE=
2,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_device_pad default_omap4_uart4_pads[] __initdata=
 =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart4_tx.uart4_tx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_OUTPUT | OMAP_MUX_MOD=
E0,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "uart4_rx.uart4_rx",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D OMAP_DEVICE_PAD_REMUX | OMAP=
_DEVICE_PAD_WAKEUP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D OMAP_PIN_INPUT | OMAP_MUX_MODE=
0,
>> + =A0 =A0 },
>
> Looks like you could easily allocate the struct and use sprintf
> to generate this as needed to avoid duplication.

Only uart1/2 have common name

* uart3 having different naming pins
* uart4 doesnt have cts/rts
* uart4 on 3630 uses gpmc.wait2
* rx requires wakeup enable flag

So would again give me a function with switch case for uart1/2/3/4
which is very similar to above structs.

Thats the reson I kept individual structs.
Also becomes easy if we need to disable or avoid a
individual uart pad.

--
Thanks,
Govindraj.R


>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
