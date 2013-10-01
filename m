From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Tue,  1 Oct 2013 15:31:08 +0200
Message-ID: <1380634271-27588-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:50964 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab3JANbU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 09:31:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, Daniel Mack <zonque@gmail.com>

While my first series makes the cppi41 driver survive suspend/resume
cycles as long as users are fully removed and added back after resume,
here are some more patches which make it all work completely.

Patch #1 restores more registers on resume time.

Patch #2 is a cosmetic cleanup that emerged while digging through the
driver and gaining a basic idea of how it's implemented. Nothing fancy.

Patch #3, however, gives me headaches. I can't fully explain what's
going on, but I can tell for sure that if fixes a problem that I stared
on for many hours.

The problem is that on resume, the musb core will detect that some of
the suspended USB devices' endpoints are stalled. Which is something
that is unrelated to the dma driver, it just seems to be an expected
condition. That, however, makes the musb core call
cppi41_dma_channel_abort() -> cppi41_tear_down_chan(), which is
an otherwise untravelled code path. When that function is called for
a channel which has all of td_queued, td_seen and td_desc_seen set
to FALSE, I'm always getting a warning like this:

[   17.105981] ------------[ cut here ]------------
[   17.110861] WARNING: CPU: 0 PID: 122 at drivers/dma/cppi41.c:644 cppi41_dma_control+0x378/0x3f8 [cppi41]()
[   17.120990] Modules linked in: musb_dsps musb_hdrc cppi41 snd_soc_cs4271 snd_soc_ak4104 snd_soc_davinci_mcasp musb_am335x
[   17.132583] CPU: 0 PID: 122 Comm: usb-storage Not tainted 3.12.0-rc3-00073-gb73d497-dirty #975
[   17.141670] [<c00135b8>] (unwind_backtrace+0x0/0xf4) from [<c0011418>] (show_stack+0x10/0x14)
[   17.150636] [<c0011418>] (show_stack+0x10/0x14) from [<c003597c>] (warn_slowpath_common+0x6c/0x84)
[   17.160052] [<c003597c>] (warn_slowpath_common+0x6c/0x84) from [<c0035a30>] (warn_slowpath_null+0x1c/0x24)
[   17.170198] [<c0035a30>] (warn_slowpath_null+0x1c/0x24) from [<bf015824>] (cppi41_dma_control+0x378/0x3f8 [cppi41])
[   17.181370] [<bf015824>] (cppi41_dma_control+0x378/0x3f8 [cppi41]) from [<bf023974>] (cppi41_dma_channel_abort+0xb0/0x124 [musb_hd)
[   17.194111] [<bf023974>] (cppi41_dma_channel_abort+0xb0/0x124 [musb_hdrc]) from [<bf02031c>] (musb_host_rx+0x2b0/0x404 [musb_hdrc])
[   17.206565] [<bf02031c>] (musb_host_rx+0x2b0/0x404 [musb_hdrc]) from [<bf01ca70>] (musb_interrupt+0x70/0x95c [musb_hdrc])
[   17.218102] [<bf01ca70>] (musb_interrupt+0x70/0x95c [musb_hdrc]) from [<bf02f640>] (dsps_interrupt+0x174/0x254 [musb_dsps])
[   17.229817] [<bf02f640>] (dsps_interrupt+0x174/0x254 [musb_dsps]) from [<c00686d0>] (handle_irq_event_percpu+0x38/0x194)
[   17.241238] [<c00686d0>] (handle_irq_event_percpu+0x38/0x194) from [<c0068868>] (handle_irq_event+0x3c/0x5c)
[   17.251565] [<c0068868>] (handle_irq_event+0x3c/0x5c) from [<c006aa58>] (handle_level_irq+0x90/0xf4)
[   17.261163] [<c006aa58>] (handle_level_irq+0x90/0xf4) from [<c0067f30>] (generic_handle_irq+0x2c/0x3c)
[   17.270942] [<c0067f30>] (generic_handle_irq+0x2c/0x3c) from [<c000eae4>] (handle_IRQ+0x38/0x84)
[   17.280174] [<c000eae4>] (handle_IRQ+0x38/0x84) from [<c00085b8>] (omap3_intc_handle_irq+0x68/0x74)
[   17.289678] [<c00085b8>] (omap3_intc_handle_irq+0x68/0x74) from [<c0011f04>] (__irq_svc+0x44/0x78)
[   17.299085] Exception stack(0xcedf1d18 to 0xcedf1d60)
[   17.304391] 1d00:                                                       00000001 c083c10c
[   17.312981] 1d20: 00000000 cec4cb80 60000013 cec68010 cee2e640 ced12c00 00000000 60000013
[   17.321572] 1d40: cee955cc 00000080 c08640ac cedf1d60 c007af4c c0511ab8 20000013 ffffffff
[   17.330177] [<c0011f04>] (__irq_svc+0x44/0x78) from [<c0511ab8>] (_raw_spin_unlock_irqrestore+0x64/0x68)
[   17.340156] [<c0511ab8>] (_raw_spin_unlock_irqrestore+0x64/0x68) from [<bf01ee78>] (musb_urb_enqueue+0x70/0x520 [musb_hdrc])
[   17.351974] [<bf01ee78>] (musb_urb_enqueue+0x70/0x520 [musb_hdrc]) from [<c0344248>] (usb_hcd_submit_urb+0xa0/0x26c)
[   17.363044] [<c0344248>] (usb_hcd_submit_urb+0xa0/0x26c) from [<c0352724>] (usb_stor_msg_common+0x84/0x134)
[   17.373283] [<c0352724>] (usb_stor_msg_common+0x84/0x134) from [<c0352b38>] (usb_stor_bulk_transfer_buf+0x48/0x7c)
[   17.384160] [<c0352b38>] (usb_stor_bulk_transfer_buf+0x48/0x7c) from [<c0352dfc>] (usb_stor_Bulk_transport+0x144/0x2fc)
[   17.395491] [<c0352dfc>] (usb_stor_Bulk_transport+0x144/0x2fc) from [<c0353524>] (usb_stor_invoke_transport+0x20/0x48c)
[   17.406817] [<c0353524>] (usb_stor_invoke_transport+0x20/0x48c) from [<c0354960>] (usb_stor_control_thread+0x164/0x228)
[   17.418158] [<c0354960>] (usb_stor_control_thread+0x164/0x228) from [<c0050e60>] (kthread+0xb4/0xb8)
[   17.427759] [<c0050e60>] (kthread+0xb4/0xb8) from [<c000e2c8>] (ret_from_fork+0x14/0x2c)
[   17.436250] ---[ end trace 0606f8051ee8bb0d ]---

Note that the line numbers don't match the current code in mainline due
to some debugging code, but it should be clear where the warning comes
from.

With patch #3 applied, I made this problem go away, and I can suspend
resume with all musb related drivers active just fine. The only issue
I have is that I don't fully understand the reason, as it seems to me
that my patch just changes the timing, and we're actually seeing a
race condition here.

Sebastian, can you give a comment on this? I'll post the musb patches
that are necessary as well now, and I'd appreciate more testers here.


Many thanks,
Daniel


Daniel Mack (3):
  dma: cppi41: restore more registers
  dma: cppi41: use cppi41_pop_desc() where possible
  dma: cppi41: move -EAGAIN in tear_down

 drivers/dma/cppi41.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

-- 
1.8.3.1

