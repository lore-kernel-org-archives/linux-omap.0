From: Ben Goska <goskab@onid.oregonstate.edu>
Subject: Odd crashes after 2.6.31-rc5
Date: Thu, 10 Sep 2009 08:28:06 -0700
Message-ID: <ef9097660909100828l28e81e86k5104714d11eba219@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:54656 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbZIJP2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 11:28:06 -0400
Received: by ewy2 with SMTP id 2so227678ewy.17
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 08:28:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've been working with the linux-omap kernel, and after 2.6.31-rc5 I
started seeing some strange crashes. A back trace is given here:

[   46.620941] Unable to handle kernel paging request at virtual
address 0000512a
[   46.628295] pgd = c71f4000
[   46.631042] [0000512a] *pgd=878a6031, *pte=00000000, *ppte=00000000
[   46.637451] Internal error: Oops: 17 [#1]
[   46.641510] Modules linked in:
[   46.644592] CPU: 0    Not tainted  (2.6.31-rc8-omap1 #24)
[   46.650024] PC is at sysfs_open_file+0x6c/0x240
[   46.654602] LR is at sysfs_open_file+0x54/0x240
[   46.659149] pc : [<c00e7090>]    lr : [<c00e7078>]    psr: 20000013
[   46.659179] sp : c711be78  ip : 00000000  fp : 00000000
[   46.670715] r10: c780c1a0  r9 : 00020001  r8 : c743b8a0
[   46.675964] r7 : c7863428  r6 : c0026980  r5 : c782bd20  r4 : c04de406
[   46.682556] r3 : 00005126  r2 : 00000001  r1 : 00000000  r0 : c7863428
[   46.689117] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   46.696289] Control: 10c5387d  Table: 871f4019  DAC: 00000015
[   46.702056] Process udevadm (pid: 520, stack limit = 0xc711a2e8)
[   46.708099] Stack: (0xc711be78 to 0xc711c000)
[   46.712493] be60:
    00000000 c782bd20
[   46.720886] be80: c743b8a0 c00e7024 c7439138 00000000 c780c1a0
c009b9bc c743b8a0 c782bd20
[   46.729248] bea0: c78c9320 00020001 ffffff9c 00000022 c711bef0
c009bc40 00000000 c78c9320
[   46.737640] bec0: 00000000 00000000 00020002 c00a8f18 00000000
c01b1130 000000d0 000280d0
[   46.746032] bee0: 00000000 c7ae6000 c04a50a8 c04a51b8 c780c1a0
c7439138 c711bf44 c7972608
[   46.754425] bf00: 00000003 00000000 c7407618 00000101 00000001
00000000 0001eb30 c01f0404
[   46.762817] bf20: c7b4e4a0 00000000 c7b4e4b8 00000003 c05e8e00
00000000 c782bda0 00020002
[   46.771179] bf40: 00000000 c782bd20 00000003 c78e82c0 c78e82c8
c78e82c4 00000000 00020001
[   46.779571] bf60: 00000000 ffffff9c 00000003 c786c000 c711a000
00000000 0001eb30 c009b7ec
[   46.787963] bf80: 00000000 c009b650 00000000 00000001 bee01168
00000005 c002c084 c711a000
[   46.796356] bfa0: 00026df0 c002bf00 00000000 00000001 bee01168
00020001 00000000 00003100
[   46.804718] bfc0: 00000000 00000001 bee01168 00000005 00026df4
00027008 00026df0 0001eb30
[   46.813110] bfe0: 00026d00 bee01130 0001a868 400d84e8 60000010
bee01168 6f79702e 34d80100
[   46.821502] [<c00e7090>] (sysfs_open_file+0x6c/0x240) from
[<c009b9bc>] (__dentry_open+0xbc/0x25c)
[   46.830566] [<c009b9bc>] (__dentry_open+0xbc/0x25c) from
[<c009bc40>] (nameidata_to_filp+0x58/0x60)
[   46.839721] [<c009bc40>] (nameidata_to_filp+0x58/0x60) from
[<c00a8f18>] (do_filp_open+0x598/0x82c)
[   46.848876] [<c00a8f18>] (do_filp_open+0x598/0x82c) from
[<c009b7ec>] (do_sys_open+0x68/0x154)
[   46.857574] [<c009b7ec>] (do_sys_open+0x68/0x154) from [<c002bf00>]
(ret_fast_syscall+0x0/0x2c)
[   46.866363] Code: 0a000010 e5963014 e3530000 0a00003d (e5934004)
[   46.872619] ---[ end trace 463c2798013d597e ]---

After bisecting I found the problem commit to be
e084b2d95e48b31aa45f9c49ffc6cdae8bdb21d4 ("page-allocator: preserve
PFN ordering when __GFP_COLD is set"). After reverting that commit, I
have no problems. The only thing that bothers me is that no one else
seems to have this problem.

Testing hardware: OSWALD board [1], OMAP 3530, 128Mb Ram, 256Mb NAND.
All peripherals have been disabled with no effect on the problem.

A git tree with the OSWALD added can be found at [2] if anyone is
interested, I will be submitting patches for OSWALD in the future, but
currently it is in no state to be submitted upstream (we have a very
small team).

Ben Goska
goskab@onid.oregonstate.edu

[1] - http://beaversource.oregonstate.edu/projects/cspfl/wiki
[2] - https://code.oregonstate.edu/git/oswald-kernel/?h=oswald-origin
