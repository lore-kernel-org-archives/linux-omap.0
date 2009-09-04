From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: 3430SDP: Crash on first UART keypress after boot
Date: Fri, 4 Sep 2009 12:19:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A0071C4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932510AbZIDGt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 02:49:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n846nPML017445
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 01:49:31 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n846nOse019618
	for <linux-omap@vger.kernel.org>; Fri, 4 Sep 2009 12:19:24 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Current linux-omap kernel boots up fine on 3430 SDP after
adding Sergio's patch [1], but then I get the following crash
on the first UART keypress.

This is new, it used to work okay a little while ago.

Regards,
Anand

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000010
<1>pgd = c79f8000
<1>[00000010] *pgd=87b05031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.31-rc8-omap1 #5)
PC is at do_con_write+0x61c/0x1d30
LR is at do_con_write+0x404/0x1d30
pc : [<c01d3a0c>]    lr : [<c01d37f4>]    psr: 60000013
sp : c7b7be38  ip : 00000000  fp : 00000001
r10: 00000000  r9 : 00000000  r8 : c79d9000
r7 : 00000073  r6 : 00000100  r5 : 00000073  r4 : 00000073
r3 : 00000173  r2 : 080104c0  r1 : 00000010  r0 : 00000173
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 879f8019  DAC: 00000015
Process init (pid: 594, stack limit = 0xc7b7a2f0)
Stack: (0xc7b7be38 to 0xc7b7c000)
be20:                                                       c7b0c800 00000000
be40: c7a3e300 c01c3e70 0000002e c79e9400 c7b0c800 00000100 00000001 ffffffff
be60: 00000000 00000000 000000ff 00000000 c7b5a000 c74b0300 00000022 c00bab3c
be80: c79fdab0 00000004 c7b53580 c79fdab0 c00baa18 00000000 c79d9000 00000073
bea0: c7b7a000 c7b0c800 c7b0c800 c79e9400 0000002f c7b7a000 c7b53580 c7b0cbc8
bec0: c79e9400 c01d5168 c7988000 c7b0c800 c79e9400 c01c4e00 c7b0c910 c7b0c89c
bee0: 00000000 00000000 c7988000 c004ece0 c7b0c910 c7b0c910 00000000 0000002f
bf00: 00000400 00000000 c7b0c800 c7b7a000 0000002f 00000000 c7b53580 c01c28bc
bf20: c7a60a80 bed48554 c01c4bb4 c798e520 00000000 c7b44588 0000000b c7b53580
bf40: bed48554 c7b7bf80 0000002f 0000002f c7b7a000 40025000 bed48f14 c00b8988
bf60: c7b53580 bed48554 00000000 00000000 c7b53580 0000002f bed48554 c00b8adc
bf80: 00000000 00000000 0000002f 00000000 0000002f bed48554 00000003 00000004
bfa0: c002df44 c002ddc0 0000002f bed48554 00000003 bed48554 0000002f 000c1704
bfc0: 0000002f bed48554 00000003 00000004 000c1764 00000001 40025000 bed48f14
bfe0: 4001e6f0 bed48520 0004193c 401c1f6c 60000010 00000003 00000000 00000000
[<c01d3a0c>] (do_con_write+0x61c/0x1d30) from [<c01d5168>] (con_write+0xc/0x20)
[<c01d5168>] (con_write+0xc/0x20) from [<c01c4e00>] (n_tty_write+0x24c/0x3ac)
[<c01c4e00>] (n_tty_write+0x24c/0x3ac) from [<c01c28bc>] (tty_write+0x188/0x224)
[<c01c28bc>] (tty_write+0x188/0x224) from [<c00b8988>] (vfs_write+0xac/0x154)
[<c00b8988>] (vfs_write+0xac/0x154) from [<c00b8adc>] (sys_write+0x3c/0x68)
[<c00b8adc>] (sys_write+0x3c/0x68) from [<c002ddc0>] (ret_fast_syscall+0x0/0x2c)
Code: e6ec2077 11a03000 e0833002 e6ff0073 (e1c100b0)
<4>---[ end trace 5a94e3c94d71be0e ]