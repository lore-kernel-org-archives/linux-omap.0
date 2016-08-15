From: Peter Chen <peter.chen@nxp.com>
Subject: RE: [lkp] [usb]  ad05399d68: BUG: unable to handle kernel NULL
 pointer dereference at 0000000000000012
Date: Mon, 15 Aug 2016 06:51:59 +0000
Message-ID: <HE1PR04MB14503E90B2937B9F913EA3258B120@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20160815043823.GH19354@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160815043823.GH19354@yexl-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lkp@01.org" <lkp@01.org>
List-Id: linux-omap@vger.kernel.org

 
>
>
>FYI, we noticed the following commit:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next commit
>ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104 ("usb: udc: core: fix error handling")
>

Hi Xiaolong,

You reported it one month ago, and said it is a false report. see below.
Would you please double confirm it?

On Wed, Jul 13, 2016 at 01:55:26AM +0000, Peter Chen wrote:
> 
>
>>-----Original Message-----
>>From: lkp-request@eclists.intel.com 
>>[mailto:lkp-request@eclists.intel.com] On Behalf Of kernel test robot
>>Sent: Wednesday, July 13, 2016 9:28 AM
>>To: Peter Chen <peter.chen@nxp.com>
>>Cc: 0day robot <fengguang.wu@intel.com>; LKML 
>><linux-kernel@vger.kernel.org>; lkp@01.org
>>Subject: [lkp] [usb] 9696ef14de: WARNING: CPU: 0 PID: 1 at 
>>lib/list_debug.c:36
>>__list_add+0x104/0x188
>>
>>
>>FYI, we noticed the following commit:
>>
>>https://github.com/0day-ci/linux Peter-Chen/usb-udc-core-fix-error-
>>handling/20160711-100832
>>commit 9696ef14ded07fb0847f8e1cdda6d98a89ecd4f2 ("usb: udc: core: fix 
>>error
>>handling")
>>
>
>Thanks,  but I really can't find the relationship between my patch and dump.
>Can you reproduce it after running again or without my patch?
>

Sorry, it's a false report, the error dump also showed in parent commit, please ignore the report and sorry for the noise.

Thanks,
Xiaolong




Peter

>in testcase: boot
>
>on test machine: 1 threads qemu-system-x86_64 -enable-kvm -cpu SandyBridge
>with 512M memory
>
>caused below changes:
>
>
>+-----------------------------------------------------------+------------+------------+
>|                                                           | 0937a4d787
>| | ad05399d68 |
>+-----------------------------------------------------------+------------+------------+
>| boot_successes                                            | 0          | 0          |
>| boot_failures                                             | 12         | 12         |
>| WARNING:at_lib/list_debug.c:#__list_del_entry             | 2          | 12         |
>| BUG:kernel_test_hang                                      | 2          |            |
>| backtrace:kernel_restart                                  | 2          |            |
>| backtrace:SyS_reboot                                      | 2          |            |
>| BUG:kernel_oversize_in_test_stage                         | 4          |            |
>| Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode= | 6          |            |
>| BUG:unable_to_handle_kernel                               | 0          | 11         |
>| Oops                                                      | 0          | 11         |
>| RIP:sysfs_kf_write                                        | 0          | 11         |
>| Kernel_panic-not_syncing:Fatal_exception                  | 0          | 11         |
>| backtrace:serio_handle_event                              | 0          | 12         |
>| backtrace:vfs_write                                       | 0          | 11         |
>| backtrace:SyS_write                                       | 0          | 11         |
>+-----------------------------------------------------------+------------+------------+
>
>
>[   12.161205] BUG: unable to handle kernel NULL pointer dereference at
>0000000000000012
>[   12.162485] IP: [<ffffffff81245ecf>] sysfs_kf_write+0x4f/0x70
>[   12.163414] PGD 1a380067 PUD 1a357067 PMD 0
>[   12.164242] Oops: 0000 [#1] PREEMPT SMP
>[   12.164952] CPU: 0 PID: 240 Comm: udevadm Tainted: G        W       4.8.0-rc1-
>00021-gad05399 #1
>[   12.166477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>Debian-1.8.2-1 04/01/2014
>[   12.167885] task: ffff88001a3701c0 task.stack: ffff88001a374000
>[   12.168789] RIP: 0010:[<ffffffff81245ecf>]  [<ffffffff81245ecf>]
>sysfs_kf_write+0x4f/0x70
>[   12.170082] RSP: 0018:ffff88001a377dc0  EFLAGS: 00010297
>[   12.171001] RAX: ffff88001aad9260 RBX: 0000000000000000 RCX:
>0000000000000003
>[   12.172252] RDX: ffff88001a253020 RSI: ffffffff82888fa0 RDI: ffff88001aada1f8
>[   12.186536] RBP: ffff88001a377de8 R08: 0000000000000000 R09:
>0000000000000000
>[   12.187769] R10: 0000000055aab65f R11: 0000000000000001 R12:
>0000000000000003
>[   12.189058] R13: ffff88001a393000 R14: 000000000000000a R15:
>ffff88001a253020
>[   12.190274] FS:  00007f1f13d8f700(0000) GS:ffff88001f400000(0000)
>knlGS:0000000000000000
>[   12.191514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   12.192393] CR2: 0000000000000012 CR3: 000000001a341000 CR4:
>00000000000406b0
>[   12.193518] Stack:
>[   12.193884]  ffff88001a253020 ffff88001a393000 0000000000000003
>ffffffff81245e80
>[   12.195278]  ffff88001a393018 ffff88001a377e28 ffffffff81244e44
>ffff88001a377f20
>[   12.196679]  ffff88001dc6fc40 ffffffff81244cf0 ffff88001a377f20
>0000000000000003
>[   12.197896] Call Trace:
>[   12.198289]  [<ffffffff81245e80>] ? sysfs_file_ops+0x90/0x90
>[   12.199162]  [<ffffffff81244e44>] kernfs_fop_write+0x154/0x200
>[   12.211238]  [<ffffffff81244cf0>] ? kernfs_vma_page_mkwrite+0xb0/0xb0
>[   12.212330]  [<ffffffff811ae953>] __vfs_write+0x43/0x1b0
>[   12.213150]  [<ffffffff811b369a>] ? __sb_start_write+0xba/0x110
>[   12.214175]  [<ffffffff810d4612>] ? percpu_down_read+0x52/0x90
>[   12.215219]  [<ffffffff811b369a>] ? __sb_start_write+0xba/0x110
>[   12.216256]  [<ffffffff811aecd6>] vfs_write+0x106/0x1f0
>[   12.217146]  [<ffffffff811aeed3>] SyS_write+0x53/0xc0
>[   12.217930]  [<ffffffff820250b6>] entry_SYSCALL_64_fastpath+0x1e/0xad
>[   12.218907] Code: ff ff 4d 85 e4 74 2d 49 89 c6 e8 0d 25 ee ff 49 8b 45 00 4c 89
>e1 4c 89 fa 48 8b b0 80 00 00 00 48 8b 40 28 48 8b b8 80 00 00 00 <41> ff 56 08 48
>89 c3 eb 00 e8 e3 24 ee ff 48 89 d8 5b 41 5c 41
>[   12.223712] RIP  [<ffffffff81245ecf>] sysfs_kf_write+0x4f/0x70
>[   12.224633]  RSP <ffff88001a377dc0>
>[   12.225172] CR2: 0000000000000012
>[   12.366338] ---[ end trace b696b5aff8dfca8d ]---
>[   12.367092] Kernel panic - not syncing: Fatal exception
>[   12.367920] Kernel Offset: disabled
>
>
>FYI, raw QEMU command line is:
>
>	qemu-system-x86_64 -enable-kvm -cpu SandyBridge -kernel
>/pkg/linux/x86_64-randconfig-n0-08110915/gcc-
>6/ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104/vmlinuz-4.8.0-rc1-00021-
>gad05399 -append 'ip=::::vm-kbuild-yocto-x86_64-3::dhcp root=/dev/ram0 user=lkp
>job=/lkp/scheduled/vm-kbuild-yocto-x86_64-3/boot-1-yocto-minimal-x86_64.cgz-
>ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104-20160812-122343-ax2dev-0.yaml
>ARCH=x86_64 kconfig=x86_64-randconfig-n0-08110915 branch=linux-devel/devel-
>hourly-2016081104 commit=ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104
>BOOT_IMAGE=/pkg/linux/x86_64-randconfig-n0-08110915/gcc-
>6/ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104/vmlinuz-4.8.0-rc1-00021-
>gad05399 max_uptime=600 RESULT_ROOT=/result/boot/1/vm-kbuild-yocto-
>x86_64/yocto-minimal-x86_64.cgz/x86_64-randconfig-n0-08110915/gcc-
>6/ad05399d68b6ae1649cdcfc82ce3ffea1a7c5104/0 LKP_SERVER=inn debug
>apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 panic=-1
>softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2
>prompt_ramdisk=0 systemd.log_level=err ignore_loglevel earlyprintk=ttyS0,115200
>console=ttyS0,115200 console=tty0 vga=normal rw drbd.minor_count=8'  -initrd
>/fs/sdg1/initrd-vm-kbuild-yocto-x86_64-3 -m 512 -smp 1 -device e1000,netdev=net0
>-netdev user,id=net0 -boot order=nc -no-reboot -watchdog i6300esb -watchdog-
>action debug -rtc base=localtime -drive file=/fs/sdg1/disk0-vm-kbuild-yocto-x86_64-
>3,media=disk,if=virtio -pidfile /dev/shm/kboot/pid-vm-kbuild-yocto-x86_64-3 -serial
>file:/dev/shm/kboot/serial-vm-kbuild-yocto-x86_64-3 -daemonize -display none -
>monitor null
>
>
>
>
>
>Thanks,
>Xiaolong
