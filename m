From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
Date: Tue, 4 Oct 2011 23:36:42 +0200
Message-ID: <4E8B7C6A.2050207@ti.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42890 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab1JDVgw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 17:36:52 -0400
In-Reply-To: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tarun,

On 10/4/2011 11:20 PM, Cousson, Benoit wrote:
> Hi Tony,
>
> Here is the series to fix the warning and remove the redundant
> latency structure that be removed since the timer runtime PM
> adaptation was just pulled.
>
> I was just able to test that on OMAP4.

It will be nice if you can test that on the other platforms.
In theory, if they are properly using hwmod that should work fine.

Thanks,
Benoit

>
> Patches are based on Kevin's for_3.2/omap_device-2 branch
> and are available here:
> git://gitorious.org/omap-pm/linux.git for_3.2/timer_fixes
>
> Regards,
> Benoit
>
>
> Benoit Cousson (2):
>    ARM: OMAP2+: clock data: Remove redundant timer clkdev
>    ARM: OMAP2+: timer: Remove omap_device_pm_latency
>
>   arch/arm/mach-omap2/clock2420_data.c |   12 ------------
>   arch/arm/mach-omap2/clock2430_data.c |   12 ------------
>   arch/arm/mach-omap2/clock3xxx_data.c |   12 ------------
>   arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
>   arch/arm/mach-omap2/timer.c          |   12 +-----------
>   5 files changed, 1 insertions(+), 58 deletions(-)
>

