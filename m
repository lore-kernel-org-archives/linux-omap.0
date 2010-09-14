From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Hang on Suspend to RAM with 2.6.36-rc4
Date: Tue, 14 Sep 2010 16:02:49 -0700
Message-ID: <87r5gwhqsm.fsf@deeprootsystems.com>
References: <AANLkTikaTRJpZ=twcCxPvqQLOHBWsS5zyzgDwEWVbe-6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0INXCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 19:02:53 -0400
Received: by pzk34 with SMTP id 34so2572390pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 16:02:53 -0700 (PDT)
In-Reply-To: <AANLkTikaTRJpZ=twcCxPvqQLOHBWsS5zyzgDwEWVbe-6@mail.gmail.com>
	(Laine Walker-Avina's message of "Tue, 14 Sep 2010 14:39:26 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@pasco.com>
Cc: linux-omap@vger.kernel.org, Linux Kernel ARM List <linux-arm-kernel@lists.arm.linux.org.uk>

Laine Walker-Avina <lwalkera@pasco.com> writes:

> I just pulled the latest changes today from the linux-omap git tree,
> and something appears to have broken suspend to RAM on my OMAP3503
> board. 

Is this on the master branch?  What defconfig?  When was this last
working for you?  -rc3?

Looks like you may have your rootfs on MMC.  Do you have
CONFIG_MMC_UNSAFE_RESUME=y in your .config?

Kevin

> Here's a log:
>
> ~$ echo mem > /sys/power/state
> [   23.102416] PM: Syncing filesystems ... done.
> [   29.493927] PM: Preparing system for mem sleep
> [   29.500396] PM: Adding info for No Bus:vcs63
> [   29.506774] PM: Adding info for No Bus:vcsa63
> [   29.547424] mmc0: card bed5 removed
> [   29.550964] PM: Removing info for mmc:mmc0:bed5
> [   37.001373] INFO: task init:1 blocked for more than 5 seconds.
> [   37.007415] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   37.015472] init          D c02a8cb8     0     1      0 0x00000000
> [   37.021942] [<c02a8cb8>] (schedule+0x320/0x368) from [<c0121938>]
> (do_get_write_access+0x2bc/0x52c)
> [   37.031250] [<c0121938>] (do_get_write_access+0x2bc/0x52c) from
> [<c0121bcc>] (journal_get_write_access+0x24/0x38)
> [   37.041809] [<c0121bcc>] (journal_get_write_access+0x24/0x38) from
> [<c01187d4>] (__ext3_journal_get_write_access+0x1c/0x48)
> [   37.053222] [<c01187d4>]
> (__ext3_journal_get_write_access+0x1c/0x48) from [<c010c5a8>]
> (ext3_reserve_inode_write+0x3c/0x80)
> [   37.064636] [<c010c5a8>] (ext3_reserve_inode_write+0x3c/0x80) from
> [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54)
> [   37.075164] [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54) from
> [<c010c768>] (ext3_dirty_inode+0x68/0x80)
> [   37.084991] [<c010c768>] (ext3_dirty_inode+0x68/0x80) from
> [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188)
> [   37.094665] [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188) from
> [<c00cf610>] (touch_atime+0x114/0x140)
> [   37.104064] [<c00cf610>] (touch_atime+0x114/0x140) from
> [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c)
> [   37.113830] [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c) from
> [<c00bc0cc>] (do_sync_read+0xa0/0xe8)
> [   37.123474] [<c00bc0cc>] (do_sync_read+0xa0/0xe8) from [<c00bcbc8>]
> (vfs_read+0xa8/0x130)
> [   37.131896] [<c00bcbc8>] (vfs_read+0xa8/0x130) from [<c00bccfc>]
> (sys_read+0x3c/0x68)
> [   37.139984] [<c00bccfc>] (sys_read+0x3c/0x68) from [<c002df40>]
> (ret_fast_syscall+0x0/0x3c)
> [   37.148559] 1 lock held by init/1:
> [   37.152008]  #0:  (jbd_handle){+.+...}, at: [<c0122290>]
> start_this_handle+0x314/0x3c8
> [   37.160247] INFO: task mmcqd:320 blocked for more than 5 seconds.
> [   37.166534] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   37.174560] mmcqd         D c02a8cb8     0   320      2 0x00000000
> [   37.181030] [<c02a8cb8>] (schedule+0x320/0x368) from [<c0204570>]
> (__mmc_claim_host+0xbc/0x158)
> [   37.190002] [<c0204570>] (__mmc_claim_host+0xbc/0x158) from
> [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504)
> [   37.199829] [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504) from
> [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0)
> [   37.209564] [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0) from
> [<c006e948>] (kthread+0x80/0x88)
> [   37.218200] [<c006e948>] (kthread+0x80/0x88) from [<c002ef90>]
> (kernel_thread_exit+0x0/0x8)
> [   37.226776] no locks held by mmcqd/320.
> [   37.230682] INFO: task sh:363 blocked for more than 5 seconds.
> [   37.236694] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   37.244720] sh            D c02a8cb8     0   363      1 0x00000000
> [   37.251220] [<c02a8cb8>] (schedule+0x320/0x368) from [<c01264f8>]
> (log_wait_commit+0xb8/0x110)
> [   37.260101] [<c01264f8>] (log_wait_commit+0xb8/0x110) from
> [<c0113e10>] (ext3_sync_fs+0x3c/0x44)
> [   37.269134] [<c0113e10>] (ext3_sync_fs+0x3c/0x44) from [<c00dcee4>]
> (__sync_filesystem+0x80/0x9c)
> [   37.278289] [<c00dcee4>] (__sync_filesystem+0x80/0x9c) from
> [<c00e5e88>] (fsync_bdev+0x18/0x38)
> [   37.287261] [<c00e5e88>] (fsync_bdev+0x18/0x38) from [<c0186b28>]
> (invalidate_partition+0x18/0x34)
> [   37.296478] [<c0186b28>] (invalidate_partition+0x18/0x34) from
> [<c010264c>] (del_gendisk+0x28/0xd0)
> [   37.305786] [<c010264c>] (del_gendisk+0x28/0xd0) from [<c020b414>]
> (mmc_blk_remove+0x20/0x40)
> [   37.314575] [<c020b414>] (mmc_blk_remove+0x20/0x40) from
> [<c0205190>] (mmc_bus_remove+0x18/0x20)
> [   37.323608] [<c0205190>] (mmc_bus_remove+0x18/0x20) from
> [<c01d7f6c>] (__device_release_driver+0x84/0xd0)
> [   37.333435] [<c01d7f6c>] (__device_release_driver+0x84/0xd0) from
> [<c01d808c>] (device_release_driver+0x20/0x2c)
> [   37.343902] [<c01d808c>] (device_release_driver+0x20/0x2c) from
> [<c01d75d8>] (bus_remove_device+0xa4/0xb4)
> [   37.353820] [<c01d75d8>] (bus_remove_device+0xa4/0xb4) from
> [<c01d5d98>] (device_del+0x114/0x194)
> [   37.362945] [<c01d5d98>] (device_del+0x114/0x194) from [<c0205254>]
> (mmc_remove_card+0x5c/0x70)
> [   37.371917] [<c0205254>] (mmc_remove_card+0x5c/0x70) from
> [<c0206fc4>] (mmc_sd_remove+0x30/0x40)
> [   37.380950] [<c0206fc4>] (mmc_sd_remove+0x30/0x40) from
> [<c0204694>] (mmc_pm_notify+0x88/0xd8)
> [   37.389831] [<c0204694>] (mmc_pm_notify+0x88/0xd8) from
> [<c0073930>] (notifier_call_chain+0x2c/0x70)
> [   37.399230] [<c0073930>] (notifier_call_chain+0x2c/0x70) from
> [<c0073d8c>] (__blocking_notifier_call_chain+0x48/0x5c)
> [   37.410125] [<c0073d8c>] (__blocking_notifier_call_chain+0x48/0x5c)
> from [<c0073db4>] (blocking_notifier_call_chain+0x14/0x18)
> [   37.421813] [<c0073db4>] (blocking_notifier_call_chain+0x14/0x18)
> from [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c)
> [   37.432769] [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c) from
> [<c008b424>] (enter_state+0x7c/0x120)
> [   37.442352] [<c008b424>] (enter_state+0x7c/0x120) from [<c008ab5c>]
> (state_store+0xa0/0xbc)
> [   37.450958] [<c008ab5c>] (state_store+0xa0/0xbc) from [<c018fde8>]
> (kobj_attr_store+0x18/0x1c)
> [   37.459838] [<c018fde8>] (kobj_attr_store+0x18/0x1c) from
> [<c0105220>] (sysfs_write_file+0x10c/0x140)
> [   37.469329] [<c0105220>] (sysfs_write_file+0x10c/0x140) from
> [<c00bc9c0>] (vfs_write+0xac/0x134)
> [   37.478363] [<c00bc9c0>] (vfs_write+0xac/0x134) from [<c00bcaf4>]
> (sys_write+0x3c/0x68)
> [   37.486602] [<c00bcaf4>] (sys_write+0x3c/0x68) from [<c002df40>]
> (ret_fast_syscall+0x0/0x3c)
> [   37.495269] 6 locks held by sh/363:
> [   37.498931]  #0:  (&buffer->mutex){+.+.+.}, at: [<c010513c>]
> sysfs_write_file+0x28/0x140
> [   37.507324]  #1:  (s_active#14){.+.+.+}, at: [<c01051fc>]
> sysfs_write_file+0xe8/0x140
> [   37.515441]  #2:  (pm_mutex){+.+.+.}, at: [<c008b3c8>] enter_state+0x20/0x120
> [   37.522888]  #3:  ((pm_chain_head).rwsem){.+.+..}, at: [<c0073d70>]
> __blocking_notifier_call_chain+0x2c/0x5c
> [   37.533020]  #4:  (&__lockdep_no_validate__){+.+.+.}, at:
> [<c01d8084>] device_release_driver+0x18/0x2c
> [   37.542633]  #5:  (&type->s_umount_key#22){.+.+..}, at:
> [<c00be640>] get_super+0x60/0xbc
> [   42.568206] INFO: task init:1 blocked for more than 5 seconds.
> [   42.574096] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   42.582153] init          D c02a8cb8     0     1      0 0x00000000
> [   42.588623] [<c02a8cb8>] (schedule+0x320/0x368) from [<c0121938>]
> (do_get_write_access+0x2bc/0x52c)
> [   42.597961] [<c0121938>] (do_get_write_access+0x2bc/0x52c) from
> [<c0121bcc>] (journal_get_write_access+0x24/0x38)
> [   42.608489] [<c0121bcc>] (journal_get_write_access+0x24/0x38) from
> [<c01187d4>] (__ext3_journal_get_write_access+0x1c/0x48)
> [   42.619903] [<c01187d4>]
> (__ext3_journal_get_write_access+0x1c/0x48) from [<c010c5a8>]
> (ext3_reserve_inode_write+0x3c/0x80)
> [   42.631317] [<c010c5a8>] (ext3_reserve_inode_write+0x3c/0x80) from
> [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54)
> [   42.641845] [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54) from
> [<c010c768>] (ext3_dirty_inode+0x68/0x80)
> [   42.651702] [<c010c768>] (ext3_dirty_inode+0x68/0x80) from
> [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188)
> [   42.661376] [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188) from
> [<c00cf610>] (touch_atime+0x114/0x140)
> [   42.670776] [<c00cf610>] (touch_atime+0x114/0x140) from
> [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c)
> [   42.680511] [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c) from
> [<c00bc0cc>] (do_sync_read+0xa0/0xe8)
> [   42.690155] [<c00bc0cc>] (do_sync_read+0xa0/0xe8) from [<c00bcbc8>]
> (vfs_read+0xa8/0x130)
> [   42.698608] [<c00bcbc8>] (vfs_read+0xa8/0x130) from [<c00bccfc>]
> (sys_read+0x3c/0x68)
> [   42.706695] [<c00bccfc>] (sys_read+0x3c/0x68) from [<c002df40>]
> (ret_fast_syscall+0x0/0x3c)
> [   42.715301] 1 lock held by init/1:
> [   42.718872]  #0:  (jbd_handle){+.+...}, at: [<c0122290>]
> start_this_handle+0x314/0x3c8
> [   42.727142] INFO: task mmcqd:320 blocked for more than 5 seconds.
> [   42.733428] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   42.741455] mmcqd         D c02a8cb8     0   320      2 0x00000000
> [   42.747924] [<c02a8cb8>] (schedule+0x320/0x368) from [<c0204570>]
> (__mmc_claim_host+0xbc/0x158)
> [   42.756866] [<c0204570>] (__mmc_claim_host+0xbc/0x158) from
> [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504)
> [   42.766693] [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504) from
> [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0)
> [   42.776458] [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0) from
> [<c006e948>] (kthread+0x80/0x88)
> [   42.785064] [<c006e948>] (kthread+0x80/0x88) from [<c002ef90>]
> (kernel_thread_exit+0x0/0x8)
> [   42.793670] no locks held by mmcqd/320.
> [   42.797698] INFO: task kjournald:325 blocked for more than 5 seconds.
> [   42.804351] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   42.812377] kjournald     D c02a8cb8     0   325      2 0x00000000
> [   42.818847] [<c02a8cb8>] (schedule+0x320/0x368) from [<c02a8d44>]
> (io_schedule+0x44/0x70)
> [   42.827301] [<c02a8d44>] (io_schedule+0x44/0x70) from [<c00dfd2c>]
> (sync_buffer+0x44/0x4c)
> [   42.835845] [<c00dfd2c>] (sync_buffer+0x44/0x4c) from [<c02a9214>]
> (__wait_on_bit+0x54/0x9c)
> [   42.844543] [<c02a9214>] (__wait_on_bit+0x54/0x9c) from
> [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84)
> [   42.854309] [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84) from
> [<c01233a8>] (journal_commit_transaction+0xcd0/0x1450)
> [   42.865447] [<c01233a8>] (journal_commit_transaction+0xcd0/0x1450)
> from [<c0126698>] (kjournald+0xbc/0x218)
> [   42.875488] [<c0126698>] (kjournald+0xbc/0x218) from [<c006e948>]
> (kthread+0x80/0x88)
> [   42.883575] [<c006e948>] (kthread+0x80/0x88) from [<c002ef90>]
> (kernel_thread_exit+0x0/0x8)
> [   42.892181] no locks held by kjournald/325.
> [   42.896575] INFO: task sh:363 blocked for more than 5 seconds.
> [   42.902465] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   42.910491] sh            D c02a8cb8     0   363      1 0x00000000
> [   42.916961] [<c02a8cb8>] (schedule+0x320/0x368) from [<c01264f8>]
> (log_wait_commit+0xb8/0x110)
> [   42.925842] [<c01264f8>] (log_wait_commit+0xb8/0x110) from
> [<c0113e10>] (ext3_sync_fs+0x3c/0x44)
> [   42.934967] [<c0113e10>] (ext3_sync_fs+0x3c/0x44) from [<c00dcee4>]
> (__sync_filesystem+0x80/0x9c)
> [   42.944122] [<c00dcee4>] (__sync_filesystem+0x80/0x9c) from
> [<c00e5e88>] (fsync_bdev+0x18/0x38)
> [   42.953094] [<c00e5e88>] (fsync_bdev+0x18/0x38) from [<c0186b28>]
> (invalidate_partition+0x18/0x34)
> [   42.962310] [<c0186b28>] (invalidate_partition+0x18/0x34) from
> [<c010264c>] (del_gendisk+0x28/0xd0)
> [   42.971618] [<c010264c>] (del_gendisk+0x28/0xd0) from [<c020b414>]
> (mmc_blk_remove+0x20/0x40)
> [   42.980407] [<c020b414>] (mmc_blk_remove+0x20/0x40) from
> [<c0205190>] (mmc_bus_remove+0x18/0x20)
> [   42.989471] [<c0205190>] (mmc_bus_remove+0x18/0x20) from
> [<c01d7f6c>] (__device_release_driver+0x84/0xd0)
> [   42.999298] [<c01d7f6c>] (__device_release_driver+0x84/0xd0) from
> [<c01d808c>] (device_release_driver+0x20/0x2c)
> [   43.009735] [<c01d808c>] (device_release_driver+0x20/0x2c) from
> [<c01d75d8>] (bus_remove_device+0xa4/0xb4)
> [   43.019653] [<c01d75d8>] (bus_remove_device+0xa4/0xb4) from
> [<c01d5d98>] (device_del+0x114/0x194)
> [   43.028808] [<c01d5d98>] (device_del+0x114/0x194) from [<c0205254>]
> (mmc_remove_card+0x5c/0x70)
> [   43.037750] [<c0205254>] (mmc_remove_card+0x5c/0x70) from
> [<c0206fc4>] (mmc_sd_remove+0x30/0x40)
> [   43.046813] [<c0206fc4>] (mmc_sd_remove+0x30/0x40) from
> [<c0204694>] (mmc_pm_notify+0x88/0xd8)
> [   43.055694] [<c0204694>] (mmc_pm_notify+0x88/0xd8) from
> [<c0073930>] (notifier_call_chain+0x2c/0x70)
> [   43.065093] [<c0073930>] (notifier_call_chain+0x2c/0x70) from
> [<c0073d8c>] (__blocking_notifier_call_chain+0x48/0x5c)
> [   43.076019] [<c0073d8c>] (__blocking_notifier_call_chain+0x48/0x5c)
> from [<c0073db4>] (blocking_notifier_call_chain+0x14/0x18)
> [   43.087677] [<c0073db4>] (blocking_notifier_call_chain+0x14/0x18)
> from [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c)
> [   43.098663] [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c) from
> [<c008b424>] (enter_state+0x7c/0x120)
> [   43.108245] [<c008b424>] (enter_state+0x7c/0x120) from [<c008ab5c>]
> (state_store+0xa0/0xbc)
> [   43.116851] [<c008ab5c>] (state_store+0xa0/0xbc) from [<c018fde8>]
> (kobj_attr_store+0x18/0x1c)
> [   43.125732] [<c018fde8>] (kobj_attr_store+0x18/0x1c) from
> [<c0105220>] (sysfs_write_file+0x10c/0x140)
> [   43.135223] [<c0105220>] (sysfs_write_file+0x10c/0x140) from
> [<c00bc9c0>] (vfs_write+0xac/0x134)
> [   43.144256] [<c00bc9c0>] (vfs_write+0xac/0x134) from [<c00bcaf4>]
> (sys_write+0x3c/0x68)
> [   43.152526] [<c00bcaf4>] (sys_write+0x3c/0x68) from [<c002df40>]
> (ret_fast_syscall+0x0/0x3c)
> [   43.161193] 6 locks held by sh/363:
> [   43.164855]  #0:  (&buffer->mutex){+.+.+.}, at: [<c010513c>]
> sysfs_write_file+0x28/0x140
> [   43.173278]  #1:  (s_active#14){.+.+.+}, at: [<c01051fc>]
> sysfs_write_file+0xe8/0x140
> [   43.181427]  #2:  (pm_mutex){+.+.+.}, at: [<c008b3c8>] enter_state+0x20/0x120
> [   43.188842]  #3:  ((pm_chain_head).rwsem){.+.+..}, at: [<c0073d70>]
> __blocking_notifier_call_chain+0x2c/0x5c
> [   43.199005]  #4:  (&__lockdep_no_validate__){+.+.+.}, at:
> [<c01d8084>] device_release_driver+0x18/0x2c
> [   43.208770]  #5:  (&type->s_umount_key#22){.+.+..}, at:
> [<c00be640>] get_super+0x60/0xbc
> [   48.229949] INFO: task init:1 blocked for more than 5 seconds.
> [   48.235992] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   48.244049] init          D c02a8cb8     0     1      0 0x00000000
> [   48.250518] [<c02a8cb8>] (schedule+0x320/0x368) from [<c0121938>]
> (do_get_write_access+0x2bc/0x52c)
> [   48.259826] [<c0121938>] (do_get_write_access+0x2bc/0x52c) from
> [<c0121bcc>] (journal_get_write_access+0x24/0x38)
> [   48.270385] [<c0121bcc>] (journal_get_write_access+0x24/0x38) from
> [<c01187d4>] (__ext3_journal_get_write_access+0x1c/0x48)
> [   48.281799] [<c01187d4>]
> (__ext3_journal_get_write_access+0x1c/0x48) from [<c010c5a8>]
> (ext3_reserve_inode_write+0x3c/0x80)
> [   48.293212] [<c010c5a8>] (ext3_reserve_inode_write+0x3c/0x80) from
> [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54)
> [   48.303741] [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54) from
> [<c010c768>] (ext3_dirty_inode+0x68/0x80)
> [   48.313568] [<c010c768>] (ext3_dirty_inode+0x68/0x80) from
> [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188)
> [   48.323242] [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188) from
> [<c00cf610>] (touch_atime+0x114/0x140)
> [   48.332672] [<c00cf610>] (touch_atime+0x114/0x140) from
> [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c)
> [   48.342437] [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c) from
> [<c00bc0cc>] (do_sync_read+0xa0/0xe8)
> [   48.352081] [<c00bc0cc>] (do_sync_read+0xa0/0xe8) from [<c00bcbc8>]
> (vfs_read+0xa8/0x130)
> [   48.360504] [<c00bcbc8>] (vfs_read+0xa8/0x130) from [<c00bccfc>]
> (sys_read+0x3c/0x68)
> [   48.368591] [<c00bccfc>] (sys_read+0x3c/0x68) from [<c002df40>]
> (ret_fast_syscall+0x0/0x3c)
> [   48.377166] 1 lock held by init/1:
> [   48.380767]  #0:  (jbd_handle){+.+...}, at: [<c0122290>]
> start_this_handle+0x314/0x3c8
> [   48.389007] INFO: task mmcqd:320 blocked for more than 5 seconds.
> [   48.395172] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   48.403198] mmcqd         D c02a8cb8     0   320      2 0x00000000
> [   48.409667] [<c02a8cb8>] (schedule+0x320/0x368) from [<c0204570>]
> (__mmc_claim_host+0xbc/0x158)
> [   48.418640] [<c0204570>] (__mmc_claim_host+0xbc/0x158) from
> [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504)
> [   48.428466] [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504) from
> [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0)
> [   48.438232] [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0) from
> [<c006e948>] (kthread+0x80/0x88)
> [   48.446838] [<c006e948>] (kthread+0x80/0x88) from [<c002ef90>]
> (kernel_thread_exit+0x0/0x8)
> [   48.455444] no locks held by mmcqd/320.
> [   48.459472] INFO: task kjournald:325 blocked for more than 5 seconds.
> [   48.465972] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [   48.473999] kjournald     D c02a8cb8     0   325      2 0x00000000
> [   48.480468] [<c02a8cb8>] (schedule+0x320/0x368) from [<c02a8d44>]
> (io_schedule+0x44/0x70)
> [   48.488922] [<c02a8d44>] (io_schedule+0x44/0x70) from [<c00dfd2c>]
> (sync_buffer+0x44/0x4c)
> [   48.497467] [<c00dfd2c>] (sync_buffer+0x44/0x4c) from [<c02a9214>]
> (__wait_on_bit+0x54/0x9c)
> [   48.506164] [<c02a9214>] (__wait_on_bit+0x54/0x9c) from
> [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84)
> [   48.515930] [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84) from
> [<c01233a8>] (journal_commit_transaction+0xcd0/0x1450)
> [   48.527069] [<c01233a8>] (journal_commit_transaction+0xcd0/0x1450)
> from [<c0126698>] (kjournald+0xbc/0x218)
> [   48.537109] [<c0126698>] (kjournald+0xbc/0x218) from [<c006e948>]
> (kthread+0x80/0x88)
> [   48.545196] [<c006e948>] (kthread+0x80/0x88) from [<c002ef90>]
> (kernel_thread_exit+0x0/0x8)
> [   48.553802] no locks held by kjournald/325.
