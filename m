From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: [OMAP 1710] Mainline Broken
Date: Thu, 16 Dec 2010 21:00:06 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52025 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756376Ab0LPPaL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 10:30:11 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBGFU7XP003722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 09:30:09 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oBGFU7LR014180
	for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 21:00:07 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Did anyone observe this? I am using omap_generic_1710_defconfig

[...]
input: omap-keypad as /devices/platform/omap-keypad/input/input0
TCP cubic registered
NET: Registered protocol family 17
Registering the dns_resolver key type
eth0: link up
IP-Config: Complete:
     device=eth0, addr=172.24.191.106, mask=255.255.252.0, gw=172.24.188.1,
     host=myomap, domain=, nis-domain=(none),
     bootserver=172.24.191.66, rootserver=172.24.191.66, rootpath=
VFS: Mounted root (nfs filesystem) on device 0:10.
Freeing init memory: 128K
Kernel panic - not syncing: Attempted to kill init!
Backtrace:
[<c0032104>] (dump_backtrace+0x0/0x114) from [<c027ecd4>] (dump_stack+0x18/0x1c)
 r7:c0826000 r6:c0826000 r5:c0304ce8 r4:c0320254
[<c027ecbc>] (dump_stack+0x0/0x1c) from [<c027ed38>] (panic+0x60/0x188)
[<c027ecd8>] (panic+0x0/0x188) from [<c0047414>] (do_exit+0x74/0x600)
 r3:60000013 r2:c0826000 r1:c08260f8 r0:c02d6cff
[<c00473a0>] (do_exit+0x0/0x600) from [<c0047a38>] (do_group_exit+0x98/0xcc)
[<c00479a0>] (do_group_exit+0x0/0xcc) from [<c00535e4>] (get_signal_to_deliver+0x304/0x33c)
 r7:c08ba484 r6:c0828000 r5:c0829ee4 r4:00000004
[<c00532e0>] (get_signal_to_deliver+0x0/0x33c) from [<c0030fb8>] (do_notify_resume+0x7c/0x638)
[<c0030f3c>] (do_notify_resume+0x0/0x638) from [<c002eb14>] (work_pending+0x24/0x28)

--
Tarun
