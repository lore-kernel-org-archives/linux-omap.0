From: Nishanth Menon <nm@ti.com>
Subject: [next-20150119]regression (mm)?
Date: Mon, 19 Jan 2015 10:42:04 -0600
Message-ID: <54BD33DC.40200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Most platforms seem broken intoday's next tag.

https://github.com/nmenon/kernel-test-logs/tree/next-20150119
(defconfig: omap2plus_defconfig)

> [    7.166600] ------------[ cut here ]------------
> [    7.171676] WARNING: CPU: 0 PID: 54 at mm/mmap.c:2859 exit_mmap+0x1a8/0x21c()
> [    7.179194] Modules linked in:
> [    7.182479] CPU: 0 PID: 54 Comm: init Not tainted 3.19.0-rc5-next-20150119-00002-gfdefcded1272 #1
> [    7.191863] Hardware name: Generic AM33XX (Flattened Device Tree)
> [    7.198318] [<c00153f0>] (unwind_backtrace) from [<c0011a74>] (show_stack+0x10/0x14)
> [    7.206528] [<c0011a74>] (show_stack) from [<c0580150>] (dump_stack+0x78/0x94)
> [    7.214191] [<c0580150>] (dump_stack) from [<c003d4d0>] (warn_slowpath_common+0x7c/0xb4)
> [    7.222751] [<c003d4d0>] (warn_slowpath_common) from [<c003d524>] (warn_slowpath_null+0x1c/0x24)
> [    7.232038] [<c003d524>] (warn_slowpath_null) from [<c012de64>] (exit_mmap+0x1a8/0x21c)
> [    7.240536] [<c012de64>] (exit_mmap) from [<c003abb8>] (mmput+0x44/0xec)
> [    7.247612] [<c003abb8>] (mmput) from [<c0151368>] (flush_old_exec+0x300/0x5a4)
> [    7.255357] [<c0151368>] (flush_old_exec) from [<c0195c10>] (load_elf_binary+0x2ec/0x1144)
> [    7.264111] [<c0195c10>] (load_elf_binary) from [<c0150ea0>] (search_binary_handler+0x88/0x1ac)
> [    7.273311] [<c0150ea0>] (search_binary_handler) from [<c019554c>] (load_script+0x260/0x280)
> [    7.282232] [<c019554c>] (load_script) from [<c0150ea0>] (search_binary_handler+0x88/0x1ac)
> [    7.291066] [<c0150ea0>] (search_binary_handler) from [<c0151f0c>] (do_execveat_common+0x538/0x6c4)
> [    7.300628] [<c0151f0c>] (do_execveat_common) from [<c01520c4>] (do_execve+0x2c/0x34)
> [    7.308881] [<c01520c4>] (do_execve) from [<c000e5e0>] (ret_fast_syscall+0x0/0x4c)
> [    7.316881] ---[ end trace 3b8a46b1b280f423 ]---


-- 
Regards,
Nishanth Menon
