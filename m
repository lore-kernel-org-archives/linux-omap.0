From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: use generic panel data in board files
Date: Tue, 09 Nov 2010 12:13:11 +0200
Message-ID: <1289297591.3297.146.camel@tubuntu>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
	 <1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
	 <1289219163.3297.54.camel@tubuntu>
	 <AANLkTin7XOPyupobBehHc+hdJbGVJWFPRPYf03BwuDcZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:28437 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578Ab0KIKLu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 05:11:50 -0500
In-Reply-To: <AANLkTin7XOPyupobBehHc+hdJbGVJWFPRPYf03BwuDcZ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gadiyar@ti.com" <gadiyar@ti.com>, "notasas@gmail.com" <notasas@gmail.com>

On Mon, 2010-11-08 at 20:43 +0100, ext Bryan Wu wrote:
> On Mon, Nov 8, 2010 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > On Fri, 2010-11-05 at 20:43 +0100, ext Bryan Wu wrote:

> >>  static struct omap_dss_device sdp3430_dvi_device = {
> >>         .name                   = "dvi",
> >> -       .driver_name            = "generic_panel",
> >> -       .type                   = OMAP_DISPLAY_TYPE_DPI,
> >> -       .phy.dpi.data_lines     = 24,
> >
> > Why do you remove type and datalines configuration? You do this for the
> > other panels also.
> >
> 
> I found this is common in all the generic dpi panel, but the value
> depends on the specific panel. I move this to the panel configuration
> data and will set this value in panel-dpi driver. Do you think need I
> keep them here? Actually I found all of them are 24 for generic one.
> 16 or 18 for others.

Both type and .phy.dpi.data_lines tell about the connection to the
panel, not about the panel itself. Thus I think it's more consistent to
have them defined in the board file.

Also, it's really up to the board HW design how many lines are connected
from OMAP to the panel. You could connect only 16, for example, so it's
something that has to be defined in the board file.

 Tomi


