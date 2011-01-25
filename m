From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Tue, 25 Jan 2011 21:16:37 +0530
Message-ID: <AANLkTi=PqUBrrZwWbipXDNxoKrcX8MefZjdeaOrgPApV@mail.gmail.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60280 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526Ab1AYPql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 10:46:41 -0500
Received: by mail-wy0-f175.google.com with SMTP id 40so5753181wyb.20
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 07:46:38 -0800 (PST)
In-Reply-To: <20110124201731.GC13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110123 09:47]:
>> On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux w=
rote:
>> > Move non-mapping and non-irq initialization code out of .map_io an=
d
>> > .init_irq respectively into the new init_early hook.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> > I think I've updated this patch correctly for the new platforms me=
rged
>> > into mainline.
>>
>> Grr, this breaks on OMAP because some of this stuff wants to do iore=
map()
>> and therefore wants the kmem allocators initialized. =A0That's rathe=
r
>> annoying...
>
> So far tested on zoom3 only, but the following gets it booting
> on top of your patch.
>
> Want to take this one into your series?
>
> Meanwhile, I'll add these both into our omap-testing branch
> for some more testing.
>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 24 Jan 2011 11:56:37 -0800
> Subject: [PATCH] omap2+: Fix omap_serial_early_init to work with init=
_early hook
>
> The new init_early hook happens at the end of setup_arch,
> which is too early for kzalloc. However, there's no need
> to call omap_serial_early_init that early, so fix this
> by setting it up as a subsys_initcall.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -400,8 +400,6 @@ void __init omap2_init_common_infrastructure(void=
)
> =A0void __init omap2_init_common_devices(struct omap_sdrc_params *sdr=
c_cs0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct omap_sdrc_params *sdrc_cs1)
> =A0{
> - =A0 =A0 =A0 omap_serial_early_init();
> -
> =A0 =A0 =A0 =A0omap_hwmod_late_init();
>
> =A0 =A0 =A0 =A0if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -655,7 +655,7 @@ static void serial_out_override(struct uart_port =
*up, int offset, int value)
> =A0}
> =A0#endif
>
> -void __init omap_serial_early_init(void)
> +static int __init omap_serial_early_init(void)
> =A0{
> =A0 =A0 =A0 =A0int i =3D 0;
>
> @@ -691,7 +691,10 @@ void __init omap_serial_early_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart->oh->flags |=3D HWMOD_INIT_NO_IDL=
E | HWMOD_INIT_NO_RESET;
> =A0 =A0 =A0 =A0} while (1);
> +
> + =A0 =A0 =A0 return 0;
> =A0}
> +subsys_initcall(omap_serial_early_init);
>
> =A0/**
> =A0* omap_serial_init_port() - initialize single serial port
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -96,7 +96,6 @@
>
> =A0struct omap_board_data;
>
> -extern void __init omap_serial_early_init(void);
> =A0extern void omap_serial_init(void);
> =A0extern void omap_serial_init_port(struct omap_board_data *bdata);
> =A0extern int omap_uart_can_sleep(void);
> --

Just FYI, I observed similar results on OMAP4 for these patches.
=46or OMAP2420, OMAP2430 and OMAP3430 SDPs, you can add my boot
Tested-by: Sourav Poddar<sourav.poddar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
