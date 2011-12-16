From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 09:19:07 -0800
Message-ID: <20111216171906.GZ32251@atomide.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>
 <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>
 <1324023504.1859.11.camel@deskari>
 <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com>
 <1324025267.1859.29.camel@deskari>
 <alpine.DEB.2.00.1112160211400.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40968 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751955Ab1LPRTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 12:19:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160211400.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

* Paul Walmsley <paul@pwsan.com> [111216 00:41]:
> On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
> 
> > On Fri, 2011-12-16 at 01:27 -0700, Paul Walmsley wrote:
> > > On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
> > > 
> > > > But with DT we can't use func pointers in platform_data either, right?
> > > 
> > > In the future, if someone wants to run a platform_data-less kernel, 
> > > they'll have to come up with a replacement mechanism for these.  Several 
> > > replacements have been proposed internally, such as having an 
> > > omap_bus/omap_device for devices with OMAP-specific integration, but right 
> > > now there are more pressing crises to deal with...
> > 
> > Ok. Benoit was telling me not to use pdata, so I thought it's a hard
> > rule for DT. He didn't give me a clear alternative, though =).
> 
> As far as I know, we've got no other choice.  And if we don't add these, 
> then not only will current code be broken, but when the time comes to 
> convert away from using platform_data function pointers, then no one will 
> know what functions should be exposed from the integration code for the 
> driver to call.

There really should not be any need for platform_data with device tree.

Idling a device should be done with pm_runtime calls. Then the
bus code should idle the right device, in this case using the hwmod
calls.

Most of the platform_data function pointers can be replaced with
Linux generic calls for regulator framework etc. If some frameworks
are missing, then that's obviously a problem that should be addressed.

Different devices can be handled with a combination of compatible
flag + data. For example, take a look at drivers/tty/serial/of_serial.c
and note how the of_platform_serial_table has a .data pointer for
each different device.

Regards,

Tony
