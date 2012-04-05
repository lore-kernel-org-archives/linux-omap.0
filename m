From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: drm/omap: move where DMM driver is registered
Date: Thu, 5 Apr 2012 11:51:30 -0500
Message-ID: <CAF6AEGv7pUht3VkGqobCJd4+KPx2NUoju5++eRUpToAg1ZxPeg@mail.gmail.com>
References: <1333640096-24142-1-git-send-email-rob.clark@linaro.org>
	<20120405164112.GB16546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42161 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2DEQ4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 12:56:51 -0400
Received: by gghe5 with SMTP id e5so815581ggh.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 09:56:50 -0700 (PDT)
In-Reply-To: <20120405164112.GB16546@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, dri-devel@lists.freedesktop.org

On Thu, Apr 5, 2012 at 11:41 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, Apr 05, 2012 at 10:34:56AM -0500, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> Not sure what triggered the change in behavior, but seems to
>> result in recursively acquiring a mutex and hanging on boot. =A0But
>> omap_drm_init() seems a much more sane place to register the
>> driver for the DMM sub-device.
>> ---
>> =A0drivers/staging/omapdrm/omap_drv.c | =A0 =A07 ++++---
>> =A01 files changed, 4 insertions(+), 3 deletions(-)
>
> Is this needed for 3.4-final? =A0Any older kernels like 3.3 as well?

Yeah, it is needed for 3.4-final..  I need to check on 3.3 (it was
fine circa 3.3-rc6 or rc7)

BR,
-R

>
> thanks,
>
> greg k-h
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
