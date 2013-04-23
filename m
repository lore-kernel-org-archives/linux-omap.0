From: Tony Lindgren <tony@atomide.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Tue, 23 Apr 2013 10:31:07 -0700
Message-ID: <20130423173107.GE10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
 <5174FE16.6080307@ti.com>
 <51750FF8.6000401@ti.com>
 <51752B48.50700@ti.com>
 <20130422180822.GB10155@atomide.com>
 <51769248.60602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20200 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab3DWRbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 13:31:10 -0400
Content-Disposition: inline
In-Reply-To: <51769248.60602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

* Grygorii Strashko <grygorii.strashko@ti.com> [130423 06:59]:
> 
> I've posted two patches to fix I2C/TWL initialization and they should fix
> DSS indirectly (if not - DSS need to be shifted to init later).
> lkml.org/lkml/2013/4/23/215
> lkml.org/lkml/2013/4/23/217

OK, thanks. We may want to wait a bit on those, but I'll reply to
that thread.

> In addition, It seems, possibly :), drivers/Makefile might need to
> be changed a bit:
> - move generic drivers framework to be initialized first ("base", "clk");
> - move "i2c" buses initialization as early as possible (but after
> "pinctrl" and "gpio")
> - move "mfd" initialization before "regulators"
> - move "video" initialization down after "regulators" (as minimum).

I doubt that we want to start messing with the current ordering
of the drivers/Makefile. That always breaks something else, and
the real fix is to get -EPROBE_DEFER to work for us.

With the DSS there are way too many dependencies to various other
drivers to try to initialize it early. We're better off just fixing
it to work with -EPROBE_DEFER.

Regards,

Tony
