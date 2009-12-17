From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/4 v2] ARM: L2 : Errata 588369: Clean & Invalidate do
	not invalidate clean lines
Date: Thu, 17 Dec 2009 19:22:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFB58916@dbde02.ent.ti.com>
References: <1261054832-14995-1-git-send-email-santosh.shilimkar@ti.com>
 <20091217133508.GA5813@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbZLQNxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 08:53:19 -0500
In-Reply-To: <20091217133508.GA5813@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, Catalin Marinas <catalin.marinas@arm.com>

Thanks Russell,
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, December 17, 2009 7:05 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; tony@atomide.com; linux-omap@vger.kernel.org; Woodruff,
> Richard; Catalin Marinas
> Subject: Re: [PATCH 3/4 v2] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> 
> On Thu, Dec 17, 2009 at 06:30:32PM +0530, Santosh Shilimkar wrote:
> > +config PL310_ERRATA_588369
> > +	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
> > +	depends on CACHE_L2X0 && ARCH_OMAP4
> > +	default n
> 
> default n is the default anyway, so its redundant to specify it.
ok
> 
> > +#ifdef CONFIG_PL310_ERRATA_588369
> > +static void debug_writel(unsigned long val)
> > +{
> > +	/*
> > +	 * Texas Instrument secure monitor api to modify the PL310
> > +	 * Debug Control Register. R0 = val
> > +	 */
> > +	__asm__ __volatile__(
> > +	"stmfd r13!, {r4-r8}\n"
> > +	"ldr r12, =0x100\n"
> > +	"dsb\n"
> > +	"smc\n"
> > +	"ldmfd r13!, {r4-r8}");
> 
> Just tell the compiler that r4 to r8 are clobbered - then it'll save and
> restore them itself.  Also, you can't guarantee that r0 will contain the
> value unless you explicitly pass it in.  IOW:
Perfect. I was looking for something like this.
> 	register unsigned long r0 asm("r0") = val;
> 
> 	asm volatile(
> 	__asmeq(%0, r0)
> 	"..."
> 	: : "r" (r0)
> 	: "r4", "r5", "r6", "r7", "r8");
> 
> The use of asmeq will also ensure that '%0' is indeed r0 - some gcc
> versions are buggy.
OK
> As I've said before, your patch is fine for the current version, but
> not for the other cache-l2x0 changes.
I can rebase this on top of your changes. I have that version also functional.
Just need to rebase on top of your 2 patched.

Regards,
Santosh
