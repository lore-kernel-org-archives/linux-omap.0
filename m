From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Wed, 15 Sep 2010 13:15:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48805 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab0IOTPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 15:15:13 -0400
In-Reply-To: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com, tony@atomide.com

Hi Jon,

I regret the delay:

On Wed, 21 Jul 2010, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> When changing the L3 clock frequency, the CPU is executing from internal RAM
> and the SDRC clock is disabled. During this time accesses made to external
> DDR are stalled. If the ARM subsystem attempts to access the DDR while the
> SDRC clock is disabled this will stall the CPU until the access to the SDRC
> timeouts. A timeout on the SDRC should never occur. Once a timeout occurs all
> the following accesses will be aborted and the DDR is no longer accessible.
> 
> Although the code being executed in the internal RAM does not directly access
> the DDR, it was found that the branch prediction logic in the CPU may cause
> the CPU to prefetch code from a DDR location while the SDRC clock is disabled.
> This was causing an SDRC timeout which resulted in a system hang.
> 
> This patch fixes this problem by ensuring the branch prediction logic is
> disabled while changing the L3 clock frequency. The branch prediction logic
> is disabled by clearing the Z-bit in the ARM AUX CTRL register.
> 
> Disabling the branch prediction logic does not have any noticable impact
> on the execution time of this code section. The hardware observability
> signals were used to monitor the sdrc idle time with and without this
> patch when operating at different CPU frequencies (150MHz, 500MHz and
> 600MHz) and the total sdrc idle time when changing frequenct was in
> the range of 9-11us. This was measured on an omap3430 SDP running the
> omapzoom p-android-omap-2.6.29 branch.
> 
> This change has been commited to both TI's android 2.6.29 and 2.6.32 kernels.
> The commits can be viewed here:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=5679c7b1142f3cc2b9285181d53f6b40c4d0296d
> http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=cf16e57823575d98e9d5165aa7a498ffb751c940
> 
> This patch has been rebased on the latest linux-omap tree and tested on
> Kevin Hilman's pm branch.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Really nice changelog.  I wish every patch had a description this good.  
Patch looks really good, too.  Queued for 2.6.37.


- Paul
