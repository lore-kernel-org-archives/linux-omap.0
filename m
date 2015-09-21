From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: usb: dwc3: gadget: warning on v4.3-rc1
Date: Mon, 21 Sep 2015 11:06:27 +0300
Message-ID: <55FFBA83.7010003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

I see the following warning when g_zero is loaded
and USB cable is plugged to host on dra7-evm's USB1 port.

It happens only once and no longer appears on re-loading gadget
or plugging/unplugging cable.

root@rockdesk:~# modprobe g_zero
[   28.414895] zero gadget: Gadget Zero, version: Cinco de Mayo 2008
[   28.421284] zero gadget: zero ready
root@rockdesk:~# [   35.298997] zero gadget: high-speed config #3: source/sink
[   35.305079] ------------[ cut here ]------------
[   35.309948] WARNING: CPU: 1 PID: 2269 at drivers/usb/dwc3/gadget.c:697 dwc3_gadget_ep_disable+0xa8/0xc8 [dwc3]()
[   35.320613] dwc3 48890000.usb: ep1in is already disabled
[   35.326174] Modules linked in: usb_f_ss_lb g_zero libcomposite xhci_plat_hcd xhci_hcd usbcore dwc3 m25p80 spi_nor udc_core usb_common c_can_platform c_can spi_ti_qspi can_dev cpufreq_dt omap_wdt extcon_usb_gx
[   35.353787] CPU: 1 PID: 2269 Comm: irq/415-dwc3 Not tainted 4.3.0-rc2-00001-g895eac6 #289
[   35.362349] Hardware name: Generic DRA74X (Flattened Device Tree)
[   35.368749] [<c0016ed4>] (unwind_backtrace) from [<c00131d4>] (show_stack+0x10/0x14)
[   35.376877] [<c00131d4>] (show_stack) from [<c033c94c>] (dump_stack+0x80/0x9c)
[   35.384459] [<c033c94c>] (dump_stack) from [<c003e684>] (warn_slowpath_common+0x7c/0xb8)
[   35.392952] [<c003e684>] (warn_slowpath_common) from [<c003e754>] (warn_slowpath_fmt+0x30/0x40)
[   35.402088] [<c003e754>] (warn_slowpath_fmt) from [<bf098acc>] (dwc3_gadget_ep_disable+0xa8/0xc8 [dwc3])
[   35.412080] [<bf098acc>] (dwc3_gadget_ep_disable [dwc3]) from [<bf149ac0>] (disable_ep+0x2c/0x6c [usb_f_ss_lb])
[   35.422676] [<bf149ac0>] (disable_ep [usb_f_ss_lb]) from [<bf14a6b0>] (disable_endpoints+0x18/0x50 [usb_f_ss_lb])
[   35.433445] [<bf14a6b0>] (disable_endpoints [usb_f_ss_lb]) from [<bf14a714>] (disable_source_sink+0x2c/0x34 [usb_f_ss_lb])
[   35.445032] [<bf14a714>] (disable_source_sink [usb_f_ss_lb]) from [<bf14a74c>] (sourcesink_set_alt+0x2c/0x264 [usb_f_ss_lb])
[   35.456810] [<bf14a74c>] (sourcesink_set_alt [usb_f_ss_lb]) from [<bf131730>] (composite_setup+0xc28/0x1574 [libcomposite])
[   35.468500] [<bf131730>] (composite_setup [libcomposite]) from [<bf099ac0>] (dwc3_ep0_delegate_req+0x2c/0x40 [dwc3])
[   35.479559] [<bf099ac0>] (dwc3_ep0_delegate_req [dwc3]) from [<bf09a840>] (dwc3_ep0_interrupt+0x984/0xc40 [dwc3])
[   35.490353] [<bf09a840>] (dwc3_ep0_interrupt [dwc3]) from [<bf09821c>] (dwc3_thread_interrupt+0x7a8/0x9c8 [dwc3])
[   35.501195] [<bf09821c>] (dwc3_thread_interrupt [dwc3]) from [<c009c5d8>] (irq_thread_fn+0x1c/0x34)
[   35.510689] [<c009c5d8>] (irq_thread_fn) from [<c009c78c>] (irq_thread+0x148/0x1a4)
[   35.518724] [<c009c78c>] (irq_thread) from [<c005de20>] (kthread+0xd0/0xec)
[   35.526024] [<c005de20>] (kthread) from [<c000f870>] (ret_from_fork+0x14/0x24)
[   35.533593] ---[ end trace fe01e35c4677ca2f ]---

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
