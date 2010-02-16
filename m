From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 5/6] Mailbox: sleeping function called from invalid
 context fix
Date: Tue, 16 Feb 2010 01:25:14 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9285@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18DB@dlee06.ent.ti.com>
 <20100215.154846.212385655.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46842 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932624Ab0BPHZV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 02:25:21 -0500
In-Reply-To: <20100215.154846.212385655.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

>-----Original Message-----
>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Monday, February 15, 2010 7:49 AM
>To: Guzman Lugo, Fernando
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 5/6] Mailbox: sleeping function called from invalid
>context fix
>
>Hi Fernando,
>
>From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
>Subject: [PATCH 5/6] Mailbox: sleeping function called from invalid context
>fix
>Date: Sat, 13 Feb 2010 02:42:16 +0100
>
>> From e06b2716824f225747c4dc83ed2623d0160ae132 Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo <x0095840@ti.com>
>> Date: Fri, 29 Jan 2010 17:12:24 -0600
>> Subject: [PATCH] Mailbox: sleeping function called from invalid context
>fix
>>
>> This patch fixes this bug:
>> BUG: sleeping function called from invalid context
>> Inside omap2_mbox_startup is called clk_get_sys that can sleep,
>> therefore omap2_mbox_startup can sleep but it is call in an atomic
>> context . So the spinlock is change for a semaphore.
>
>"mboxes_lock" is used to maintain the global list of mailbox
>instances, which belong to a single mailbox H/W module, but they are
>logical channels from S/W perspective. Both "->ops->startup()" and
>"->ops->shutdown()" are being executed against the above single H/W
>module, and a mailbox H/W module is totally __independent__ of the
>registration of logical mailboxes, which are (un)registered with

Yes, they are independent of each other, and can be executed at the same time. I am agreed with your patch; that should be the right solution, so you can drop my patch.

Thanks and regards,
Fernando.

>"omap_mbox_(un)register()". IOW, a mbox instance can be registered at
>anytime(before/after) H/W initialization. This H/W initialization is
>taken care of by "mbox_configured" variable. So I might think that the
>right solution is to introduce a new mutex lock __just for__ h/w
>configuration as below:
>
>	Modified arch/arm/plat-omap/mailbox.c
>diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>index 8e90633..19530de 100644
>--- a/arch/arm/plat-omap/mailbox.c
>+++ b/arch/arm/plat-omap/mailbox.c
>@@ -32,6 +32,7 @@ static struct omap_mbox *mboxes;
> static DEFINE_RWLOCK(mboxes_lock);
>
> static int mbox_configured;
>+static DEFINE_MUTEX(mbox_configured_lock);
>
> /* Mailbox FIFO handle functions */
> static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
>@@ -247,16 +248,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
> 	struct omap_mbox_queue *mq;
>
> 	if (likely(mbox->ops->startup)) {
>-		write_lock(&mboxes_lock);
>+		mutex_lock(&mbox_configured_lock);
> 		if (!mbox_configured)
> 			ret = mbox->ops->startup(mbox);
>
> 		if (unlikely(ret)) {
>-			write_unlock(&mboxes_lock);
>+			mutex_unlock(&mbox_configured_lock);
> 			return ret;
> 		}
> 		mbox_configured++;
>-		write_unlock(&mboxes_lock);
>+		mutex_unlock(&mbox_configured_lock);
> 	}
>
> 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
>@@ -302,12 +303,12 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
> 	free_irq(mbox->irq, mbox);
>
> 	if (unlikely(mbox->ops->shutdown)) {
>-		write_lock(&mboxes_lock);
>+		mutex_lock(&mbox_configured_lock);
> 		if (mbox_configured > 0)
> 			mbox_configured--;
> 		if (!mbox_configured)
> 			mbox->ops->shutdown(mbox);
>-		write_unlock(&mboxes_lock);
>+		mutex_unlock(&mbox_configured_lock);
> 	}
> }
