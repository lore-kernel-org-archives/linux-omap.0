From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: do not allow SmartReflex to be built as a
 module
Date: Fri, 29 Jun 2012 06:05:28 -0700
Message-ID: <20120629130527.GG4202@atomide.com>
References: <1340902538-1318-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25919 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab2F2NFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 09:05:33 -0400
Content-Disposition: inline
In-Reply-To: <1340902538-1318-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

* Kevin Hilman <khilman@ti.com> [120628 10:00]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Disable the module option for POWER_AVS since this is currently not
> supported.
> 
> This patch fixes these error in the case POWER_AVS is set to 'm':
> 
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_configure':
> /home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:43: undefined reference to `sr_configure_errgen'
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_disable':
> /home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:33: undefined reference to `sr_disable_errgen'
> /home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:35: undefined reference to `sr_disable'
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_enable':
> /home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:28: undefined reference to `sr_enable'
> arch/arm/mach-omap2/built-in.o: In function `sr_class3_init':
> /home/tmlind/src/linux-2.6/arch/arm/mach-omap2/smartreflex-class3.c:59: undefined reference to `sr_register_class'
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, this one fixes the SR related build errors you saw with
> randconfig.  It applies to my for_3.6/pm/sr-move branch which is now
> included in your devel-driver.  Let me know if want me to fold this
> into the original and re-spin the branch.
> 
> Also, special thanks to Jean for fixing this immediatly after it 
> was reported!

Thanks applying into devel-driver branch.

Tony
