From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]PM: Initialization of SDRC params for DVFS on Zoom2
Date: Wed, 30 Sep 2009 11:06:14 -0700
Message-ID: <636c5030909301106r60eb02c9t968408f06c62829d@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A007938@dbde02.ent.ti.com>
	 <87ljkpm67t.fsf@deeprootsystems.com>
	 <200909091412.07748.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:34143 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbZI3SGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:06:10 -0400
Received: by pxi32 with SMTP id 32so5680868pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 11:06:14 -0700 (PDT)
In-Reply-To: <200909091412.07748.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <jpihet@mvista.com>

Teerth,  ping.

On Wed, Sep 9, 2009 at 5:12 AM, Jean Pihet <jpihet@mvista.com> wrote:
> On Wednesday 09 September 2009 00:17:42 Kevin Hilman wrote:
>> "Reddy, Teerth" <teerth@ti.com> writes:
>> > This patch initializes the SDRC params for DVFS on Zoom2.
>> >
>> > Signed-off-by: Teerth Reddy <teerth@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/board-zoom2.c | =A0 =A06 ++++--
>> > =A01 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c
>> > +++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
>> > @@ -23,6 +23,7 @@
>> >
>> > =A0#include "mmc-twl4030.h"
>> > =A0#include "omap3-opp.h"
>> > +#include "sdram-micron-mt46h32m32lf-6.h"
>> >
>> > =A0static struct omap_uart_config zoom2_uart_config __initdata =3D=
 {
>> > =A0 =A0 .enabled_uarts =A0=3D ((1 << 0) | (1 << 1) | (1 << 2)),
>> > @@ -36,8 +37,9 @@ static void __init omap_zoom2_init_irq(v
>> > =A0{
>> > =A0 =A0 omap_board_config =3D zoom2_config;
>> > =A0 =A0 omap_board_config_size =3D ARRAY_SIZE(zoom2_config);
>> > - =A0 omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_dsp_rate_ta=
ble, omap3_l3_rate_table);
>> > + =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
>> > + =A0 =A0 =A0 =A0 =A0 omap3_mpu_rate_table, omap3_dsp_rate_table,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 omap3_l3_rate_table);
>>
>> Not having looked at the Zoom2 schematics, are you sure this is only
>> using a single chip select? =A0The other boards using the same part
>> (beagle, overo) are interfacing to this part using both CSes.
>>
>> Have you tested DVFS on Zoom2 using the full 256Mb?
> Good point!
>
> DVFS works fine using the two chip selects:
> =A0 =A0 =A0 =A0omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt46h32m32lf6=
_sdrc_params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_mpu_rat=
e_table,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rat=
e_table,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_l3_rate=
_table);
>
> One remark though: since the memory chips are popped on top of the OM=
AP chip
> the schematics are not showing the chip selects connections. In any c=
ase
> U-Boot is configuring the SDRC module to use the 2 chip selects, so I=
 think
> this change is needed.
>
> We need confirmation. Anyone from TI knows?
>
> Regards,
> Jean
>
>>
>> Kevin
>>
>> > =A0 =A0 omap_init_irq();
>> > =A0 =A0 omap_gpio_init();
>> > =A0}
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
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
