From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
Date: Sun, 21 Feb 2010 00:23:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417FF8C@dbde02.ent.ti.com>
References: <2C1563023E232C49B9F505633D57C2DA2640D0235C@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41247 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207Ab0BTSxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Feb 2010 13:53:09 -0500
In-Reply-To: <2C1563023E232C49B9F505633D57C2DA2640D0235C@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anna, Suman" <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Anna,
> Suman
> Sent: Friday, February 19, 2010 2:37 AM
> To: linux-omap@vger.kernel.org
> Cc: Hiroshi.DOYU@nokia.com; Clark, Rob; Kanigeri, Hari; C.A, Subramaniam
> Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> 
> From 2488815a9facca29e2da3ddd279de441a5de6a58 Mon Sep 17 00:00:00 2001
> From: Suman Anna <s-anna@ti.com>
> Date: Tue, 26 Jan 2010 16:55:29 -0600
> Subject: [PATCH 2/5] omap: mailbox: correct OMAP4 reset logic
> 
> OMAP4 mailbox has a different register set. There is
> no MAILBOX_SYSSTATUS register. The reset is indicated
> with the SOFTRESET bit of the MAILBOX_SYSCONFIG register
> itself. This bit should read 0 for a successful Reset.
> Also, the SOFTRESET bit occupies bit0 and not bit1 as with
> previous generations.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |   38 +++++++++++++++++++++++++++-----------
>  1 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index c970cf6..88e9043 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -40,6 +40,7 @@
>  #define AUTOIDLE	(1 << 0)
>  #define SOFTRESET	(1 << 1)
>  #define SMARTIDLE	(2 << 3)
> +#define OMAP4_SOFTRESET	(1 << 0)
> 
>  /* SYSSTATUS: register bit definition */
>  #define RESETDONE	(1 << 0)
> @@ -99,17 +100,32 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
>  	}
>  	clk_enable(mbox_ick_handle);
> 
> -	mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
> -	timeout = jiffies + msecs_to_jiffies(20);
> -	do {
> -		l = mbox_read_reg(MAILBOX_SYSSTATUS);
> -		if (l & RESETDONE)
> -			break;
> -	} while (!time_after(jiffies, timeout));
> -
> -	if (!(l & RESETDONE)) {
> -		pr_err("Can't take mmu out of reset\n");
> -		return -ENODEV;
> +	if (cpu_is_omap44xx()) {
Not so strong opinion but can we make use of mailbox ip revision instead
of cpu_is_xxxx() check. 

> +		mbox_write_reg(OMAP4_SOFTRESET, MAILBOX_SYSCONFIG);
> +		timeout = jiffies + msecs_to_jiffies(20);
> +		do {
> +			l = mbox_read_reg(MAILBOX_SYSCONFIG);
> +			if (!(l & OMAP4_SOFTRESET))
> +				break;
> +		} while (!time_after(jiffies, timeout));
> +
> +		if (l & OMAP4_SOFTRESET) {
> +			pr_err("Can't take mailbox out of reset\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +		mbox_write_reg(SOFTRESET, MAILBOX_SYSCONFIG);
> +		timeout = jiffies + msecs_to_jiffies(20);
> +		do {
> +			l = mbox_read_reg(MAILBOX_SYSSTATUS);
> +			if (l & RESETDONE)
> +				break;
> +		} while (!time_after(jiffies, timeout));
> +
> +		if (!(l & RESETDONE)) {
> +			pr_err("Can't take mailbox out of reset\n");
> +			return -ENODEV;
> +		}
>  	}
> 
>  	l = mbox_read_reg(MAILBOX_REVISION);
> --
> 1.6.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
