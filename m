From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Suspend broken on 3.3?
Date: Tue, 27 Mar 2012 15:39:12 +0100
Message-ID: <WC20120327143912.161659@terrafix.co.uk>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com> <WC20120326134115.9815DF@terrafix.co.uk> <87haxaq3ua.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:54228 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751275Ab2C0Oj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 10:39:29 -0400
In-Reply-To: <87haxaq3ua.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, govindraj.raja@ti.com, Felipe Balbi <balbi@ti.com>

...snip...

> Just to confirm: did the above work for you before v3.3?
> 

I've checked and v3.2 works correctly:

echo "enabled" > /sys/devices/platform/omap/omap_uart.2/power/wakeup => device wakes from console presses
echo "disabled" > /sys/devices/platform/omap/omap_uart.2/power/wakeup => device does not wake from console presses

Thanks for looking in to this!

Cheers,
Joe 

> > Could you test if this is also the case your end?
> 
> Yes, I get the same behavior, which is indeed broken.
> 
> Govindraj, can you look into this?
> 
> A quick glance suggests that disabling wakeups via the sysfs file is
> only disabling runtime PM, but not actually disabling wakups at the
> module-level or at the IO ring.
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


