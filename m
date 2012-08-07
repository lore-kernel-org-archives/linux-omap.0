From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2+: Fix random config build break with
 !ARM_CPU_SUSPEND
Date: Tue, 7 Aug 2012 00:23:01 -0700
Message-ID: <20120807072300.GM11011@atomide.com>
References: <1342176307-6435-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52095 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab2HGHXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 03:23:04 -0400
Content-Disposition: inline
In-Reply-To: <1342176307-6435-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120713 03:50]:
> The random config builds with PM and !ARM_CPU_SUSPEND breaks with below
> error on omap2plus_defconfig.
> 
> arch/arm/mach-omap2/sleep44xx.S:323: undefined reference to `cpu_resume'
> arch/arm/mach-omap2/omap-mpuss-lowpower.c:278: undefined reference to `cpu_suspend'
> 
> This is because recently merged OMAP5 platform shares the common files
> with OMAP4 but doesn't select ARM_CPU_SUSPEND. Without the ARM_CPU_SUSPEND
> the sleep code is meaningless.
> 
> Fix the same by adding ARM_CPU_SUSPEND for OMAP5. The suggestion came from
> Russell King in an off-list discussion.

Thanks applying into fixes.

Tony
