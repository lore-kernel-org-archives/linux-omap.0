From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: drm/omap: move where DMM driver is registered
Date: Thu, 5 Apr 2012 12:44:56 -0500
Message-ID: <CAF6AEGuo1DQnSG8JBTCW0v6kscAETxZDFEdND3RCC1mrsx7haQ@mail.gmail.com>
References: <1333640096-24142-1-git-send-email-rob.clark@linaro.org>
	<20120405164112.GB16546@kroah.com>
	<CAF6AEGv7pUht3VkGqobCJd4+KPx2NUoju5++eRUpToAg1ZxPeg@mail.gmail.com>
	<20120405165843.GA17004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33447 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2DERo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 13:44:56 -0400
Received: by yenl12 with SMTP id l12so858282yen.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 10:44:56 -0700 (PDT)
In-Reply-To: <20120405165843.GA17004@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, dri-devel@lists.freedesktop.org

On Thu, Apr 5, 2012 at 11:58 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, Apr 05, 2012 at 11:51:30AM -0500, Rob Clark wrote:
>> On Thu, Apr 5, 2012 at 11:41 AM, Greg KH <greg@kroah.com> wrote:
>> > On Thu, Apr 05, 2012 at 10:34:56AM -0500, Rob Clark wrote:
>> >> From: Rob Clark <rob@ti.com>
>> >>
>> >> Not sure what triggered the change in behavior, but seems to
>> >> result in recursively acquiring a mutex and hanging on boot. =A0B=
ut
>> >> omap_drm_init() seems a much more sane place to register the
>> >> driver for the DMM sub-device.
>> >> ---
>> >> =A0drivers/staging/omapdrm/omap_drv.c | =A0 =A07 ++++---
>> >> =A01 files changed, 4 insertions(+), 3 deletions(-)
>> >
>> > Is this needed for 3.4-final? =A0Any older kernels like 3.3 as wel=
l?
>>
>> Yeah, it is needed for 3.4-final.. =A0I need to check on 3.3 (it was
>> fine circa 3.3-rc6 or rc7)
>
> Ok, I'll queue it up for 3.4-final, let me know if it's also needed i=
n
> 3.3 if you get the chance.
>

oh, duh.. I realized that patch that split DMM into a sub-device (for
hwmod) was actually part of the patches for 3.4, so the problem didn't
exist yet in 3.3 :-)

BR,
-R


> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
