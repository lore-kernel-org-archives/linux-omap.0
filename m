From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: fix build failure
Date: Tue, 22 Feb 2011 13:57:10 -0800
Message-ID: <20110222215710.GT15225@atomide.com>
References: <20110222201842.GB31275@n2100.arm.linux.org.uk>
 <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40550 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1BVV5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 16:57:32 -0500
Content-Disposition: inline
In-Reply-To: <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [110222 12:25]=
:
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
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Tony Lindgren <tony@atomide.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
