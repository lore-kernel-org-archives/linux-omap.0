From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Wed, 21 Oct 2009 10:17:12 -0500
Message-ID: <4ADF25F8.3020408@ti.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46465 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbZJUPRP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 11:17:15 -0400
In-Reply-To: <87iqezdmas.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman wrote:
> Hello,
> 
> I've rebased/updated the PM branch based on current linux-omap master
> branch (2.6.32-rc1 based.)
> 
> I've also updated the OMAP Power Management wiki, and the 'Current
> version' section highlights the changes, supported platforms as well
> as the features that have made it into mainline.
> 
>      http://elinux.org/OMAP_Power_Management#Current_version
> 
> Have fun,
> 
> Kevin

Hi Kevin,

I am not sure if anyone else if seeing this, but I have noticed that if 
my root file-system is on an SD card, then if I enable sleep_while_idle 
and off mode then the system will hang after sometime and eventually the 
kernel will panic. If my root file-system is mounted over the network, 
then I see no problems. I have reproduced this problem on both the 
beagle board and 3430sdp.

To reproduce this problem simply enable sleep_while_idle and 
enable_off_mode, wait sometime and then execute any command such as "ls" 
to view the file-system. Eventually you should see the below backtrace.

Not sure what the problem is but appears to be related to MMC and off mode.

Cheers
Jon


INFO: task mmcqd:400 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
mmcqd         D c02c977c     0   400      2 0x00000000
Backtrace:
[<c02c9498>] (schedule+0x0/0x370) from [<c02c9df0>] 
(schedule_timeout+0x24/0x21c
)
[<c02c9dcc>] (schedule_timeout+0x0/0x21c) from [<c02c9c58>] 
(wait_for_common+0xe
4/0x19c)
  r7:7fffffff r6:c78d3df4 r5:c78faa40 r4:c78d3db0
[<c02c9b74>] (wait_for_common+0x0/0x19c) from [<c02c9da0>] 
(wait_for_completion+
0x18/0x1c)
[<c02c9d88>] (wait_for_completion+0x0/0x1c) from [<c0229508>] 
(mmc_wait_for_req+
0x124/0x134)
[<c02293e4>] (mmc_wait_for_req+0x0/0x134) from [<c022f838>] 
(mmc_blk_issue_rq+0x
1d0/0x734)
  r5:c78d2000 r4:c78d3e94
[<c022f668>] (mmc_blk_issue_rq+0x0/0x734) from [<c0230450>] 
(mmc_queue_thread+0x
f8/0xfc)
[<c0230358>] (mmc_queue_thread+0x0/0xfc) from [<c0065600>] 
(kthread+0x88/0x90)
[<c0065578>] (kthread+0x0/0x90) from [<c0053214>] (do_exit+0x0/0x644)
  r7:00000000 r6:00000000 r5:00000000 r4:00000000
INFO: task kjournald:405 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kjournald     D c02c977c     0   405      2 0x00000000
Backtrace:
[<c02c9498>] (schedule+0x0/0x370) from [<c02c984c>] (io_schedule+0x44/0x70)
[<c02c9808>] (io_schedule+0x0/0x70) from [<c00d4840>] 
(sync_buffer+0x4c/0x54)
  r5:c7907e9c r4:00000000
[<c00d47f4>] (sync_buffer+0x0/0x54) from [<c02ca204>] 
(__wait_on_bit+0x64/0xb0)
[<c02ca1a0>] (__wait_on_bit+0x0/0xb0) from [<c02ca2d0>] 
(out_of_line_wait_on_bit
+0x80/0x8c)
[<c02ca250>] (out_of_line_wait_on_bit+0x0/0x8c) from [<c00d4778>] 
(__wait_on_buf
fer+0x28/0x30)
[<c00d4750>] (__wait_on_buffer+0x0/0x30) from [<c011f46c>] 
(journal_commit_trans
action+0xc5c/0x141c)
[<c011e810>] (journal_commit_transaction+0x0/0x141c) from [<c01232f8>] 
(kjournal
d+0xc4/0x264)
[<c0123234>] (kjournald+0x0/0x264) from [<c0065600>] (kthread+0x88/0x90)
[<c0065578>] (kthread+0x0/0x90) from [<c0053214>] (do_exit+0x0/0x644)
  r7:00000000 r6:00000000 r5:00000000 r4:00000000
INFO: task ash:427 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
ash           D c02c977c     0   427      1 0x00000000
Backtrace:
[<c02c9498>] (schedule+0x0/0x370) from [<c011d96c>] 
(do_get_write_access+0x27c/0
x4b8)
[<c011d6f0>] (do_get_write_access+0x0/0x4b8) from [<c011dbd4>] 
(journal_get_writ
e_access+0x2c/0x40)
[<c011dba8>] (journal_get_write_access+0x0/0x40) from [<c0113ffc>] 
(__ext3_journ
al_get_write_access+0x28/0x58)
  r5:c7471090 r4:00000000
[<c0113fd4>] (__ext3_journal_get_write_access+0x0/0x58) from 
[<c0107468>] (ext3_
reserve_inode_write+0x44/0x80)
  r7:c753fdb0 r6:c7477000 r5:c79b3d24 r4:00000000
[<c0107424>] (ext3_reserve_inode_write+0x0/0x80) from [<c01074c8>] 
(ext3_mark_in
ode_dirty+0x24/0x44)
  r7:00000115 r6:c79b3d24 r5:c753fdb0 r4:c7477000
[<c01074a4>] (ext3_mark_inode_dirty+0x0/0x44) from [<c0107624>] 
(ext3_dirty_inod
e+0x70/0x88)
  r6:c753fdb0 r5:00000000 r4:c7477000
[<c01075b4>] (ext3_dirty_inode+0x0/0x88) from [<c00cd808>] 
(__mark_inode_dirty+0
x34/0x15c)
  r7:00000115 r6:00000000 r5:c753fdb0 r4:00000001
[<c00cd7d4>] (__mark_inode_dirty+0x0/0x15c) from [<c00c3460>] 
(file_update_time+
0x108/0x124)
  r7:00000115 r6:00000000 r5:00000003 r4:c753fdb0
[<c00c3358>] (file_update_time+0x0/0x124) from [<c0084400>] 
(__generic_file_aio_
write+0x37c/0x4e4)
  r8:00000608 r7:c753fdb0 r6:0000001b r5:00000000 r4:00000623
[<c0084084>] (__generic_file_aio_write+0x0/0x4e4) from [<c00845dc>] 
(generic_fil
e_aio_write+0x74/0xd8)
[<c0084568>] (generic_file_aio_write+0x0/0xd8) from [<c00af0b8>] 
(do_sync_write+
0xb4/0x104)
[<c00af004>] (do_sync_write+0x0/0x104) from [<c00afbb8>] 
(vfs_write+0xb8/0x164)
  r8:0000001b r7:0000001b r6:c79b3f70 r5:001d6fa0 r4:c798af00
[<c00afb00>] (vfs_write+0x0/0x164) from [<c00afd28>] (sys_write+0x44/0x70)
  r8:001d6fa0 r7:0000001b r6:c798af00 r5:00000000 r4:00000608
[<c00afce4>] (sys_write+0x0/0x70) from [<c0027f80>] 
(ret_fast_syscall+0x0/0x2c)
  r8:c0028104 r7:00000004 r6:00000003 r5:001d6fa0 r4:0000001b

