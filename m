From: Ye Xiaolong <xiaolong.ye-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [lkp] [usb]  ad05399d68: BUG: unable to handle kernel NULL
 pointer dereference at 0000000000000012
Date: Mon, 15 Aug 2016 22:49:55 +0800
Message-ID: <20160815144955.GA19665@yexl-desktop>
References: <20160815043823.GH19354@yexl-desktop>
 <HE1PR04MB14503E90B2937B9F913EA3258B120@HE1PR04MB1450.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <HE1PR04MB14503E90B2937B9F913EA3258B120-6LN7OEpIatVC+P/YwrXEHc9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lkp-JC7UmRfGjtg@public.gmane.org" <lkp-JC7UmRfGjtg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 08/15, Peter Chen wrote:
> 
>>
>>
>>FYI, we noticed the following commit:
>>
>>https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next commit
>>ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104 ("usb: udc: core: fix error handling")
>>
>
>Hi Xiaolong,
>
>You reported it one month ago, and said it is a false report. see below.
>Would you please double confirm it?

Hi, peter

Last time I reported stat "WARNING: CPU: 0 PID: 1 at
lib/list_debug.c:36" and it showed both in this commit and its parent,
this time, the observed change stat is "BUG: unable to handle kernel NULL
pointer dereference at 0000000000000012" and it doesn't show in parent
commit, however, the parent commit's dmesg would show kernel panic log
as:

[   10.338487] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   10.338487] 
[   10.339911] CPU: 0 PID: 1 Comm: init Not tainted 4.8.0-rc1-00020-g0937a4d #1
[   10.341177] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
[   10.342798]  0000000000000000 ffff88001e53bc28 ffffffff8168cf8a ffff88001e534000
[   10.345177]  ffffffff8256ef20 ffff88001e53bcb8 ffff88001e50ca50 ffff88001e53bca8
[   10.346739]  ffffffff8114e062 ffff880000000010 ffff88001e53bcb8 ffff88001e53bc50
[   10.347970] Call Trace:
[   10.348690]  [<ffffffff8168cf8a>] dump_stack+0x83/0xb9
[   10.351592]  [<ffffffff8114e062>] panic+0xf3/0x2a9
[   10.352386]  [<ffffffff81090e01>] do_exit+0x601/0xde0
[   10.352879]  [<ffffffff8109a283>] ? __sigqueue_free+0x43/0x50
[   10.353511]  [<ffffffff8109a5f7>] ? __dequeue_signal+0x1f7/0x210
[   10.354483]  [<ffffffff810916e2>] do_group_exit+0xa2/0x100
[   10.355324]  [<ffffffff8109e06e>] get_signal+0x68e/0x740
[   10.356155]  [<ffffffff81009233>] do_signal+0x23/0x670
[   10.356983]  [<ffffffff810e0000>] ? do_syslog+0x2c0/0x6a0
[   10.357832]  [<ffffffff810305e3>] ? bad_area_nosemaphore+0x33/0x40
[   10.358825]  [<ffffffff81030cf7>] ? __do_page_fault+0x407/0x4d0
[   10.359738]  [<ffffffff810020c9>] exit_to_usermode_loop+0x69/0xc0
[   10.360680]  [<ffffffff8100241d>] prepare_exit_to_usermode+0x3d/0x70
[   10.361725]  [<ffffffff82025a27>] retint_user+0x8/0x10
[   10.362650] Kernel Offset: disabled

The whole parent dmesg is attached.

Thanks,
Xiaolong

