From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Fri, 19 Nov 2010 10:32:01 +0200
Message-ID: <20101119083201.GG6446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
 <1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab0KSIb5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 03:31:57 -0500
Content-Disposition: inline
In-Reply-To: <1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 18, 2010 at 01:15:39PM -0600, Hari Kanigeri wrote:
>disabling rx interrupt on omap4 is different than its pre-decessors.
>The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
>interrupts instead of clearing the bit.

How nasty :-p

>Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>---
> arch/arm/mach-omap2/mailbox.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>index 42dbfa4..82b5ced 100644
>--- a/arch/arm/mach-omap2/mailbox.c
>+++ b/arch/arm/mach-omap2/mailbox.c
>@@ -195,7 +195,10 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
> 	struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
> 	u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
> 	l = mbox_read_reg(p->irqdisable);
>-	l &= ~bit;
>+	if (cpu_is_omap44xx())
>+		l |= bit;
>+	else
>+		l &= ~bit;

you should not use cpu_is_* checks on drivers. Even though this is
located under mach-omap2, it's still a normal driver and you should not
use those checks. Pass a flag like "has_twisted_rx_irq_disable" via
platform_data and use that instead.

-- 
balbi
