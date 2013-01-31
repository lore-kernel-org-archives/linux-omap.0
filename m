From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: OMAP2+: Get rid of custom OMAP_32K_TIMER_HZ
Date: Thu, 31 Jan 2013 16:37:28 +0100
Message-ID: <1524396.4DaQLsSWOZ@wuerfel>
References: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59605 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3AaPhq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 10:37:46 -0500
In-Reply-To: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, John Stultz <john.stultz@linaro.org>, linux-omap@vger.kernel.org

On Thursday 31 January 2013 21:02:00 Santosh Shilimkar wrote:
> The timekeeping doesn't depend on HZ value in presence of fine grained
> clocksource and hence there should not be any time drift because of HZ
> value which was chosen to be divisor of 32768.
> 
> OMAP has been using HZ = 128 value to avoid any time drift issues
> because of 32768 HZ clock. But with various measurements performed
> with HZ = 100, no time drift is observed and it also proves the
> point about HZ not having impact on time keeping on OMAP.
> 
> Very informative thread on this topic is here:
>         https://lkml.org/lkml/2013/1/29/435
> 
> Special thanks to John Stulz, Arnd Bergmann and Russell King for their
> valuable suggestions.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks so much for looking into this!
