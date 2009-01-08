From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.28-omap1 on Friday
Date: Thu, 8 Jan 2009 12:06:01 +0200
Message-ID: <20090108100600.GX27566@atomide.com>
References: <20090107190427.GV27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59206 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZAHKGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 05:06:06 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LKrm7-0006nv-3a
	for linux-omap@vger.kernel.org; Thu, 08 Jan 2009 10:06:03 +0000
Content-Disposition: inline
In-Reply-To: <20090107190427.GV27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090107 21:04]:
> Hi all,
> 
> I'm planning to tag v2.6.28-omap1 on Friday. I'll be going through
> my omap inbox and applying some obvious fixes, but if anybody has
> new fixes that should go in, please post them ASAP.

I've also pushed the recent 23 patch clock series from Paul,
and merged in Kevin's omap-pm-upstream branch. So please give
the current l-o head some testing on your favorite boards.

Looks like we now have some McBSP clock issue probably related
to the custom clock:

WARNING: at arch/arm/mach-omap2/clock.c:1092 omap2_clk_register+0x24/0x3c()     
Modules linked in:       
[<c00317f4>] (dump_stack+0x0/0x14) from [<c004c96c>]
 (warn_on_slowpath+0x4c/0x68
[<c004c920>] (warn_on_slowpath+0x0/0x68) from [<c0036450>]
 (omap2_clk_register+0
 r6:c0427bd0 r5:c0421e94 r4:c0421e30       
 [<c003642c>] (omap2_clk_register+0x0/0x3c) from [<c0039ce4>]
(clk_register+0x44/
[<c0039ca0>] (clk_register+0x0/0xc8) from [<c0011208>]
(omap2_mcbsp_init+0xc4/0x
 r7:c03bcc31 r6:00000008 r5:c0421e94 r4:c0421e30       
 [<c0011144>] (omap2_mcbsp_init+0x0/0x12c) from [<c002d2d4>]
(do_one_initcall+0x6
[<c002d270>] (do_one_initcall+0x0/0x198) from [<c0008718>]
(kernel_init+0x70/0xd
[<c00086a8>] (kernel_init+0x0/0xdc) from [<c004f324>]
(do_exit+0x0/0x6b4)       
 r5:00000000 r4:00000000 
...

Similar warnings for other McBSP clocks

...

omap-mcbsp omap-mcbsp.1: Invalid clock configuration for McBSP1.       
omap-mcbsp: probe of omap-mcbsp.1 failed with error -2       
omap-mcbsp omap-mcbsp.2: Invalid clock configuration for McBSP2.       
omap-mcbsp: probe of omap-mcbsp.2 failed with error -2       
omap-mcbsp omap-mcbsp.3: Invalid clock configuration for McBSP3.       
omap-mcbsp: probe of omap-mcbsp.3 failed with error -2       
omap-mcbsp omap-mcbsp.4: Invalid clock configuration for McBSP4.       
omap-mcbsp: probe of omap-mcbsp.4 failed with error -2       
omap-mcbsp omap-mcbsp.5: Invalid clock configuration for McBSP5.       
omap-mcbsp: probe of omap-mcbsp.5 failed with error -2         

Regards,

Tony
