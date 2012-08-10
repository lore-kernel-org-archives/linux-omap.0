From: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: Re: [PATCHv2 1/2] media: rc: Introduce RX51 IR transmitter driver
Date: Fri, 10 Aug 2012 14:31:04 +0300
Message-ID: <20120810113104.GA4506@itanic.dhcp.inet.fi>
References: <1344593797-15819-1-git-send-email-timo.t.kokkonen@iki.fi>
 <1344593797-15819-2-git-send-email-timo.t.kokkonen@iki.fi>
 <5024EB3E.7060806@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:42807 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab2HJLbJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Aug 2012 07:31:09 -0400
Content-Disposition: inline
In-Reply-To: <5024EB3E.7060806@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 08.10 2012 14:06:38, Timo Kokkonen wrote:
> I should have probably tried this before, but when I enabled lock
> debugging with this driver, I got this:
> 
> > [  663.848083] BUG: sleeping function called from invalid context at kernel/mutex.c:269
> > [  663.856262] in_atomic(): 1, irqs_disabled(): 128, pid: 889, name: lircd
> > [  663.863220] 1 lock held by lircd/889:
> > [  663.867065]  #0:  (dm_timer_lock){......}, at: [<c00343e4>] omap_dm_timer_request_specific+0x18/0xc4
> > [  663.876739] irq event stamp: 1770
> > [  663.880218] hardirqs last  enabled at (1769): [<c050e4fc>] __mutex_unlock_slowpath+0xe0/0x15c
> > [  663.889221] hardirqs last disabled at (1770): [<c05102e8>] _raw_spin_lock_irqsave+0x1c/0x60
> > [  663.898010] softirqs last  enabled at (1674): [<c04bcc14>] unix_create1+0x148/0x174
> > [  663.906066] softirqs last disabled at (1672): [<c04bcbfc>] unix_create1+0x130/0x174
> > [  663.914154] [<c0019a90>] (unwind_backtrace+0x0/0xf8) from [<c050e11c>] (mutex_lock_nested+0x28/0x328)
> > [  663.923858] [<c050e11c>] (mutex_lock_nested+0x28/0x328) from [<c04196bc>] (clk_get_sys+0x1c/0xfc)
> > [  663.933197] [<c04196bc>] (clk_get_sys+0x1c/0xfc) from [<c0034344>] (omap_dm_timer_prepare+0xe4/0x16c)
> > [  663.942901] [<c0034344>] (omap_dm_timer_prepare+0xe4/0x16c) from [<c0034440>] (omap_dm_timer_request_specific+0x74/0xc4)
> > [  663.954345] [<c0034440>] (omap_dm_timer_request_specific+0x74/0xc4) from [<c03e7554>] (lirc_rx51_open+0x50/0x154)
> > [  663.965148] [<c03e7554>] (lirc_rx51_open+0x50/0x154) from [<c0103cf0>] (chrdev_open+0x98/0x16c)
> > [  663.974304] [<c0103cf0>] (chrdev_open+0x98/0x16c) from [<c00fd608>] (do_dentry_open+0x1dc/0x264)
> > [  663.983551] [<c00fd608>] (do_dentry_open+0x1dc/0x264) from [<c00fd9ec>] (finish_open+0x44/0x5c)
> > [  663.992706] [<c00fd9ec>] (finish_open+0x44/0x5c) from [<c010e230>] (do_last.isra.21+0x598/0xba8)
> > [  664.001953] [<c010e230>] (do_last.isra.21+0x598/0xba8) from [<c010e8e8>] (path_openat+0xa8/0x47c)
> > [  664.011291] [<c010e8e8>] (path_openat+0xa8/0x47c) from [<c010efb4>] (do_filp_open+0x2c/0x80)
> > [  664.020172] [<c010efb4>] (do_filp_open+0x2c/0x80) from [<c00fe674>] (do_sys_open+0xe0/0x174)
> > [  664.029052] [<c00fe674>] (do_sys_open+0xe0/0x174) from [<c0013a60>] (ret_fast_syscall+0x0/0x3c)
> 
> It appears that in omap_dm_timer_request() there is a call to
> spin_lock_irqsave() and then, as visible on the back trace,
> clk_get_sys() takes a mutex lock while the spinlock is still held.
> 
> To me it appears commit 3392cdd33a0 might have introduced this problem,
> but I'm not sure.
> 
> Any thoughts?
> 

What is the actual reason for holding the omap_timer_list lock in
omap_dm_timer_request*() functions? Is it just protecting the list? I
would guess so if the name implies anything..

Thus, do we still need to hold the lock when we call the
omap_dm_timer_prepare() or can we drop the lock before calling the
prepare? We can't keep on holding a spinlock of we are about to call
clk_get().

So, how about something like this:

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 626ad8c..1f66cac 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -189,6 +189,7 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 		timer->reserved = 1;
 		break;
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -197,7 +198,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
 			timer = NULL;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer request failed!\n", __func__);
@@ -220,6 +220,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (timer) {
 		ret = omap_dm_timer_prepare(timer);
@@ -228,7 +229,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 			timer = NULL;
 		}
 	}
-	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	if (!timer)
 		pr_debug("%s: timer%d request failed!\n", __func__, id);


