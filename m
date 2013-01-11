From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RFC 0/4] TI LCDC DRM driver
Date: Thu, 10 Jan 2013 21:15:26 -0600
Message-ID: <CAF6AEGu4KJ27R6P7CiewVYSP22ZX+2=s6ZeNJv+Voh06gntBzg@mail.gmail.com>
References: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
	<CAPM=9tzZiQuVNdNhm9=iNWqAwk+uZRh0_YC3QLkyZbne5dfeyg@mail.gmail.com>
	<1782274.DIo8UG5duX@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:50002 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3AKDP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 22:15:27 -0500
Received: by mail-vc0-f176.google.com with SMTP id fo13so1028099vcb.21
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 19:15:26 -0800 (PST)
In-Reply-To: <1782274.DIo8UG5duX@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, Jan 10, 2013 at 6:05 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 10 January 2013 10:16:10 Dave Airlie wrote:
>> On Wed, Jan 9, 2013 at 2:11 PM, Rob Clark <robdclark@gmail.com> wrote:
>> > Updated version of DRM driver for TI LCD Controller.  Since the initial
>> > version of the patch, which only supported TFP410 DVI output, I've added
>> > an output driver for LCD panels (for example, LCD3 or LCD7 cape for the
>> > beagle-bone), and initial support for HDMI output via NXP TDA19988 HDMI
>> > encoder (via i2c encoder-slave output driver).
>> >
>> > At this point, I think the basic lcdc drm driver plus TFP410 DVI output
>> > (first patch) is in reasonable shape (barring potential rename, if lcdc
>> > is too generic of a name... but I was not feeling creative enough yet to
>> > pick a new name).
>>
>> I'd like at least tilcdc :-)
>
> So do I :-) The Renesas LCD controller is also called LCDC, and they called
> the fbdev driver sh_mobile_lcdcfb. tilcdc isn't *that* long in comparison :-)

next version will be 'tilcdc' :-)

I would appreciate some thoughts about more generic devicetree lcd
panel parameters for the (ti)lcdc_panel patch..  from a functional
standpoint, I think the lcd panel support part is also pretty much
ready to go (I've added backlight support since the last version I
sent), but I'm not really happy with the DT bindings for that because
they seem to me a bit too hw specific, but I'm not really sure how
they should look.

Fwiw, on the CDF <-> KMS end of things, I'm sort of thinking the i2c
encoder slave is not too far off.. just needs to be a bit decoupled
from i2c.

BR,
-R

> --
> Regards,
>
> Laurent Pinchart
>
