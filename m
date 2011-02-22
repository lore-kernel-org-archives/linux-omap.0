From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix compile after delay page freeing patch
Date: Tue, 22 Feb 2011 20:18:42 +0000
Message-ID: <20110222201842.GB31275@n2100.arm.linux.org.uk>
References: <20110222194332.GQ15225@atomide.com> <20110222195929.GA31275@n2100.arm.linux.org.uk> <20110222201047.GE22310@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45276 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab1BVUSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:18:53 -0500
Content-Disposition: inline
In-Reply-To: <20110222201047.GE22310@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 22, 2011 at 09:10:47PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Russell,
>=20
> On Tue, Feb 22, 2011 at 07:59:29PM +0000, Russell King - ARM Linux wr=
ote:
> > Note that arch/x86/mm/init.c and arch/x86/mm/pgtable.c both include
> > asm/tlb.h without linux/pagemap.h, and use the generic version.  I =
bet
> > no one's tried building x86 with CONFIG_SWAP=3Dn yet...
> I did, and it doesn't fail.
>=20
> include/asm-generic/tlb.h includes <asm/pgalloc.h> which for x86
> includes <linux/pagemap.h>

Maybe then we should add linux/pagemap.h to our asm/pgalloc.h.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
