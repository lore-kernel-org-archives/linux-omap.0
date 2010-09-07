From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/2]OMAP:DSS:RFC for HDMI in OMAP4
Date: Tue, 07 Sep 2010 13:53:11 +0300
Message-ID: <1283856791.2363.67.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:48901 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab0IGKxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 06:53:17 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BE2A6AB1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-08-26 at 07:16 +0200, ext K, Mythri P wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> This patch is a outline of how the HDMI support is added to OMAP4.

Please run checkpatch.pl for the patches before you send them.
Checkpatch reported over 300 errors.
 
> HDMI is a driver that is similar to the VENC or the DSI driver to support
> HDMI/DVI sink device.

When I made the VENC driver, I put both the core VENC and the venc panel
into the same file, inside dss driver. The reason was that VENC is part
of OMAP DSS, and not an external panel. I've been thinking about this a
few times, but so far I haven't changed it.

Did you have some reason to put the HDMI panel driver into displays/? 

> The current Design adheres to the DSS2 Architecture.
> 
> It is split into the HDMI DSS driver and HDMI panel Driver.
>  
> HDMI DSS driver  Located in drivers/video/omap2/dss/hdmi.c
> is responsible for OMAP related configuration such as listening to the
> DSS_HDMI irq which signals changes  such as Hot-plug detect ,
> Physical attach/detach.
> 
> This driver is responsible to calculate the PLL values based on the
> TV resolution  that is selected.
> Yet another functionality is to call necessary configuration for the
> Mux/GPIO settings.

Why does HDMI need mux/GPIO changes?
 
> HDMI Panel Driver is located in drivers/video/omap2/displays/hdmi_omap4_panel.c.
> This is a panel driver which acts as the HDMI source  and is responsible for all the configuration of the HDMI, based on the parameters read from the EDID of the sink device.
> It registers hdmi driver to the omap_dss bus and calls the functionality
> of the HDMI DSS driver.
> This driver is responsible for configuration of the HDMI IP, which are:
> 	1. Configuration of the PHY registers.
> 	2. Configuration of the PLL registers and setting of the TMDS clock.
> 	3. Configuration of the DDC to read the EDID data when available.
> 	4. Configuration of the core reigsters to set:
> 		a. set the video registers to the timing and format that
> 			is selected.
> 		b. set the audio reigsters based on the EDID value read and
> 			user selected parameters.
> 		c. Set the AVI info frame reigsters to configure the auxilary
> 			info frame which are repeated.
> It is also provides the interface for users 
> 	1.To read the EDID contents and also confiure the timings based on EDID.
> 	2.To configure AVI Inforframe Based on the the EDID(sink capability).
> 
> 
> Mythri P K (2):
>   OMAP:DSS:Patch to add support for HDMI as panel driver
>   OMAP:DSS:Patch to add HDMI DSS driver support
> 
>  drivers/video/omap2/displays/hdmi_omap4_panel.c | 1443 +++++++++++++++++++++++
>  drivers/video/omap2/displays/hdmi_omap4_panel.h |  672 +++++++++++
>  drivers/video/omap2/dss/hdmi.c                  |  292 +++++
>  3 files changed, 2407 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/hdmi_omap4_panel.c
>  create mode 100644 drivers/video/omap2/displays/hdmi_omap4_panel.h
>  create mode 100644 drivers/video/omap2/dss/hdmi.c
> 


