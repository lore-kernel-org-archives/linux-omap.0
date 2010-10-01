From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH 2/2] omap: zoom: Move new code introduced by ASoC m-c to board-zoom-peripherals
Date: Sat, 2 Oct 2010 04:09:49 +0530
Message-ID: <ac252c0b89d0931d54a4d763e11035a3@mail.gmail.com>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
 <1285258314-23721-2-git-send-email-jhnikula@gmail.com> <C9D59C82B94F474B872F2092A87F26141272FF6109@dlee07.ent.ti.com>
 <1285349412.13240.42.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33751 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752871Ab0JAWjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 18:39:48 -0400
Received: by mail-wy0-f182.google.com with SMTP id 29so2184711wyb.13
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 15:39:47 -0700 (PDT)
In-Reply-To: <1285349412.13240.42.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Misael Lopez Cruz <misael.lopez@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Jorge Candelaria Villarreal <jorge.candelaria@ti.com>, Tony Lindgren <tony@atomide.com>

Liam Girdwood wrote:
> On Fri, 2010-09-24 at 11:31 -0500, Lopez Cruz, Misael wrote:
> > Hi Jarkko,
> >
> > > ASoC Multi-Component Support moves some code from
> > > sound/soc/omap/zoom2.c
> > > into
> > > arch/arm/mach-omap2/board-zoom2.c. However, that code should go to
> > > board-zoom-peripherals.c instead as there is common code and
> > > registration
> > > for zoom boards.
> > >
> > > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > > Cc: Vikram Pandita <vikram.pandita@ti.com>
> > > Cc: Lopez Cruz, Misael <x0052729@ti.com>
> > > Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > ---
> > > I don't have this HW so not tested.
> > Tested on zoom2 using the 2 patches of your series, compilation break is
> > gone and audio works fine.
> >
> > Thanks,
> > -Misael
>
> Applied, and manually added your Tested-by:
>
> Thanks
>
> Liam

Misael, Liam,

Sorry I noticed this patch only now. I have a minor comment on the patch:

Specifically, the part below

+	if (machine_is_omap_zoom2()) {
+		zoom_audio_data.ramp_delay_value = 3;	/* 161 ms */
+		zoom_audio_data.hs_extmute = 1;
+		zoom_audio_data.set_hs_extmute = zoom2_set_hs_extmute;
+	}

Isn't the audio on a zoom2/zoom3/3630 SDP the same? (Or at least the
same on a zoom2 and zoom3)? If so, we could probably get rid of the
machine_is_omap_zoom2() check, right?

- Anand
