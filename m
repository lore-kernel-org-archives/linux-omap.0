From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Kill warning in CPUIDLE code with
 !CONFIG_SMP
Date: Fri, 21 Feb 2014 15:17:15 -0800
Message-ID: <20140221231714.GC5342@atomide.com>
References: <1392623575-4884-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24517 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753116AbaBUXRc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Feb 2014 18:17:32 -0500
Content-Disposition: inline
In-Reply-To: <1392623575-4884-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux@arm.linux.org.uk, nm@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Mugunthan V N <mugunthanvnm@ti.com> [140216 23:56]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> for non SMP build, NR_CPUS is 1 and hence the code complains with below
> warnings.
> 
> arch/arm/mach-omap2/cpuidle44xx.c:207:8: warning: array subscript is above array bounds [-Warray-bounds]
> arch/arm/mach-omap2/cpuidle44xx.c:212:11: warning: array subscript is above array bounds [-Warray-bounds]
> 
> Kill it by making array size fixed.
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Thanks applying into omap-for-v3.14/fixes.

Tony
