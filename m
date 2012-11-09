From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 14/26] ARM: OMAP3: clock: Add 3xxx data using common
 struct clk
Date: Fri, 9 Nov 2012 00:11:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211090002380.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com> <1352337181-29427-15-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com> <alpine.DEB.2.00.1211082158310.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55326 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab2KIALN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 19:11:13 -0500
In-Reply-To: <alpine.DEB.2.00.1211082158310.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, 8 Nov 2012, Paul Walmsley wrote:

> On Thu, 8 Nov 2012, Paul Walmsley wrote:
> 
> > Am seeing warnings during the disable-unused-clocks phase of the boot on 
> > the OMAP3 test boards here.
> 
> Similar problems during system suspend on 3530ES3 Beagle.  Not sure
> what's causing these yet.  At this point the clockdomain usecounts
> should be accurate.

Here's a redacted debugging log for these cases.  The suspend events start 
around the 30 second mark.

One observation is that dpll4_m5x2_ck and dpll4_m6x2_ck are never enabled.  
The tracebacks occur when something in the suspend path tries to disable 
those clocks.


- Paul

[    0.135528] enabling clkdm dpll4_clkdm during enable of clk dpll4_ck
[    0.135559] clockdomain: dpll4_clkdm: enabled
[    0.135589] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.135681] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[    0.135681] disabling clkdm dpll4_clkdm during disable of clk dpll4_ck
[    0.135711] clockdomain: dpll4_clkdm: disabled
[    0.135772] enabling clkdm dpll4_clkdm during enable of clk dpll4_ck
[    0.135803] clockdomain: dpll4_clkdm: enabled
[    0.135833] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.135894] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[    0.135925] disabling clkdm dpll4_clkdm during disable of clk dpll4_ck
[    0.135955] clockdomain: dpll4_clkdm: disabled
[    0.135986] enabling clkdm dpll4_clkdm during enable of clk dpll4_ck
[    0.136016] clockdomain: dpll4_clkdm: enabled
[    0.136047] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.136138] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[    0.136169] disabling clkdm dpll4_clkdm during disable of clk dpll4_ck
[    0.136169] clockdomain: dpll4_clkdm: disabled
[    0.136260] enabling clkdm dpll4_clkdm during enable of clk dpll4_ck
[    0.136291] clockdomain: dpll4_clkdm: enabled
[    0.136322] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[    0.140594] enabling clkdm dpll4_clkdm during enable of clk dpll4_m4x2_ck
[    0.140686] enabling clkdm dpll4_clkdm during enable of clk dpll4_m3x2_ck
[    0.140838] disabling clkdm dpll4_clkdm during disable of clk dpll4_m3x2_ck
[    0.140930] disabling clkdm dpll4_clkdm during disable of clk dpll4_m4x2_ck
[    0.141479] enabling clkdm dpll4_clkdm during enable of clk dpll4_m4x2_ck
[    0.141571] disabling clkdm dpll4_clkdm during disable of clk dpll4_m4x2_ck
[    0.141601] enabling clkdm dpll4_clkdm during enable of clk dpll4_m4x2_ck
[    0.141662] disabling clkdm dpll4_clkdm during disable of clk dpll4_m4x2_ck
[    0.141693] enabling clkdm dpll4_clkdm during enable of clk dpll4_m4x2_ck
[    0.141784] disabling clkdm dpll4_clkdm during disable of clk dpll4_m4x2_ck
[    0.141815] enabling clkdm dpll4_clkdm during enable of clk dpll4_m3x2_ck
[    0.141876] disabling clkdm dpll4_clkdm during disable of clk dpll4_m3x2_ck
[    3.399200] disabling clkdm dpll4_clkdm during disable of clk dpll4_m6x2_ck
[    3.417694] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[    3.445251] ---[ end trace 72e2d7bdcf98ea8b ]---
[    3.450134] disabling clkdm dpll4_clkdm during disable of clk dpll4_m5x2_ck
[    3.453918] clockdomain: dpll4_clkdm: disabled
[    3.477569] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[    3.505096] ---[ end trace 72e2d7bdcf98ea8c ]---
[    3.531280] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[    3.558807] ---[ end trace 72e2d7bdcf98ea8d ]---
[   38.999145] disabling clkdm dpll4_clkdm during disable of clk dpll4_m2x2_ck
[   38.999267] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[   38.999816] ---[ end trace 72e2d7bdcf98ea8e ]---
[   38.999816] disabling clkdm dpll4_clkdm during disable of clk dpll4_ck
[   38.999908] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[   39.000366] ---[ end trace 72e2d7bdcf98ea8f ]---
[   42.169647] enabling clkdm dpll4_clkdm during enable of clk dpll4_ck
[   42.169647] clockdomain: dpll4_clkdm: enabled
[   42.169677] enabling clkdm dpll4_clkdm during enable of clk dpll4_m2x2_ck
[   45.730346] [<c001c1cc>] (unwind_backtrace+0x0/0xf0) from [<c0043680>] (warn_slowpath_common+0x4c/0x64)
[   45.795654] ---[ end trace 72e2d7bdcf98ea90 ]---
