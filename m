From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 11:30:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42959 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755861Ab2K0QaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 11:30:13 -0500
In-Reply-To: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>, Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, USB list <linux-usb@vger.kernel.org>, rogerq@ti.com

On Tue, 27 Nov 2012, Ming Lei wrote:

> IMO, all matches mean the devices are inside the ehci-omap bus, so
> the direct/simple way is to enable/disable the regulators in the probe() and
> remove() of ehci-omap controller driver.

When this discussion started, Felipe argued against such an approach.  
He pointed out that the same chip could be used in other platforms, and
then the code added to ehci-omap.c would have to be duplicated in
several other places.

We should have a more generic solution in a more central location, like 
the device core.

For example, each struct platform_device could have a list of resources
to be enabled when the device is bound to a driver and disabled when
the device is unbound.  Such a list could include regulators, clocks,
and whatever else people can invent.

In this case, when it is created the ehci-omap.0 platform device could
get an entry pointing to the LAN95xx's regulator.  Then the regulator 
would automatically be turned on when the platform device is bound to 
the ehci-omap driver.

How does this sound?

Alan Stern

