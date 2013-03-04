From: Siddharth Heroor <heroor@gmail.com>
Subject: 3.9.0-rc1 - [ BUG: swapper/0/1 still has locks held! ]
Date: Mon, 4 Mar 2013 15:03:08 +0530
Message-ID: <CAANGMpivP+3T6DLS276pT3tg=doRbjxH_1OdhNx_5HU=hE7YyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43444 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317Ab3CDJdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 04:33:10 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so1743238wib.4
        for <linux-omap@vger.kernel.org>; Mon, 04 Mar 2013 01:33:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm testing 3.9-rc1 on a pandaboard 4430. I have built using
omap2plus_defconfig and CONFIG_USB_ARCH_HAS_HCD=y. My rootfs is on NFS

[   10.538665] [ BUG: swapper/0/1 still has locks held! ]
[   10.544097] 3.9.0-rc1-svn #1 Not tainted
[   10.548217] -------------------------------------
[   10.553192] 1 lock held by swapper/0/1:
[   10.557220]  #0:  (&type->s_umount_key#13/1){+.+.+.}, at:
[<c0108804>] sget+0x208/0x504
[   10.565734]
[   10.565734] stack backtrace:
[   10.570404] [<c001ae78>] (unwind_backtrace+0x0/0xf0) from
[<c04cf550>] (rpc_wait_bit_killable+0x80/0xb8)
[   10.580383] [<c04cf550>] (rpc_wait_bit_killable+0x80/0xb8) from
[<c04f2cc4>] (__wait_on_bit+0x7c/0xb4)
[   10.590179] [<c04f2cc4>] (__wait_on_bit+0x7c/0xb4) from
[<c04f2d60>] (out_of_line_wait_on_bit+0x64/0x70)
[   10.600158] [<c04f2d60>] (out_of_line_wait_on_bit+0x64/0x70) from
[<c04cfe48>] (__rpc_execute+0xec/0x300)
[   10.610260] [<c04cfe48>] (__rpc_execute+0xec/0x300) from
[<c04c9b14>] (rpc_run_task+0x98/0xa4)
[   10.619323] [<c04c9b14>] (rpc_run_task+0x98/0xa4) from [<c04c9c18>]
(rpc_call_sync+0x40/0xac)
[   10.628295] [<c04c9c18>] (rpc_call_sync+0x40/0xac) from
[<c020d044>] (nfs_proc_get_root+0x44/0x120)
[   10.637817] [<c020d044>] (nfs_proc_get_root+0x44/0x120) from
[<c0200184>] (nfs_get_root+0x58/0x198)
[   10.647338] [<c0200184>] (nfs_get_root+0x58/0x198) from
[<c0202a54>] (nfs_fs_mount_common+0x9c/0x15c)
[   10.657073] [<c0202a54>] (nfs_fs_mount_common+0x9c/0x15c) from
[<c0203230>] (nfs_try_mount+0x14c/0x204)
[   10.666961] [<c0203230>] (nfs_try_mount+0x14c/0x204) from
[<c02053dc>] (nfs_fs_mount+0x420/0x884)
[   10.676300] [<c02053dc>] (nfs_fs_mount+0x420/0x884) from
[<c0109684>] (mount_fs+0x44/0x184)
[   10.685119] [<c0109684>] (mount_fs+0x44/0x184) from [<c01211ec>]
(vfs_kern_mount+0x4c/0xc0)
[   10.693908] [<c01211ec>] (vfs_kern_mount+0x4c/0xc0) from
[<c0123050>] (do_mount+0x1a0/0x868)
[   10.702789] [<c0123050>] (do_mount+0x1a0/0x868) from [<c012379c>]
(sys_mount+0x84/0xb8)
[   10.711242] [<c012379c>] (sys_mount+0x84/0xb8) from [<c0702eec>]
(mount_root+0x54/0x118)
[   10.719787] [<c0702eec>] (mount_root+0x54/0x118) from [<c0703114>]
(prepare_namespace+0x164/0x1c4)
[   10.729370] [<c0703114>] (prepare_namespace+0x164/0x1c4) from
[<c070298c>] (kernel_init_freeable+0x180/0x1c8)
[   10.739837] [<c070298c>] (kernel_init_freeable+0x180/0x1c8) from
[<c04e9124>] (kernel_init+0x8/0xe4)
[   10.749450] [<c04e9124>] (kernel_init+0x8/0xe4) from [<c00137b0>]
(ret_from_fork+0x14/0x24)


-- 
Sid
