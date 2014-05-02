From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Display not working if omapdrm is builtin with 3.15rc
Date: Fri, 2 May 2014 13:55:34 +0200
Message-ID: <87536BEF-95B7-4CD8-B62F-BC332156B6A8@dominion.thruhere.net>
References: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net> <CABxcv==fYi6fhTj9_qdoozooi6Su7KCao+GY9cx242_BwvC+Ew@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61278 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaEBLzj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2014 07:55:39 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so3438403wgg.0
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2014 04:55:38 -0700 (PDT)
In-Reply-To: <CABxcv==fYi6fhTj9_qdoozooi6Su7KCao+GY9cx242_BwvC+Ew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>


Op 2 mei 2014, om 13:25 heeft Javier Martinez Canillas <javier@dowhile0.org> het volgende geschreven:

> Hello Koen,
> 
> On Fri, May 2, 2014 at 12:47 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>> Hi,
>> 
>> I've been trying to get DVI on my beagleboard XM to output a picture with mainline and with 3.15rc it still doesn't work. If I statically build in everything the drm encoders and connectors all go into deferred probe mode and fail, falling back to 1024x768. I with omapdrm and encoders/outputs/etc as modules deferred probe is avoided, far fewer error messages and a 1280x1024 resolution is being used. But still the monitor still says 'no signal' detected.
>> 
>> So what's the magic to get an actual signal on the hdmi connector?
>> 
>> regards,
>> 
>> Koen--
> 
> This is a known issue as far as I know. You need [0] to correctly set
> the display PLL clock rates.

OK, 1/2 is already in and I applied 2/2 manually. Still no picture on screen :(

root@beagleboard:~# dmesg | grep -i fb
      .init : 0xc07a9000 - 0xc07fb040   ( 329 kB)
[    3.830474] Freeing unused kernel memory: 328K (c07a9000 - c07fb000)
[   10.082489] omapdrm omapdrm.0: fb0: omapdrm frame buffer device

root@beagleboard:~# dmesg | grep -i drm
[    3.042266] [drm] Initialized drm 1.1.0 20060810
[    9.785095] omapdrm omapdrm.0: DMM not available, disable DMM support
[    9.792816] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    9.799865] [drm] No driver support for vblank timestamp query.
[   10.082489] omapdrm omapdrm.0: fb0: omapdrm frame buffer device
[   10.088775] omapdrm omapdrm.0: registered panic notifier
[   10.094421] [drm] Initialized omapdrm 1.0.0 20110917 on minor 0

root@beagleboard:~# dmesg | grep -i dvi
[    6.943420] connector-dvi connector.10: failed to find video source
[    6.950256] platform connector.10: Driver connector-dvi requests probe deferral

Then I used this uSD card in a different board and I get the orange u-boot screen and later a GNOME desktop. So it seems I tested it with a broken board :/
Nevertheless, everything as builtin is still broken, but with modules it seems to work.

regards,

Koen