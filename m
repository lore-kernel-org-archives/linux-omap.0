From: Philip Balister <philip@balister.org>
Subject: Regulator message while booting recent kernel
Date: Tue, 23 Mar 2010 09:34:46 -0400
Message-ID: <4BA8C376.8060606@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:37821 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095Ab0CWNes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 09:34:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is from a "recent" git kernel. Any ideas how I can make it go away?

[   16.512817] ------------[ cut here ]------------ 

[   16.517517] WARNING: at drivers/regulator/core.c:1375 
_regulator_disable+0x58
/0x170() 

[   16.525451] unbalanced disables for dummy 

[   16.529479] Modules linked in: 

[   16.532623] [<c0039628>] (unwind_backtrace+0x0/0xdc) from 
[<c005c864>] (warn_
slowpath_common+0x4c/0x80) 

[   16.542114] [<c005c864>] (warn_slowpath_common+0x4c/0x80) from 
[<c005c8d4>] (
warn_slowpath_fmt+0x28/0x38) 

[   16.551788] [<c005c8d4>] (warn_slowpath_fmt+0x28/0x38) from 
[<c020575c>] (_re
gulator_disable+0x58/0x170) 

[   16.561370] [<c020575c>] (_regulator_disable+0x58/0x170) from 
[<c0205968>] (r
egulator_disable+0x20/0x38) 

[   16.570953] [<c0205968>] (regulator_disable+0x20/0x38) from 
[<c02b2314>] (oma
p_hsmmc_23_set_power+0xb8/0xf4) 

[   16.580902] [<c02b2314>] (omap_hsmmc_23_set_power+0xb8/0xf4) from 
[<c02b1400>
] (omap_hsmmc_set_ios+0x74/0x40c) 

[   16.591003] [<c02b1400>] (omap_hsmmc_set_ios+0x74/0x40c) from 
[<c02a74a8>] (m
mc_power_off+0x4c/0x54) 

[   16.600219] [<c02a74a8>] (mmc_power_off+0x4c/0x54) from [<c02a86a8>] 
(mmc_res
can+0x23c/0x268) 

[   16.608856] [<c02a86a8>] (mmc_rescan+0x23c/0x268) from [<c006c064>] 
(worker_t
hread+0x150/0x1c4) 

[   16.617645] [<c006c064>] (worker_thread+0x150/0x1c4) from 
[<c006f198>] (kthre
ad+0x78/0x80) 

[   16.626007] [<c006f198>] (kthread+0x78/0x80) from [<c00358c0>] 
(kernel_thread
_exit+0x0/0x8) 

[   16.634429] ---[ end trace 72e9bbcb61162c84 ]--- 

