From: Tony Lindgren <tony@atomide.com>
Subject: Re: Display related board specific boot args
Date: Fri, 22 Mar 2013 08:36:14 -0700
Message-ID: <20130322153614.GC25575@atomide.com>
References: <514C1599.7080803@ti.com>
 <20130322151838.GB25575@atomide.com>
 <514C78F7.5050906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:48826 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933368Ab3CVPgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Mar 2013 11:36:17 -0400
Content-Disposition: inline
In-Reply-To: <514C78F7.5050906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130322 08:34]:
> On 2013-03-22 17:18, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [130322 01:30]:
> >> Hi Tony,
> >>
> >> As you probably know, Overo is a very basic omap board to which you can
> >> attach different add-on modules, like LCD module. In the current overo
> >> board file we always add multiple LCD devices, of which the user should
> >> only use one (the one on his module). This model of allowing multiple
> >> LCD devices on the same video bus is causing headaches in the dss land,
> >> and I'm removing support for it.
> > 
> > OK yes sounds like they should be all selectable, and only the selected
> > one gets initialized.
> >  
> >> So what we should do is add only the LCD device that you actually have
> >> attached. With DT this will probably be handled with separate dts files,
> >> depending on the add-on module.
> >>
> >> How should this be handled with board files? Is it ok to add a board
> >> specific kernel boot argument, parsed in the board file, which tells the
> >> add-on board?
> > 
> > At this point I'd stay away adding any kind of custom handling to the
> > board-*.c files as that will make the task of removing them harder. And
> > a kernel boot argument is something we'd have to support in the future.
> > So if something gets added, it should be a Linux generic boot argument.
> > 
> > Some of these add on boards can be detected over i2c, but it seems as
> > DT is the way to go in the long run in this case.
> >  
> >> We have similar situation in some other boards also.
> > 
> > Yeah. There's the capebus coming that might even allow hotplugging
> > some of these add on boards eventually.
> > 
> > How about just make PANEL_LGPHILIPS_LB035Q02 depends on !PANEL_XYZ_DPI
> > in drivers/video/omap2/displays/Kconfig and add some comments for now?
> > 
> > That way people can still select LB035Q02 but not for generic
> > configurations.
> 
> Well, I don't want to disable a panel driver totally because of one
> board. And it's more complex than that. For overo we have three displays
> on the same DPI bus (using the names assigned in the board file): dvi,
> lcd43, lcd35. So even if the LB035Q02 would be disabled, we have dvi and
> lcd43 which conflict.
> 
> I also would stay away from custom boot args. So I guess that leaves us
> only the compile time option. Either so that the overo board-file needs
> to be modified by the user to change the add-on board, or a Kconfig
> option to select the add-on board under "TI OMAP2/3/4 Specific Features"
> menu.
> 
> Would the Kconfig option be acceptable?

Yes I think that's better than cmdline option in this case considering that
the cmdline option won't be needed at some point in the future.

Regards,

Tony
