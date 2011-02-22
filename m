From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: Fix compile after delay page freeing patch
Date: Tue, 22 Feb 2011 21:01:06 +0100
Message-ID: <20110222200105.GD22310@pengutronix.de>
References: <20110222194332.GQ15225@atomide.com>
 <4D6413D9.7080906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33629 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1BVUBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:01:08 -0500
Content-Disposition: inline
In-Reply-To: <4D6413D9.7080906@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 22, 2011 at 10:51:53PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> Tony Lindgren wrote:
>=20
> >Commit 06824ba824b3e9f2fedb38bee79af0643198ed7f
> >(ARM: tlb: delay page freeing for SMP and ARMv7 CPUs) causes
> >the following compile error for at least omap1_defconfig:
I't not omap1_defconfig only, see

	http://armlinux.simtec.co.uk/kautobuild/2.6.38-rc5-git6/index.html
=20
> >In file included from arch/arm/mm/init.c:27:
> >arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> >arch/arm/include/asm/tlb.h:101: error: implicit declaration of funct=
ion 'release_pages'
> >arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> >arch/arm/include/asm/tlb.h:165: error: implicit declaration of funct=
ion 'page_cache_release'
> >
> >Fix this by including pagemap.h.
> >
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> >--- a/arch/arm/mm/init.c
> >+++ b/arch/arm/mm/init.c
> >@@ -19,6 +19,7 @@
> > #include <linux/gfp.h>
> > #include <linux/memblock.h>
> > #include <linux/sort.h>
> >+#include <linux/pagemap.h>
> > #include <asm/mach-types.h>
> > #include <asm/sections.h>
>=20
>    Shouldn't you be #including it into tlb.h instead?
=46or me building arch/arm/mm/mmu.o fails, too.  So Tony's patch doesn'=
t
help.

Adding the #include to arch/arm/include/asm/tlb.h works fine though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
