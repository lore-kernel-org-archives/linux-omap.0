From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Wed, 9 Mar 2011 13:42:15 -0800
Message-ID: <20110309214215.GQ26463@atomide.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20761 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1CIVmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 16:42:20 -0500
Content-Disposition: inline
In-Reply-To: <1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framework
> is not completely up and running.
> +	 common.o gpio.o dma.o wd_timer.o dmtimer.o

> new file mode 100755
> index 0000000..60c410b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimer.c

Uhh please check the mode changes for this series..

> new file mode 100755
> index 0000000..4cfd580
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimer.h

Here too and maybe other places also.

Tony
