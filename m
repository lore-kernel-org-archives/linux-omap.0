From: "K, Mythri P" <mythripk@ti.com>
Subject: RE: [PATCH 0/2]OMAP:DSS:RFC for HDMI in OMAP4
Date: Tue, 7 Sep 2010 15:52:42 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706C5776DFE@dbde02.ent.ti.com>
References: <1282555058-21044-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33495 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab0IGKWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 06:22:53 -0400
In-Reply-To: <1282555058-21044-1-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

Hi Tomi,
Can you please comment on the below patch series?

Thanks and regards,
Mythri.

> -----Original Message-----
> From: K, Mythri P
> Sent: Monday, August 23, 2010 2:48 PM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; K, Mythri P
> Subject: [PATCH 0/2]OMAP:DSS:RFC for HDMI in OMAP4
> 
> From: Mythri P K <mythripk@ti.com>
> 
> This patch is a outline of how the HDMI support is added to OMAP4.
> 
> HDMI is a driver that is similar to the VENC or the DSI driver to
> support
> HDMI/DVI sink device.
> 
> The current Design adheres to the DSS2 Architecture.
> 
> It is split into the HDMI DSS driver and HDMI panel Driver.
> 
> HDMI DSS driver  Located in drivers/video/omap2/dss/hdmi.c
> is responsible for OMAP related configuration such as listening to
> the
> DSS_HDMI irq which signals changes  such as Hot-plug detect ,
> Physical attach/detach.
> 
> This driver is responsible to calculate the PLL values based on the
> TV resolution  that is selected.
> Yet another functionality is to call necessary configuration for the
> Mux/GPIO settings.
> 
> HDMI Panel Driver is located in
> drivers/video/omap2/displays/hdmi_omap4_panel.c.
> This is a panel driver which acts as the HDMI source  and is
> responsible for all the configuration of the HDMI, based on the
> parameters read from the EDID of the sink device.
> It registers hdmi driver to the omap_dss bus and calls the
> functionality
> of the HDMI DSS driver.
> This driver is responsible for configuration of the HDMI IP, which
> are:
> 	1. Configuration of the PHY registers.
> 	2. Configuration of the PLL registers and setting of the TMDS
> clock.
> 	3. Configuration of the DDC to read the EDID data when
> available.
> 	4. Configuration of the core reigsters to set:
> 		a. set the video registers to the timing and format that
> 			is selected.
> 		b. set the audio reigsters based on the EDID value read
> and
> 			user selected parameters.
> 		c. Set the AVI info frame reigsters to configure the
> auxilary
> 			info frame which are repeated.
> It is also provides the interface for users
> 	1.To read the EDID contents and also confiure the timings
> based on EDID.
> 	2.To configure AVI Inforframe Based on the the EDID(sink
> capability).
> 
> 
> Mythri P K (2):
>   OMAP:DSS:Patch to add support for HDMI as panel driver
>   OMAP:DSS:Patch to add HDMI DSS driver support
> 
>  drivers/video/omap2/displays/hdmi_omap4_panel.c | 1443
> +++++++++++++++++++++++
>  drivers/video/omap2/displays/hdmi_omap4_panel.h |  672 +++++++++++
>  drivers/video/omap2/dss/hdmi.c                  |  292 +++++
>  3 files changed, 2407 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/hdmi_omap4_panel.c
>  create mode 100644 drivers/video/omap2/displays/hdmi_omap4_panel.h
>  create mode 100644 drivers/video/omap2/dss/hdmi.c

