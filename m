From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri, 11 Feb 2011 15:31:20 -0800
Message-ID: <87pqqy6tdj.fsf@ti.com>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50484 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756892Ab1BKXbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 18:31:25 -0500
Received: by gyh4 with SMTP id 4so1701699gyh.23
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 15:31:23 -0800 (PST)
In-Reply-To: <1297263683-10621-1-git-send-email-dave.martin@linaro.org> (Dave
	Martin's message of "Wed, 9 Feb 2011 15:01:18 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

Hi Dave,

Dave Martin <dave.martin@linaro.org> writes:

> This set of patches, along with some other patches under
> discussion on alkml, should enable omap3 and omap4 kernels to be
> built with CONFIG_THUMB2_KERNEL.

OK, I tried some more testing with your 'dirty' branch merged with my PM
branch.

Compiled in ARM mode, everything worked as expected on my 3530/omap3evm,
including off-mode (in suspend and idle).  My 3630 (Zoom3) also can't do
CORE off due to i583, but MPU, PER etc. all can hit off.

To rebuild in Thumb-2 mode, I disabled OMAP2 support and added Thumb-2
mode:

   CONFIG_ARCH_OMAP2=n
   CONFIG_THUMB2_KERNEL=y

then tested on 3530/omap3evm.  Testing suspend/resume to retention
seemed to work fine.  However, enabling retention during idle[1] hung
someplace (didn't debug further.)

I also tried off-mode, and suspend/resume to off didn't even work.

I didn't have time to debug this any further, so this is just to report
raw test results.

Hope that helps,

Kevin


[1] Here's what's needed to attempt low-power states during idle

# UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout 
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout 
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout 
echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout 

# enable low-power states during idle
echo 1 > /debug/pm_debug/sleep_while_idle  


[2] to enable off-mode

echo 1 > /debug/pm_debug/enable_off_mode
