From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Mon, 7 May 2012 10:57:44 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98712C@DBDE01.ent.ti.com>
References: <cover.1335874494.git.afzal@ti.com>
 <363273a9ef82d6836197929157aa9a8eb8f5171a.1335874494.git.afzal@ti.com>
 <4FA022FC.5040703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E982967@DBDE01.ent.ti.com>
 <4FA401C0.7070503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38945 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab2EGK6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 06:58:13 -0400
In-Reply-To: <4FA401C0.7070503@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Menon, Nishanth" <nm@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "notasas@gmail.com" <notasas@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Hire

Hi Jon,

On Fri, May 04, 2012 at 21:50:16, Hunter, Jon wrote:
> > As mentioned in the cover letter,
> > 
> > "Additional features that currently boards in mainline does not make
> > use of like, waitpin interrupt handling, changes to leverage revision
> > 6 IP differences has not been incorporated."
> > 
> > Priority in this series is to convert into a driver, get all boards working
> > on mainline. Once all boards are working with gpmc driver, these features
> > which are not required for currently supported boards can be added later.
> 
> Yes, but I meant why 2 and not say 5? Anyway, I think that this should
> be marked with a comment like a TODO so it is clear that this needs to
> be re-visited.

Ok, it will be marked with TODO

> >> I think that it make more sense to have the wait-pin information part of
> >> the gpmc_cs_data structure for the following reasons ...
> > 
> > Waitpin information is indeed a part of cs as far as boards are concerned,
> > it is only that it gets propogated to device
> 
> Why does the device's driver care? From my point of view, the wait-pin
> is just part of the interface setup/configuration. The external device
> may require this and assumes that this has been setup along with the CS
> and interface timing, but the device's driver should not care. Remember
> this is just a ready signal used to stall the access. Once configured,
> software should be unaware of it.

By device, it is referred to gpmc device which only gpmc driver is aware,
the peripheral device's driver is not at all aware.

> >> Also, any reason why waitpin_polarity is an int? I see you define LOW as
> >> -1, but I not sure why LOW cannot be 0 as 0 is programmed into the
> >> register for an active low wait signal.
> > 
> > Only intention is not to alter default waitpin polarity value, i.e. if
> > any board does make use of it w/o knowledge of Kernel, I don't want to
> > break it, there may be an argument saying that the board code is buggy,
> > while if some board does so, it is, but don't want to break working one.
> > 
> > Here unless user explicitly set the flag, it does nothing on polarity
> 
> Ok. Do such scenario's exist today? Please note that board code will be
> removed in the future and device-tree will replace. So if there are no
> cases today, I would not be concerned. Unless this could be something
> that has already been configured by the bootloader. However, in that
> case would be even call this function?

Let me check this, here only intent was to play safe, as I have
only two boards to test.

> >>> +int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *cs)
> >>
> >> What scenario is this function used in? May be worth adding a comment
> >> about the function.
> > 
> > Ok, it was required for OneNAND, as it needs to reconfigure
> 
> Ok, but why is that? Unless this is something generic about one-nand I
> don't comprehend. I have a high-level understanding of one-nand, but I
> am not familiar with the specifics that require it to be reconfigured.

Not too familiar with OneNAND, from the code it has been understood
that to set into sync mode, first it may have to set to async mode, read
frequency from OneNAND, then setup sync mode for that frequency.


> >>> +	gpmc_setup_writeprotect(gpmc);
> >>
> >> Write protect is a pin and there is only one. Like the waitpins and CS
> >> signals this needs to be associated with a device. It would make sense
> >> that this is associated with the cs data.
> > 
> > As far as platform are concerned, it is associated with cs, it is only
> > that while configuring CS, it is propagated such that it is done once.
> 
> Hmmm ... but here it looks like if write-protect is used you are going
> to turn it on. A feature like this seems that it does need to be handled
> by the device's driver. Enabling and disabling write-protect are
> functions that I would expect are exported to the device's driver and
> not directly enabled in the gpmc driver during probe. However, maybe is
> could be valid for the write protect to be enabled by default which
> could make sense. However, I don't see anywhere else in the driver to
> control it.
> 
> Shouldn't we warn on multiple devices trying to use write-protect when
> parsing their configuration?

Even if a single device sets write protect, kernel will log it.

Regards
Afzal
