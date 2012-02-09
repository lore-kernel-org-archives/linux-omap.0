From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Wed, 08 Feb 2012 16:03:24 -0800
Message-ID: <87zkcsx48j.fsf@ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
	<20120208135329.GJ16334@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:38339 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757210Ab2BIAD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:03:27 -0500
Received: by pbbrp2 with SMTP id rp2so897119pbb.24
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 16:03:26 -0800 (PST)
In-Reply-To: <20120208135329.GJ16334@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Wed, 8 Feb 2012 15:53:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linus.walleij@stericsson.com, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, tarun.kanti@ti.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Wed, Feb 08, 2012 at 03:26:54PM +0200, Felipe Balbi wrote:
>> try to keep gpio block suspended as much as possible.
>> 
>> Tested with pandaboard and a sysfs exported gpio.
>> 
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>> 
>> I couldn't see any issues with this patch. I managed to export
>> a gpio and change the direction with a while true loop with
>> no issues whatsoever.
>
> btw, I also played with gpios 7 and 8 because they have LEDs on them on
> pandaboard and everything seems to be fine.
>
> I just want to be sure I can still go to OFF mode and wakeup, but on
> vanilla 3.3-rc2 after echo mem > /sys/power/state the systems freezes on
> panda, so I can't go any further.

I don't think it's frozen.  I suspected it's suspended without any
wakeups enabled.  You probably haven't enabled UART wakeups.  Try
enabling them like this:

  echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup
 
before going into suspend.

Kevin
