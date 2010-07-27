From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/2] OMAP: DSS2: enable generic panel configuration modification
Date: Tue, 27 Jul 2010 16:59:08 +0300
Message-ID: <4C4EE62C.9010701@compulab.co.il>
References: <1280140468-8183-1-git-send-email-grinberg@compulab.co.il> <1280217649.2427.68.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:57064 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab0G0N7P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jul 2010 09:59:15 -0400
In-Reply-To: <1280217649.2427.68.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

On 07/27/10 11:00, Tomi Valkeinen wrote:
> On Mon, 2010-07-26 at 12:34 +0200, ext Igor Grinberg wrote:
>   
>> This patch enables platforms to modify the dss device configuration
>> of the generic panel.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  drivers/video/omap2/displays/panel-generic.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
>> index 300eff5..ad80dd0 100644
>> --- a/drivers/video/omap2/displays/panel-generic.c
>> +++ b/drivers/video/omap2/displays/panel-generic.c
>> @@ -66,7 +66,7 @@ static void generic_panel_power_off(struct omap_dss_device *dssdev)
>>  
>>  static int generic_panel_probe(struct omap_dss_device *dssdev)
>>  {
>> -	dssdev->panel.config = OMAP_DSS_LCD_TFT;
>> +	dssdev->panel.config |= OMAP_DSS_LCD_TFT;
>>  	dssdev->panel.timings = generic_panel_timings;
>>  
>>  	return 0;
>>     
>
> I don't like this. Panel driver should be the one which decides the
> config.
>   

I agree with this in most cases, but not always.
There are certain transmitters (like TI TFP410 dvi transmitter found
on cm-t35 and other boards) that can have some of their parameters
defined by hardware (strapped), so only the platform knows the correct
values for them.
One of such parameters is the edge of the clock sampling.

> I think a better solution is to make panel-generic configurable, which
> has been discussed a bit some time ago on l-o.
>   

No doubt about that :)

> Briefly:
>
> - Add a struct for the configuration variables (a bit like
> arch/arm/plat-omap/include/plat/nokia-dsi-panel.h).
>
> - Fill the struct in the board file, and pass it to the panel driver via
> omap_dss_device->data pointer.
>
> - The panel driver get the struct and uses it to do whatever
> configuration it needs.
>   

This is more or less what I've been thinking of, but with slight addition:
the panel driver should have a defaults for all the parameters,
so there will be no need to provide the whole parameters list,
just the ones that are different.

> I think there are two ways to implement this:
>
> 1) Have lots of fields in the struct, including video timings and video
> signaling information, and the driver uses these directly.
>   

This seems like a good choice for better flexibility and
provides an easy way of dealing with the issues, I've described above.

> 2) Have a panel name in the struct, and the panel driver contains a
> static list of panels, including configurations for those panels, and
> the driver selects the configuration based on the panel name given from
> the board file. (like drivers/video/omap2/displays/panel-taal.c does,
> except there's currently only one panel defined).
>   

This approach does not deal with the dvi transmitters issue above,
unless there will be possibility to define some kind of platform data.
Also, if we have a static list of panels with their configurations,
there could be panels with (almost) the same parameters defined
for a couple of times.

> While 1. gives perhaps slightly easier configuration, as you just edit
> the board file, I'd go for 2. because the required configuration is
> really defined by the panel/chip being used, and so the board file
> should just state which panel/chip we have, and the driver handles the
> rest.

Well, unfortunately, it is not :(

>  And 2. makes it also easier to use the same panel/chip on multiple
> boards.
>
> Implementing this would allow us to remove some panel drivers which
> currently are 99% copies of each other.
>
>  Tomi
>
>   

My idea is:
generic driver will have built-in defaults, that can
(but not necessarily will) be overridden by platform (or other) code
on a parameter basis.
This will allow other panels (like tdo35s) reuse the generic driver
without the need for their special driver.

What do you think of it?

-- 
Regards,
Igor.

