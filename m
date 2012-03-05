From: Tony Lindgren <tony@atomide.com>
Subject: Re: Incorrect Register Offsets in OMAP Mailbox
Date: Mon, 5 Mar 2012 11:34:17 -0800
Message-ID: <20120305193417.GL12083@atomide.com>
References: <4F3165F0.2010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27158 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab2CETeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:34:19 -0500
Content-Disposition: inline
In-Reply-To: <4F3165F0.2010306@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Henry Chan <enli.chan@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Henry,

* Henry Chan <enli.chan@gmail.com> [120207 09:25]:
> Hi,
> 
> Looks like the register offsets are incorrect in the OMAP mailbox code
> (arch/arm/mach-omap2/mailbox.c) for the OMAP4_MAILBOX_IRQ* macros. The
> discrepancy is with p.224 of TI document SPRUGX9 and p3891 of SWPU231K.
> Patch attached.
> 
> My hardware hasn't come in yet, so I would appreciate it if anyone can
> share their experience using this code.

Can you please reply with your Signed-off-by, it's missing from the
patch.

Thanks,

Tony

> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -26,9 +26,9 @@
>  #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
>  #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
>  
> -#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 10 * (u))
> -#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 10 * (u))
> -#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
> +#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 0x10 * (u))
> +#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 0x10 * (u))
> +#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 0x10 * (u))
>  
>  #define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
>  #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
> 
