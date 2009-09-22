From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes
 to support OMAP4 mailbox.
Date: Tue, 22 Sep 2009 18:11:33 +0300 (EEST)
Message-ID: <20090922.181133.39157696.Hiroshi.DOYU@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60885 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbZIVPMB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 11:12:01 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, rmk@arm.linux.org.uk, h-kanigeri2@ti.com, grgupta@ti.com

Hi Tony,

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
Date: Tue, 22 Sep 2009 16:33:32 +0200

> From 6e3100d338c37928724821cab460ced1437bfa59 Mon Sep 17 00:00:00 2001
> From: C A Subramaniam <subramaniam.ca@ti.com>
> Date: Tue, 8 Sep 2009 22:36:20 +0530
> Subject: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
> 
> This patch adds code changes in the mailbox driver module to
> add support for OMAP4 mailbox.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |  120 +++++++++++++++++++++++++++++++++++------
>  arch/arm/plat-omap/mailbox.c  |   25 +++++++--
>  2 files changed, 123 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 6f71f37..3d85807 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c

[...]

> @@ -70,10 +88,9 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
>  static int omap2_mbox_startup(struct omap_mbox *mbox)
>  {
>  	unsigned int l;
> -
>  	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
>  	if (IS_ERR(mbox_ick_handle)) {
> -		printk("Could not get mailboxes_ick\n");
> +		printk(KERN_ERR "Could not get mailboxes_ick\n");
>  		return -ENODEV;
>  	}
>  	clk_enable(mbox_ick_handle);
> @@ -85,7 +102,6 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
>  	l = mbox_read_reg(MAILBOX_SYSCONFIG);
>  	l |= 0x00000011;
>  	mbox_write_reg(l, MAILBOX_SYSCONFIG);
> -
>  	omap2_mbox_enable_irq(mbox, IRQ_RX);
>  
>  	return 0;

The above may conflict with the following patch, but it won't be
diffcult to solve the confliction.

http://patchwork.kernel.org/patch/44224/

Tony, can you get the above "softreset" patch in?

[...]

> @@ -156,6 +172,8 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
>  	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>  
>  	mbox_write_reg(bit, p->irqstatus);
> +	/* Flush post writing */
> +	 mbox_read_reg(p->irqstatus);
>  }

This is the same as the following patch:

http://patchwork.kernel.org/patch/43740/

Tony, can you get the above "flush posted write" patch in?
