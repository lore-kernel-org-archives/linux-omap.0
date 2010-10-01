From: "Lopez Cruz, Misael" <misael.lopez@ti.com>
Subject: RE: [PATCH 2/2] omap: zoom: Move new code introduced by ASoC m-c to
 board-zoom-peripherals
Date: Fri, 1 Oct 2010 18:47:49 -0500
Message-ID: <C9D59C82B94F474B872F2092A87F261412730D6302@dlee07.ent.ti.com>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
 <1285258314-23721-2-git-send-email-jhnikula@gmail.com>
 <C9D59C82B94F474B872F2092A87F26141272FF6109@dlee07.ent.ti.com>
 <1285349412.13240.42.camel@odin>
 <ac252c0b89d0931d54a4d763e11035a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53911 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab0JAXr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:47:59 -0400
In-Reply-To: <ac252c0b89d0931d54a4d763e11035a3@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>, Tony Lindgren <tony@atomide.com>

> Liam Girdwood wrote:
> > On Fri, 2010-09-24 at 11:31 -0500, Lopez Cruz, Misael wrote:
> > > Hi Jarkko,
> > >
> > > > ASoC Multi-Component Support moves some code from
> > > > sound/soc/omap/zoom2.c
> > > > into
> > > > arch/arm/mach-omap2/board-zoom2.c. However, that code should go to
> > > > board-zoom-peripherals.c instead as there is common code and
> > > > registration
> > > > for zoom boards.
> > > >
> > > > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > > > Cc: Vikram Pandita <vikram.pandita@ti.com>
> > > > Cc: Lopez Cruz, Misael <x0052729@ti.com>
> > > > Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > > I don't have this HW so not tested.
> > > Tested on zoom2 using the 2 patches of your series, compilation break
> is
> > > gone and audio works fine.
> > >
> > > Thanks,
> > > -Misael
> >
> > Applied, and manually added your Tested-by:
> >
> > Thanks
> >
> > Liam
> 
> Misael, Liam,
> 
> Sorry I noticed this patch only now. I have a minor comment on the patch:
> 
> Specifically, the part below
> 
> +	if (machine_is_omap_zoom2()) {
> +		zoom_audio_data.ramp_delay_value = 3;	/* 161 ms */
> +		zoom_audio_data.hs_extmute = 1;
> +		zoom_audio_data.set_hs_extmute = zoom2_set_hs_extmute;
> +	}
> 
> Isn't the audio on a zoom2/zoom3/3630 SDP the same? (Or at least the
> same on a zoom2 and zoom3)?
Yes, at least zoom2 and zoom3 are the same for audio. 

> If so, we could probably get rid of the
> machine_is_omap_zoom2() check, right?
I think it'd better to add checks for the machines supported by the
driver, so it fails nicely with unsupported ones. I'll go thru the
differences between our boards and send a patch soon.

> - Anand

Thanks,
-Misa
