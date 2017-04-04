From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Tue, 4 Apr 2017 10:09:50 +0300
Message-ID: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,

since 4.9 (4.8 was fine) I can not boot omap4-panda-es if the musb is 
compiled in. The kernel will stuck printing:

** 206 printk messages dropped ** [    8.926727] musb_bus_suspend 2584: 
trying to suspend as a_idle while active

The bisect (log is [1]) points to:
d8e5f0eca1e8 usb: musb: Fix hardirq-safe hardirq-unsafe lock order error

and reverting the d8e5f0eca1e8 makes the board to boot up fine (Linux 
4.11-rc5 and next-20170331).

any idea on how to fix this w/o reverting the commit?

[1] https://pastebin.com/Z2HJY229

- Péter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
