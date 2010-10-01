From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 02/14] omap: Map only available sram memory
Date: Fri, 1 Oct 2010 23:15:44 +0300
Message-ID: <AANLkTi=PM1x7zXbSMRxBHVZ5Z2+4iwebvbiGizca_rC8@mail.gmail.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35695 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0JAUPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:15:45 -0400
Received: by qwh6 with SMTP id 6so1695564qwh.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 13:15:44 -0700 (PDT)
In-Reply-To: <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

On Fri, Sep 17, 2010 at 12:47 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Currently we map 1 MB section while setting up SRAM on OMAPs.
> The actual physcal OCM RAM available on OMAP SOCs is in order
> of KBs. This patch maps only available sram and removes some
> non necessary cpu_is_xxx checks.
>
> On the newer ARMs with speculation, this is dangerous and can
> result in untraceable aborts.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

This hangs OMAP3 pandora:

[    0.000000] Linux version
2.6.36-rc6-next-20101001-00002-ge76bb53-dirty (notaz@pixelinis) (gcc
version 4.3.3 (Sourcery G++ Lite 2009q1-20
[    0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D=
10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] Machine: Pandora Handheld Console
[    0.000000] Ignoring unrecognised tag 0x54410008
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Reserving 6422528 bytes SDRAM for VRAM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x1000=
0
(stuck here)

reverting this fixes the problem.

> ---
> =A0arch/arm/plat-omap/sram.c | =A0 25 +++++--------------------
> =A01 files changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 226b2e8..10b3b4c 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -220,20 +220,7 @@ void __init omap_map_sram(void)
> =A0 =A0 =A0 =A0if (omap_sram_size =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 if (cpu_is_omap24xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_sram_io_desc[0].virtual =3D OMAP2_=
SRAM_VA;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP2_SRAM_PA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D ROUND_DOWN(base, PAGE_SIZE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_sram_io_desc[0].pfn =3D __phys_to_=
pfn(base);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_sram_io_desc[0].virtual =3D OMAP3_=
SRAM_VA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP3_SRAM_PA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D ROUND_DOWN(base, PAGE_SIZE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_sram_io_desc[0].pfn =3D __phys_to_=
pfn(base);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * SRAM must be marked as non-cached o=
n OMAP3 since the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * CORE DPLL M2 divider change code (i=
n SRAM) runs with the
> @@ -244,13 +231,11 @@ void __init omap_map_sram(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_sram_io_desc[0].type =3D MT_MEMOR=
Y_NONCACHED;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (cpu_is_omap44xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_sram_io_desc[0].virtual =3D OMAP4_=
SRAM_VA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D OMAP4_SRAM_PA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D ROUND_DOWN(base, PAGE_SIZE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_sram_io_desc[0].pfn =3D __phys_to_=
pfn(base);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 omap_sram_io_desc[0].length =3D 1024 * 1024; =A0 =A0 =A0=
/* Use section desc */
> + =A0 =A0 =A0 omap_sram_io_desc[0].virtual =3D omap_sram_base;
> + =A0 =A0 =A0 base =3D omap_sram_start;
> + =A0 =A0 =A0 base =3D ROUND_DOWN(base, PAGE_SIZE);
> + =A0 =A0 =A0 omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);
> + =A0 =A0 =A0 omap_sram_io_desc[0].length =3D ROUND_DOWN(omap_sram_si=
ze, PAGE_SIZE);
> =A0 =A0 =A0 =A0iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_i=
o_desc));
>
> =A0 =A0 =A0 =A0printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08l=
x size: 0x%lx\n",
> --
> 1.6.0.4
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