>
>On Wed, Jul 13, 2016 at 01:55:26AM +0000, Peter Chen wrote:
>> 
>>
>>>-----Original Message-----
>>>From: lkp-request-1kAaIIS+jLWtqXYlAKuG4QC/G2K4zDHf@public.gmane.org 
>>>[mailto:lkp-request-1kAaIIS+jLWtqXYlAKuG4QC/G2K4zDHf@public.gmane.org] On Behalf Of kernel test robot
>>>Sent: Wednesday, July 13, 2016 9:28 AM
>>>To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
>>>Cc: 0day robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; LKML 
>>><linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; lkp-JC7UmRfGjtg@public.gmane.org
>>>Subject: [lkp] [usb] 9696ef14de: WARNING: CPU: 0 PID: 1 at 
>>>lib/list_debug.c:36
>>>__list_add+0x104/0x188
>>>
>>>
>>>FYI, we noticed the following commit:
>>>
>>>https://github.com/0day-ci/linux Peter-Chen/usb-udc-core-fix-error-
>>>handling/20160711-100832
>>>commit 9696ef14ded07fb0847f8e1cdda6d98a89ecd4f2 ("usb: udc: core: fix 
>>>error
>>>handling")
>>>
>>
>>Thanks,  but I really can't find the relationship between my patch and dump.
>>Can you reproduce it after running again or without my patch?
>>
>
>Sorry, it's a false report, the error dump also showed in parent commit, please ignore the report and sorry for the noise.
>
>Thanks,
>Xiaolong
>
>
>
>
>Peter
>
>>in testcase: boot
>>
>>on test machine: 1 threads qemu-system-x86_64 -enable-kvm -cpu SandyBridge
>>with 512M memory
>>
>>caused below changes:
>>
>>
>>+-----------------------------------------------------------+------------+------------+
>>|                                                           | 0937a4d787
>>| | ad05399d68 |
>>+-----------------------------------------------------------+------------+------------+
>>| boot_successes                                            | 0          | 0          |
>>| boot_failures                                             | 12         | 12         |
>>| WARNING:at_lib/list_debug.c:#__list_del_entry             | 2          | 12         |
>>| BUG:kernel_test_hang                                      | 2          |            |
>>| backtrace:kernel_restart                                  | 2          |            |
>>| backtrace:SyS_reboot                                      | 2          |            |
>>| BUG:kernel_oversize_in_test_stage                         | 4          |            |
>>| Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode= | 6          |            |
>>| BUG:unable_to_handle_kernel                               | 0          | 11         |
>>| Oops                                                      | 0          | 11         |
>>| RIP:sysfs_kf_write                                        | 0          | 11         |
>>| Kernel_panic-not_syncing:Fatal_exception                  | 0          | 11         |
>>| backtrace:serio_handle_event                              | 0          | 12         |
>>| backtrace:vfs_write                                       | 0          | 11         |
>>| backtrace:SyS_write                                       | 0          | 11         |
>>+-----------------------------------------------------------+------------+------------+
>>
>>
>>[   12.161205] BUG: unable to handle kernel NULL pointer dereference at
>>0000000000000012
>>[   12.162485] IP: [<ffffffff81245ecf>] sysfs_kf_write+0x4f/0x70
>>[   12.163414] PGD 1a380067 PUD 1a357067 PMD 0
>>[   12.164242] Oops: 0000 [#1] PREEMPT SMP
>>[   12.164952] CPU: 0 PID: 240 Comm: udevadm Tainted: G        W       4.8.0-rc1-
>>00021-gad05399 #1
>>[   12.166477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>Debian-1.8.2-1 04/01/2014
>>[   12.167885] task: ffff88001a3701c0 task.stack: ffff88001a374000
>>[   12.168789] RIP: 0010:[<ffffffff81245ecf>]  [<ffffffff81245ecf>]
>>sysfs_kf_write+0x4f/0x70
>>[   12.170082] RSP: 0018:ffff88001a377dc0  EFLAGS: 00010297
>>[   12.171001] RAX: ffff88001aad9260 RBX: 0000000000000000 RCX:
>>0000000000000003
>>[   12.172252] RDX: ffff88001a253020 RSI: ffffffff82888fa0 RDI: ffff88001aada1f8
>>[   12.186536] RBP: ffff88001a377de8 R08: 0000000000000000 R09:
>>0000000000000000
>>[   12.187769] R10: 0000000055aab65f R11: 0000000000000001 R12:
>>0000000000000003
>>[   12.189058] R13: ffff88001a393000 R14: 000000000000000a R15:
>>ffff88001a253020
>>[   12.190274] FS:  00007f1f13d8f700(0000) GS:ffff88001f400000(0000)
>>knlGS:0000000000000000
>>[   12.191514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>[   12.192393] CR2: 0000000000000012 CR3: 000000001a341000 CR4:
>>00000000000406b0
>>[   12.193518] Stack:
>>[   12.193884]  ffff88001a253020 ffff88001a393000 0000000000000003
>>ffffffff81245e80
>>[   12.195278]  ffff88001a393018 ffff88001a377e28 ffffffff81244e44
>>ffff88001a377f20
>>[   12.196679]  ffff88001dc6fc40 ffffffff81244cf0 ffff88001a377f20
>>0000000000000003
>>[   12.197896] Call Trace:
>>[   12.198289]  [<ffffffff81245e80>] ? sysfs_file_ops+0x90/0x90
>>[   12.199162]  [<ffffffff81244e44>] kernfs_fop_write+0x154/0x200
>>[   12.211238]  [<ffffffff81244cf0>] ? kernfs_vma_page_mkwrite+0xb0/0xb0
>>[   12.212330]  [<ffffffff811ae953>] __vfs_write+0x43/0x1b0
>>[   12.213150]  [<ffffffff811b369a>] ? __sb_start_write+0xba/0x110
>>[   12.214175]  [<ffffffff810d4612>] ? percpu_down_read+0x52/0x90
>>[   12.215219]  [<ffffffff811b369a>] ? __sb_start_write+0xba/0x110
>>[   12.216256]  [<ffffffff811aecd6>] vfs_write+0x106/0x1f0
>>[   12.217146]  [<ffffffff811aeed3>] SyS_write+0x53/0xc0
>>[   12.217930]  [<ffffffff820250b6>] entry_SYSCALL_64_fastpath+0x1e/0xad
>>[   12.218907] Code: ff ff 4d 85 e4 74 2d 49 89 c6 e8 0d 25 ee ff 49 8b 45 00 4c 89
>>e1 4c 89 fa 48 8b b0 80 00 00 00 48 8b 40 28 48 8b b8 80 00 00 00 <41> ff 56 08 48
>>89 c3 eb 00 e8 e3 24 ee ff 48 89 d8 5b 41 5c 41
>>[   12.223712] RIP  [<ffffffff81245ecf>] sysfs_kf_write+0x4f/0x70
>>[   12.224633]  RSP <ffff88001a377dc0>
>>[   12.225172] CR2: 0000000000000012
>>[   12.366338] ---[ end trace b696b5aff8dfca8d ]---
>>[   12.367092] Kernel panic - not syncing: Fatal exception
>>[   12.367920] Kernel Offset: disabled
>>
>>
>>FYI, raw QEMU command line is:
>>
>>	qemu-system-x86_64 -enable-kvm -cpu SandyBridge -kernel
>>/pkg/linux/x86_64-randconfig-n0-08110915/gcc-
>>6/ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104/vmlinuz-4.8.0-rc1-00021-
>>gad05399 -append 'ip=::::vm-kbuild-yocto-x86_64-3::dhcp root=/dev/ram0 user=lkp
>>job=/lkp/scheduled/vm-kbuild-yocto-x86_64-3/boot-1-yocto-minimal-x86_64.cgz-
>>ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104-20160812-122343-ax2dev-0.yaml
>>ARCH=x86_64 kconfig=x86_64-randconfig-n0-08110915 branch=linux-devel/devel-
>>hourly-2016081104 commit=ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104
>>BOOT_IMAGE=/pkg/linux/x86_64-randconfig-n0-08110915/gcc-
>>6/ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104/vmlinuz-4.8.0-rc1-00021-
>>gad05399 max_uptime=600 RESULT_ROOT=/result/boot/1/vm-kbuild-yocto-
>>x86_64/yocto-minimal-x86_64.cgz/x86_64-randconfig-n0-08110915/gcc-
>>6/ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104/0 LKP_SERVER=inn debug
>>apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 panic=-1
>>softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2
>>prompt_ramdisk=0 systemd.log_level=err ignore_loglevel earlyprintk=ttyS0,115200
>>console=ttyS0,115200 console=tty0 vga=normal rw drbd.minor_count=8'  -initrd
>>/fs/sdg1/initrd-vm-kbuild-yocto-x86_64-3 -m 512 -smp 1 -device e1000,netdev=net0
>>-netdev user,id=net0 -boot order=nc -no-reboot -watchdog i6300esb -watchdog-
>>action debug -rtc base=localtime -drive file=/fs/sdg1/disk0-vm-kbuild-yocto-x86_64-
>>3,media=disk,if=virtio -pidfile /dev/shm/kboot/pid-vm-kbuild-yocto-x86_64-3 -serial
>>file:/dev/shm/kboot/serial-vm-kbuild-yocto-x86_64-3 -daemonize -display none -
>>monitor null
>>
>>
>>
>>
>>
>>Thanks,
>>Xiaolong

--EVF5PPMfhYS0aIcm
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="parent-dmesg.xz"
Content-Transfer-Encoding: base64

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
9QKxxGf7AgAAAAAEWVo=

--EVF5PPMfhYS0aIcm--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
