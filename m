From: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Subject: Kernel panic on "run_init_process(execute command)"
Date: Fri, 8 Apr 2011 15:22:41 -0400
Message-ID: <0E62BBF85AF134469094EB502CE90A321EAEB7@TAMPA202EM.se.sypris.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og126.obsmtp.com ([64.18.2.206]:46525 "HELO
	exprod7og126.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757674Ab1DHTXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 15:23:42 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I am working with a custom OMAP3530 board. I am using rowboat 2.6.32,
codesourcery 2010q1, X-loader and U-boot, all uniquely customized for
this board.

I am using the 3 partition microSD card for this board, modeled after
the TI-DevKit version 2.2, with rootfs as a partition at /dev/mmcblk0p2.


On kernel boot, after mounting the root filesystem (/dev/mmcblk0p2) when
attempting to start init (bootargs are init=/init), in main.c,
run_init_process(execute_command) with execute_command set to /init, I
get a kernel panic:


[  103.806274] Kernel panic - not syncing: Attempted to kill init!


The backtrace identifies: 


[  103.812377] [<c0048320>] (unwind_backtrace+0x0/0x17c) from
[<c0489d34>] (dump_stack+0x20/0x24)
[  103.821105] [<c0489d34>] (dump_stack+0x20/0x24) from [<c0489d94>]
(panic+0x5c/0x130)
[  103.828918] [<c0489d94>] (panic+0x5c/0x130) from [<c007cc18>]
(do_exit+0x5d4/0x6a4)
[  103.836669] [<c007cc18>] (do_exit+0x5d4/0x6a4) from [<c007cd34>]
(do_group_exit+0x4c/0xbc)
[  103.845062] [<c007cd34>] (do_group_exit+0x4c/0xbc) from [<c008dee8>]
(get_signal_to_deliver+0x208/0x3e8)
[  103.854644] [<c008dee8>] (get_signal_to_deliver+0x208/0x3e8) from
[<c0042de0>] (do_signal+0x74/0x698)
[  103.863983] [<c0042de0>] (do_signal+0x74/0x698) from [<c0043470>]
(do_notify_resume+0x6c/0x78)
[  103.872680] [<c0043470>] (do_notify_resume+0x6c/0x78) from
[<c003fb4c>] (work_pending+0x1c/0x20)

I am not sure what is exactly causing this error. I am using RealView
ICE and RVD, with source code debugging. 

Can anybody assist?

Thanks.


