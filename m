From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: musb RPM sleep-while-atomic in 4.9-rc1
Date: Thu, 20 Oct 2016 17:37:49 +0200
Message-ID: <20161020153749.GC12413@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I'm getting the splat below when booting 4.9-rc1 on a BBB and
tracked it down to 65b3f50ed6fa ("usb: musb: Add PM runtime support for
MUSB DSPS glue layer") which added a synchronous RPM get in a timer
callback:

[    6.466226] BUG: sleeping function called from invalid context at /home/johan/work/omicron/src/linux/drivers/base/power/runtime.c:955
[    6.478850] in_atomic(): 1, irqs_disabled(): 0, pid: 59, name: grep
[    6.485434] 1 lock held by grep/59:
[    6.489102]  #0: [    6.490966]  (
((&glue->timer))[    6.494206] ){+.-...}
, at: [    6.497194] [<c0191084>] call_timer_fn+0x0/0x41c
[    6.502048] Preemption disabled at:[    6.505540] [<c01015e0>] __do_softirq+0x80/0x594
[    6.510393] 
[    6.511974] CPU: 0 PID: 59 Comm: grep Not tainted 4.9.0-rc1 #46
[    6.518190] Hardware name: Generic AM33XX (Flattened Device Tree)
[    6.524613] [<c01116e4>] (unwind_backtrace) from [<c010dec0>] (show_stack+0x20/0x24)
[    6.532753] [<c010dec0>] (show_stack) from [<c0364f1c>] (dump_stack+0x24/0x28)
[    6.540351] [<c0364f1c>] (dump_stack) from [<c015ea58>] (___might_sleep+0x1d8/0x2c4)
[    6.548486] [<c015ea58>] (___might_sleep) from [<c015ebb4>] (__might_sleep+0x70/0xa8)
[    6.556720] [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
[    6.565404] [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
[    6.573813] [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
[    6.581675] [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
[    6.589990] [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
[    6.598487] [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
[    6.607079] [<c010168c>] (__do_softirq) from [<c01384cc>] (irq_exit+0xf4/0x130)
[    6.614766] [<c01384cc>] (irq_exit) from [<c017d910>] (__handle_domain_irq+0x84/0xec)
[    6.622991] [<c017d910>] (__handle_domain_irq) from [<c0101500>] (omap_intc_handle_irq+0x44/0xa0)
[    6.632306] [<c0101500>] (omap_intc_handle_irq) from [<c010ee78>] (__irq_usr+0x58/0x80)
[    6.640716] Exception stack(0xcf669fb0 to 0xcf669ff8)
[    6.646028] 9fa0:                                     b6fd5050 0012ebb0 b6e71058 b6e1c088
[    6.654614] 9fc0: b6e07000 00000001 b6e1cb10 b6fd5000 00000001 00000000 b6fd38e8 bec32a54
[    6.663198] 9fe0: b6e1c870 bec32990 b6fb0a20 b6fb9758 20030010 ffffffff

Setting the irq_safe flag seems to do the trick, but not sure that's
what you intended to do.

I saw you posted some regression fixes lately, but they did not look
related to this at first glance at least.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
