From: Ash Charles <ashcharles@gmail.com>
Subject: Re: DT support for OMAP3 ISP
Date: Tue, 27 Jan 2015 09:00:31 -0800
Message-ID: <CAK8F28mWoUQieZzoxodaEEJAutFAW12zRP=Xe+2zs6jV_exw5A@mail.gmail.com>
References: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
 <20150106214218.GZ4081@atomide.com> <20150106221107.GV17565@valkosipuli.retiisi.org.uk>
 <CAK8F28=farAB0AMqN8iR9ZW5yyYVCD_5bdWfX=Xmpkca2_EfbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:37646 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbbA0RBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 12:01:03 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so15925952wgg.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2015 09:01:02 -0800 (PST)
In-Reply-To: <CAK8F28=farAB0AMqN8iR9ZW5yyYVCD_5bdWfX=Xmpkca2_EfbA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

For what it is worth, I was able to get a MT9V032 camera  (caspa)
working with an OMAP3 using the suggested linux-media branch with
these two patches [1,2].  Thanks for the help :)

--Ash
[1] http://gumstix-misc.s3.amazonaws.com/patches/0001-First-cut-at-caspa-support-with-devicetree.patch
[2] http://gumstix-misc.s3.amazonaws.com/patches/0002-Pulling-in.patch

On Tue, Jan 6, 2015 at 6:41 PM, Ash Charles <ashcharles@gmail.com> wrote:
> Thanks for the hints.
>
> I tried the suggested branch adding omap3isp data to the Overo device
> tree and device tree bindings for the mt9v032 device.  I needed to
> manually modprobe omap3-isp but the camera was registered and I was
> able to use media-ctl to manipulate the v4l2 pipeline.  I wasn't able
> to stream as v4l2 was reporting "inappropriate ioctl"----old driver
> perhaps?
>
> I also tried changing the #define HIST_CONFIG_DMA 0 such that the
> histogram block uses PIO instead of using the deprecated
> omap_request_dma.  I saw basically the same behaviour.  What would be
> the correct/modern way to use DMA here?
>
> --Ash
>
> On Tue, Jan 6, 2015 at 2:11 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>> (Fixed Laurent's e-mail.)
>>
>> Moikka,
>>
>> On Tue, Jan 06, 2015 at 01:42:18PM -0800, Tony Lindgren wrote:
>>> * Ash Charles <ashcharles@gmail.com> [150106 12:45]:
>>> > Hi,
>>> >
>>> > I'm playing with the Caspa camera (mt9v032) and Overo on the 3.17
>>> > kernel.  It looks like there has been some work on dt-bindings for the
>>> > omap3isp (notably [1] and [2]) but I didn't see anything heading for
>>> > mainline.
>>> >
>>> > What would be needed to support cameras using the omap3isp in a mainline kernel?
>>>
>>> No idea about the camera, but at least the legacy omap DMA calls need
>>> to be replaced or removed as the legacy DMA API will go away soon.
>>
>> OMAP DMA is only used by the histogram block which can cope with PIO as well
>> --- I think there at least was a #define for it. That's not a reason not to
>> convert it however, it's just not as urgent it otherwise might be. I wonder
>> if someone has patches for that already.
>>
>> Cc Laurent.
>>
>> --
>> Terveisin,
>>
>> Sakari Ailus
>> e-mail: sakari.ailus@iki.fi     XMPP: sailus@retiisi.org.uk
