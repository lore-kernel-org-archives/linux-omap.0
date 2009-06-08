From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:
	Re: Beagleboard rev C memory timings & suspend/resume)
Date: Mon, 8 Jun 2009 14:01:18 +0300
Message-ID: <6ed0b2680906080401g64ed4dbcpa24bbad3841a2b2d@mail.gmail.com>
References: <200904291553.49378.jpihet@mvista.com>
	 <alpine.DEB.2.00.0906051308370.31531@utopia.booyaka.com>
	 <6ed0b2680906060350i4de093fbj3575ba117c084295@mail.gmail.com>
	 <200906081102.00779.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58969 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbZFHLBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 07:01:17 -0400
Received: by fxm9 with SMTP id 9so2060761fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2009 04:01:18 -0700 (PDT)
In-Reply-To: <200906081102.00779.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Jun 8, 2009 at 12:02 PM, Jean Pihet<jpihet@mvista.com> wrote:
> Paul, Gra=9Evydas,
>
> Ok, thanks!
>
> Here is a patch that addresses the Pandora's use of 2 SDRAM chip sele=
cts.
> It applies on top of 'OMAP3: add support for 2 SDRAM chip selects'.
>
> Is that OK? It has been build tested only.

thanks!

>
> Regards,
> Jean
>
> From 297a0b09267fc1a0ae4428771ff54b73b27d5bbe Mon Sep 17 00:00:00 200=
1
> From: Jean Pihet <jpihet@mvista.com>
> Date: Mon, 8 Jun 2009 10:49:53 +0200
> Subject: OMAP3 Pandora: add support for 2 SDRAM chip selects
>
> This allows the self refresh to work correctly on
> Pandora.
>
> Signed-off-by: Jean Pihet <jpihet@mvista.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3pandora.c | =A0 =A08 +++++++-
> =A01 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c
> b/arch/arm/mach-omap2/board-omap3pandora.c
> index 05ab99e..ba015b4 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -44,6 +44,7 @@
> =A0#include <mach/gpmc.h>
> =A0#include <mach/hardware.h>
> =A0#include <mach/nand.h>
> +#include <mach/mux.h>
> =A0#include <mach/usb.h>
> =A0#include <mach/mcspi.h>
>
> @@ -220,7 +221,8 @@ static int __init omap3pandora_i2c_init(void)
>
> =A0static void __init omap3pandora_init_irq(void)
> =A0{
> - =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL,
> + =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt46h32m32lf=
6_sdrc_params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL, N=
ULL);

Hm, since pandora uses OMAP3530, maybe it should also have
omap3_*_rate_table args passed? Could also be true for Overo, at least
for omap3_mpu_rate_table and omap3_l3_rate_table, as some models use
OMAP3503 without the DSP.

> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> @@ -307,6 +309,10 @@ static void __init omap3pandora_init(void)
> =A0 =A0 =A0 =A0usb_ehci_init();
> =A0 =A0 =A0 =A0omap3pandora_flash_init();
> =A0 =A0 =A0 =A0omap3pandora_ads7846_init();
> +
> + =A0 =A0 =A0 /* Ensure SDRC pins are mux'd for self-refresh */
> + =A0 =A0 =A0 omap_cfg_reg(H16_34XX_SDRC_CKE0);
> + =A0 =A0 =A0 omap_cfg_reg(H17_34XX_SDRC_CKE1);
> =A0}
>
> =A0static void __init omap3pandora_map_io(void)
> --
> 1.6.2.5.168.g3823
>
>
> On Saturday 06 June 2009 12:50:42 Grazvydas Ignotas wrote:
>> On Fri, Jun 5, 2009 at 10:14 PM, Paul Walmsley<paul@pwsan.com> wrote=
:
>> > Hi Jean,
>> >
>> > On Fri, 5 Jun 2009, Jean Pihet wrote:
>> >> Some notes:
>> >> - all calls to omap2_init_common_hw have been adapted in the boar=
d
>> >> files. it looks like 2430SDP and Pandora board files are broken s=
ince
>> >> they use only one param. Can that be checked on those boards?
>> >
>> > Yep, builds with those two boards are broken on the PM branch, and=
 it
>> > looks like your patch fixes both.
>> >
>> > Gra=9Eyvdas, looks like Pandora might use 2 SDRAM chipselects also=
?
>>
>> Yes it does, it uses different part than Beagle rev C (256/512
>> RAM/NAND instead of 256/256), but RAM portion should be identical I
>> guess.
>>
>>
>> Gra=9Evydas
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
