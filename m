From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: enable generic panel configuration
 modification
Date: Tue, 03 Aug 2010 10:54:22 +0300
Message-ID: <1280822062.3436.89.camel@tubuntu.research.nokia.com>
References: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il>
	 <1280217649.2427.68.camel@tubuntu.research.nokia.com>
	 <4C4EE62C.9010701@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34220 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0HCHyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 03:54:46 -0400
In-Reply-To: <4C4EE62C.9010701@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

On Tue, 2010-07-27 at 15:59 +0200, ext Igor Grinberg wrote:
> On 07/27/10 11:00, Tomi Valkeinen wrote:
> > On Mon, 2010-07-26 at 12:34 +0200, ext Igor Grinberg wrote:
> >   
> >> This patch enables platforms to modify the dss device configuration
> >> of the generic panel.
> >>
> >> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> >> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> >> ---
> >>  drivers/video/omap2/displays/panel-generic.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
> >> index 300eff5..ad80dd0 100644
> >> --- a/drivers/video/omap2/displays/panel-generic.c
> >> +++ b/drivers/video/omap2/displays/panel-generic.c
> >> @@ -66,7 +66,7 @@ static void generic_panel_power_off(struct omap_dss_device *dssdev)
> >>  
> >>  static int generic_panel_probe(struct omap_dss_device *dssdev)
> >>  {
> >> -	dssdev->panel.config = OMAP_DSS_LCD_TFT;
> >> +	dssdev->panel.config |= OMAP_DSS_LCD_TFT;
> >>  	dssdev->panel.timings = generic_panel_timings;
> >>  
> >>  	return 0;
> >>     
> >
> > I don't like this. Panel driver should be the one which decides the
> > config.
> >   
> 
> I agree with this in most cases, but not always.
> There are certain transmitters (like TI TFP410 dvi transmitter found
> on cm-t35 and other boards) that can have some of their parameters
> defined by hardware (strapped), so only the platform knows the correct
> values for them.
> One of such parameters is the edge of the clock sampling.

Right. But in that case the panel driver should get arguments from the
board file, and the panel driver uses those arguments to configure the
panel device.

> > Briefly:
> >
> > - Add a struct for the configuration variables (a bit like
> > arch/arm/plat-omap/include/plat/nokia-dsi-panel.h).
> >
> > - Fill the struct in the board file, and pass it to the panel driver via
> > omap_dss_device->data pointer.
> >
> > - The panel driver get the struct and uses it to do whatever
> > configuration it needs.
> >   
> 
> This is more or less what I've been thinking of, but with slight addition:
> the panel driver should have a defaults for all the parameters,
> so there will be no need to provide the whole parameters list,
> just the ones that are different.

That's fine, if there's a sane default value for the parameter.

> > I think there are two ways to implement this:
> >
> > 1) Have lots of fields in the struct, including video timings and video
> > signaling information, and the driver uses these directly.
> >   
> 
> This seems like a good choice for better flexibility and
> provides an easy way of dealing with the issues, I've described above.
> 
> > 2) Have a panel name in the struct, and the panel driver contains a
> > static list of panels, including configurations for those panels, and
> > the driver selects the configuration based on the panel name given from
> > the board file. (like drivers/video/omap2/displays/panel-taal.c does,
> > except there's currently only one panel defined).
> >   
> 
> This approach does not deal with the dvi transmitters issue above,
> unless there will be possibility to define some kind of platform data.

If the panel (DVI transmitter) has some non-standard configurations,
then it should have a driver of its own.

Of course if there's a panel that has just one tiny bit of non-standard
functionality (like the DVI transmitter here), it'd be tempting to try
to get it use the generic panel and add functionality to generic panel
that will allow extra custom configuration.

That would perhaps mean some kind of key-value map passed from the board
file to panel driver for overriding the panel's default configuration.
Depending on the complexity of the implementation, it may or may not be
worth it.

And how about i2c which can be used to get the resolutions from the DVI
display? That would require support in the panel driver, but it doesn't
belong in an LCD driver.

> Also, if we have a static list of panels with their configurations,
> there could be panels with (almost) the same parameters defined
> for a couple of times.

Sure. But isn't it better to have the panel configs defined only once in
the panel driver, than have the same configs defined multiple times in
every board file that uses that panel?

Also, it's much easier for new boards to use an existing panel: just
state the panel's name. The other option would mean browsing through the
board files, trying to find some board using the same panel so that you
could copy the values.

 Tomi


