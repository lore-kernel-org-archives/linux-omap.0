From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the
 display options
Date: Fri, 29 Mar 2013 08:47:33 -0700
Message-ID: <20130329154732.GC10155@atomide.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
 <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com>
 <51546B2C.2030101@compulab.co.il>
 <20130328165336.GW10155@atomide.com>
 <515479F6.9090005@ti.com>
 <20130328212837.GY10155@atomide.com>
 <51551841.9070704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27572 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755731Ab3C2Prg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 11:47:36 -0400
Content-Disposition: inline
In-Reply-To: <51551841.9070704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130328 21:32]:
> On 2013-03-28 23:28, Tony Lindgren wrote:
> > 
> > How do you plan to change between LCD and DVI with DT? By using some
> > custom driver modules?
> 
> I don't know, but I guess we need board specific drivers.
> 
> Do you know if there are other similar cases for other busses? I mean, I
> think this is a similar case than, say, having two i2c devices with the
> same i2c-id on the same bus. Only one of the devices can be enabled, the
> other must be disconnected. And how the connect/disconnect is made is
> board specific.

No good ideas, unless it all can be controlled via pinctrl framework?

With pinctrl framework the dss driver could request named modes like
"dvi" and "lcd" for sets of pins. And the panel driver could implement
pinctrl functions, so when a named mode "lcd" is requested by the dss
driver, the data lines configured and GPIO and regulators get set.
If we are really muxing the dss data lines, then using that might
make sense.

Note that there may be issues related to waiting sleeping regulators etc.

> > There's the capebus coming that can be used for that too, but in most
> > cases all the hardware is permanently connected with LCD and DVI. So
> > sounds like capebus should only be needed for the add on boards.
> 
> True.
> 
> Well, depends on how you look at it. From one point of view there's no
> real difference whether the disabled device is physically on the board
> or not, as it has to be disconnected. The details depend on the bus, but
> for example for DSI I think the disabled device has to be totally
> removed from the DSI bus with some mux or such.

Yes, so if we're really muxing lines, then maybe using the pinctrl
framework makes sense until we have the capebus available?
 
> But, from the other point of view, the devices are there, on the board,
> and in some cases the HW has been designed to support switching the
> displays during runtime.
> 
> So what I wish is that I could make the linux device for the display to
> be removed when it's disabled. I believe that can be done, but I guess
> it requires a board specific driver, with some custom user interface to
> do that.

Sounds like capebus will do that when it's available.
 
> And it would be different user interface than currently, which is again
> not so nice. Currently the devices are always there, with their sysfs
> files, and those sysfs files are used to enable/disable the devices. If
> the device is removed, the sysfs files get removed also...

You can probably keep the user interface the same if the dss driver
requests changing the panels, and can probably support both pinctrl
muxing and capebus pretty easily. The biggest change would be that when
capebus is available there's more than one struct device for the panels,
so the .dts files would have to be updated for that.

Or maybe the pinctrl handler could already easily add and remove devices
depending which named mode is requested by the dss driver, I don't know.
 
> But I would really like to get rid of the current model, which I think
> was a very bad design decision.

Yes agreed, we need to get rid of the board-*.c file callback functions.

Regards,

Tony
