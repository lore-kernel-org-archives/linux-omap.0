From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] mfd: twl4030-irq: irq_desc->lock converted to
 raw_spinlock_t
Date: Wed, 16 Dec 2009 20:20:22 +0200
Message-ID: <20091216182022.GA20302@nokia.com>
References: <1260987530-20221-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32744 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762762AbZLPSV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 13:21:57 -0500
Content-Disposition: inline
In-Reply-To: <1260987530-20221-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 16, 2009 at 07:18:50PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>commit 239007b8440abff689632f50cdf0f2b9e895b534 converted
>the spinlock_t to raw_spinlock_t. Unfortunately twl4030-irq
>was left aside on the conversion.
>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Tony Lindgre <tony@atomide.com>

oops, my n is failing.

Tony Lindgren, below is better version:

========== cut here =================

 From 17edd64d8e813713da6fb9fa018ab5f79d94d159 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 16 Dec 2009 20:11:22 +0200
Subject: [PATCH] mfd: twl4030-irq: irq_desc->lock converted to raw_spinlock_t

commit 239007b8440abff689632f50cdf0f2b9e895b534 converted
the spinlock_t to raw_spinlock_t. Unfortunately twl4030-irq
was left aside on the conversion.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

I'm not sure this is the expected fix since twl4030-irq handler
should be running in thread context. Currently mask/unmask/set_type
are deferred to a workqueue. Thomas, should this be done ? How
do you expect irq chips on slow busses to implement mask/unmask/set_type ?

  drivers/mfd/twl4030-irq.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 20d29ba..9df9a5a 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -568,12 +568,12 @@ static void twl4030_sih_do_edge(struct work_struct *work)
  
  		bytes[byte] &= ~(0x03 << off);
  
-		spin_lock_irq(&d->lock);
+		raw_spin_lock_irq(&d->lock);
  		if (d->status & IRQ_TYPE_EDGE_RISING)
  			bytes[byte] |= BIT(off + 1);
  		if (d->status & IRQ_TYPE_EDGE_FALLING)
  			bytes[byte] |= BIT(off + 0);
-		spin_unlock_irq(&d->lock);
+		raw_spin_unlock_irq(&d->lock);
  
  		edge_change &= ~BIT(i);
  	}
-- 
1.6.6.rc0


-- 
balbi
