From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Date: Sat, 03 Sep 2011 22:06:38 +0530
Message-ID: <4E625796.1020109@ti.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:57537 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134Ab1ICQgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Sep 2011 12:36:44 -0400
Received: by gxk7 with SMTP id 7so3302511gxk.21
        for <linux-omap@vger.kernel.org>; Sat, 03 Sep 2011 09:36:43 -0700 (PDT)
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 01 September 2011 06:17 PM, Russell King - ARM Linux wrote:
> Some systems (such as OMAP) preserve the L2 cache across a suspend/
> resume cycle.  This means they do not perform L2 cache maintanence
> in their suspend finisher function.
>
> However, the side effect is that the saved CPU state is not readable
> by the resume code because it is sitting in the L2 cache.
>
> This patch series adds L2 cache cleaning to the generic CPU suspend/
> resume support code, making it possible to use this on systems with
> L2 cache enabled without having to clean/invalidate the entire L2
> cache.
>
> We also add a separate page table, allocated at boot time, for the
> resume process to use so we don't have to fiddle about with tweaking
> entries in the current processes page table.  Moreover, the current
> processes page table may be in use by another CPU in the system if
> these paths are used from cpuidle or hotplug, so changing the page
> table is technically unsound.
>
> Overall, this makes it possible for OMAP4 systems to use this code.
>
> The first four patches in this set are already merged into Linus' tree
> as bug fixes, and are included here for completeness given that the
> kernel.org infrastructure is currently offline.
>
> This has (so far) only been tested on OMAP4.  Further testing on OMAP3
> and Assabet will follow.

Thanks a lot Russell for this series. I have tested the entire series
with OMAP4 S2R and CPUIDLE and it works great.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh

