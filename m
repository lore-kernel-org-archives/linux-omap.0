From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED instead
 of MT_DEVICE
Date: Thu, 19 Aug 2010 11:29:27 -0700
Message-ID: <AANLkTi=9k19RUmfnNBO8AfFj_LtyNtsPPVYC_=-AW5yE@mail.gmail.com>
References: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55906 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0HSSbd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 14:31:33 -0400
Received: by gwj17 with SMTP id 17so871443gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 11:31:32 -0700 (PDT)
In-Reply-To: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com

On Sun, Aug 8, 2010 at 3:18 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
>
> Since the section mapping limitation gets fixed with first
> patch in this series, the MT_MEMORY_NONCACHED can be used now.
>
> Have not tested this, so somebody with Davinci hardware can
> try this out
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: davinci-linux-open-source@linux.davincidsp.com
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
> =A0arch/arm/mach-davinci/dm355.c =A0| =A0 =A03 +--
> =A0arch/arm/mach-davinci/dm365.c =A0| =A0 =A03 +--
> =A0arch/arm/mach-davinci/dm644x.c | =A0 =A03 +--
> =A0arch/arm/mach-davinci/dm646x.c | =A0 =A03 +--
> =A04 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm=
355.c
> index 3834781..e7bd2ad 100644
> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c
> @@ -767,8 +767,7 @@ static struct map_desc dm355_io_desc[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.virtual =A0 =A0 =A0 =A0=3D SRAM_VIRT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pfn =A0 =A0 =A0 =A0 =A0 =A0=3D __phys=
_to_pfn(0x00010000),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.length =A0 =A0 =A0 =A0 =3D SZ_32K,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MT_MEMORY_NONCACHED requires superse=
ction alignment */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_DEVICE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_MEMORY=
_NONCACHED,
> =A0 =A0 =A0 =A0},
> =A0};
>
> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm=
365.c
> index a146849..5dee032 100644
> --- a/arch/arm/mach-davinci/dm365.c
> +++ b/arch/arm/mach-davinci/dm365.c
> @@ -967,8 +967,7 @@ static struct map_desc dm365_io_desc[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.virtual =A0 =A0 =A0 =A0=3D SRAM_VIRT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pfn =A0 =A0 =A0 =A0 =A0 =A0=3D __phys=
_to_pfn(0x00010000),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.length =A0 =A0 =A0 =A0 =3D SZ_32K,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MT_MEMORY_NONCACHED requires superse=
ction alignment */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_DEVICE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_MEMORY=
_NONCACHED,
> =A0 =A0 =A0 =A0},
> =A0};
>
> diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/d=
m644x.c
> index 7ad1520..5112d51 100644
> --- a/arch/arm/mach-davinci/dm644x.c
> +++ b/arch/arm/mach-davinci/dm644x.c
> @@ -651,8 +651,7 @@ static struct map_desc dm644x_io_desc[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.virtual =A0 =A0 =A0 =A0=3D SRAM_VIRT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pfn =A0 =A0 =A0 =A0 =A0 =A0=3D __phys=
_to_pfn(0x00008000),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.length =A0 =A0 =A0 =A0 =3D SZ_16K,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MT_MEMORY_NONCACHED requires superse=
ction alignment */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_DEVICE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_MEMORY=
_NONCACHED,
> =A0 =A0 =A0 =A0},
> =A0};
>
> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/d=
m646x.c
> index 9404565..97078f4 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -735,8 +735,7 @@ static struct map_desc dm646x_io_desc[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.virtual =A0 =A0 =A0 =A0=3D SRAM_VIRT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pfn =A0 =A0 =A0 =A0 =A0 =A0=3D __phys=
_to_pfn(0x00010000),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.length =A0 =A0 =A0 =A0 =3D SZ_32K,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MT_MEMORY_NONCACHED requires superse=
ction alignment */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_DEVICE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D MT_MEMORY=
_NONCACHED,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.6.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
