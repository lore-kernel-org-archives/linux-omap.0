From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 2/4] Makefile and Kconfig changes for V7 Cache updates
Date: Tue, 12 Jun 2007 11:16:54 -0700
Message-ID: <20070612181652.GS28834@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701120B43@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701120B43@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070605 17:27]:

> Makefile and Kconfig changes for V7 Cache update.
> --- linux-omap/arch/arm/mm/Makefile	2007-05-16 14:32:40.000000000 -0500
> --- linux-omap/arch/arm/mm/Kconfig	2007-05-25 13:27:03.000000000 -0500
> +++ val_3430_GIT/arch/arm/mm/Kconfig	2007-06-05 16:06:28.000000000 -0500
> @@ -370,7 +370,7 @@ config CPU_32v6K
>  # ARMv7
>  config CPU_V7
>  	bool "Support ARM V7 processor"
> -	depends on ARCH_INTEGRATOR
> +	depends on ARCH_INTEGRATOR || ARCH_OMAP3
>  	select CPU_32v6K
>  	select CPU_32v7
>  	select CPU_ABRT_EV7

I've only pushed this chunk, the rest should already be there after
git-cherry-picking following commits from arm tree:

commit 4c18422773362093fe0d60feb8011a116138ec33
Author: Paul Brook <paul@codesourcery.com>

ARMv7: Linux Thumb-2 support for user-space applications
    
commit b3bc735ae605fd051c8f17aa8032619286f18b70
Author: Catalin Marinas <catalin.marinas@arm.com>

ARMv7: Add Neon support

commit 081cc063d42edc954a398ce2a7923f9acdb08a93
Author: Catalin Marinas <catalin.marinas@arm.com>

ARMv7: Add VFPv3 support

commit d8c394c0f1e07d1016b36451e9b1126b09dba5a3
Author: Catalin Marinas <catalin.marinas@arm.com>

ARMv7: Add support for the Xenon state saving/restoring

commit a18393c93ecd33d10ae3bb8031bf65ce3ce1adf7
Author: Catalin Marinas <catalin.marinas@arm.com>

ARMv7: Add uncompressing code for the new CPU Id format

Can you please check that these are enough? Then provide follow-up
patches if something else needs changing.

If you want more patches from arm git tree, then also provide
the commit id.

Regards,

Tony
		    
