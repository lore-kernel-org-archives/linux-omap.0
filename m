From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3EVM: Choose OMAP_PACKAGE_CBB
Date: Tue, 5 Jan 2010 16:09:39 -0800
Message-ID: <20100106000938.GI14533@atomide.com>
References: <hvaibhav@ti.com>
 <1262240667-29962-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sfyO1m2EN8ZOtJL6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62191 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab0AFAJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 19:09:40 -0500
Content-Disposition: inline
In-Reply-To: <1262240667-29962-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* hvaibhav@ti.com <hvaibhav@ti.com> [091230 22:22]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Without this the kernel doesn't boot, it craches in
> omap_mux_package_fixup(), since the package_subset becomes NULL.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 10eafa7..606bf04 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -80,6 +80,7 @@ config MACH_OVERO
>  config MACH_OMAP3EVM
>  	bool "OMAP 3530 EVM board"
>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> +	select OMAP_PACKAGE_CBB
>  
>  config MACH_OMAP3517EVM
>  	bool "OMAP3517/ AM3517 EVM board"

Also applying the following fix so uninitialized packages won't
cause problems.

Regards,

Tony

--sfyO1m2EN8ZOtJL6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mux-init-fix.patch"

>From a6f77c57a213d692ef61db8e7920390779960302 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Jan 2010 15:54:58 -0800
Subject: [PATCH] omap: Fix booting if package is uninitialized

Otherwise bringing up new boards can be harder:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc2-00015-g0bc9c93-dirty #37)
PC is at omap_mux_init+0xa4/0x3d8
LR is at omap_mux_init+0x3c/0x3d8
...

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index e071b3f..459ef23 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -994,8 +994,10 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	}
 
 #ifdef CONFIG_OMAP_MUX
-	omap_mux_package_fixup(package_subset, superset);
-	omap_mux_package_init_balls(package_balls, superset);
+	if (package_subset)
+		omap_mux_package_fixup(package_subset, superset);
+	if (package_balls)
+		omap_mux_package_init_balls(package_balls, superset);
 	omap_mux_set_cmdline_signals();
 	omap_mux_set_board_signals(board_mux);
 #endif

--sfyO1m2EN8ZOtJL6--
