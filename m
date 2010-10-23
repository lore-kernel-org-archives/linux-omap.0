From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix data abort accessing proc_info from
 __lookup_processor_type (Re: [PATCH 03/10] ARM: hotplug cpu: Keep
 processor information, startup code & __lookup_processor_type)
Date: Sat, 23 Oct 2010 11:18:19 -0700
Message-ID: <20101023181819.GB19376@atomide.com>
References: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk>
 <20101022185108.GF17595@atomide.com>
 <20101023083044.GA13009@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49354 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357Ab0JWSSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 14:18:31 -0400
Content-Disposition: inline
In-Reply-To: <20101023083044.GA13009@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101023 01:21]:
> On Fri, Oct 22, 2010 at 11:51:08AM -0700, Tony Lindgren wrote:
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > index 1953e3d..a58b91d 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -114,6 +114,7 @@ SECTIONS
> >  			*(.glue_7)
> >  			*(.glue_7t)
> >  		*(.got)			/* Global offset table		*/
> > +			. = ALIGN(4);
> >  			ARM_CPU_KEEP(PROC_INFO)
> 
> The got table should also be word aligned - but the kernel doesn't use
> one.  In any case, it would be a good idea to place it before the .got.

OK, updated patch below.

By moving ARM_CPU_KEEP(PROC_INFO) around I've confirmed that it's
happening at rodata.*. Do you want also another align before .glue_7
as well?

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Fri, 22 Oct 2010 12:41:55 -0700
Subject: [PATCH] ARM: Fix data abort accessing proc_info from __lookup_processor_type

Commit 5085f3ff458521045f7e43da62b8c30ea7df2e82 added better support for
CONFIG_HOTPLUG_CPU by keeping proc_info around. However, depending on
the Kconfig options selected, this can make the booting fail mysteriously
early on.

Turns out a data abort can happen in __lookup_processor in ldmia r5 {r3, r4}.
When it happens the address loaded to r5 is not aligned. Fix the problem by
aligning proc_info.

Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Anand Gadiyar <gadiyar@ti.com>

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1953e3d..cead889 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -113,6 +113,7 @@ SECTIONS
 			*(.rodata.*)
 			*(.glue_7)
 			*(.glue_7t)
+		. = ALIGN(4);
 		*(.got)			/* Global offset table		*/
 			ARM_CPU_KEEP(PROC_INFO)
 	}
