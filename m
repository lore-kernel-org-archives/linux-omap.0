From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/17] ARM: OMAP2: Add common register access for 24xx and 34xx
Date: Mon, 7 Apr 2008 17:20:49 +0100
Message-ID: <20080407162049.GF5306@flint.arm.linux.org.uk>
References: <1205848935-12078-1-git-send-email-tony@atomide.com> <1205848935-12078-2-git-send-email-tony@atomide.com> <1205848935-12078-3-git-send-email-tony@atomide.com> <1205848935-12078-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57799 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYDGQVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 12:21:09 -0400
Content-Disposition: inline
In-Reply-To: <1205848935-12078-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Mar 18, 2008 at 04:02:01PM +0200, Tony Lindgren wrote:
> diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> new file mode 100644
> index 0000000..f575a87
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cm.h
> @@ -0,0 +1,142 @@
> +
> +#ifndef __ASSEMBLER__
> +/* Clock management global register get/set */
> +
> +static void __attribute__((unused)) cm_write_reg(u32 val, void __iomem *addr)
> +{
> +	pr_debug("cm_write_reg: writing 0x%0x to 0x%0x\n", val, (u32)addr);
> +
> +	__raw_writel(val, addr);
> +}
> +
> +static u32 __attribute__((unused)) cm_read_reg(void __iomem *addr)
> +{
> +	return __raw_readl(addr);
> +}
> +#endif

Erm, code in a header file?  Make them __inline__ or if you really want
to have them as separate functions, put them in a .c file.

Next point - what's the purpose of them.  They're doing nothing (apart
from that excess debug statement).

> +#ifndef __ASSEMBLER__
> +static void __attribute__((unused)) cm_write_mod_reg(u32 val, s16 module,
> +							s16 idx)
> +{
> +	cm_write_reg(val, OMAP_CM_REGADDR(module, idx));
> +}
> +
> +static u32 __attribute__((unused)) cm_read_mod_reg(s16 module, s16 idx)
> +{
> +	return cm_read_reg(OMAP_CM_REGADDR(module, idx));
> +}
> +#endif

Ditto.

> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 90f5305..01ab3bc 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/clk.h>
> +#include <linux/io.h>

Always suspicious of changes which just _add_ includes.  Is this actually
needed?  Did it build before?

> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> new file mode 100644
> index 0000000..455b060
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -0,0 +1,334 @@
>..
> +#ifndef __ASSEMBLER__
> +
> +/* Power/reset management global register get/set */
> +
> +static void __attribute__((unused)) prm_write_reg(u32 val, void __iomem *addr)
> +{
> +	pr_debug("prm_write_reg: writing 0x%0x to 0x%0x\n", val, (u32)addr);
> +
> +	__raw_writel(val, addr);
> +}
> +
> +static u32 __attribute__((unused)) prm_read_reg(void __iomem *addr)
> +{
> +	return __raw_readl(addr);
> +}
> +
> +#endif

Yet more code in includes.  And this looks like a pointless abstraction.

> +#ifndef __ASSEMBLER__
> +
> +/* Power/reset management domain register get/set */
> +
> +static void __attribute__((unused)) prm_write_mod_reg(u32 val, s16 module, s16 idx)
> +{
> +	prm_write_reg(val, OMAP_PRM_REGADDR(module, idx));
> +}
> +
> +static u32 __attribute__((unused)) prm_read_mod_reg(s16 module, s16 idx)
> +{
> +	return prm_read_reg(OMAP_PRM_REGADDR(module, idx));
> +}
> +
> +#endif

And more.

> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
> new file mode 100644
> index 0000000..928e1c4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sdrc.h
>...
> +#ifndef __ASSEMBLER__
> +extern unsigned long omap2_sdrc_base;
> +extern unsigned long omap2_sms_base;
> +
> +#define OMAP_SDRC_REGADDR(reg)						\
> +		(void __iomem *)IO_ADDRESS(omap2_sdrc_base + (reg))
> +#define OMAP_SMS_REGADDR(reg)						\
> +		(void __iomem *)IO_ADDRESS(omap2_sms_base + (reg))
> +
> +/* SDRC global register get/set */
> +
> +static void __attribute__((unused)) sdrc_write_reg(u32 val, u16 reg)
> +{
> +	pr_debug("sdrc_write_reg: writing 0x%0x to 0x%0x\n", val,
> +		 (u32)OMAP_SDRC_REGADDR(reg));
> +
> +	__raw_writel(val, OMAP_SDRC_REGADDR(reg));
> +}
> +
> +static u32 __attribute__((unused)) sdrc_read_reg(u16 reg)
> +{
> +	return __raw_readl(OMAP_SDRC_REGADDR(reg));
> +}
> +
> +/* SMS global register get/set */
> +
> +static void __attribute__((unused)) sms_write_reg(u32 val, u16 reg)
> +{
> +	pr_debug("sms_write_reg: writing 0x%0x to 0x%0x\n", val,
> +		 (u32)OMAP_SMS_REGADDR(reg));
> +
> +	__raw_writel(val, OMAP_SMS_REGADDR(reg));
> +}
> +
> +static u32 __attribute__((unused)) sms_read_reg(u16 reg)
> +{
> +	return __raw_readl(OMAP_SMS_REGADDR(reg));
> +}

And more.

So that's a NAK.
