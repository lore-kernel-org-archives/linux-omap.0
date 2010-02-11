From: Peter Barada <peter.barada@gmail.com>
Subject: Circular mm_lock semaphore in omapfb code
Date: Thu, 11 Feb 2010 11:34:44 -0500
Message-ID: <738b3f7e1002110834o1d639891pb21f5da479724baa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:48246 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859Ab0BKQes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 11:34:48 -0500
Received: by pzk2 with SMTP id 2so814365pzk.21
        for <linux-omap@vger.kernel.org>; Thu, 11 Feb 2010 08:34:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've got a version of OMAP 2.6.33-rc3 up on my board, based on Kevin's
tree, commit 838cb5e10ba0131bd46b5404d313980144a481a5

And I've added in my LCD code which works (I see a penguin on bootup).
 I have CONFIG_FB_OMAP enabled and CONFIG_OMAp2_DSS not disabled in my
kernel config.

When I try to execute a small test program that maps in the
framebuffer with the following code(stripped down):

ret = ioctl(fb, FBIOGET_FSCREENINFO, &fb_fix);
ret = ioctl(fb, FBIOGET_VSCREENINFO, &fb_var);
fb_size = fb_var.xres * fb_var.yres * fb_var.bits_per_pixel/8;
fb_ptr = mmap(NULL, fb_size, PROT_READ|PROT_WRITE, MAP_SHARED, fb, 0);

to map in the frame buffer for scribbling, and I get:

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.33-rc3 #5
-------------------------------------------------------
draw-test/1018 is trying to acquire lock:
 (&fbdev->rqueue_mutex){+.+...}, at: [<c020a38c>] omapfb_mmap+0x1c/0x44

but task is already holding lock:
 (&fb_info->mm_lock){+.+...}, at: [<c01f7384>] fb_mmap+0x50/0x164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&fb_info->mm_lock){+.+...}:
       [<c0091f9c>] __lock_acquire+0x1394/0x173c
       [<c009241c>] lock_acquire+0xd8/0xf0
       [<c0415ab0>] mutex_lock_nested+0x60/0x2e4
       [<c020a3ec>] set_fb_fix+0x38/0xd8
       [<c020a4b0>] omapfb_set_par+0x24/0x40
       [<c0202454>] fbcon_init+0x2e0/0x408
       [<c0223a20>] visual_init+0xf4/0x148
       [<c0225c20>] bind_con_driver+0x2f4/0x444
       [<c0225da4>] take_over_console+0x34/0x3c
       [<c02025f4>] fbcon_takeover+0x78/0xe4
       [<c0202c9c>] fbcon_event_notify+0x2a8/0x6f0
       [<c04194e8>] notifier_call_chain+0x2c/0x70
       [<c0084144>] __blocking_notifier_call_chain+0x48/0x5c
       [<c008416c>] blocking_notifier_call_chain+0x14/0x18
       [<c01f7e24>] register_framebuffer+0x29c/0x2d8
       [<c020ba68>] omapfb_do_probe+0x5f8/0x86c
       [<c020dc10>] omap3logic_panel_probe+0xc/0x18
       [<c02350b0>] platform_drv_probe+0x18/0x1c
       [<c0234158>] driver_probe_device+0xa0/0x14c
       [<c0234264>] __driver_attach+0x60/0x84
       [<c023399c>] bus_for_each_dev+0x44/0x74
       [<c02332f4>] bus_add_driver+0x100/0x28c
       [<c0234534>] driver_register+0xa8/0x130
       [<c0036344>] do_one_initcall+0x5c/0x1bc
       [<c0008578>] kernel_init+0x90/0x10c
       [<c0037964>] kernel_thread_exit+0x0/0x8

-> #0 (&fbdev->rqueue_mutex){+.+...}:
       [<c0091c4c>] __lock_acquire+0x1044/0x173c
       [<c009241c>] lock_acquire+0xd8/0xf0
       [<c0415ab0>] mutex_lock_nested+0x60/0x2e4
       [<c020a38c>] omapfb_mmap+0x1c/0x44
       [<c01f739c>] fb_mmap+0x68/0x164
       [<c00d1510>] mmap_region+0x1d8/0x3b0
       [<c00d1a8c>] sys_mmap_pgoff+0x94/0xc0
       [<c0036940>] ret_fast_syscall+0x0/0x38

other info that might help us debug this:

2 locks held by draw-test/1018:
 #0:  (&mm->mmap_sem){++++++}, at: [<c00d1a68>] sys_mmap_pgoff+0x70/0xc0
 #1:  (&fb_info->mm_lock){+.+...}, at: [<c01f7384>] fb_mmap+0x50/0x164

stack backtrace:
[<c003c60c>] (unwind_backtrace+0x0/0xdc) from [<c00906d4>] (print_circular_bug+0
xc8/0xe0)
[<c00906d4>] (print_circular_bug+0xc8/0xe0) from [<c0091c4c>] (__lock_acquire+0x
1044/0x173c)
[<c0091c4c>] (__lock_acquire+0x1044/0x173c) from [<c009241c>] (lock_acquire+0xd8
/0xf0)
[<c009241c>] (lock_acquire+0xd8/0xf0) from [<c0415ab0>] (mutex_lock_nested+0x60/
0x2e4)
[<c0415ab0>] (mutex_lock_nested+0x60/0x2e4) from [<c020a38c>] (omapfb_mmap+0x1c/
0x44)
[<c020a38c>] (omapfb_mmap+0x1c/0x44) from [<c01f739c>] (fb_mmap+0x68/0x164)
[<c01f739c>] (fb_mmap+0x68/0x164) from [<c00d1510>] (mmap_region+0x1d8/0x3b0)
[<c00d1510>] (mmap_region+0x1d8/0x3b0) from [<c00d1a8c>] (sys_mmap_pgoff+0x94/0x
c0)
[<c00d1a8c>] (sys_mmap_pgoff+0x94/0xc0) from [<c0036940>] (ret_fast_syscall+0x0/
0x38)

Has anyone seen this before?
