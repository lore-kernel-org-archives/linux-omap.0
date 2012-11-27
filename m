From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Wed, 28 Nov 2012 01:22:29 +0800
Message-ID: <CACVXFVM_hPJcNSWp0qCVpexetDBcKgXZRCzR293KAYtK_fpOOg@mail.gmail.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
	<Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:46437 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab2K0RWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 12:22:31 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>, rogerq@ti.com

On Wed, Nov 28, 2012 at 12:30 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 27 Nov 2012, Ming Lei wrote:
>
>> IMO, all matches mean the devices are inside the ehci-omap bus, so
>> the direct/simple way is to enable/disable the regulators in the probe() and
>> remove() of ehci-omap controller driver.
>
> When this discussion started, Felipe argued against such an approach.
> He pointed out that the same chip could be used in other platforms, and
> then the code added to ehci-omap.c would have to be duplicated in
> several other places.

>From Andy's implementation, the 'general' code is to enable/disable
the regulators(patch 3/5), I am wondering if it is general enough, so the
'duplicated' code are just several lines of regulator_enable/regulator_disable,
which should be implemented in many platform drivers.

Also from my intuition, power domain should be involved in the problem,
because these hard-wired and self-powered USB devices should have
its own power domains, and the ehci-omap driver may enable/disable
these power domains before adding the bus.

>
> We should have a more generic solution in a more central location, like
> the device core.
>
> For example, each struct platform_device could have a list of resources
> to be enabled when the device is bound to a driver and disabled when
> the device is unbound.  Such a list could include regulators, clocks,
> and whatever else people can invent.
>
> In this case, when it is created the ehci-omap.0 platform device could
> get an entry pointing to the LAN95xx's regulator.  Then the regulator
> would automatically be turned on when the platform device is bound to
> the ehci-omap driver.

The LAN95xx's regulator is still platform dependent(even for same LAN95xx
USB devices on different platforms(omap, tegra, ..)) , so I am wondering
why we don't enable it directly in probe() of ehci-omap.0 platform device?


Thanks,
-- 
Ming Lei
