From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v2] ARMv7: Use the Inner Shareable I-cache on MP
Date: Wed, 19 May 2010 18:05:47 +0530
Message-ID: <AANLkTim03PQYiNGNzxNfs-MkyFSZgc2DKMxVMoJzxSnR@mail.gmail.com>
References: <1274271062-30807-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61863 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab0ESMfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 08:35:48 -0400
Received: by iwn6 with SMTP id 6so2892927iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 05:35:47 -0700 (PDT)
In-Reply-To: <1274271062-30807-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> This patch fixes the flush_cache_all for ARMv7 SMP. It was
> missing from commit b8349b569aae661dea9d59d7d2ee587ccea3336c
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Updated version after removing the not necessary second hunk
>
> arch/arm/mm/cache-v7.S | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index 06a90dc..5009635 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -91,7 +91,11 @@ ENTRY(v7_flush_kern_cache_all)
> =A0THUMB( =A0 =A0 =A0 =A0stmfd =A0 sp!, {r4-r7, r9-r11, lr} =A0 =A0 =A0=
 =A0)
> =A0 =A0 =A0 =A0bl =A0 =A0 =A0v7_flush_dcache_all
> =A0 =A0 =A0 =A0mov =A0 =A0 r0, #0
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r0, c7, c1, 0 =A0 =A0 =A0 =A0 =A0 @=
 invalidate I-cache inner shareable
> +#elese

s/elese/else

> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c5, 0 =A0 =A0 =A0 =A0 =A0 =
@ I+BTB cache invalidate
> +#endif
> =A0ARM( =A0ldmfd =A0 sp!, {r4-r5, r7, r9-r11, lr} =A0 =A0)
> =A0THUMB( =A0 =A0 =A0 =A0ldmfd =A0 sp!, {r4-r7, r9-r11, lr} =A0 =A0 =A0=
 =A0)
> =A0 =A0 =A0 =A0mov =A0 =A0 pc, lr
> --
> 1.6.0.4
>
> --
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
