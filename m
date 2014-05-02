From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Display not working if omapdrm is builtin with 3.15rc
Date: Fri, 2 May 2014 14:33:06 +0200
Message-ID: <AD528168-3D2D-42E7-B219-E3FCE32A859E@dominion.thruhere.net>
References: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net> <5363888C.5090303@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:53167 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEBMdK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2014 08:33:10 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so2230894wib.6
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2014 05:33:09 -0700 (PDT)
In-Reply-To: <5363888C.5090303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>


Op 2 mei 2014, om 13:59 heeft Tomi Valkeinen <tomi.valkeinen@ti.com> het volgende geschreven:

> On 02/05/14 13:47, Koen Kooi wrote:
>> Hi,
>> 
>> I've been trying to get DVI on my beagleboard XM to output a picture with mainline and with 3.15rc it still doesn't work. If I statically build in everything the drm encoders and connectors all go into deferred probe mode and fail, falling back to 1024x768. I with omapdrm and encoders/outputs/etc as modules deferred probe is avoided, far fewer error messages and a 1280x1024 resolution is being used. But still the monitor still says 'no signal' detected.
>> 
>> So what's the magic to get an actual signal on the hdmi connector?
> 
> Sigh, looks like my beagle xM died on me while testing this...
> 
> The reason for this is that the twl_gpio (which TFP410 uses) gets
> initialized really late, so display things get deferred. Then, before
> TFP410 has initialized, omapdrm starts. It finds VENC (tv-out) display
> available, so it starts. After that TFP410 gets probed, but as DRM
> doesn't support adding displays later, it is never actually added to
> omapdrm.
> 
> Also, the VENC output doesn't even work by default if
> CONFIG_DRM_OMAP_NUM_CRTCS is 1. It needs to be set to 2 to support the
> second output (tv-out in this case). But my board died before I managed
> to test this.
> 
> So, the probing is quite broken. And I have no good ideas how to fix it,
> only bad ones...
> 
> A simple thing to do for testing is to either disable
> CONFIG_OMAP2_DSS_VENC from the kernel, or remove the svideo-connector
> from the board's .dts file. This results in tv-out not being available,
> so when omapdrm starts and finds no displays, it'll defer its probe,
> thus getting the DVI next time it probes.

I disabled CONFIG_OMAP2_DSS_VENC and DVI works as expected with everything builtin!

regards,

Koen