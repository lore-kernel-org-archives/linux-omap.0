From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: PM: build sleep/suspend code for idle path also
	(not only suspend)
Date: Fri, 7 Oct 2011 23:39:22 +0100
Message-ID: <20111007223922.GC26805@n2100.arm.linux.org.uk>
References: <1318026686-20191-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44930 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab1JGWji (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 18:39:38 -0400
Content-Disposition: inline
In-Reply-To: <1318026686-20191-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, Oct 07, 2011 at 03:31:26PM -0700, Kevin Hilman wrote:
> Some platforms (e.g. OMAP) use the same common cpu_suspend/cpu_resume
> helpers during idle as well as suspend.
> 
> Currently, if suspend is disabled (CONFIG_PM_SLEEP=n) and the platform
> idle code is using the common cpu_suspend/cpu_resume functions, the
> kernel will not link.
> 
> Since platform code commonly uses CONFIG_PM=y to build it's idle code,
> build the common sleep/suspend code based on CONFIG_PM instead of
> CONFIG_PM_SLEEP.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies on Russell's devel-stable branch, where the new common
> suspend/resume code is queued.

See:

commit 15e0d9e37c7fe9711b60f47221c394d45553ad8c
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Oct 1 21:09:39 2011 +0200

    ARM: pm: let platforms select cpu_suspend support

    Support for the cpu_suspend functions is only built-in
    when CONFIG_PM_SLEEP is enabled, but omap3/4, exynos4
    and pxa always call cpu_suspend when CONFIG_PM is enabled.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

