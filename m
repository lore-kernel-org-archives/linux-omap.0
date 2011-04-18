From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [RFC PATCH v2] Consolidate SRAM support
Date: Mon, 18 Apr 2011 21:42:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CA31B27@dbde02.ent.ti.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <20110418085259.GA26044@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48402 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab1DRQM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 12:12:57 -0400
In-Reply-To: <20110418085259.GA26044@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On Mon, Apr 18, 2011 at 14:22:59, Russell King - ARM Linux wrote:
> This is the second revision of this patch.  I've not moved it out of
> ARM yet as I haven't had a positive response from SH yet.

I was able to test this on DaVinci (DA850 suspend-to-RAM) with
the following additional changes:

There was a sram_free call remaining in pm.c file.

diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 06eb0ff..0068e41 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -131,7 +131,8 @@ static int __init davinci_pm_probe(struct platform_device *pdev)
 
 static int __exit davinci_pm_remove(struct platform_device *pdev)
 {
-	sram_free(davinci_sram_suspend, davinci_cpu_suspend_sz);
+	pv_pool_free(davinci_pv_pool, davinci_sram_suspend,
+					davinci_cpu_suspend_sz);
 	return 0;
 }

The cpu suspend code on DaVinci was not aligned 8 to bytes
and so the fncpy function was throwing a bug.

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index fb5e72b..dcb8e9d 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -50,6 +50,8 @@
  * 	r4: contains virtual address of the DEEPSLEEP register
  */
 ENTRY(davinci_cpu_suspend)
+	.align 3
+
 	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
 
 	ldr 	ip, CACHE_FLUSH

> > Lastly, uio_pruss should probably take the SRAM pool pointer via
> > platform data so that it doesn't have to include Davinci specific
> > includes.
> 
>  arch/arm/Kconfig                            |    2 +
>  arch/arm/common/Kconfig                     |    4 ++
>  arch/arm/common/Makefile                    |    1 +
>  arch/arm/common/pv-pool.c                   |   69 +++++++++++++++++++++++++++
>  arch/arm/include/asm/pv-pool.h              |   20 ++++++++
>  arch/arm/mach-davinci/da850.c               |    2 +-
>  arch/arm/mach-davinci/dm355.c               |    2 +-
>  arch/arm/mach-davinci/dm365.c               |    2 +-
>  arch/arm/mach-davinci/dm644x.c              |    2 +-
>  arch/arm/mach-davinci/dm646x.c              |    2 +-
>  arch/arm/mach-davinci/include/mach/common.h |    2 +-
>  arch/arm/mach-davinci/include/mach/sram.h   |   13 +----
>  arch/arm/mach-davinci/pm.c                  |   12 +----
>  arch/arm/mach-davinci/sram.c                |   42 +++--------------
>  arch/arm/plat-mxc/Kconfig                   |    2 +-
>  arch/arm/plat-mxc/include/mach/iram.h       |   24 +++++++--
>  arch/arm/plat-mxc/iram_alloc.c              |   50 +++++---------------
>  arch/arm/plat-omap/include/plat/sram.h      |   17 ++++---
>  arch/arm/plat-omap/sram.c                   |   34 +++++---------
>  drivers/uio/uio_pruss.c                     |    7 ++-
>  20 files changed, 171 insertions(+), 138 deletions(-)

The davinci audio driver in sound/soc/davinci/davinci-pcm.c uses
the sram allocator too and would need to be converted to the
new API.

Thanks,
Sekhar

