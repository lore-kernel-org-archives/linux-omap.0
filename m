From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: Create an ARM debugfs root.
Date: Tue, 22 Apr 2008 12:18:27 -0700
Message-ID: <20080422191827.GF24257@atomide.com>
References: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51584 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbYDVTSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 15:18:30 -0400
Content-Disposition: inline
In-Reply-To: <1208848630-6771-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080422 00:17]:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/kernel/setup.c  |   14 ++++++++++++++
>  include/asm-arm/system.h |    2 ++
>  2 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index b7b0720..1b1e6e4 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -24,6 +24,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/smp.h>
>  #include <linux/fs.h>
> +#include <linux/debugfs.h>
>  
>  #include <asm/cpu.h>
>  #include <asm/elf.h>
> @@ -1007,3 +1008,16 @@ const struct seq_operations cpuinfo_op = {
>  	.stop	= c_stop,
>  	.show	= c_show
>  };
> +
> +#ifdef CONFIG_DEBUG_FS
> +struct dentry *arm_debugfs_root;
> +static int __init arm_debugfs_init(void)
> +{
> +	arm_debugfs_root = debugfs_create_dir("arm", NULL);
> +	if (IS_ERR(arm_debugfs_root))
> +		return PTR_ERR(arm_debugfs_root);
> +
> +	return 0;
> +}
> +arch_initcall(arm_debugfs_init);
> +#endif
> diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
> index 6335de9..a6be185 100644
> --- a/include/asm-arm/system.h
> +++ b/include/asm-arm/system.h
> @@ -378,6 +378,8 @@ extern void enable_hlt(void);
>  #include <asm-generic/cmpxchg.h>
>  #endif
>  
> +extern struct dentry *arm_debugfs_root;
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #define arch_align_stack(x) (x)
> -- 
> 1.5.5.rc2.6.gf58d

This one should be discussed first on the linux-arm-kernel list.

Tony
