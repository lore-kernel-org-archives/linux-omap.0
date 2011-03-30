From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the
 omap4430_phy_init function
Date: Wed, 30 Mar 2011 11:46:38 -0700
Message-ID: <20110330184637.GG18334@atomide.com>
References: <1300966722-10955-1-git-send-email-hemahk@ti.com>
 <20110328212015.GH30616@atomide.com>
 <4369479157892165533add3d883a79a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711Ab1C3Sqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 14:46:42 -0400
Content-Disposition: inline
In-Reply-To: <4369479157892165533add3d883a79a7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

* Hema Kalliguddi <hemahk@ti.com> [110328 23:11]:
> Hi,
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Tuesday, March 29, 2011 2:50 AM
> >To: Hema HK
> >Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
> >Subject: Re: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the
> >omap4430_phy_init function
> >
> >* Hema HK <hemahk@ti.com> [110324 04:36]:
> >> omap4430_phy_init() function can be called with no device pointer,
> >> to powerdown the PHY during board init when USB is disabled.
> >> Fix the function accordingly.
> >
> >This should no longer be needed after merge commit
> >0df0914d414a504b975f3cc66ace0c16ef55b7f3.
> 
> I did not get how the above commit help to fix it.

Ah it's not there. Well IMHO omap4430_phy_init(dev) should
not get called before dev is initialized in usb_musb_init.

So it should get called only after the get_device(dev) call.

Regards,

Tony

