From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
Date: Tue, 11 Oct 2011 14:13:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECCE551F@dbde02.ent.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-2-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA545E3@dbde02.ent.ti.com>
 <20111007085614.GD10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
 <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48161 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab1JKInU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 04:43:20 -0400
In-Reply-To: <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,
> On Mon, Oct 10, 2011 at 10:40:55AM +0530, Gupta, Ajay Kumar wrote:
> > Hi,
> > > On Mon, Sep 26, 2011 at 03:21:07PM +0530, Gupta, Ajay Kumar wrote:
> > > > > To: linux-omap@vger.kernel.org
> > > > > Cc: linux-usb@vger.kernel.org; Balbi, Felipe; tony@atomide.com;
> > > > > B, Ravi; Cousson, Benoit; Gupta, Ajay Kumar
> > > > > Subject: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
> > > >
> > > > Felipe,
> > > > I am planning to send patch 1/6 along with next revision of ti81xx
> > > > hwmod baseport patch from Hemant so that all hwmod data gets
> > > > reviewed at one place.
> > > >
> > > > So now only rest 5 (2/6 to 6/6) patches needs to be queued for
> usb.
> > > >
> > > > I hope this will be fine with you. Let me know if you want me to
> > > > post Same 5 patches separately.
> > >
> > > I guess it's better to queue them separately. I will only take
> > > whatever lies in drivers/usb/musb
> >
> > Ok fine so usb hwmod patch will come from Hemant in his hwmod baseport
> > Series. I will resubmit the one patch fixing your comment.
> 
> ok cool, tks.
> 
> For you platform_data stuff (if you have any), you can add a header to
> include/linux/platform_data/musb-dsps.h

I need to access "struct omap_musb_board_data" and so would add
"#include <plat/usb.h>" in new file drivers/usb/musb/musb_dsps.h.

Any comment ?

Ajay
> 
> Or something similar.

> 
> --
> balbi
