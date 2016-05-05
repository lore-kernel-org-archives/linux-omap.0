From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: NFSroot hangs with bad unlock balance in Linux next
Date: Thu, 5 May 2016 15:03:44 -0700
Message-ID: <20160505220344.GE5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Trond Myklebust <trond.myklebust-7I+n7zu2hftEKMMhf/gKZA@public.gmane.org>, Anna Schumaker <anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Cc: linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like Linux next with NFSroot hangs for me at some point booting
into init. Then after a while it produces "BUG: bad unlock balance
detected!".

This happens at least with omap5-uevm and igepv5. Not sure yet if it
also happens on other boards, the ones I'm seeing it happen both have
USB Ethernet controller. They usually hang after the system starts
being idle some tens of seconds into booting.

I tried to bisect it down with no luck. I do have the following
trace, does that provide any clues?

Regards,

Tony

8< --------------------------
[ BUG: bad unlock balance detected! ]
4.6.0-rc6-next-20160505+ #1252 Not tainted
-------------------------------------
kworker/0:2/112 is trying to release lock (&nfsi->rmdir_sem) at:
[<c03a7f98>] nfs_async_unlink_release+0x20/0x68
but there are no more locks to release!

other info that might help us debug this:
2 locks held by kworker/0:2/112:
 #0:  ("nfsiod"){.+.+..}, at: [<c0154774>] process_one_work+0x120/0x6bc
  #1:  ((&task->u.tk_work)#2){+.+...}, at: [<c0154774>] process_one_work+0x120/0x6bc

stack backtrace:
CPU: 0 PID: 112 Comm: kworker/0:2 Not tainted 4.6.0-rc6-next-20160505+ #1252
Hardware name: Generic OMAP5 (Flattened Device Tree)
Workqueue: nfsiod rpc_async_release
[<c0110328>] (unwind_backtrace) from [<c010c3cc>] (show_stack+0x10/0x14)
[<c010c3cc>] (show_stack) from [<c0481348>] (dump_stack+0xb0/0xe4)
[<c0481348>] (dump_stack) from [<c018d638>] (print_unlock_imbalance_bug+0xb0/0xe0)
[<c018d638>] (print_unlock_imbalance_bug) from [<c0191444>] (lock_release+0x2ec/0x4c4)
[<c0191444>] (lock_release) from [<c018abf0>] (up_read+0x18/0x58)
[<c018abf0>] (up_read) from [<c03a7f98>] (nfs_async_unlink_release+0x20/0x68)
[<c03a7f98>] (nfs_async_unlink_release) from [<c0785320>] (rpc_free_task+0x24/0x44)
[<c0785320>] (rpc_free_task) from [<c015483c>] (process_one_work+0x1e8/0x6bc)
[<c015483c>] (process_one_work) from [<c0154e54>] (worker_thread+0x144/0x4e8)
[<c0154e54>] (worker_thread) from [<c015ad0c>] (kthread+0xdc/0xf8)
[<c015ad0c>] (kthread) from [<c01078f0>] (ret_from_fork+0x14/0x24)
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
