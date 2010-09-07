From: "K, Mythri P" <mythripk@ti.com>
Subject: RE: [PATCH 0/2]OMAP:DSS:RFC for HDMI in OMAP4
Date: Tue, 7 Sep 2010 17:27:21 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706C5776E8B@dbde02.ent.ti.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB1@dbde02.ent.ti.com>
 <1283856791.2363.67.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56013 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab0IGL51 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 07:57:27 -0400
In-Reply-To: <1283856791.2363.67.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Tomi,
> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, September 07, 2010 4:23 PM
> To: K, Mythri P
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/2]OMAP:DSS:RFC for HDMI in OMAP4
> 
> Hi,
> 
> On Thu, 2010-08-26 at 07:16 +0200, ext K, Mythri P wrote:
> > From: Mythri P K <mythripk@ti.com>
> >
> > This patch is a outline of how the HDMI support is added to OMAP4.
> 
> Please run checkpatch.pl for the patches before you send them.
> Checkpatch reported over 300 errors.
I am not sure which of the 2 patches you are talking about , I have run checkpatch.pl for the patches and I see some "over 80 lines" warning which I have ignored but I see no errors. 
> 
> > HDMI is a driver that is similar to the VENC or the DSI driver to
> support
> > HDMI/DVI sink device.
> 
> When I made the VENC driver, I put both the core VENC and the venc
> panel
> into the same file, inside dss driver. The reason was that VENC is
> part
> of OMAP DSS, and not an external panel. I've been thinking about
> this a
> few times, but so far I haven't changed it.
> 
> Did you have some reason to put the HDMI panel driver into
> displays/?
The reason why I separated out the DSS specific code and the panel driver with the HDMI core specific code is because, when the OMAP related code might change, the HDMI core related changes could be reusable and logically as it reads the EDID and configures the IP based on the TV i.e. connected to it. Also given that there are several user level configurations that are supported such as the YUV format conversion/AVI information based on the TV capability it would be cleaner to handle that in a panel driver.
> 
> > The current Design adheres to the DSS2 Architecture.
> >
> > It is split into the HDMI DSS driver and HDMI panel Driver.
> >
> > HDMI DSS driver  Located in drivers/video/omap2/dss/hdmi.c
> > is responsible for OMAP related configuration such as listening to
> the
> > DSS_HDMI irq which signals changes  such as Hot-plug detect ,
> > Physical attach/detach.
> >
> > This driver is responsible to calculate the PLL values based on
> the
> > TV resolution  that is selected.
> > Yet another functionality is to call necessary configuration for
> the
> > Mux/GPIO settings.
> 
> Why does HDMI need mux/GPIO changes?
Some of the HDMI functionality like hot-plug-detect which works on the level shifters(0/5v) and the DDC line to read the EDID from the TV needs GPIO configurations.
> 
> > HDMI Panel Driver is located in
> drivers/video/omap2/displays/hdmi_omap4_panel.c.
> > This is a panel driver which acts as the HDMI source  and is
> responsible for all the configuration of the HDMI, based on the
> parameters read from the EDID of the sink device.
> > It registers hdmi driver to the omap_dss bus and calls the
> functionality
> > of the HDMI DSS driver.
> > This driver is responsible for configuration of the HDMI IP, which
> are:
> > 	1. Configuration of the PHY registers.
> > 	2. Configuration of the PLL registers and setting of the TMDS
> clock.
> > 	3. Configuration of the DDC to read the EDID data when
> available.
> > 	4. Configuration of the core reigsters to set:
> > 		a. set the video registers to the timing and format that
> > 			is selected.
> > 		b. set the audio reigsters based on the EDID value read
> and
> > 			user selected parameters.
> > 		c. Set the AVI info frame reigsters to configure the
> auxilary
> > 			info frame which are repeated.
> > It is also provides the interface for users
> > 	1.To read the EDID contents and also confiure the timings
> based on EDID.
> > 	2.To configure AVI Inforframe Based on the the EDID(sink
> capability).
> >
> >
> > Mythri P K (2):
> >   OMAP:DSS:Patch to add support for HDMI as panel driver
> >   OMAP:DSS:Patch to add HDMI DSS driver support
> >
> >  drivers/video/omap2/displays/hdmi_omap4_panel.c | 1443
> +++++++++++++++++++++++
> >  drivers/video/omap2/displays/hdmi_omap4_panel.h |  672
> +++++++++++
> >  drivers/video/omap2/dss/hdmi.c                  |  292 +++++
> >  3 files changed, 2407 insertions(+), 0 deletions(-)
> >  create mode 100644
> drivers/video/omap2/displays/hdmi_omap4_panel.c
> >  create mode 100644
> drivers/video/omap2/displays/hdmi_omap4_panel.h
> >  create mode 100644 drivers/video/omap2/dss/hdmi.c
> >
> 

