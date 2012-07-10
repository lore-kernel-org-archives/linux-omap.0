From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: set GPIO mode for mux
 mcspi1_cs2 pin
Date: Tue, 10 Jul 2012 09:24:13 +0200
Message-ID: <CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
References: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0090480481445212895=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tom Rini <trini@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0090480481445212895==
Content-Type: multipart/alternative; boundary=e89a8ff24b3b0bed8104c4749e57

--e89a8ff24b3b0bed8104c4749e57
Content-Type: text/plain; charset=UTF-8

2012/7/10 Javier Martinez Canillas <javier@dowhile0.org>

> According to the IGEPv2 Rev.C data-sheet the LAN9221i pin 14 (IRQ) is
> connected to the OMAP3730 mcspi1_cs2 pin. Since this omap mux pin acts
> as an IRQ line, it has to be configured as an input GPIO.
>
> IGEPv2 platform code sets the smsc911x_cfg->gpio_irq to GPIO 176 but
> since the mux pin default mode is MODE7 (safe_mode) the driver fails
> when trying to register the IRQ with the following error message:
>
> [    1.994598] smsc911x: Driver version 2008-10-21
> [    3.704162] irq 272: nobody cared (try booting with the "irqpoll"
> option)
> [    3.711364] [<c001a114>] (unwind_backtrace+0x0/0xf0) from [<c009a0d4>]
> (__report_bad_irq+0x20/0xbc)
> [    3.720916] [<c009a0d4>] (__report_bad_irq+0x20/0xbc) from [<c009a41c>]
> (note_interrupt+0x1d8/0x238)
> [    3.730560] [<c009a41c>] (note_interrupt+0x1d8/0x238) from [<c0098234>]
> (handle_irq_event_percpu+0xc0/0x260)
> [    3.740936] [<c0098234>] (handle_irq_event_percpu+0xc0/0x260) from
> [<c0098410>] (handle_irq_event+0x3c/0x5c)
> [    3.751312] [<c0098410>] (handle_irq_event+0x3c/0x5c) from [<c009abe0>]
> (handle_level_irq+0xac/0x10c)
> [    3.761047] [<c009abe0>] (handle_level_irq+0xac/0x10c) from
> [<c0097a34>] (generic_handle_irq+0x30/0x48)
> [    3.770935] [<c0097a34>] (generic_handle_irq+0x30/0x48) from
> [<c02a6b74>] (gpio_irq_handler+0x180/0x1d4)
> [    3.780944] [<c02a6b74>] (gpio_irq_handler+0x180/0x1d4) from
> [<c0097a34>] (generic_handle_irq+0x30/0x48)
> [    3.790954] [<c0097a34>] (generic_handle_irq+0x30/0x48) from
> [<c0013e18>] (handle_IRQ+0x4c/0xac)
> [    3.800231] [<c0013e18>] (handle_IRQ+0x4c/0xac) from [<c000858c>]
> (omap3_intc_handle_irq+0x60/0x74)
> [    3.809783] [<c000858c>] (omap3_intc_handle_irq+0x60/0x74) from
> [<c04979e4>] (__irq_svc+0x44/0x60)
> [    3.819213] Exception stack(0xee42fde0 to 0xee42fe28)
> [    3.824554] fde0: 00000001 00000001 00000000 00000000 60000013 c06cce14
> c06cce14 00000110
> [    3.833190] fe00: 00000000 c06ccdf4 60000013 ee41d000 fb058064 ee42fe28
> c0089e08 c04976b4
> [    3.841796] fe20: 20000013 ffffffff
> [    3.845489] [<c04979e4>] (__irq_svc+0x44/0x60) from [<c04976b4>]
> (_raw_spin_unlock_irqrestore+0x34/0x44)
> [    3.855499] [<c04976b4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from
> [<c0099744>] (__setup_irq+0x1b8/0x3f0)
> [    3.865875] [<c0099744>] (__setup_irq+0x1b8/0x3f0) from [<c0099a34>]
> (request_threaded_irq+0xb8/0x140)
> [    3.875701] [<c0099a34>] (request_threaded_irq+0xb8/0x140) from
> [<c0487950>] (smsc911x_drv_probe+0x75c/0x11a4)
> [    3.886260] [<c0487950>] (smsc911x_drv_probe+0x75c/0x11a4) from
> [<c02e9bcc>] (platform_drv_probe+0x18/0x1c)
> [    3.906707] [<c02e89b8>] (driver_probe_device+0x90/0x210) from
> [<c02e8bcc>] (__driver_attach+0x94/0x98)
> [    3.916625] [<c02e8bcc>] (__driver_attach+0x94/0x98) from [<c02e7298>]
> (bus_for_each_dev+0x50/0x7c)
> [    3.926177] [<c02e7298>] (bus_for_each_dev+0x50/0x7c) from [<c02e81d4>]
> (bus_add_driver+0x184/0x248)
> [    3.935821] [<c02e81d4>] (bus_add_driver+0x184/0x248) from [<c02e909c>]
> (driver_register+0x78/0x12c)
> [    3.945465] [<c02e909c>] (driver_register+0x78/0x12c) from [<c0008648>]
> (do_one_initcall+0x34/0x178)
> [    3.955108] [<c0008648>] (do_one_initcall+0x34/0x178) from [<c066e8f4>]
> (kernel_init+0xfc/0x1c0)
> [    3.964385] [<c066e8f4>] (kernel_init+0xfc/0x1c0) from [<c00140b0>]
> (kernel_thread_exit+0x0/0x8)
> [    3.973632] handlers:
> [    3.976043] [<c034e2cc>] smsc911x_irqhandler
> [    3.980560] Disabling IRQ #272
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c
> b/arch/arm/mach-omap2/board-igep0020.c
> index 7491529..2821448 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -554,6 +554,8 @@ static const struct usbhs_omap_board_data
> igep3_usbhs_bdata __initconst = {
>
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
> +       /* SMSC9221 LAN Controller ETH IRQ (GPIO_176) */
> +       OMAP3_MUX(MCSPI1_CS2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
>         { .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #endif
> --
> 1.7.7.6
>
>
Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Thanks Javier,

--e89a8ff24b3b0bed8104c4749e57
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/7/10 Javier Martinez Canillas <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:javier@dowhile0.org" target=3D"_blank">j=
avier@dowhile0.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
According to the IGEPv2 Rev.C data-sheet the LAN9221i pin 14 (IRQ) is<br>
connected to the OMAP3730 mcspi1_cs2 pin. Since this omap mux pin acts<br>
as an IRQ line, it has to be configured as an input GPIO.<br>
<br>
IGEPv2 platform code sets the smsc911x_cfg-&gt;gpio_irq to GPIO 176 but<br>
since the mux pin default mode is MODE7 (safe_mode) the driver fails<br>
when trying to register the IRQ with the following error message:<br>
<br>
[ =C2=A0 =C2=A01.994598] smsc911x: Driver version 2008-10-21<br>
[ =C2=A0 =C2=A03.704162] irq 272: nobody cared (try booting with the &quot;=
irqpoll&quot; option)<br>
[ =C2=A0 =C2=A03.711364] [&lt;c001a114&gt;] (unwind_backtrace+0x0/0xf0) fro=
m [&lt;c009a0d4&gt;] (__report_bad_irq+0x20/0xbc)<br>
[ =C2=A0 =C2=A03.720916] [&lt;c009a0d4&gt;] (__report_bad_irq+0x20/0xbc) fr=
om [&lt;c009a41c&gt;] (note_interrupt+0x1d8/0x238)<br>
[ =C2=A0 =C2=A03.730560] [&lt;c009a41c&gt;] (note_interrupt+0x1d8/0x238) fr=
om [&lt;c0098234&gt;] (handle_irq_event_percpu+0xc0/0x260)<br>
[ =C2=A0 =C2=A03.740936] [&lt;c0098234&gt;] (handle_irq_event_percpu+0xc0/0=
x260) from [&lt;c0098410&gt;] (handle_irq_event+0x3c/0x5c)<br>
[ =C2=A0 =C2=A03.751312] [&lt;c0098410&gt;] (handle_irq_event+0x3c/0x5c) fr=
om [&lt;c009abe0&gt;] (handle_level_irq+0xac/0x10c)<br>
[ =C2=A0 =C2=A03.761047] [&lt;c009abe0&gt;] (handle_level_irq+0xac/0x10c) f=
rom [&lt;c0097a34&gt;] (generic_handle_irq+0x30/0x48)<br>
[ =C2=A0 =C2=A03.770935] [&lt;c0097a34&gt;] (generic_handle_irq+0x30/0x48) =
from [&lt;c02a6b74&gt;] (gpio_irq_handler+0x180/0x1d4)<br>
[ =C2=A0 =C2=A03.780944] [&lt;c02a6b74&gt;] (gpio_irq_handler+0x180/0x1d4) =
from [&lt;c0097a34&gt;] (generic_handle_irq+0x30/0x48)<br>
[ =C2=A0 =C2=A03.790954] [&lt;c0097a34&gt;] (generic_handle_irq+0x30/0x48) =
from [&lt;c0013e18&gt;] (handle_IRQ+0x4c/0xac)<br>
[ =C2=A0 =C2=A03.800231] [&lt;c0013e18&gt;] (handle_IRQ+0x4c/0xac) from [&l=
t;c000858c&gt;] (omap3_intc_handle_irq+0x60/0x74)<br>
[ =C2=A0 =C2=A03.809783] [&lt;c000858c&gt;] (omap3_intc_handle_irq+0x60/0x7=
4) from [&lt;c04979e4&gt;] (__irq_svc+0x44/0x60)<br>
[ =C2=A0 =C2=A03.819213] Exception stack(0xee42fde0 to 0xee42fe28)<br>
[ =C2=A0 =C2=A03.824554] fde0: 00000001 00000001 00000000 00000000 60000013=
 c06cce14 c06cce14 00000110<br>
[ =C2=A0 =C2=A03.833190] fe00: 00000000 c06ccdf4 60000013 ee41d000 fb058064=
 ee42fe28 c0089e08 c04976b4<br>
[ =C2=A0 =C2=A03.841796] fe20: 20000013 ffffffff<br>
[ =C2=A0 =C2=A03.845489] [&lt;c04979e4&gt;] (__irq_svc+0x44/0x60) from [&lt=
;c04976b4&gt;] (_raw_spin_unlock_irqrestore+0x34/0x44)<br>
[ =C2=A0 =C2=A03.855499] [&lt;c04976b4&gt;] (_raw_spin_unlock_irqrestore+0x=
34/0x44) from [&lt;c0099744&gt;] (__setup_irq+0x1b8/0x3f0)<br>
[ =C2=A0 =C2=A03.865875] [&lt;c0099744&gt;] (__setup_irq+0x1b8/0x3f0) from =
[&lt;c0099a34&gt;] (request_threaded_irq+0xb8/0x140)<br>
[ =C2=A0 =C2=A03.875701] [&lt;c0099a34&gt;] (request_threaded_irq+0xb8/0x14=
0) from [&lt;c0487950&gt;] (smsc911x_drv_probe+0x75c/0x11a4)<br>
[ =C2=A0 =C2=A03.886260] [&lt;c0487950&gt;] (smsc911x_drv_probe+0x75c/0x11a=
4) from [&lt;c02e9bcc&gt;] (platform_drv_probe+0x18/0x1c)<br>
[ =C2=A0 =C2=A03.906707] [&lt;c02e89b8&gt;] (driver_probe_device+0x90/0x210=
) from [&lt;c02e8bcc&gt;] (__driver_attach+0x94/0x98)<br>
[ =C2=A0 =C2=A03.916625] [&lt;c02e8bcc&gt;] (__driver_attach+0x94/0x98) fro=
m [&lt;c02e7298&gt;] (bus_for_each_dev+0x50/0x7c)<br>
[ =C2=A0 =C2=A03.926177] [&lt;c02e7298&gt;] (bus_for_each_dev+0x50/0x7c) fr=
om [&lt;c02e81d4&gt;] (bus_add_driver+0x184/0x248)<br>
[ =C2=A0 =C2=A03.935821] [&lt;c02e81d4&gt;] (bus_add_driver+0x184/0x248) fr=
om [&lt;c02e909c&gt;] (driver_register+0x78/0x12c)<br>
[ =C2=A0 =C2=A03.945465] [&lt;c02e909c&gt;] (driver_register+0x78/0x12c) fr=
om [&lt;c0008648&gt;] (do_one_initcall+0x34/0x178)<br>
[ =C2=A0 =C2=A03.955108] [&lt;c0008648&gt;] (do_one_initcall+0x34/0x178) fr=
om [&lt;c066e8f4&gt;] (kernel_init+0xfc/0x1c0)<br>
[ =C2=A0 =C2=A03.964385] [&lt;c066e8f4&gt;] (kernel_init+0xfc/0x1c0) from [=
&lt;c00140b0&gt;] (kernel_thread_exit+0x0/0x8)<br>
[ =C2=A0 =C2=A03.973632] handlers:<br>
[ =C2=A0 =C2=A03.976043] [&lt;c034e2cc&gt;] smsc911x_irqhandler<br>
[ =C2=A0 =C2=A03.980560] Disabling IRQ #272<br>
<br>
Signed-off-by: Javier Martinez Canillas &lt;<a href=3D"mailto:javier@dowhil=
e0.org">javier@dowhile0.org</a>&gt;<br>
---<br>
=C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 =C2=A02 ++<br>
=C2=A01 files changed, 2 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/boa=
rd-igep0020.c<br>
index 7491529..2821448 100644<br>
--- a/arch/arm/mach-omap2/board-igep0020.c<br>
+++ b/arch/arm/mach-omap2/board-igep0020.c<br>
@@ -554,6 +554,8 @@ static const struct usbhs_omap_board_data igep3_usbhs_b=
data __initconst =3D {<br>
<br>
=C2=A0#ifdef CONFIG_OMAP_MUX<br>
=C2=A0static struct omap_board_mux board_mux[] __initdata =3D {<br>
+ =C2=A0 =C2=A0 =C2=A0 /* SMSC9221 LAN Controller ETH IRQ (GPIO_176) */<br>
+ =C2=A0 =C2=A0 =C2=A0 OMAP3_MUX(MCSPI1_CS2, OMAP_MUX_MODE4 | OMAP_PIN_INPU=
T),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { .reg_offset =3D OMAP_MUX_TERMINATOR },<br>
=C2=A0};<br>
=C2=A0#endif<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.7.6<br>
<br></font></span></blockquote><div>=C2=A0</div></div>Acked-by: Enric Balle=
tbo i Serra &lt;<a href=3D"mailto:eballetbo@gmail.com">eballetbo@gmail.com<=
/a>&gt;<br>Tested-by: Enric Balletbo i Serra &lt;<a href=3D"mailto:eballetb=
o@gmail.com">eballetbo@gmail.com</a>&gt;<br>
<br>Thanks Javier,<br>

--e89a8ff24b3b0bed8104c4749e57--


--===============0090480481445212895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0090480481445212895==--
