From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: 4.6-rc5 on arm (nokia n900): spinlock bad magic on CPU#0,
Date: Mon, 25 Apr 2016 13:20:28 +0200
Message-ID: <20160425112028.GA22359@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!

First time such thing happened, normally N900 is very stable.

Any ideas?

							Pavel

[ 6274.123779] DSS: context saved
[ 6410.643981] BUG: spinlock bad magic on CPU#0, kworker/u2:1/18947
[ 6410.644409]  lock: 0xce648f40, .magic: 00000000, .owner: <none>/-1,
.owner_cpu: 0
[ 6410.644836] CPU: 0 PID: 18947 Comm: kworker/u2:1 Not tainted
4.6.0-rc5-176732-g177b741-dirty #243
[ 6410.647949] Hardware name: Nokia RX-51 board
[ 6410.650909] Workqueue: phy1 wl1251_irq_work
[ 6410.653869] [<c010eebc>] (unwind_backtrace) from [<c010b150>]
(show_stack+0x10/0x14)
[ 6410.657135] [<c010b150>] (show_stack) from [<c04232b0>]
(dump_stack+0x8c/0xac)
[ 6410.660583] [<c04232b0>] (dump_stack) from [<c017cf78>]
(do_raw_spin_lock+0x198/0x1b8)
[ 6410.664245] [<c017cf78>] (do_raw_spin_lock) from [<c08393f8>]
(_raw_spin_lock_irqsave+0x10/0x18)
[ 6410.668243] [<c08393f8>] (_raw_spin_lock_irqsave) from [<c05aaf20>]
(wl1251_op_tx+0x38/0x5c)
[ 6410.672485] [<c05aaf20>] (wl1251_op_tx) from [<c0802dec>]
(ieee80211_tx_frags+0xd0/0x3d4)
[ 6410.677001] [<c0802dec>] (ieee80211_tx_frags) from [<c080315c>]
(__ieee80211_tx+0x6c/0x134)
[ 6410.681793] [<c080315c>] (__ieee80211_tx) from [<c0804698>]
(ieee80211_tx+0xb4/0xdc)
[ 6410.686828] [<c0804698>] (ieee80211_tx) from [<c080539c>]
(__ieee80211_subif_start_xmit+0x540/0x6d0)
[ 6410.697448] [<c080539c>] (__ieee80211_subif_start_xmit) from
[<c0805538>] (ieee80211_subif_start_xmit+0xc/0x14)
[ 6410.709625] [<c0805538>] (ieee80211_subif_start_xmit) from
[<c06905a4>] (dev_hard_start_xmit+0x228/0x440)
[ 6410.723205] [<c06905a4>] (dev_hard_start_xmit) from [<c06b0754>]
(sch_direct_xmit+0xf4/0x220)
[ 6410.730712] [<c06b0754>] (sch_direct_xmit) from [<c0690b64>]
(__dev_queue_xmit+0x25c/0x62c)
[ 6410.738494] [<c0690b64>] (__dev_queue_xmit) from [<c06c2738>]
(ip_finish_output2+0x1b8/0x3d0)
[ 6410.746551] [<c06c2738>] (ip_finish_output2) from [<c06c380c>]
(ip_output+0x130/0x144)
[ 6410.754852] [<c06c380c>] (ip_output) from [<c06c2eb8>]
(ip_local_out+0x38/0x3c)
[ 6410.763366] [<c06c2eb8>] (ip_local_out) from [<c06db674>]
(tcp_transmit_skb+0x510/0x984)
[ 6410.772003] [<c06db674>] (tcp_transmit_skb) from [<c06d8300>]
(tcp_rcv_established+0x360/0x728)
[ 6410.780822] [<c06d8300>] (tcp_rcv_established) from [<c06e1088>]
(tcp_v4_do_rcv+0x14c/0x1b0)
[ 6410.789764] [<c06e1088>] (tcp_v4_do_rcv) from [<c06e3698>]
(tcp_v4_rcv+0xc3c/0xc58)
[ 6410.798919] [<c06e3698>] (tcp_v4_rcv) from [<c06bd9bc>]
(ip_local_deliver_finish+0x5c/0x29c)
[ 6410.808197] [<c06bd9bc>] (ip_local_deliver_finish) from
[<c06bddf4>] (ip_local_deliver+0xd0/0xd8)
[ 6410.817565] [<c06bddf4>] (ip_local_deliver) from [<c06bd6f8>]
(ip_rcv_finish+0x1f0/0x458)
[ 6410.826873] [<c06bd6f8>] (ip_rcv_finish) from [<c06be198>]
(ip_rcv+0x39c/0x56c)
[ 6410.836059] [<c06be198>] (ip_rcv) from [<c0688934>]
(__netif_receive_skb_core+0x2e8/0x958)
[ 6410.845214] [<c0688934>] (__netif_receive_skb_core) from
[<c068d1b0>] (netif_receive_skb_internal+0x30/0xa0)
[ 6410.863647] [<c068d1b0>] (netif_receive_skb_internal) from
[<c07fcaf4>] (ieee80211_deliver_skb+0x184/0x1bc)
[ 6410.882598] [<c07fcaf4>] (ieee80211_deliver_skb) from [<c07fdd44>]
(ieee80211_rx_handlers+0xe9c/0x201c)
[ 6410.901916] [<c07fdd44>] (ieee80211_rx_handlers) from [<c07ff07c>]
(ieee80211_prepare_and_rx_handle+0x1b8/0x9b4)
[ 6410.921600] [<c07ff07c>] (ieee80211_prepare_and_rx_handle) from
[<c07ffef8>] (ieee80211_rx_napi+0x680/0x7f0)
[ 6410.941650] [<c07ffef8>] (ieee80211_rx_napi) from [<c05ad0c0>]
(wl1251_rx+0x324/0x49c)
[ 6410.951843] [<c05ad0c0>] (wl1251_rx) from [<c05ab660>]
(wl1251_irq_work+0x154/0x1b0)
[ 6410.961944] [<c05ab660>] (wl1251_irq_work) from [<c014ce64>]
(process_one_work+0x130/0x428)
[ 6410.971923] [<c014ce64>] (process_one_work) from [<c014d2f0>]
(worker_thread+0x15c/0x490)
[ 6410.981842] [<c014d2f0>] (worker_thread) from [<c01522f4>]
(kthread+0xd4/0xf0)
[ 6410.991577] [<c01522f4>] (kthread) from [<c0107918>]
(ret_from_fork+0x14/0x3c)
[ 6417.062316] DISPC: dispc_runtime_get
[ 6417.062408] DSS: dss_restore_context
[ 6417.062408] DSS: context restored

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
