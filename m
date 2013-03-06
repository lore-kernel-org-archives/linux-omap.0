From: Tony Lindgren <tony@atomide.com>
Subject: Re: 3.8 -> 3.9-rc1 upgrade: old configs broken
Date: Wed, 6 Mar 2013 12:33:32 -0800
Message-ID: <20130306203332.GR11806@atomide.com>
References: <51376E2F.9090005@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15705 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753265Ab3CFUdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 15:33:38 -0500
Content-Disposition: inline
In-Reply-To: <51376E2F.9090005@broadcom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Piotr Haber <phaber@broadcom.com>, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

Adding Mike, Paul and Rajendra.

* Piotr Haber <phaber@broadcom.com> [130306 08:30]:
> 
> I run into same problem, 3.9-rc1 builds fail to boot on mu panda
> have all the things mentioned above in my .config
...

Hmm this seems to be related to the recent generic clock conversion
and CONFIG_DEBUG_SLAB=y in your .config that exposes the bug.

I get this with DEBUG_LL and earlyprintk enabled:

[    0.000000] Kernel BUG at c01174f8 [verbose debug info unavailable]
[    0.000000] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (3.9.0-rc1-12179-g72d48f9 #6)
[    0.000000] PC is at __kmalloc+0x1d4/0x248
[    0.000000] LR is at __clk_init+0x2e0/0x364
[    0.000000] pc : [<c01174f8>]    lr : [<c0441f54>]    psr: 600001d3
[    0.000000] sp : c076ff28  ip : c065cefc  fp : c0441f54
[    0.000000] r10: 0000001c  r9 : 000080d0  r8 : c076ffd4
[    0.000000] r7 : c074b578  r6 : c0794d88  r5 : 00000040  r4 : 00000000
[    0.000000] r3 : 00000000  r2 : c07cac70  r1 : 000080d0  r0 : 0000001c
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc076e240)
[    0.000000] Stack: (0xc076ff28 to 0xc0770000)
[    0.000000] ff20:                   22222222 c0794ec8 c06546e8 00000000 00000040 c0794d88
[    0.000000] ff40: c074b578 c076ffd4 c07951c8 c076e000 00000000 c0441f54 c074b578 c076ffd4
[    0.000000] ff60: c0793828 00000040 c0794d88 c074b578 c076ffd4 c0776900 c076e000 c07272ac
[    0.000000] ff80: 2f800000 c074c968 c07f93d0 c0719780 c076ffa0 c076ff98 00000000 00000000
[    0.000000] ffa0: 00000000 00000000 00000000 00000001 c074cd6c c077b1ec 8000406a c0715724
[    0.000000] ffc0: 00000000 00000000 00000000 00000000 00000000 c074c968 10c53c7d c0776974
[    0.000000] ffe0: c074cd6c c077b1ec 8000406a 411fc092 00000000 80008074 00000000 00000000
[    0.000000] [<c01174f8>] (__kmalloc+0x1d4/0x248) from [<c0441f54>] (__clk_init+0x2e0/0x364)
[    0.000000] [<c0441f54>] (__clk_init+0x2e0/0x364) from [<c07272ac>] (omap4xxx_clk_init+0xbc/0x140)
[    0.000000] [<c07272ac>] (omap4xxx_clk_init+0xbc/0x140) from [<c0719780>] (setup_arch+0x15c/0x284)
[    0.000000] [<c0719780>] (setup_arch+0x15c/0x284) from [<c0715724>] (start_kernel+0x7c/0x334)
[    0.000000] [<c0715724>] (start_kernel+0x7c/0x334) from [<80008074>] (0x80008074)
[    0.000000] Code: e5883004 e1a00006 e28dd00c e8bd8ff0 (e7f001f2)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!

So basically what's going is that __clk_init() calls kzalloc() before
kmem_cache_init() is done. This happens the first time for sys_clkin_ck
where we do have clk->num_parents.

With CONFIG_DEBUG_SLAB we actually get an error in __find_general_cachep()
as generic caches are not yet initialized.

It seems that in the omap case we need to statically allocate clk->parents
to fix this. I believe we now are overwriting parent clocks..

Regards,

Tony
