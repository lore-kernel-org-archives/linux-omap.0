From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.10-rc1: backlight brightness after boot on N900
Date: Fri, 17 May 2013 22:17:23 +0300
Message-ID: <20130517191723.GD31836@blackmetal.musicnaut.iki.fi>
References: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
 <519465FC.9090002@ti.com>
 <20130517182504.GC31836@blackmetal.musicnaut.iki.fi>
 <20130517184534.GZ5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:50187 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab3EQTRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 15:17:31 -0400
Content-Disposition: inline
In-Reply-To: <20130517184534.GZ5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org

Hi,

On Fri, May 17, 2013 at 11:45:35AM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [130517 11:30]:
> > So I bisected and it points to:
> > 
> > 	commit a2797beadfcb5a0974a30929b613b4d1adb023d1
> > 	Author: Jon Hunter <jon-hunter@ti.com>
> > 	Date:   Thu Apr 4 15:16:15 2013 -0500
> > 
> > 	    gpio/omap: force restore if context loss is not detectable
> > 
> > When I revert that commit from 3.10-rc1, the display works again as
> > expected.
> 
> OK that should be fixed by ab6ec0fb (gpio/omap: ensure gpio context is initialised)
> in linux-next. Can you check if that helps?

Yeah, that fixes it. Thanks,

A.
