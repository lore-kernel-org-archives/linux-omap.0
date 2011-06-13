From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3: ftrace on latest 3.0.0-rc2
Date: Mon, 13 Jun 2011 20:01:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D4CF1D7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab1FMOb3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 10:31:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5DEVP9f014880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 09:31:28 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5DEVOph024767
	for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 20:01:25 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,

I am unable to enable ftrace on the 3.0.0-rc2. Have tried with
Codesourcery toolchain using GCC v4.3.3 and 4.5.1.

Before moving to debug, I just wanted to know if it is a known
problem.

~sanjeev

Linux version 3.0.0-rc2-11092-gc04c67c (premi@mylinux) (gcc version 4.5.1
 (Sourcery G++ Lite 2010.09-50) ) #2 SMP Mon Jun 13 15:23:22 IST 2011

[root@OMAP3EVM tracing]# uname -a
Linux OMAP3EVM 3.0.0-rc2-11092-gc04c67c #2 SMP Mon Jun 13 15:23:22 IST 201
1 armv7l GNU/Linux
[root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]# zcat /proc/config.gz | grep TRACER
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_GENERIC_TRACER=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_STACK_TRACER=y
[root@OMAP3EVM tracing]#

[root@OMAP3EVM tracing]# dmesg | grep -i tracer
[    0.841461] Testing tracer function: PASSED
[    1.932708] Testing tracer function_graph:
[    1.933349] Failed to init function_graph tracer, init returned -19
[    5.950775] Failed to enable function tracer for event tests
[root@OMAP3EVM tracing]# pwd
root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]# cat available_tracers
nop

Linux version 3.0.0-rc2-11092-gc04c67c (premi@mylinux) (gcc version 4.3.3
 (Sourcery G++ Lite 2009q1-203) ) #3 SMP Mon Jun 13 17:29:19 IST 2011

[    5.845520] Testing all events: OK
[    5.898864] ------------[ cut here ]------------
[    5.903808] WARNING: at kernel/trace/trace_events.c:1662 event_trace_s
elf_tests_init+0x5c/0x80()
[    5.913085] Modules linked in:
[    5.916351] [<c007ac20>] (unwind_backtrace+0x0/0x104) from [<c04bbb3c>] 
(dump_stack+0x20/0x24)
[    5.925476] [<c04bbb3c>] (dump_stack+0x20/0x24) from [<c00b3c78>] (warn
_slowpath_common+0x5c/0x74)
[    5.934967] [<c00b3c78>] (warn_slowpath_common+0x5c/0x74) from [<c00b3c
bc>] (warn_slowpath_null+0x2c/0x34)
[    5.945190] [<c00b3cbc>] (warn_slowpath_null+0x2c/0x34) from [<c0020ecc
>]
 (event_trace_self_tests_init+0x5c/0x80)
[    5.956054] [<c0020ecc>] (event_trace_self_tests_init+0x5c/0x80) from 
[<c0066598>] (do_one_initcall+0x44/0x194)
[    5.966705] [<c0066598>] (do_one_initcall+0x44/0x194) from [<c0008454>]
 (kernel_init+0xbc/0x170)
[    5.976013] [<c0008454>] (kernel_init+0xbc/0x170) from [<c0073ab8>] (ke
rnel_thread_exit+0x0/0x8)
[    5.985321] ---[ end trace 3c0bd3405257eb98 ]---
[    5.990203] Failed to enable function tracer for event tests

[root@OMAP3EVM tracing]# uname -a
Linux OMAP3EVM 3.0.0-rc2-11092-gc04c67c #3 SMP Mon Jun 13 17:29:19 IST 2011
 armv7l GNU/Linux
[root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]# cat available_tracers
nop
[root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]#
[root@OMAP3EVM tracing]# zcat /proc/config.gz | grep TRACER
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_GENERIC_TRACER=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_STACK_TRACER=y
[root@OMAP3EVM tracing]#
