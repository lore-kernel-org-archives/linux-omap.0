From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix the OMAP2 only build break seen with
 2011+ ARM tool-chains
Date: Tue, 7 Feb 2012 21:33:43 -0800
Message-ID: <20120208053343.GA1426@atomide.com>
References: <1328523587-21341-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38098 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2BHFdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 00:33:46 -0500
Content-Disposition: inline
In-Reply-To: <1328523587-21341-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120206 01:48]:
> With the latest Sourcery G++ Lite 2011.03-41 and latest linaro
> tool-chains OMAP2 only build breaks with below error.
> 
> arch/arm/mach-omap2/omap-smc.S: Assembler messages:
> arch/arm/mach-omap2/omap-smc.S:30: Error: selected processor does not support ARM mode `smc #0'
> arch/arm/mach-omap2/omap-smc.S:53: Error: selected processor does not support ARM mode `smc #0'
> arch/arm/mach-omap2/omap-smc.S:61: Error: selected processor does not support ARM mode `smc #0'
> arch/arm/mach-omap2/omap-smc.S:69: Error: selected processor does not support ARM mode `smc #0'
> arch/arm/mach-omap2/omap-smc.S:77: Error: selected processor does not support ARM mode `smc #0'
> make[1]: *** [arch/arm/mach-omap2/omap-smc.o] Error 1
> 
> OMAP2 devices doesn't have the security support but the security support
> was getting built because of OMAP2PLUS. Don't build security code for
> OMAP2 devices.
> 
> While at it, fix the secure-common line in the Makefile to use tabs
> instead of spaces.
> 
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, applying into fixes.

Regards,

Tony
