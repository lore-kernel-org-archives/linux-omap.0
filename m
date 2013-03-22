From: Tony Lindgren <tony@atomide.com>
Subject: Re: Display related board specific boot args
Date: Fri, 22 Mar 2013 08:18:39 -0700
Message-ID: <20130322151838.GB25575@atomide.com>
References: <514C1599.7080803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54273 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933169Ab3CVPSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 11:18:42 -0400
Content-Disposition: inline
In-Reply-To: <514C1599.7080803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130322 01:30]:
> Hi Tony,
> 
> As you probably know, Overo is a very basic omap board to which you can
> attach different add-on modules, like LCD module. In the current overo
> board file we always add multiple LCD devices, of which the user should
> only use one (the one on his module). This model of allowing multiple
> LCD devices on the same video bus is causing headaches in the dss land,
> and I'm removing support for it.

OK yes sounds like they should be all selectable, and only the selected
one gets initialized.
 
> So what we should do is add only the LCD device that you actually have
> attached. With DT this will probably be handled with separate dts files,
> depending on the add-on module.
> 
> How should this be handled with board files? Is it ok to add a board
> specific kernel boot argument, parsed in the board file, which tells the
> add-on board?

At this point I'd stay away adding any kind of custom handling to the
board-*.c files as that will make the task of removing them harder. And
a kernel boot argument is something we'd have to support in the future.
So if something gets added, it should be a Linux generic boot argument.

Some of these add on boards can be detected over i2c, but it seems as
DT is the way to go in the long run in this case.
 
> We have similar situation in some other boards also.

Yeah. There's the capebus coming that might even allow hotplugging
some of these add on boards eventually.

How about just make PANEL_LGPHILIPS_LB035Q02 depends on !PANEL_XYZ_DPI
in drivers/video/omap2/displays/Kconfig and add some comments for now?

That way people can still select LB035Q02 but not for generic
configurations.

Regards,

Tony
