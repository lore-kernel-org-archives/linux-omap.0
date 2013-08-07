From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: v3.11-rc4: OMAP1/Amstrad Delta (E3) crash
Date: Thu, 8 Aug 2013 00:08:56 +0100
Message-ID: <20130807230856.GJ23053@n2100.arm.linux.org.uk>
References: <20130806232609.GB15014@blackmetal.musicnaut.iki.fi> <20130807190521.GD15014@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40696 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540Ab3HGXLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 19:11:15 -0400
Content-Disposition: inline
In-Reply-To: <20130807190521.GD15014@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>

On Wed, Aug 07, 2013 at 10:05:21PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Aug 07, 2013 at 02:26:09AM +0300, Aaro Koskinen wrote:
> > I get the following on Amstrad Delta (E3) when booting unpatched
> > v3.11-rc4. The kernel config is after the crash.
> 
> This is regression introduced between -rc3 and -rc4. According to the
> git bisect, the first bad commit is:
> 
> 	commit e39e3f3ebfef03450cf7bfa7a974a8c61f7980c8
> 	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> 	Date:   Tue Jul 9 01:03:17 2013 +0100
> 
> 	    ARM: update FIQ support for relocation of vectors
> 
> If I revert the commit from v3.11-rc4, the board boots fine.
> 
> A.
> 
> > Uncompressing Linux... done, booting the kernel.
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Initializing cgroup subsys cpu
> > [    0.000000] Linux version 3.11.0-rc4-e3 (aaro@blackmetal) (gcc version 4.7.3 (GCC) ) #4 PREEMPT Wed Aug 7 02:03:27 EEST 2013
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] OMAP1510
> > [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16

Hmm, so ARM925T which is VIVT...

> > [    0.238868] Installing fiq handler from c001b110, length 0x164
> > [    0.245750] Unable to handle kernel paging request at virtual address ffff1224

In one way, that's good news - that's public independent proof that the
code associated with the vectors is well protected from kernel writes. :)

Can you try this (untested) patch please?  We need to write into this
page via the page's alias, rather than directly to it.  Thanks.

 arch/arm/kernel/fiq.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 25442f4..fc79202 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -84,17 +84,13 @@ int show_fiq_list(struct seq_file *p, int prec)
 
 void set_fiq_handler(void *start, unsigned int length)
 {
-#if defined(CONFIG_CPU_USE_DOMAINS)
-	void *base = (void *)0xffff0000;
-#else
 	void *base = vectors_page;
-#endif
 	unsigned offset = FIQ_OFFSET;
 
 	memcpy(base + offset, start, length);
+	if (!cache_is_vipt_nonaliasing())
+		flush_icache_range(base + offset, offset + length);
 	flush_icache_range(0xffff0000 + offset, 0xffff0000 + offset + length);
-	if (!vectors_high())
-		flush_icache_range(offset, offset + length);
 }
 
 int claim_fiq(struct fiq_handler *f)

