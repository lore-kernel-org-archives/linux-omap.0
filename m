From: Tony Lindgren <tony@atomide.com>
Subject: Re: v3.10-rc1: backlight brightness after boot on N900
Date: Fri, 17 May 2013 11:45:35 -0700
Message-ID: <20130517184534.GZ5600@atomide.com>
References: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
 <519465FC.9090002@ti.com>
 <20130517182504.GC31836@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59373 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755519Ab3EQSpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 14:45:42 -0400
Content-Disposition: inline
In-Reply-To: <20130517182504.GC31836@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130517 11:30]:
> On Thu, May 16, 2013 at 07:52:12AM +0300, Tomi Valkeinen wrote:
> > On 15/05/13 20:18, Aaro Koskinen wrote:
> > > Is it expected that after boot you get 0 brightness i.e. a seemingly
> > > blank display on N900 with 3.10-rc1?
> > 
> > There were some small changes merged in v3.10 related to acx's
> > backlight, but they were removing dead code so I don't see how those
> > could affect...
> 
> [...]
> 
> > So what comes to my mind is that either the model is detected wrong,
> > or the acx565akm_get_actual_brightness() which reads the current BL from
> > the panel happens to return 0, either because of an error, or because
> > the bootloader has set the BL to 0.
> > 
> > But why either of those would've changed with v3.10... No idea...
> 
> The panel is detected and probed correctly. So something else is wrong.
> It's not a bootloader issue, because booting 3.9 right after 3.10-rc1
> makes the display work again correctly.
> 
> So I bisected and it points to:
> 
> 	commit a2797beadfcb5a0974a30929b613b4d1adb023d1
> 	Author: Jon Hunter <jon-hunter@ti.com>
> 	Date:   Thu Apr 4 15:16:15 2013 -0500
> 
> 	    gpio/omap: force restore if context loss is not detectable
> 
> When I revert that commit from 3.10-rc1, the display works again as
> expected.

OK that should be fixed by ab6ec0fb (gpio/omap: ensure gpio context is initialised)
in linux-next. Can you check if that helps?

Looks like it has not yet been merged to mainline tree.
Linus W, any news on when you might be sending that fix upstream?

Regards,

Tony
