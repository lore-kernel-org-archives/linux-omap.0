From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 11:41:31 +0800
Message-ID: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
References: <20121126192206.GB11239@kroah.com>
	<Pine.LNX.4.44L0.1211261555400.2168-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40661 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933147Ab2K0Dlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 22:41:32 -0500
In-Reply-To: <Pine.LNX.4.44L0.1211261555400.2168-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

On Tue, Nov 27, 2012 at 5:07 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 26 Nov 2012, Greg KH wrote:
>
>> Ah, here's the root of your problem, right?  You need a way for your
>> hardware to tell the kernel that you have a regulator attached to a
>> specific device?  Using the device path and hard-coding it into the
>> kernel is not the proper way to solve this, sorry.  Use some other
>> unique way to describe the hardware, surely the hardware designers
>> couldn't have been that foolish not to provide this [1]?
>
> As far as I know, the kernel has no other way to describe devices.
>
> What about using partial matches?  In this example, instead of doing a
> wildcard match against
>
>         /platform/usbhs_omap/ehci-omap.0/usb*

IMO, all matches mean the devices are inside the ehci-omap bus, so
the direct/simple way is to enable/disable the regulators in the probe() and
remove() of ehci-omap controller driver.

On the other side, both the two LAN95xx USB devices(hub + ethernet) are
simple self-powered device. Just like other self-powered devices, the power
should be provided from external world, instead of hub driver itself. And it is
doable to power on the devices before creating the specific ehci-omap usb
bus inside ehci-omap driver.

Thanks,
-- 
Ming Lei
