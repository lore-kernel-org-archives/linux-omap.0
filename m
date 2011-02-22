From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: fix build failure
Date: Tue, 22 Feb 2011 22:26:28 +0000
Message-ID: <20110222222628.GC31275@n2100.arm.linux.org.uk>
References: <20110222201842.GB31275@n2100.arm.linux.org.uk> <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40011 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab1BVW0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 17:26:47 -0500
Content-Disposition: inline
In-Reply-To: <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Looks good.  Can you stick it in the patch system please?

On Tue, Feb 22, 2011 at 09:26:42PM +0100, Uwe Kleine-K=F6nig wrote:
> Commit
>=20
> 	06824ba (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs)
>=20
> introduced a build failure for builds with CONFIG_SWAP=3Dn:
>=20
> 	In file included from arch/arm/mm/init.c:27:
> 	arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> 	arch/arm/include/asm/tlb.h:101: error: implicit declaration of funct=
ion 'release_pages'
> 	arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> 	arch/arm/include/asm/tlb.h:165: error: implicit declaration of funct=
ion 'page_cache_release'
>=20
> Fix that by #including <linux/pagemap.h> in <asm/pgalloc.h> as it's d=
one
> by x86.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/include/asm/pgalloc.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pg=
alloc.h
> index 9763be0..22de005 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -10,6 +10,8 @@
>  #ifndef _ASMARM_PGALLOC_H
>  #define _ASMARM_PGALLOC_H
> =20
> +#include <linux/pagemap.h>
> +
>  #include <asm/domain.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/processor.h>
> --=20
> 1.7.2.3
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
