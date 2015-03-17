From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Couple of dmtimer fixes
Date: Tue, 17 Mar 2015 10:45:29 -0700
Message-ID: <20150317174529.GG31346@atomide.com>
References: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38139 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbbCQRuQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 13:50:16 -0400
Content-Disposition: inline
In-Reply-To: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Suman Anna <s-anna@ti.com> [150316 18:14]:
> Hi Tony,
> 
> Please find couple of non-urgent fixes to the OMAP dmtimer driver.
> The patches are based on 4.0-rc1.
> 
> The first patch is a fix for the issue I reported earlier on the
> DRA7 dmtimer hwmod patches [1]. DRA7 has timers 13 through 16 disabled
> in DT currently, and enabling any of them would cause a kernel hang.
> This fix properly checks the pm_runtime_get_sync() calls in the OMAP
> dmtimer driver irrespective of whether the hwmods are added or not.
> In the case that they are not added, the runtime_pm calls should return
> the value as returned from _od_fail_runtime_resume(), and the probe
> should bail out properly fixing the boot hang.
> 
> Second patch is a minor fix that balances the pm_runtime_enable() call
> in probe with pm_runtime_disable() call in remove, so that the devices
> can be bound again properly after doing an unbind through sysfs.

OK thanks applying both into omap-for-v4.0/fixes.

Tony
 
> [1] http://marc.info/?l=linux-omap&m=142653933112526&w=2
> 
> Suman Anna (2):
>   ARM: OMAP: dmtimer: check for pm_runtime_get_sync() failure
>   ARM: OMAP: dmtimer: disable pm runtime on remove
> 
>  arch/arm/plat-omap/dmtimer.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> -- 
> 2.3.2
> 
