From: linux@johnea.net
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Fri, 28 Sep 2012 12:46:04 -0700
Message-ID: <5065FE7C.9070503@johnea.net>
References: <50648AA2.2010004@johnea.net> <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com> <5064A173.5000909@johnea.net> <CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com> <CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com> <5064B41D.9030709@johnea.net> <CAOCHtYjjczpQ0oJ4zgrExdF7C-OAsfzMLwAEfdExkFG2uiUKgw@mail.gmail.com> <5065F13E.8070306@johnea.net> <CAOCHtYg3zrqO+3Rk6P8K7iit7uO9g4_YHQ870TXbmuEPZEyQ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:45940 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030371Ab2I1TqF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 15:46:05 -0400
Received: from [192.168.1.143] (wsip-70-166-88-164.sd.sd.cox.net [70.166.88.164])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id 4514173F188B
	for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 12:46:05 -0700 (PDT)
In-Reply-To: <CAOCHtYg3zrqO+3Rk6P8K7iit7uO9g4_YHQ870TXbmuEPZEyQ0Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 09/28/2012 12:18 PM, Robert Nelson wrote:
> Ah, so looking at the config, ARCH switched to omapdrm... It kinda
> works in v3.5.x, but i'd wait till a few more releases...
>
> So, based on that config, they have both "CONFIG_FB_OMAP2" and
> "CONFIG_DRM_OMAP" enabled.. That's a no-no...
>
> CONFIG_DRM_OMAP
> http://cateee.net/lkddb/web-lkddb/DRM_OMAP.html
> depends on: ( CONFIG_DRM&&  ! CONFIG_CONFIG_FB_OMAP2 )&&  (
> CONFIG_ARCH_OMAP2PLUS )
>
> Option 1: Stay with omapfb
>
> CONFIG_FB_OMAP2=m ->  CONFIG_FB_OMAP2=y
> disable: CONFIG_DRM_OMAP
>
> Option 2: Go Experimental route with omapdrm
>
> CONFIG_DRM_OMAP=m
> CONFIG_DRM_OMAP_NUM_CRTCS=1
>
> disable: CONFIG_FB_OMAP2
>
>> >  Attached are config.gz from running system and gz'd complete dmesg output
>> >  (hope attachments are OK on the list).
>> >
>> >  There's another 3.5.4 build scheduled on the panda build farm this
>> >  afternoon. If you have any config modification suggestions, they'd be very
>> >  gratefully received.
> Also, if your running that config on pre-es (omap4430) panda's..
> CONFIG_OMAP4_ERRATA_I688=y&   CONFIG_ARCH_HAS_BARRIERS=y
>
> and save your self some debugging time...;)
>
> Regards,
>
> -- Robert Nelson http://www.rcn-ee.com/

Thanks Robert!

I passed along to the distro devs to include in today's build.

I'll follow up once I'm running the new version...

johnea
