From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] arm: omap1/2/3/4: convert clocksource to a
 platform_driver
Date: Tue, 6 Apr 2010 09:38:28 +0300
Message-ID: <20100406063828.GP16297@nokia.com>
References: <20100324065442.GB7534@nokia.com>
 <1269588117-17024-1-git-send-email-felipe.balbi@nokia.com>
 <87aathse2b.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58384 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab0DFGjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 02:39:33 -0400
Content-Disposition: inline
In-Reply-To: <87aathse2b.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

On Tue, Apr 06, 2010 at 12:57:16AM +0200, ext Kevin Hilman wrote:
>What' you've created is not a generic clocksource driver but one that
>can only work with the 32k sync timer.

so I achieved my goal, which was to convert *32k-sync timer* into a 
platform_driver.

>If you're going to create a generic driver, it should be generic
>enough to work with any timer source: 32k, timer GP, off-chip RTC,
>etc.  To do this, it would need a generic read function passed in with
>the platform_device.

yeah, I don't really see what you're trying to do. IMO we should just 
register all clocksources to the kernel but it doesn't mean they have to 
all come from the same platform_driver. The driver I wrote is for the 
32k-sync timer, gp timers, mpu-timer they all would have to be 
converted.

I really don't see the point in having all clocksources as one unique 
driver since the kernel is (or should be) smart enough to choose the 
best one for us at runtime.

If you really want one driver that would cope with all clocksources, be 
my guest, but IMO, that's not the way to go.

>It would also need a more generic way of handling clock names and
>frequencies.  Currently the clock rate is hard-coded to 32kHz.
>clk_get_rate() should be used in a generic driver.

but that's what 32k-sync timer uses, right ?

for anything else, then it would need more thinking.

-- 
balbi
