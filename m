From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAPDSS and panel-dpi
Date: Thu, 17 Apr 2014 12:22:16 -0700
Message-ID: <20140417192215.GA24931@atomide.com>
References: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30357 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751312AbaDQTWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 15:22:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140417 11:05]:
> Hi Tomi,
> 
> My VAR-DVK-OM44 (OMAP4460) has both a HDMI and a LCD panel. As HDMI is
> now working (thanks) I also taken a look at panel-dpi.
> 
> I found the DT patch for panel-dpi on the mailing list.
> OMAPDSS: panel-dpi: Add DT support:
> http://marc.info/?l=devicetree&m=139030201815380&w=2
> 
> And I got my display working with DT :)
> So you add can my: Tested-by: Joachim Eastwood <manabian@gmail.com>
> 
> Could you upstream the panel-dpi DT support and the HDMI connector
> gpio hpd patch in 3.16?
> I hope it's easier to upstream the stuff when it gets some users in DT.

Good to hear. The DPI panel support should use gpio-backlight
driver as discussed in the DPI thread. Did you have to patch
anything for the timings etc?

If you have the board working, care to take a look at making
the gpio-backlight change?

Otherwise we'll be creating unncessary churn and maintainer
headaches with patching half a dozen DPI using boards to change
them over to use gpio-backlight.

Regards,

Tony
