From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: Re: DSS2 broken with 36-rc1
Date: Tue, 24 Aug 2010 17:21:48 -0700
Message-ID: <AANLkTinZkdd289cbzfgymK5Tkk2JRi0gd+bfNxGG-HoA@mail.gmail.com>
References: <1281962906.1888.25.camel@chotu>
	<4C72192A.9050801@compulab.co.il>
	<4C721DFA.9010009@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab0HYAVt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 20:21:49 -0400
Received: by wyb35 with SMTP id 35so1165519wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 17:21:48 -0700 (PDT)
In-Reply-To: <4C721DFA.9010009@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Ameya Palande <ameya.palande@nokia.com>, tomi.valkeinen@nokia.com, linux-omap <linux-omap@vger.kernel.org>

On Mon, Aug 23, 2010 at 12:06 AM, Mike Rapoport <mike@compulab.co.il> w=
rote:
> Mike Rapoport wrote:
>>
>> Hi Ameya,
>>
>> Ameya Palande wrote:
>>>
>>> Hi Tomi,
>>>
>>> When I tried to boot 2.6.36-rc1 kernel on Nokia N900, omapfb failed=
 with
>>> following error messages:
>>>
>>> [ =C2=A0 =C2=A00.124145] OMAP DSS rev 2.0
>>> [ =C2=A0 =C2=A00.124237] OMAP DISPC rev 3.0
>>>
>>> [ =C2=A0 =C2=A00.303833] acx565akm spi1.2: omapfb: acx565akm rev 8b=
 LCD detected
>>>
>>> [ =C2=A0 =C2=A00.805419] omapfb omapfb: failed to allocate framebuf=
fer
>>> [ =C2=A0 =C2=A00.810882] omapfb omapfb: failed to allocate fbmem
>>> [ =C2=A0 =C2=A00.815856] omapfb omapfb: failed to setup omapfb
>>> [ =C2=A0 =C2=A00.820648] omapfb: probe of omapfb failed with error =
-12
>>
>
> Please discard the previous patch, it's buggy :(
> Sorry for the noise.
>
> From 81e9278ad27bc91be42105321e0e26d0be9e883b Mon Sep 17 00:00:00 200=
1
> From: Mike Rapoport <mike@compulab.co.il>
> Date: Mon, 23 Aug 2010 09:40:09 +0300
> Subject: [PATCH] OMAP: DSS2: OMAPFB: use phys_to_virt for RAM mapping=
s
>
> After commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8 (ARM: Prohibit
> ioremap() on kernel managed RAM) it is impossible to ioremap SDRAM fo=
r
> the framebuffer. Use phys_to_virt for kernel managed RAM mapping and
> ioremap for other memory types
>
> Reported-by: Ameya Palande <ameya.palande@nokia.com>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> =C2=A0arch/arm/plat-omap/include/plat/vram.h =C2=A0 | =C2=A0 =C2=A01 =
+
> =C2=A0drivers/video/omap2/omapfb/omapfb-main.c | =C2=A0 =C2=A02 +-
> =C2=A0drivers/video/omap2/vram.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 10 ++++++++++
> =C2=A03 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/vram.h
> b/arch/arm/plat-omap/include/plat/vram.h
> index 0aa4ecd..b1b137c 100644
> --- a/arch/arm/plat-omap/include/plat/vram.h
> +++ b/arch/arm/plat-omap/include/plat/vram.h
> @@ -33,6 +33,7 @@ extern int omap_vram_alloc(int mtype, size_t size,
> unsigned long *paddr);
> =C2=A0extern int omap_vram_reserve(unsigned long paddr, size_t size);
> =C2=A0extern void omap_vram_get_info(unsigned long *vram, unsigned lo=
ng
> *free_vram,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
*largest_free_block);
> +extern void __iomem *omap_vram_remap(size_t size, unsigned long padd=
r);
>
> =C2=A0#ifdef CONFIG_OMAP2_VRAM
> =C2=A0extern void omap_vram_set_sdram_vram(u32 size, u32 start);
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 04034d4..39f53b1 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -1436,7 +1436,7 @@ static int omapfb_alloc_fbmem(struct fb_info *f=
bi,
> unsigned long size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ofbi->rotation_type !=3D OMAP_DSS_ROT_=
VRFB) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vaddr =3D ioremap_=
wc(paddr, size);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vaddr =3D omap_vra=
m_remap(size, paddr);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vaddr) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dev_err(fbdev->dev, "failed to ioremap
> framebuffer\n");
> diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> index f6fdc20..37557b6 100644
> --- a/drivers/video/omap2/vram.c
> +++ b/drivers/video/omap2/vram.c
> @@ -30,6 +30,7 @@
> =C2=A0#include <linux/debugfs.h>
> =C2=A0#include <linux/jiffies.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/io.h>
>
> =C2=A0#include <asm/setup.h>
>
> @@ -425,6 +426,15 @@ void omap_vram_get_info(unsigned long *vram,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(omap_vram_get_info);
>
> +void __iomem *omap_vram_remap(size_t size, unsigned long paddr)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (region_mem_type(paddr) =3D=3D OMAP_VRAM_ME=
MTYPE_SDRAM)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return phys_to_vir=
t(paddr);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ioremap_wc(paddr, size);
> +}
> +EXPORT_SYMBOL(omap_vram_remap);
> +
> =C2=A0#if defined(CONFIG_DEBUG_FS)
> =C2=A0static int vram_debug_show(struct seq_file *s, void *unused)
> =C2=A0{
> --
> 1.6.6.2
>
>
>
> --
> Sincerely yours,
> Mike.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I just tried this on my custom board, and it solves my issue with
ioremap. As a point of consistency, I'd reverse the order of the
parameters on omap_vram_remap() so that they match the old
ioremap_wc() call. Otherwise, I'd ACK this patch.


--=20
Laine Walker-Avina
=46irmware Engineer
PASCO scientific
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
