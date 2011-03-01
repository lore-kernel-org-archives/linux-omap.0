From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] OMAP: DSS2: Check for SDI HW before accessing SDI
 registers
Date: Tue, 1 Mar 2011 10:00:18 +0200
Message-ID: <1298966418.2011.34.camel@deskari>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
	 <1298554461-9879-4-git-send-email-tomi.valkeinen@ti.com>
	 <4D6C96E9.20206@ti.com> <1298965117.2011.17.camel@deskari>
	 <4D6CA460.7080002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41127 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755222Ab1CAIAX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 03:00:23 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2180N7v022717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 02:00:23 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2180NfM010927
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 02:00:23 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p2180Nre004929
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 02:00:23 -0600 (CST)
In-Reply-To: <4D6CA460.7080002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 01:46 -0600, Taneja, Archit wrote:
> Hi,
> 
> On Tuesday 01 March 2011 01:08 PM, Valkeinen, Tomi wrote:
> > On Tue, 2011-03-01 at 00:49 -0600, Taneja, Archit wrote:
> >> Hi,
> >>
> >> On Thursday 24 February 2011 07:04 PM, Valkeinen, Tomi wrote:
> >>> Only OMAP 3430 hardware has SDI support. The availability of SDI HW can
> >>> be found out by checking if the LCD channel supports SDI displays.
> >>>
> >>> This patch checks for SDI HW support before accessing SDI registers,
> >>> which fixes a crash on OMAP4 when SDI SW support is compiled in.
> >>>
> >>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> >>> ---
> >>>    drivers/video/omap2/dss/display.c |   10 ++++++++++
> >>>    drivers/video/omap2/dss/dss.c     |   29 ++++++++++++++++++-----------
> >>>    2 files changed, 28 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
> >>> index 3f4fa0b..58459f4 100644
> >>> --- a/drivers/video/omap2/dss/display.c
> >>> +++ b/drivers/video/omap2/dss/display.c
> >>> @@ -30,6 +30,7 @@
> >>>
> >>>    #include<plat/display.h>
> >>>    #include "dss.h"
> >>> +#include "dss_features.h"
> >>>
> >>>    static LIST_HEAD(display_list);
> >>>
> >>> @@ -392,6 +393,15 @@ void dss_init_device(struct platform_device *pdev,
> >>>    	struct device_attribute *attr;
> >>>    	int i;
> >>>    	int r;
> >>> +	enum omap_display_type supported;
> >>> +
> >>> +	supported = dss_feat_get_supported_displays(dssdev->channel);
> >>> +
> >>> +	if (!(supported&   dssdev->type)) {
> >>> +		DSSERR("Unsupported display interface for display '%s'.\n",
> >>> +				dssdev->name);
> >>> +		return;
> >>> +	}
> >>
> >> This would make it necessary to specify the channel in the board file,
> >> especially digit. I think this patch should also add the channel
> >> parameters for all board files which add a tv display.
> >
> > Argh. You're right, dssdev->channel is not what I thought it is. That is
> > rather confusing. I remember this was discussed when that
> > dssdev->channel was introduced.
> >
> > I believe this should work if I change dssdev->channel to
> > dssdev->manager->id.
> >
> 
> I am not sure it will work, dss_init_device is called before 
> dss_recheck_connections which sets the manager for the display.
> 
> Hence, dssdev->manager will be NULL.

True.

> > But this dssdev->channel has to be fixed somehow, I'm 100% sure this
> > won't be the last time somebody tries to use it =).
> >
> 
> I think after the managers are set, we should somehow make the channel 
> parameter "void".

Perhaps not. It is a valid piece of information, isn't it? It tells to
which output channel this device is connected on the hardware level.
That and display type is needed to describe how the panel is connected
and how the DSS outputs should be set up.

Looking at manager.c:omap_dss_set_device, which checks if a device can
be attached to a manager, it only checks:

	if ((mgr->supported_displays & dssdev->type) == 0) {

Which means it doesn't work properly for OMAP4. Here we would also need
the dssdev->channel information, wouldn't we?

But this seems a bit confusing to me. I need to study this more.

For the time being, I think I can just remove the piece of code above,
as 1) it doesn't work right and 2) it's only needed in case the board
file is set up wrong.

 Tomi


