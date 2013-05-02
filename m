From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 14:02:45 +0800
Message-ID: <20130502060242.GA3616@S2101-09.ap.freescale.net>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201304301304.20650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:5737
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226Ab3EBGCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 May 2013 02:02:53 -0400
Content-Disposition: inline
In-Reply-To: <201304301304.20650.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Tue, Apr 30, 2013 at 01:04:20PM +0200, Arnd Bergmann wrote:
> >arch/arm/mach-imx/hotplug.c: In function 'imx_cpu_die':
> >arch/arm/mach-imx/hotplug.c:53:2: error: implicit declaration of function 'cpu_do_idle'
> >arch/arm/mach-imx/hotplug.c: In function 'imx_cpu_kill':
> >arch/arm/mach-imx/hotplug.c:58:26: error: 'jiffies' undeclared (first use in this function)
> >arch/arm/mach-imx/hotplug.c:58:2: error: implicit declaration of function 'msecs_to_jiffies'
> >arch/arm/mach-imx/hotplug.c:61:3: error: implicit declaration of function 'time_after'

...

> >In file included from arch/arm/mach-imx/hotplug.c:16:0:
> >arch/arm/mach-imx/common.h:100:29: warning: 'struct pt_regs' declared inside parameter list
> >arch/arm/mach-imx/common.h:100:29: warning: its scope is only this definition or declaration, which is probably not what you want
> >arch/arm/mach-imx/common.h:101:29: warning: 'struct pt_regs' declared inside parameter list

I just send a patch [1] to fix these.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg241316.html

