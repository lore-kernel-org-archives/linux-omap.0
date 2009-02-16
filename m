From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP3: SDTI: Prevent access to sdti writing if module
	is not initialized.
Date: Mon, 16 Feb 2009 13:33:03 +0200
Message-ID: <20090216113303.GL21181@scadufax.research.nokia.com>
References: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31103 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbZBPLsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 06:48:55 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1GBmA0G019046
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 05:48:51 -0600
Content-Disposition: inline
In-Reply-To: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 12, 2009 at 12:39:28PM +0100, Tereshonkov Roman wrote:
> The function sti_channel_write_trace can be run from process and interrupt
> context. It has to be completed before other sti_channel_write_trace calls.
> 
> Prevent sdti writing when SDTI module is not initialized.
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  drivers/misc/sti/sdti.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
> index 8c27504..31780de 100644
> --- a/drivers/misc/sti/sdti.c
> +++ b/drivers/misc/sti/sdti.c
> @@ -37,20 +37,25 @@
>  static struct clk *sdti_fck, *sdti_ick;
>  void __iomem *sti_base, *sti_channel_base;
>  static DEFINE_SPINLOCK(sdti_lock);
> +static int sdti_initialized;
> 
>  void sti_channel_write_trace(int len, int id, void *data,
>                                 unsigned int channel)
>  {
>         const u8 *tpntr = data;
> +       unsigned long flags;
> 
> -       spin_lock_irq(&sdti_lock);
> +       spin_lock_irqsave(&sdti_lock, flags);
> +
> +       if (unlikely(!sdti_initialized))
> +               goto skip;
> 
>         sti_channel_writeb(id, channel);
>         while (len--)
>                 sti_channel_writeb(*tpntr++, channel);
>         sti_channel_flush(channel);
> -
> -       spin_unlock_irq(&sdti_lock);
> + skip:
> +       spin_unlock_irqrestore(&sdti_lock, flags);
>  }
>  EXPORT_SYMBOL(sti_channel_write_trace);
> 
> @@ -117,6 +122,10 @@ static int __init omap_sdti_init(void)
>         /* Enable SDTI */
>         sti_writel((1 << 31) | (i & 0x3FFFFFFF), SDTI_WINCTRL);
> 
> +       spin_lock_irq(&sdti_lock);
> +       sdti_initialized = 1;
> +       spin_unlock_irq(&sdti_lock);
> +
>         i = sti_readl(SDTI_REVISION);
>         snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
>                 (i >> 4) & 0x0f, i & 0x0f);
> --
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
