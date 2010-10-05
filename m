From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 14:47:17 +0800
Message-ID: <AANLkTikq8tEsG85zb4k8AZ-4WX76HQ--tzEya8jjoOR7@mail.gmail.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com>
	<4CA9C5F6.7060902@ti.com>
	<AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
	<AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com>
	<87wrpy0xp3.fsf@deeprootsystems.com>
	<AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com>
	<87iq1hzt3u.fsf@deeprootsystems.com>
	<AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com>
	<alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44202 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab0JEGrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:47:18 -0400
Received: by wyb28 with SMTP id 28so5719887wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 23:47:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, Pramod <pramod.gurav@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

2010/10/5 Paul Walmsley <paul@pwsan.com>:
> Hello Lei,
>
> On Tue, 5 Oct 2010, Ming Lei wrote:
>
>> 2010/10/5 Kevin Hilman <khilman@deeprootsystems.com>:
>> > Ming Lei <tom.leiming@gmail.com> writes:
>> >
>> >> 2010/10/4 Kevin Hilman <khilman@deeprootsystems.com>:
>> >>>
>> >>> Why? =A0What do you need from the PM branch that is not in l-o m=
aster?
>> >>
>> >> Seems master branch works fine for me, my beagle board doesn't ha=
ng
>> >> uart3 disabling clocks.
>> >
>> > Master branch and PM branch have exactly the same functionality fo=
r
>> > UART hwmods. =A0The problem was that you manually enabled DEBUG in
>> > omap_hwmod.c.
>>
>> Yes, you are correct. If DEBUG in omap_hwmod.c is enabled manually,
>> and pass the parameter of 'earlyprintk loglevel=3D8' to kernel from =
bootloader,
>> this issue can be triggered even with master branch.
>
> Does this experimental patch solve the problem, even if DEBUG is enab=
led
> in the hwmod code?
>
>
> - Paul
>
> From d928bd31c9c4ad16a044b244ef3d2ad3ed648f6f Mon Sep 17 00:00:00 200=
1
> From: Paul Walmsley <paul@pwsan.com>
> Date: Tue, 5 Oct 2010 00:11:27 -0600
> Subject: [PATCH] RFC: omap serial: block console output while resetti=
ng earlyconsole UART
>
> Currently, no attempt is made to block console output while the
> earlyconsole UART is unavailable. =A0This can result in silent crashe=
s
> that are very difficult to debug due to the lack of console output.
> This patch holds the console semaphore while resetting the active con=
sole
> UART, which causes all console output during that time to be buffered=
 and
> then transmitted after the console semaphore is released.

Good works, this patch does fix the issue!

With the patch, even DEBUG in omap_hwmod.c is enabled manually
and 'earlyprintk loglevel=3D8' is passed to kernel, my beagle board can=
't
hang after 'uart3: disabling clocks' is printed.

