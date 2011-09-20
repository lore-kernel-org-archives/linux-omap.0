From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
Date: Tue, 20 Sep 2011 11:47:18 +0800
Message-ID: <20110920034717.GG28084@S2100-06.ap.freescale.net>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:57237
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753191Ab1ITDi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 23:38:29 -0400
Content-Disposition: inline
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Sep 19, 2011 at 05:37:41PM +0100, Russell King - ARM Linux wrote:
> This is a re-post of the previous patch series, but with an additional
> TLB flush to ensure that hte global TLB entry in the page tables is
> flushed out.  This is a flush of all TLB entries, but it could probably
> be more targetted if we need to.
> 

Here is the diff on suspend.c between last post and this series.  With
the outer_clean_range() calls added back, the series works fine on
imx6q, otherwise it hangs on resume.

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 4c95410..2d60f19 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -28,9 +28,6 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
        cpu_do_suspend(ptr);

        flush_cache_all();
-       outer_clean_range(*save_ptr, *save_ptr + ptrsz);
-       outer_clean_range(virt_to_phys(save_ptr),
-                         virt_to_phys(save_ptr) + sizeof(*save_ptr));
 }

 /*
@@ -52,8 +49,10 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
         * back to the correct page tables.
         */
        ret = __cpu_suspend(arg, fn);
-       if (ret == 0)
+       if (ret == 0) {
                cpu_switch_mm(mm->pgd, mm);
+               local_flush_tlb_all();
+       }

        return ret;
 }

-- 
Regards,
Shawn

