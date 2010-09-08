From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
Date: Wed, 8 Sep 2010 01:55:45 -0700
Message-ID: <20100908085545.GA15690@kroah.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com> <0680EC522D0CC943BC586913CF3768C003C2018B20@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60808 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab0IHI4v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Sep 2010 04:56:51 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C2018B20@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "linux-usb-owner@vger.kernel.org" <linux-usb-owner@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

On Wed, Sep 08, 2010 at 01:21:04PM +0530, Munegowda, Keshava wrote:
> > -----Original Message-----
> > From: Munegowda, Keshava
> > Sent: Wednesday, August 18, 2010 8:26 AM
> > To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> > Cc: Munegowda, Keshava
> > Subject: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
> > 
> > This series does minor code cleanup in preparation of an upcoming
> > series to add support for EHCI and OHCI on the OMAP4 SoC.
> > 
> > The changes are:
> > - Rename clock names to be consistent across OMAP3 and OMAP4
> > - Remove hardcoding of the number of TLL channels
> > - Move PHY reset earlier in the init sequence
> > 
> > These patches do not make any changes to existing functionalities.
> > 
> > Diffstat is below:
> > 
> > drivers/usb/host/ehci-omap.c                   |  104 ++++++++++++-------------
> > drivers/usb/host/ohci-omap3.c                  |   55 ++++++-------
> > 2 files changed
> > ---
> > Keshava
> 
> These are minor patches required for the adding omap4 support for 
> EHCI and OHCI in near feature.

Do I already have them in my git tree?  Did I forward them to Linus
already?

> Requesting for merge to the current merge window, so that the next 
> set of EHCI and OHCI specific changes will be aligned with this patch set.

What do you mean by "current"?  The merge window for .36 is closed now.
It's bugfixes-only at the moment.  But I can easily queue up stuff for
.37 if you want to resend these.

thanks,

greg k-h
