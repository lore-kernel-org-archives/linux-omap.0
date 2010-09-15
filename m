From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 2/2] OMAP: omap_device: make all devices a child of a new parent device
Date: Wed, 15 Sep 2010 16:04:34 -0700
Message-ID: <87y6b2bocd.fsf@deeprootsystems.com>
References: <1284489714-14705-1-git-send-email-khilman@deeprootsystems.com>
	<1284489714-14705-2-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1009151638190.458@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48188 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0IOXEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:04:40 -0400
Received: by yxp4 with SMTP id 4so231585yxp.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 16:04:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009151638190.458@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 15 Sep 2010 17:02:04 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> On Tue, 14 Sep 2010, Kevin Hilman wrote:
>
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> In order to help differentiate omap_devices from normal
>> platform_devices, make them all a parent of a new common parent
>> device.
>> 
>> Then, in order to determine if a platform_device is also an
>> omap_device, checking the parent is all that is needed.
>> 
>> Users of this feature are the runtime PM core for OMAP, where we need
>> to know if a device being passed in is an omap_device or not in order
>> to know whether to call the omap_device API with it.
>> 
>> In addition, all omap_devices will now show up under /sys/devices/omap
>> instead of /sys/devices/platform
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> At least with the current state of the Linux kernel codebase, I think it 
> would be better to have an omap_bus/omap_bus_type.  But as we've 
> discussed, that is a lot of work, and this solution seems to solve the 
> immediate problem -- how to determine if a device is really an omap_device 
> -- while being minimally invasive to the rest of the kernel code and 
> device model.  So, looks good to me for now,
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
> and feel free to merge this and patch 1/2 through your tree...
>

OK, will do.

Thanks,

Kevin
