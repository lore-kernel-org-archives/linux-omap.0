From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Warnings: pm branch
Date: Tue, 11 Aug 2009 20:25:17 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5989815@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42016 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035AbZHKOzd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 10:55:33 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>


Has anyone send these warning logs on the pm branch on kevin's tree [1] 
This seems to be some issue in CpuIdle path with interrupts? 


<4>WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x60/0x88()
WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x60/0x88()
<d>Modules linked in:Modules linked in:
[<c0031344>] [<c0031344>] (unwind_backtrace+0x0/0xdc) (unwind_backtrace+0x0/0xdc
) from [<c0057a08>] from [<c0057a08>] (warn_slowpath_common+0x48/0x60)
(warn_slowpath_common+0x48/0x60)
[<c0057a08>] [<c0057a08>] (warn_slowpath_common+0x48/0x60) (warn_slowpath_common
+0x48/0x60) from [<c002d204>] from [<c002d204>] (cpu_idle+0x60/0x88)
(cpu_idle+0x60/0x88)
[<c002d204>] [<c002d204>] (cpu_idle+0x60/0x88) (cpu_idle+0x60/0x88) from [<c0008
a70>] from [<c0008a70>] (start_kernel+0x234/0x28c)
(start_kernel+0x234/0x28c)
[<c0008a70>] [<c0008a70>] (start_kernel+0x234/0x28c) (start_kernel+0x234/0x28c)
from [<80008034>] from [<80008034>] (0x80008034)
(0x80008034)

Regards,
Vikram 

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary

