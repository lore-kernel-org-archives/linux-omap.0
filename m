From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] N900: add device tree
Date: Thu, 4 Jul 2013 22:21:45 +0200
Message-ID: <20130704202145.GB10752@amd.pavel.ucw.cz>
References: <20130613142809.GA3775@amd.pavel.ucw.cz>
 <20130613145724.GH8164@atomide.com>
 <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com>
 <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701211753.GC15318@amd.pavel.ucw.cz>
 <20130704171939.GA27374@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59957 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab3GDUVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 16:21:48 -0400
Content-Disposition: inline
In-Reply-To: <20130704171939.GA27374@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, b-cousson@ti.com, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

Hi!

> > This adds device tree with neccessary support to boot with functional
> > video (on both emulator and real N900 device).
> 
> Is this really correct? You have commented out the USB, so there is no
> way for a developer to interact with the device.

Well... I do not have USB & SDcard set up, so my testing was "does it
show failed to mount root message on screen". 

Now, if I do quick test of enabling it on 3.9, I get:

  DTC     arch/arm/boot/dts/omap3-n900.dtb
Error: arch/arm/boot/dts/omap3-n900.dts:92.2-3 label or path,
'usb_otg_hs', not found
FATAL ERROR: Syntax error parsing input tree
make[1]: *** [arch/arm/boot/dts/omap3-n900.dtb] Error 1
make: *** [dtbs] Error 2

. If you could test the patches with the USB support uncommented, that
would be very good...

Thanks,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
