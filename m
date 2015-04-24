From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Allow building as a loadable module
Date: Fri, 24 Apr 2015 09:22:47 -0700
Message-ID: <20150424162247.GT18048@atomide.com>
References: <1429833382-28532-1-git-send-email-tony@atomide.com>
 <20150424161127.GG5692@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:46637 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967097AbbDXQZj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 12:25:39 -0400
Content-Disposition: inline
In-Reply-To: <20150424161127.GG5692@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>

* Felipe Balbi <balbi@ti.com> [150424 09:14]:
> On Thu, Apr 23, 2015 at 04:56:22PM -0700, Tony Lindgren wrote:
> > We currently get all kinds of errors building the omap gpio driver
> > as a module starting with:
> > 
> > undefined reference to `omap2_gpio_resume_after_idle'
> > undefined reference to `omap2_gpio_prepare_for_idle'
> > ...
> > 
> > Let's fix the issue by adding inline functions to the header.
> > Note that we can now also remove the two unused functions for
> > omap_set_gpio_debounce and omap_set_gpio_debounce_time.
> > 
> > Then doing rmmod on the module produces further warnings
> > because of missing exit related functions. Let's add those.
> > 
> > And finally, we can make the Kconfig entry just a tristate
> > option that's selected for omaps.
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Javier Martinez Canillas <javier@dowhile0.org>
> > Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Just to be clear: when GPIO is a module, we can't really idle, can we ?

Right we cannot do off idle because of the context loss
until we have some way to register driver specific idle
functions.

Regards,

Tony
