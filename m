From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP TV video
Date: Wed, 04 Feb 2009 07:57:37 -0700
Message-ID: <4989ACE1.7050409@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76-skybeam.com ([76.76.67.137]:3684 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbZBDPIu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 10:08:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Note: if this is the wrong list, or if there's a better place
to ask these questions, please redirect me.

I have an OMAP/Zoom1 (3430 LDP).  I'm trying to use the
S-Video output, without much success.  Today, I grabbed
the latest tree (as least from what I can gather from various
web pages) from git://git.omapzoom.org/repo/omapkernel.git

When I try to use the TV, the kernel crashes immediately:
Unhandled fault: external abort on non-linefetch (0x1008) at 0xd8050440
Internal error: : 1008 [#1]
Modules linked in:

CPU: 0    Not tainted  (2.6.27.10-omap1-00181-gc9fd795 #1)
PC is at omap2_disp_enable_output_dev+0x30/0x44
LR is at write_layer_out+0x118/0x220
pc : [<c0053a84>]    lr : [<c018f3d4>]    psr: 60000013
sp : c7963ec8  ip : c7963ed8  fp : c7963ed4
r10: c7963f70  r9 : c7940e78  r8 : c039c8f0
r7 : 00000000  r6 : 00000003  r5 : c78626f8  r4 : c03c3c44
r3 : 00000000  r2 : d8050000  r1 : 00000003  r0 : 00000005
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 87320018  DAC: 00000015
Process echo (pid: 723, stack limit = 0xc79622e0)

kernel version: Linux version 2.6.27.10-omap1-00181-gc9fd795
config: omap_ldp_defconfig

Notes:
* An older kernel (circa 2008-12-01) does not crash.  The
  TV output is not correct, but at least it doesn't crash.
* How can I turn off the double printk()?  All kernel messages
  get duplicated and it makes it terribly hard to use.  e.g.

    <5>Looking up port of RPC 100003/2 on 192.168.1.100
    Looking up port of RPC 100003/2 on 192.168.1.100
    <5>Looking up port of RPC 100005/1 on 192.168.1.100
    Looking up port of RPC 100005/1 on 192.168.1.100
    VFS: Mounted root (nfs filesystem).
    VFS: Mounted root (nfs filesystem).

  Other kernels (PowerPC, etc) don't suffer from this.
* This kernel version is very unstable - it simply quits after
  just a few moments of running.  I didn't see this with the
  older kernel.

Thanks for any ideas/pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
