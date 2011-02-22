From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: Fix compile after delay page freeing patch
Date: Tue, 22 Feb 2011 21:10:47 +0100
Message-ID: <20110222201047.GE22310@pengutronix.de>
References: <20110222194332.GQ15225@atomide.com>
 <20110222195929.GA31275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53647 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab1BVUKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:10:48 -0500
Content-Disposition: inline
In-Reply-To: <20110222195929.GA31275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Russell,

On Tue, Feb 22, 2011 at 07:59:29PM +0000, Russell King - ARM Linux wrot=
e:
> Note that arch/x86/mm/init.c and arch/x86/mm/pgtable.c both include
> asm/tlb.h without linux/pagemap.h, and use the generic version.  I be=
t
> no one's tried building x86 with CONFIG_SWAP=3Dn yet...
I did, and it doesn't fail.

include/asm-generic/tlb.h includes <asm/pgalloc.h> which for x86
includes <linux/pagemap.h>

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
