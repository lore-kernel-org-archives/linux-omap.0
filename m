From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Thu, 10 Nov 2016 14:46:13 +0200
Message-ID: <7547144.tJtJXeDM1m@avalon>
References: <20161107215020.31399-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161107215020.31399-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Thank you for the patches.

On Monday 07 Nov 2016 14:50:16 Tony Lindgren wrote:
> Hi all,
> 
> Here are musb fixes for the issues that I've been able to track down.
> Not sure if these will help with the problem Ladis was seeing as I'm
> not able to reproduce that one it seems.
> 
> As many people depend on this driver I'd like to have these merged
> for v4.9-rc cycle after review and testing.
> 
> Please review and test. You need to use v4.9-rc3 or later for testing
> because of the earlier fixes.

The series fixes my problems, both with the original and latest version of
patch 2/4.

Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

I have however seen the following warning once with the original version of 2/4.

[    3.094116] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[    3.101257] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.110626] ------------[ cut here ]------------
[    3.110717] WARNING: CPU: 0 PID: 4 at /home/laurent/src/kernel/omap4/linux-2.6/drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x220/0x348
[    3.110717] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Read): Data Access in User mode during Functional access
[    3.110717] Modules linked in:
[    3.110717] CPU: 0 PID: 4 Comm: kworker/0:0 Not tainted 4.9.0-rc4-00577-g1cd727de4a19 #29
[    3.110717] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    3.110717] Workqueue: events musb_irq_work
[    3.158813] [<c0110118>] (unwind_backtrace) from [<c010c0cc>] (show_stack+0x10/0x14)
[    3.158813] [<c010c0cc>] (show_stack) from [<c0490dec>] (dump_stack+0xa8/0xe0)
[    3.158813] [<c0490dec>] (dump_stack) from [<c01377e4>] (__warn+0xd8/0x104)
[    3.158813] [<c01377e4>] (__warn) from [<c01378b8>] (warn_slowpath_fmt+0x38/0x48)
[    3.158813] [<c01378b8>] (warn_slowpath_fmt) from [<c04c49d4>] (l3_interrupt_handler+0x220/0x348)
[    3.203613] [<c04c49d4>] (l3_interrupt_handler) from [<c01a03d0>] (__handle_irq_event_percpu+0x98/0x3ec)
[    3.203613] [<c01a03d0>] (__handle_irq_event_percpu) from [<c01a0740>] (handle_irq_event_percpu+0x1c/0x58)
[    3.203613] [<c01a0740>] (handle_irq_event_percpu) from [<c01a07b4>] (handle_irq_event+0x38/0x5c)
[    3.233123] [<c01a07b4>] (handle_irq_event) from [<c01a3c38>] (handle_fasteoi_irq+0xcc/0x1a4)
[    3.233123] [<c01a3c38>] (handle_fasteoi_irq) from [<c019fb40>] (generic_handle_irq+0x18/0x28)
[    3.233123] [<c019fb40>] (generic_handle_irq) from [<c019fc54>] (__handle_domain_irq+0x64/0xdc)
[    3.251190] [<c019fc54>] (__handle_domain_irq) from [<c010152c>] (gic_handle_irq+0x48/0x9c)
[    3.251190] [<c010152c>] (gic_handle_irq) from [<c087fdb0>] (__irq_svc+0x70/0x98)
[    3.251190] Exception stack(0xee8c7e18 to 0xee8c7e60)
[    3.251190] 7e00:                                                       fc0ab000 00000060
[    3.282348] 7e20: 0000001f 00000000 00000000 ef6a7ac0 fc0ab000 00000060 c0dcda2c c06a2928
[    3.282348] 7e40: c0d0512c c0d0512c 00000000 ee8c7e68 c06a2928 c06a34b8 60000153 ffffffff
[    3.282348] [<c087fdb0>] (__irq_svc) from [<c06a34b8>] (musb_default_readb+0x48/0x184)
[    3.282348] [<c06a34b8>] (musb_default_readb) from [<c06a2928>] (musb_irq_work+0x1c/0x1cc)
[    3.316528] [<c06a2928>] (musb_irq_work) from [<c0154c94>] (process_one_work+0x1d4/0x6b8)
[    3.325256] [<c0154c94>] (process_one_work) from [<c0155314>] (worker_thread+0x164/0x488)
[    3.325256] [<c0155314>] (worker_thread) from [<c015b7e4>] (kthread+0xd0/0xec)
[    3.325256] [<c015b7e4>] (kthread) from [<c01083f0>] (ret_from_fork+0x14/0x24)
[    3.325256] ---[ end trace 0c154bedf8e63312 ]---
[    3.363372] twl6030_usb 48070000.i2c:twl@48:usb-comparator: Initialized TWL6030 USB module
[    3.365051] hub 1-1:1.0: USB hub found
[    3.365325] hub 1-1:1.0: 5 ports detected

It never occurred with the latest version of the patch, but I can't seem to
reproduce it either with the original version.

> Tony Lindgren (4):
>   usb: musb: Fix broken use of static variable for multiple instances
>   usb: musb: Fix sleeping function called from invalid context for hdrc
>     glue
>   usb: musb: Fix PM for hub disconnect
>   phy: twl4030-usb: Fix for musb session bit based PM
> 
>  drivers/phy/phy-twl4030-usb.c  |   4 +-
>  drivers/usb/musb/musb_core.c   | 107 ++++++++++++++++++++++++++++++++------
>  drivers/usb/musb/musb_core.h   |  13 ++++-
>  drivers/usb/musb/musb_dsps.c   |  24 ++++++---
>  drivers/usb/musb/musb_gadget.c |  28 ++++++++---
>  drivers/usb/musb/tusb6010.c    |   6 +--
>  6 files changed, 148 insertions(+), 34 deletions(-)

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
