From: Will Deacon <will.deacon@arm.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Sat, 27 Jul 2013 13:22:21 +0100
Message-ID: <20130727122221.GB6618@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
 <20130722184325.GA21614@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
 <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com>
 <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 27, 2013 at 05:10:56AM +0100, Paul Walmsley wrote:
> 
> Tonight I put on a Jon Hopkins album, in recollection of my UK ARM Linux 
> colleagues perhaps, and started testing, and eventually wound up with this 
> one:
> 
> commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc
> Author: Will Deacon <will.deacon@arm.com>

Oh, great...

> Date:   Wed Jun 12 12:25:56 2013 +0100
> 
>     ARM: 7757/1: mm: don't flush icache in switch_mm with hardware broadcasting
>     
>     When scheduling an mm on a CPU where it hasn't previously been used, we
>     flush the icache on that CPU so that any code loaded previously on
>     a different core can be safely executed.
>     
>     For cores with hardware broadcasting of cache maintenance operations,
>     this is clearly unnecessary, since the inner-shareable invalidation in
>     __sync_icache_dcache will affect all CPUs.
>     
>     This patch conditionalises the icache flush in switch_mm based on
>     cache_ops_need_broadcast().
>     
>     Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>     Reported-by: Albin Tonnerre <albin.tonnerre@arm.com>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> ...
> 
> v3.11-rc2 boots with it reverted.  What also works is v3.11-rc2 with the 
> below patch applied.

That's very odd -- I *suspect* your bootloader is up to no good (iirc, we've
had issues with the bootloader on this machine in the past, since it enters
the kernel in ABT mode or something).

> Would be pleased to boot-test anything you'd care to send my way, as long 
> as you can tolerate response latency jitter.

Can you try this quick hack please? It clobbers the I-cache as soon as we
enter the kernel, so it should tell us whether my theory is correct.

Cheers,

Will

--->8

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 9cf6063..d74c64c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -83,6 +83,9 @@ ENTRY(stext)
  THUMB(        .thumb                  )       @ switch to Thumb now.
  THUMB(1:                      )
 
+       mov     r9, #0
+       mcr     p15, 0, r9, c7, c5, 0
+
 #ifdef CONFIG_ARM_VIRT_EXT
        bl      __hyp_stub_install
 #endif
