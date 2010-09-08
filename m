From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
Date: Wed, 8 Sep 2010 15:19:29 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C2018BC6@dbde02.ent.ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <0680EC522D0CC943BC586913CF3768C003C2018B20@dbde02.ent.ti.com>
 <20100908085545.GA15690@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab0IHJtf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 05:49:35 -0400
In-Reply-To: <20100908085545.GA15690@kroah.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-usb-owner@vger.kernel.org" <linux-usb-owner@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, September 08, 2010 2:26 PM
> To: Munegowda, Keshava
> Cc: linux-usb-owner@vger.kernel.org; linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Gadiyar,
> Anand; Kamat, Nishant
> Subject: Re: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
> 
> On Wed, Sep 08, 2010 at 01:21:04PM +0530, Munegowda, Keshava wrote:
> > > -----Original Message-----
> > > From: Munegowda, Keshava
> > > Sent: Wednesday, August 18, 2010 8:26 AM
> > > To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> > > Cc: Munegowda, Keshava
> > > Subject: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
> > >
> > > This series does minor code cleanup in preparation of an upcoming
> > > series to add support for EHCI and OHCI on the OMAP4 SoC.
> > >
> > > The changes are:
> > > - Rename clock names to be consistent across OMAP3 and OMAP4
> > > - Remove hardcoding of the number of TLL channels
> > > - Move PHY reset earlier in the init sequence
> > >
> > > These patches do not make any changes to existing functionalities.
> > >
> > > Diffstat is below:
> > >
> > > drivers/usb/host/ehci-omap.c                   |  104 ++++++++++++-------------
> > > drivers/usb/host/ohci-omap3.c                  |   55 ++++++-------
> > > 2 files changed
> > > ---
> > > Keshava
> >
> > These are minor patches required for the adding omap4 support for
> > EHCI and OHCI in near feature.
> 
> Do I already have them in my git tree?  Did I forward them to Linus
> already?

	No. This series does not exist in your git tree.

> 
> > Requesting for merge to the current merge window, so that the next
> > set of EHCI and OHCI specific changes will be aligned with this patch set.
> 
> What do you mean by "current"?  The merge window for .36 is closed now.
> It's bugfixes-only at the moment.  But I can easily queue up stuff for
> .37 if you want to resend these.
	
	Yes, Will retest these patches on 2.6.36.rc3 kernel and I will resend.

Thanks 
Keshava Munegowda


> 
> thanks,
> 
> greg k-h
