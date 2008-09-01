From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: MMC Driver - Kernel crashing at function "omap_mmc_set_ios"
Date: Mon, 1 Sep 2008 15:56:51 +0530
Message-ID: <03dd01c90c1d$403b9000$LocalHost@wipultra1303>
References: <ca6476860809010212hfc58859nfa745af59f103e54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60141 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbYIAK1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 06:27:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: halli manjunatha <hallimanju@gmail.com>, linux-omap@vger.kernel.org

Hi,

I did not see any such crash. Why 2.6.24 kernel version? The linux omap kernel is 2.6.27.
Looking at the error it seems like an access to the mmc registers when the clocks are not on.

Regards,
Madhu
----- Original Message ----- 
From: "halli manjunatha" <hallimanju@gmail.com>
To: <linux-omap@vger.kernel.org>
Sent: Monday, September 01, 2008 2:42 PM
Subject: MMC Driver - Kernel crashing at function "omap_mmc_set_ios"


> Hello,
>       I am working on omap3430 with 2.6.24 kernel, while booting the
> kernel is crashing ,
> the kernel message is shown below.
> 
> *************************************************************************************************
> Unhandled fault: external abort on non-linefetch (0x1008) at 0xc885802c
> Internal error: : 1008 [#1]
> Modules linked in:
> CPU: 0    Not tainted  (2.6.24.7-omap1-arm2-g0d138099-dirty #6)
> PC is at omap_mmc_set_ios+0xac/0x2c8
> LR is at schedule_timeout+0x98/0xb8
> pc : [<c0233450>]    lr : [<c02e6090>]    psr: 60000013
> sp : c7c6bf38  ip : c7c6bec8  fp : c7c6bf54
> r10: 00000000  r9 : 00000000  r8 : 00000000
> r7 : c77d0540  r6 : c77d05a0  r5 : c7c6bf6c  r4 : c77d0400
> r3 : 00000f07  r2 : c8858000  r1 : 00000002  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 00c5387f  Table: 80004018  DAC: 00000017
> Process kmmcd (pid: 109, stack limit = 0xc7c6a2e8)
> Stack: (0xc7c6bf38 to 0xc7c6c000)
> bf20:                                                       c77d0400 c7c6bf6c
> bf40: c022c3e0 c7c96a60 c7c6bf64 c7c6bf58 c022ba98 c02333b0 c7c6bf84 c7c6bf68
> bf60: c022c508 c022ba54 00000000 00000000 c7c96a60 c7c6a000 c7c6bfa4 c7c6bf88
> bf80: c0095ed0 c022c3ec c7c96a68 c7c6bfb8 c7cb9700 c7c96a60 c7c6bfdc c7c6bfa8
> bfa0: c0096900 c0095e40 c7c6bfdc 00000000 c7cb9700 c009a124 c7c6bfb8 c7c6bfb8
> bfc0: c7c96a60 c0096854 00000000 00000000 c7c6bff4 c7c6bfe0 c0099c70 c0096860
> bfe0: 00000000 00000000 00000000 c7c6bff8 c0089ad0 c0099c28 00000000 00000000
> Backtrace:
> [<c02333a4>] (omap_mmc_set_ios+0x0/0x2c8) from [<c022ba98>]
> (mmc_power_off+0x50/0x54)
> r7:c7c96a60 r6:c022c3e0 r5:c7c6bf6c r4:c77d0400
> [<c022ba48>] (mmc_power_off+0x0/0x54) from [<c022c508>] (mmc_rescan+0x128/0x188)
> [<c022c3e0>] (mmc_rescan+0x0/0x188) from [<c0095ed0>] (run_workqueue+0x9c/0x118)
> r5:c7c6a000 r4:c7c96a60
> [<c0095e34>] (run_workqueue+0x0/0x118) from [<c0096900>]
> (worker_thread+0xac/0xc0)
> r7:c7c96a60 r6:c7cb9700 r5:c7c6bfb8 r4:c7c96a68
> [<c0096854>] (worker_thread+0x0/0xc0) from [<c0099c70>] (kthread+0x54/0x80)
> r7:00000000 r6:00000000 r5:c0096854 r4:c7c96a60
> [<c0099c1c>] (kthread+0x0/0x80) from [<c0089ad0>] (do_exit+0x0/0x6d4)
> r5:00000000 r4:00000000
> Code: e5923128 e3833002 ea000006 e5962044 (e592302c)
> ---[ end trace db388d58efbe09b5 ]---
> 
> ********************************************************************************************************
> 
> But if i disable the backlight driver while compiling, then kernel
> booting goes smoothly.
> where the backlight driver is no  more related to MMC driver.
> -- 
> Regards
> Manjunatha H
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
>
