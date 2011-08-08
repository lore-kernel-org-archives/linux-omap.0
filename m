From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 kernels fail to build
Date: Mon, 08 Aug 2011 16:39:32 +0530
Message-ID: <4E3FC3EC.2010909@ti.com>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41392 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752402Ab1HHLJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 07:09:41 -0400
Received: by mail-gx0-f172.google.com with SMTP id 19so617504gxk.3
        for <linux-omap@vger.kernel.org>; Mon, 08 Aug 2011 04:09:39 -0700 (PDT)
In-Reply-To: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

+ Felipe,

On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
>
> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
>
I thought below patch was suppose to fix it.
https://patchwork.kernel.org/patch/963462/


Regards
Santosh
