From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP4: PM fixes and AESS integration for 3.9
Date: Sun, 10 Feb 2013 18:16:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302101814390.2672@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302081812040.28008@utopia.booyaka.com> <20130210170849.GM4801@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57839 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab3BJSQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 13:16:45 -0500
In-Reply-To: <20130210170849.GM4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

On Sun, 10 Feb 2013, Tony Lindgren wrote:

> Looks like this branch merged into the current omap-for-v3.9/tmp-merge
> at commit 4dcccca0 causes the following on my omap4 blaze:
> 
> [    0.294006] ------------[ cut here ]------------
> [    0.298858] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2417 _init+0x108/0x134()
> [    0.306610] omap_hwmod: aess: couldn't init clocks
> [    0.311614] Modules linked in:
> [    0.314880] [<c001c4e0>] (unwind_backtrace+0x0/0xf4) from [<c0046c40>] (warn_slowpath_common+0x4c/0x64)
> [    0.324615] [<c0046c40>] (warn_slowpath_common+0x4c/0x64) from [<c0046cec>] (warn_slowpath_fmt+0x30/0x40)
> [    0.334533] [<c0046cec>] (warn_slowpath_fmt+0x30/0x40) from [<c072d0f4>] (_init+0x108/0x134)
> [    0.343292] [<c072d0f4>] (_init+0x108/0x134) from [<c002b758>] (omap_hwmod_for_each+0x50/0x64)
> [    0.352233] [<c002b758>] (omap_hwmod_for_each+0x50/0x64) from [<c072d250>] (__omap_hwmod_setup_all+0x34/0x4c)
> [    0.362518] [<c072d250>] (__omap_hwmod_setup_all+0x34/0x4c) from [<c0008768>] (do_one_initcall+0x2c/0x178)
> [    0.372528] [<c0008768>] (do_one_initcall+0x2c/0x178) from [<c071f2a0>] (do_basic_setup+0x94/0xd0)
> [    0.381805] [<c071f2a0>] (do_basic_setup+0x94/0xd0) from [<c071f358>] (kernel_init_freeable+0x7c/0x124)
> [    0.391540] [<c071f358>] (kernel_init_freeable+0x7c/0x124) from [<c051474c>] (kernel_init+0xc/0x164)
> [    0.401031] [<c051474c>] (kernel_init+0xc/0x164) from [<c0014310>] (ret_from_fork+0x14/0x24)
> [    0.409912] ---[ end trace 1b75b31a2719ed1c ]---

Thanks.  Looks like the AESS hwmod used a leaf clock that was removed by 
one of the earlier cleanup patches.  Will fix and send a new pull request 
for this series based on what's now in the arm-soc omap/pm branch 
(0e084c9c843320995b0e219f02880f910d439b37).


- Paul
