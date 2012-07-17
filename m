From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: set GPIO mode for mux
 mcspi1_cs2 pin
Date: Tue, 17 Jul 2012 09:11:16 +0200
Message-ID: <CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
References: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
	<CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55248 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab2GQHLR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 03:11:17 -0400
Received: by obbuo13 with SMTP id uo13so146282obb.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 00:11:17 -0700 (PDT)
In-Reply-To: <CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>, Tom Rini <trini@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 10, 2012 at 9:24 AM, Enric Balletb=C3=B2 i Serra
<eballetbo@gmail.com> wrote:
>
>
> 2012/7/10 Javier Martinez Canillas <javier@dowhile0.org>
>>
>> According to the IGEPv2 Rev.C data-sheet the LAN9221i pin 14 (IRQ) i=
s
>> connected to the OMAP3730 mcspi1_cs2 pin. Since this omap mux pin ac=
ts
>> as an IRQ line, it has to be configured as an input GPIO.
>>
>> IGEPv2 platform code sets the smsc911x_cfg->gpio_irq to GPIO 176 but
>> since the mux pin default mode is MODE7 (safe_mode) the driver fails
>> when trying to register the IRQ with the following error message:
>>
>> [    1.994598] smsc911x: Driver version 2008-10-21
>> [    3.704162] irq 272: nobody cared (try booting with the "irqpoll"
>> option)
>> [    3.711364] [<c001a114>] (unwind_backtrace+0x0/0xf0) from [<c009a=
0d4>]
>> (__report_bad_irq+0x20/0xbc)
>> [    3.720916] [<c009a0d4>] (__report_bad_irq+0x20/0xbc) from [<c009=
a41c>]
>> (note_interrupt+0x1d8/0x238)
>> [    3.730560] [<c009a41c>] (note_interrupt+0x1d8/0x238) from [<c009=
8234>]
>> (handle_irq_event_percpu+0xc0/0x260)
>> [    3.740936] [<c0098234>] (handle_irq_event_percpu+0xc0/0x260) fro=
m
>> [<c0098410>] (handle_irq_event+0x3c/0x5c)
>> [    3.751312] [<c0098410>] (handle_irq_event+0x3c/0x5c) from [<c009=
abe0>]
>> (handle_level_irq+0xac/0x10c)
>> [    3.761047] [<c009abe0>] (handle_level_irq+0xac/0x10c) from
>> [<c0097a34>] (generic_handle_irq+0x30/0x48)
>> [    3.770935] [<c0097a34>] (generic_handle_irq+0x30/0x48) from
>> [<c02a6b74>] (gpio_irq_handler+0x180/0x1d4)
>> [    3.780944] [<c02a6b74>] (gpio_irq_handler+0x180/0x1d4) from
>> [<c0097a34>] (generic_handle_irq+0x30/0x48)
>> [    3.790954] [<c0097a34>] (generic_handle_irq+0x30/0x48) from
>> [<c0013e18>] (handle_IRQ+0x4c/0xac)
>> [    3.800231] [<c0013e18>] (handle_IRQ+0x4c/0xac) from [<c000858c>]
>> (omap3_intc_handle_irq+0x60/0x74)
>> [    3.809783] [<c000858c>] (omap3_intc_handle_irq+0x60/0x74) from
>> [<c04979e4>] (__irq_svc+0x44/0x60)
>> [    3.819213] Exception stack(0xee42fde0 to 0xee42fe28)
>> [    3.824554] fde0: 00000001 00000001 00000000 00000000 60000013 c0=
6cce14
>> c06cce14 00000110
>> [    3.833190] fe00: 00000000 c06ccdf4 60000013 ee41d000 fb058064 ee=
42fe28
>> c0089e08 c04976b4
>> [    3.841796] fe20: 20000013 ffffffff
>> [    3.845489] [<c04979e4>] (__irq_svc+0x44/0x60) from [<c04976b4>]
>> (_raw_spin_unlock_irqrestore+0x34/0x44)
>> [    3.855499] [<c04976b4>] (_raw_spin_unlock_irqrestore+0x34/0x44) =
from
>> [<c0099744>] (__setup_irq+0x1b8/0x3f0)
>> [    3.865875] [<c0099744>] (__setup_irq+0x1b8/0x3f0) from [<c0099a3=
4>]
>> (request_threaded_irq+0xb8/0x140)
>> [    3.875701] [<c0099a34>] (request_threaded_irq+0xb8/0x140) from
>> [<c0487950>] (smsc911x_drv_probe+0x75c/0x11a4)
>> [    3.886260] [<c0487950>] (smsc911x_drv_probe+0x75c/0x11a4) from
>> [<c02e9bcc>] (platform_drv_probe+0x18/0x1c)
>> [    3.906707] [<c02e89b8>] (driver_probe_device+0x90/0x210) from
>> [<c02e8bcc>] (__driver_attach+0x94/0x98)
>> [    3.916625] [<c02e8bcc>] (__driver_attach+0x94/0x98) from [<c02e7=
298>]
>> (bus_for_each_dev+0x50/0x7c)
>> [    3.926177] [<c02e7298>] (bus_for_each_dev+0x50/0x7c) from [<c02e=
81d4>]
>> (bus_add_driver+0x184/0x248)
>> [    3.935821] [<c02e81d4>] (bus_add_driver+0x184/0x248) from [<c02e=
909c>]
>> (driver_register+0x78/0x12c)
>> [    3.945465] [<c02e909c>] (driver_register+0x78/0x12c) from [<c000=
8648>]
>> (do_one_initcall+0x34/0x178)
>> [    3.955108] [<c0008648>] (do_one_initcall+0x34/0x178) from [<c066=
e8f4>]
>> (kernel_init+0xfc/0x1c0)
>> [    3.964385] [<c066e8f4>] (kernel_init+0xfc/0x1c0) from [<c00140b0=
>]
>> (kernel_thread_exit+0x0/0x8)
>> [    3.973632] handlers:
>> [    3.976043] [<c034e2cc>] smsc911x_irqhandler
>> [    3.980560] Disabling IRQ #272
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>>  arch/arm/mach-omap2/board-igep0020.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-igep0020.c
>> b/arch/arm/mach-omap2/board-igep0020.c
>> index 7491529..2821448 100644
>> --- a/arch/arm/mach-omap2/board-igep0020.c
>> +++ b/arch/arm/mach-omap2/board-igep0020.c
>> @@ -554,6 +554,8 @@ static const struct usbhs_omap_board_data
>> igep3_usbhs_bdata __initconst =3D {
>>
>>  #ifdef CONFIG_OMAP_MUX
>>  static struct omap_board_mux board_mux[] __initdata =3D {
>> +       /* SMSC9221 LAN Controller ETH IRQ (GPIO_176) */
>> +       OMAP3_MUX(MCSPI1_CS2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
>>         { .reg_offset =3D OMAP_MUX_TERMINATOR },
>>  };
>>  #endif
>> --
>> 1.7.7.6
>>
>
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>
> Thanks Javier,

Hi Tony,

Just pinging to see if you have further comments on this patch or if
it can be applied. It solves a bug on IGEPv2 boards.

I know the trend is to move away from board code. I'll start working
on an device tree for the IGEPv2 but it will take some time until is
ready (and I'm not sure if all the OMAP3 support is already present on
DT).

So could you please take bug fixes for the board code in the meantime?

Thanks a lot and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