>
> Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/serial.c | =A0100 ++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 100 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index 338e46a..577f8f9 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -28,10 +28,13 @@
> =A0#include <linux/serial_8250.h>
> =A0#include <linux/pm_runtime.h>
>
> +#include <linux/console.h>
> +
> =A0#ifdef CONFIG_SERIAL_OMAP
> =A0#include <plat/omap-serial.h>
> =A0#endif
>
> +#include <plat/serial.h>
> =A0#include <plat/common.h>
> =A0#include <plat/board.h>
> =A0#include <plat/clock.h>
> @@ -39,6 +42,8 @@
> =A0#include <plat/omap_hwmod.h>
> =A0#include <plat/omap_device.h>
>
> +#include <asm/memory.h>
> +
> =A0#include "prm.h"
> =A0#include "pm.h"
> =A0#include "cm.h"
> @@ -51,6 +56,8 @@
> =A0#define UART_ERRATA_FIFO_FULL_ABORT =A0 =A0(0x1 << 0)
> =A0#define UART_ERRATA_i202_MDR1_ACCESS =A0 (0x1 << 1)
>
> +#define uart_id_to_ttys_id(u) =A0 =A0 =A0 =A0 =A0(u - 1)
> +
> =A0/*
> =A0* NOTE: By default the serial timeout is disabled as it causes los=
t characters
> =A0* over the serial ports. This means that the UART clocks will stay=
 on until
> @@ -106,6 +113,83 @@ static LIST_HEAD(uart_list);
> =A0static u8 num_uarts;
>
> =A0/*
> + * early_console_uart: if earlyconsole is enabled and active, the UA=
RT
> + * ID (e.g., 1, 2, 3, 4) will be stored here. =A0'0' means earlycons=
ole
> + * is disabled or some problem occurred during earlyconsole handling=
=2E
> + */
> +static int early_console_uart;
> +
> +#define for_each_console(con) \
> + =A0 =A0 =A0 for (con =3D console_drivers; con !=3D NULL; con =3D co=
n->next)
> +
> +/* XXX belongs in kernel/printk.c or some earlyconsole file */
> +/* XXX The "earlycon" string is an ugly hack */
> +int _is_early_console_enabled(void)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct console *c;
> +
> + =A0 =A0 =A0 acquire_console_sem();
> + =A0 =A0 =A0 for_each_console(c)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp("earlycon", c->name))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 release_console_sem();
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/* XXX document */
> +static int _get_early_console_uart(void)
> +{
> + =A0 =A0 =A0 u32 v;
> + =A0 =A0 =A0 int u =3D -EINVAL;
> +
> + =A0 =A0 =A0 v =3D __raw_readl(phys_to_virt(OMAP_UART_INFO));
> + =A0 =A0 =A0 /* XXX see the OMAP debug-macro.S for this table */
> + =A0 =A0 =A0 switch (v) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 case OMAP2UART1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OMAP2UART2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OMAP2UART3:
> + =A0 =A0 =A0 case OMAP3UART3:
> + =A0 =A0 =A0 case OMAP4UART3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OMAP3UART4:
> + =A0 =A0 =A0 case OMAP4UART4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case ZOOM_UART:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap serial: ZOOM UART in use =
- does that go through "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the OMAP serial code?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "omap serial: unknown serial po=
rt in use!\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return u;
> +}
> +
> +/* XXX document */
> +static void _store_early_console_uart_id(void)
> +{
> + =A0 =A0 =A0 int uart_id;
> +
> + =A0 =A0 =A0 if (_is_early_console_enabled()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_id =3D _get_early_console_uart();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_id > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 early_console_uart =3D =
uart_id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("omap serial: e=
arly console active on UART%d (ttyS%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_id=
, uart_id_to_ttys_id(uart_id));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +/*
> =A0* Since these idle/enable hooks are used in the idle path itself
> =A0* which has interrupts disabled, use the non-locking versions of
> =A0* the hwmod enable/disable functions.
> @@ -801,6 +885,17 @@ void __init omap_serial_init_port(int port)
> =A0 =A0 =A0 =A0oh->dev_attr =3D uart;
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* XXX How do we know whether the console is on this =
UART or not?
> + =A0 =A0 =A0 =A0* We should only call acquire_console_sem() if the c=
onsole is on
> + =A0 =A0 =A0 =A0* this UART.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Of course, the console is not the only thing that =
could be using
> + =A0 =A0 =A0 =A0* this UART.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (uart->num =3D=3D uart_id_to_ttys_id(early_console_u=
art))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acquire_console_sem();
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Because of early UART probing, UART did not get idl=
ed
> =A0 =A0 =A0 =A0 * on init. =A0Now that omap_device is ready, ensure f=
ull idle
> =A0 =A0 =A0 =A0 * before doing omap_device_enable().
> @@ -824,6 +919,9 @@ void __init omap_serial_init_port(int port)
> =A0 =A0 =A0 =A0omap_uart_block_sleep(uart);
> =A0 =A0 =A0 =A0uart->timeout =3D DEFAULT_TIMEOUT;
>
> + =A0 =A0 =A0 if (uart->num =3D=3D uart_id_to_ttys_id(early_console_u=
art))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_console_sem();
> +
> =A0 =A0 =A0 =A0if ((cpu_is_omap34xx() && uart->padconf) ||
> =A0 =A0 =A0 =A0 =A0 =A0(uart->wk_en && uart->wk_mask)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_init_wakeup(&od->pdev.dev, true=
);
> @@ -846,6 +944,8 @@ void __init omap_serial_init(void)
> =A0{
> =A0 =A0 =A0 =A0struct omap_uart_state *uart;
>
> + =A0 =A0 =A0 _store_early_console_uart_id();
> +
> =A0 =A0 =A0 =A0list_for_each_entry(uart, &uart_list, node)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_init_port(uart->num);
> =A0}
> --
> 1.7.1
>


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
