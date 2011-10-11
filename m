From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Tue, 11 Oct 2011 16:58:27 -0700
Message-ID: <20111011235827.GB2293@atomide.com>
References: <20111007194242.18205.64009.stgit@kaulin.local>
 <20111007194543.18205.36115.stgit@kaulin.local>
 <20111011134048.28b9b19b@queued.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59977 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1JKX6a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 19:58:30 -0400
Content-Disposition: inline
In-Reply-To: <20111011134048.28b9b19b@queued.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Andres Salomon <dilinger@queued.net> [111011 14:11]:
> On Fri, 07 Oct 2011 12:45:43 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > This allows mapping external memory such as SRAM for use.
> > 
> > This is needed for some small chunks of code, such as reprogramming
> > SDRAM memory source clocks that can't be executed in SDRAM. Other
> > use cases include some PM related code.
> 
> 
> Acked-by: Andres Salomon <dilinger@queued.net>
> 
> Looks good to me, thanks for doing this.  I only have one very minor
> quibble below, which could be addressed in a later patch..

> > +void __iomem *
> > +__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)
> 
> I'd rather see this as 'bool cached', so it's clear we're talking
> about a simple boolean (rather than bits).

Sure, thanks, updated version below. Will also update the patch in
Russell's patch system.

Tony

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="ioremap-exec.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 5 Oct 2011 15:14:01 -0700
Subject: [PATCH] ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY

This allows mapping external memory such as SRAM for use.

This is needed for some small chunks of code, such as reprogramming
SDRAM memory source clocks that can't be executed in SDRAM. Other
use cases include some PM related code.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Andres Salomon <dilinger@queued.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -80,6 +80,7 @@ extern void __iomem *__arm_ioremap_caller(unsigned long, size_t, unsigned int,
 
 extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long, size_t, unsigned int);
 extern void __iomem *__arm_ioremap(unsigned long, size_t, unsigned int);
+extern void __iomem *__arm_ioremap_exec(unsigned long, size_t, bool cached);
 extern void __iounmap(volatile void __iomem *addr);
 
 /*
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -289,6 +289,27 @@ __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
+/*
+ * Remap an arbitrary physical address space into the kernel virtual
+ * address space as memory. Needed when the kernel wants to execute
+ * code in external memory. This is needed for reprogramming source
+ * clocks that would affect normal memory for example. Please see
+ * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
+ */
+void __iomem *
+__arm_ioremap_exec(unsigned long phys_addr, size_t size, bool cached)
+{
+	unsigned int mtype;
+
+	if (cached)
+		mtype = MT_MEMORY;
+	else
+		mtype = MT_MEMORY_NONCACHED;
+
+	return __arm_ioremap_caller(phys_addr, size, mtype,
+			__builtin_return_address(0));
+}
+
 void __iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);

--vtzGhvizbBRQ85DL--
