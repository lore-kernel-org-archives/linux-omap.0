From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 00/15] More cleanups
Date: Wed, 16 Feb 2011 21:18:54 +0200
Message-ID: <1297883934.1789.2.camel@eowin>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
	 <20110216180745.GH20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38017 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab1BPTUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 14:20:07 -0500
In-Reply-To: <20110216180745.GH20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, 2011-02-16 at 10:07 -0800, Tony Lindgren wrote:
> As based on a quick test this one will oops:
> 
> [    2.925170] Internal error: Oops: 5 [#1] SMP
> [    2.929656] last sysfs file:
> [    2.932800] Modules linked in:
> [    2.936035] CPU: 0    Not tainted  (2.6.38-rc4-00101-gbbb5d46 #113)
> [    2.942657] PC is at retu_write_reg+0x8/0x24
> [    2.947143] LR is at _retu_modify_counter+0x28/0x34
> [    2.952301] pc : [<c0329ad4>]    lr : [<c032a23c>]    psr: a0000013
> [    2.952331] sp : c7825ee8  ip : 22222222  fp : 00000000
> [    2.964355] r10: 00000000  r9 : 00000000  r8 : c0b4e6f0
> [    2.969848] r7 : c05f5598  r6 : 00000000  r5 : 0000003f  r4 : 00000017
> [    2.976715] r3 : c0b4e6f0  r2 : 0000003f  r1 : 00000017  r0 : 00000000
> [    2.983581] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    2.991271] Control: 00c5387d  Table: 80004000  DAC: 00000017
> [    2.997314] Process swapper (pid: 1, stack limit = 0xc78242f8)
> [    3.003448] Stack: (0xc7825ee8 to 0xc7826000)
> [    3.008056] 5ee0:                   c05f5598 0000003f 00000000 c032a23c c05f5598 c032a278
> [    3.016693] 5f00: c7a96ea0 c7898008 00000000 c002ceb0 c7898008 c7898008 c05f55ac c7a96f20
> [    3.025299] 5f20: c05e8b60 c0296c40 c7898008 c0295da8 c7898008 c789803c c05f55ac c0295ed0
> [    3.033905] 5f40: 00000000 c0295e68 c05f55ac c02955c8 c7819658 c78bb790 c05f5598 c05f55ac
> [    3.042541] 5f60: c05f55ac c0294efc c0532916 00000468 00000000 c05f5598 c059aaf8 c05f55ac
> [    3.051147] 5f80: 00000013 c002cdb4 00000000 c02961c8 c05f5598 c059aaf8 c059aaf0 00000013
> [    3.059753] 5fa0: c002cdb4 c0297048 c0034930 c059aaf8 c059aaf0 c0052554 00000000 00000000
> [    3.068389] 5fc0: c0500122 000001a2 c059aaf8 c0034930 c059aaf8 c059aaf0 00000013 00000000
> [    3.076995] 5fe0: 00000000 c00084f4 00000000 c00083a4 c005dd64 c005dd64 ffffffff ffffffff
> [    3.085632] [<c0329ad4>] (retu_write_reg+0x8/0x24) from [<c032a23c>] (_retu_modify_counter+0x28/0x34)
> [    3.095367] [<c032a23c>] (_retu_modify_counter+0x28/0x34) from [<c032a278>] (retu_modify_counter+0x30/0x44)
> [    3.105651] [<c032a278>] (retu_modify_counter+0x30/0x44) from [<c002ceb0>] (retu_wdt_probe+0xe8/0x160)
> [    3.115447] [<c002ceb0>] (retu_wdt_probe+0xe8/0x160) from [<c0296c40>] (platform_drv_probe+0x18/0x
> [    3.125183] [<c0296c40>] (platform_drv_probe+0x18/0x1c) from [<c0295da8>] (driver_probe_device+0xc8/0x188)
> [    3.135375] [<c0295da8>] (driver_probe_device+0xc8/0x188) from [<c0295ed0>] (__driver_attach+0x68/0x8c)
> [    3.145263] [<c0295ed0>] (__driver_attach+0x68/0x8c) from [<c02955c8>] (bus_for_each_dev+0x44/0x74)
> [    3.154815] [<c02955c8>] (bus_for_each_dev+0x44/0x74) from [<c0294efc>] (bus_add_driver+0xa0/0x228)
> [    3.164337] [<c0294efc>] (bus_add_driver+0xa0/0x228) from [<c02961c8>] (driver_register+0xa8/0x130)
> [    3.173889] [<c02961c8>] (driver_register+0xa8/0x130) from [<c0297048>] (platform_driver_probe+0x18/0x8c)
> [    3.183990] [<c0297048>] (platform_driver_probe+0x18/0x8c) from [<c0052554>] (do_one_initcall+0xc8/0x1a0)
> [    3.194061] [<c0052554>] (do_one_initcall+0xc8/0x1a0) from [<c00084f4>] (kernel_init+0x150/0x218)
> [    3.203430] [<c00084f4>] (kernel_init+0x150/0x218) from [<c005dd64>] (kernel_thread_exit+0x0/0x8)
> [    3.212768] Code: e8bd41f0 ea035b8e e92d4070 e1a04001 (e5900000)
> [    3.219451] ---[ end trace 5cc53738ab810194 ]---

found the problem, commit 6b8074b00d90b191227dc875b90b272c51f7d6eb
never got to the point of saving struct device * in struct retu_wdt_dev.

Since it was there already, I was assuming it was working. Silly
mistake. The remaining patches are coming in a few minutes.

-- 
balbi

