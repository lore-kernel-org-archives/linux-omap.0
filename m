From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code
 changes to support OMAP4 mailbox.
Date: Wed, 18 Nov 2009 10:06:12 +0200 (EET)
Message-ID: <20091118.100612.98874554.Hiroshi.DOYU@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE563EB2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64639 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZKRIGQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:06:16 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE563EB2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, grgupta@ti.com

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
Date: Tue, 17 Nov 2009 15:51:14 +0100

> Hi Tony,
> Following is the version 2 of Patch 8/10 (removing all #fidefs)
> 
> Regards
> Subbu
>  
> From 775dde65217785f519efe2a202489a791460f861 Mon Sep 17 00:00:00 2001
> From: C A Subramaniam <subramaniam.ca@ti.com>
> Date: Fri, 13 Nov 2009 16:42:40 +0530
> Subject: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
> 
> This patch adds code changes in the mailbox driver module to
> add support for OMAP4 mailbox.
> Removed #ifdef CONFIG_ARCH_OMAP4
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |  140 ++++++++++++++++++++++++++++++++++-------
>  arch/arm/plat-omap/mailbox.c  |   25 ++++++--
>  2 files changed, 136 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 5ba3aa6..d20550f 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -18,6 +18,8 @@
>  #include <plat/mailbox.h>
>  #include <mach/irqs.h>
>  
> +#define DRV_NAME "omap2-mailbox"
> +
>  #define MAILBOX_REVISION		0x000
>  #define MAILBOX_SYSCONFIG		0x010
>  #define MAILBOX_SYSSTATUS		0x014
> @@ -27,8 +29,12 @@
>  #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
>  #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
>  
> -#define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
> -#define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
> +#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 10 * (u))
> +#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 10 * (u))
> +#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
> +
> +#define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
> +#define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
>  
>  /* SYSCONFIG: register bit definition */
>  #define AUTOIDLE	(1 << 0)
> @@ -39,7 +45,11 @@
>  #define RESETDONE	(1 << 0)
>  
>  #define MBOX_REG_SIZE			0x120
> +
> +#define OMAP4_MBOX_REG_SIZE		0x130
> +
>  #define MBOX_NR_REGS			(MBOX_REG_SIZE / sizeof(u32))
> +#define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / sizeof(u32))

Doesn't this modification break other OMAP arch support?

We need to support OMAP2/3/4 mailbox with this file.

>  
>  static void __iomem *mbox_base;
>  
> @@ -56,7 +66,8 @@ struct omap_mbox2_priv {
>  	unsigned long irqstatus;
>  	u32 newmsg_bit;
>  	u32 notfull_bit;
> -	u32 ctx[MBOX_NR_REGS];
> +	u32 ctx[OMAP4_MBOX_REG_SIZE];

Is this only valid for OMAP4?
