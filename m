From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] omap3_beagle: init uart2 for beagle rev AX/BX only
Date: Mon, 7 May 2012 17:52:20 +0530
Message-ID: <CAMrsUdLE5CY_39p6g4gR7bi5B_gyD6ASitaWPA=D+WFvp4Rb=g@mail.gmail.com>
References: <1331024711-23578-1-git-send-email-govindraj.raja@ti.com> <20120504181808.GM5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:59065 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756287Ab2EGMWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 08:22:42 -0400
Received: by obqv19 with SMTP id v19so10361022obq.8
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 05:22:41 -0700 (PDT)
In-Reply-To: <20120504181808.GM5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Kevin Hilman <khilman@ti.com>, Koen Kooi <koen@dominion.thruhere.net>

On Fri, May 4, 2012 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> Looking at this again..
>
> * Govindraj.R <govindraj.raja@ti.com> [120306 00:34]:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> All beagle boards rev > AX/BX have external usb hubs connected to eh=
ci
>> interface, external hub/peripheral uses a nreset sequence for which
>> uart2_rx.gpio_147 pin in mux mode4(USB2HS_nRST) is used on all beagl=
e
>> boards expect rev Ax/BX.
>> (Reference to all beagle boards rev schematics:
>> http://beagleboard.org/hardware/design)
>>
>> Initialising uart2 will lead to serial init taking over uart2_rx pin
>> so init uart2_rx pin mux only for Beagle AX/BX rev boards.
>> Dont init uart2 for all other boards allowing usb_ehci functionality=
=2E
>
> OK so the above got fixed for the muxing part with commit
> bce492c04ba8fc66a4ea0a52b181ba255daaaf54.
>
>> To initialise individual uart port by id utilise and modify the exis=
ting
>> available func. omap_serial_board_init.
>
> This makes sense as board specific fixes.
>
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -126,6 +126,7 @@ static void __init omap3_beagle_init_rev(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.mmc1_gpio_wp =3D 29;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.reset_gpio =3D 170;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 beagle_config.usr_button_gpio =3D 7;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_board_init(NULL, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 6:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "OMAP3 Beagle Rev: C1/C=
2/C3\n");
>> @@ -528,7 +529,10 @@ static void __init omap3_beagle_init(void)
>> =A0 =A0 =A0 platform_add_devices(omap3_beagle_devices,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap3_beagle_=
devices));
>> =A0 =A0 =A0 omap_display_init(&beagle_dss_data);
>> - =A0 =A0 omap_serial_init();
>> + =A0 =A0 omap_serial_board_init(NULL, 0);
>> + =A0 =A0 omap_serial_board_init(NULL, 2);
>> + =A0 =A0 omap_serial_board_init(NULL, 3);
>> +
>> =A0 =A0 =A0 omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt46=
h32m32lf6_sdrc_params);
>>
>
> So this still looks valid, except now you also add the muxing for the
> uart pins instead of NULL? Note that you could define OMAP3_UART1_DEF=
AULT_PINS
> etc in some header.
>
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -393,30 +393,32 @@ void __init omap_serial_init_port(struct omap_=
board_data *bdata,
>> =A0/**
>> =A0 * omap_serial_board_init() - initialize all supported serial por=
ts
>> =A0 * @info: platform specific data pointer
>> + * @port_id: uart port number to be initialised
>> =A0 *
>> - * Initializes all available UARTs as serial ports. Platforms
>> + * Initializes individual UARTs as serial ports. Platforms
>> =A0 * can call this function when they want to have default behaviou=
r
>> - * for serial ports (e.g initialize them all as serial ports).
>> + * for serial ports (e.g initialize individual serial ports based o=
n port id).
>> =A0 */
>> -void __init omap_serial_board_init(struct omap_uart_port_info *info=
)
>> +void __init omap_serial_board_init(struct omap_uart_port_info *info=
, u8 port_id)
>> =A0{
>> =A0 =A0 =A0 struct omap_uart_state *uart;
>> =A0 =A0 =A0 struct omap_board_data bdata;
>>
>> - =A0 =A0 list_for_each_entry(uart, &uart_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bdata.id =3D uart->num;
>> - =A0 =A0 =A0 =A0 =A0 =A0 bdata.flags =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads =3D NULL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads_cnt =3D 0;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap34xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_fill_default_p=
ads(&bdata);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!info)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_init_port(&bda=
ta, NULL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_init_port(&bda=
ta, &info[uart->num]);
>> - =A0 =A0 }
>> + =A0 =A0 list_for_each_entry(uart, &uart_list, node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (uart->num =3D=3D port_id) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.id =3D uart->num;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.flags =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads_cnt =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_is_omap24xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_seria=
l_fill_default_pads(&bdata);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_seria=
l_init_port(&bdata, NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_seria=
l_init_port(&bdata, info);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0}
>> @@ -428,5 +430,8 @@ void __init omap_serial_board_init(struct omap_u=
art_port_info *info)
>> =A0 */
>> =A0void __init omap_serial_init(void)
>> =A0{
>> - =A0 =A0 omap_serial_board_init(NULL);
>> + =A0 =A0 struct omap_uart_state *uart;
>> +
>> + =A0 =A0 list_for_each_entry(uart, &uart_list, node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_board_init(NULL, uart->num);
>> =A0}
>
> Is this fix still needed? If so, it should probably be a separate fix
> with it's own description.

No this one is not needed anymore
since its fixed part of commit
bce492c04ba8fc66a4ea0a52b181ba255daaaf54

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
