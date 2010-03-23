From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Mar 2010 17:11:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0EB15@dbde02.ent.ti.com>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
 <20100223095154.GA12815@gandalf>
 <19F8576C6E063C45BE387C64729E7394044DA995E5@dbde02.ent.ti.com>
 <20100223203215.GA21920@gandalf> <20100225221940.GN28173@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044DA99E2B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41819 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab0CWLlb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 07:41:31 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DA99E2B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
> Sent: Friday, February 26, 2010 10:03 AM
> To: Tony Lindgren; Felipe Balbi
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] musb: fix power field to hold all possible values
> 
> Hi,
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Friday, February 26, 2010 3:50 AM
> > To: Felipe Balbi
> > Cc: Gupta, Ajay Kumar; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] musb: fix power field to hold all possible values
> >
> > * Felipe Balbi <me@felipebalbi.com> [100223 12:30]:
> > > Hi,
> > >
> > > On Tue, Feb 23, 2010 at 08:01:50PM +0530, Gupta, Ajay Kumar wrote:
> > > > Board files are providing the actual mA and it is getting divided in
> > > > Arch/arm/mach-omap2/usb-musb.c. See the code snippet below,
> > > >
> > > >         musb_plat.clock = "ick";
> > > >         musb_plat.board_data = board_data;
> > > > -->     musb_plat.power = board_data->power >> 1;
> > > >         musb_plat.mode = board_data->mode;
> > > >
> > > > So we need to either take this patch or fix this logic of dividing
> the
> > mA
> > > > supplied from all omap board files.
> > >
> > > that's true, had missed that. Sorry.
> >
> > Hmm, I believe this value is also divided somewhere else but
> > I forgot where. In any case, when making changes like this
> > please run the standard USB tests for gadgets and OTG.
> >
> > Otherwise things are guaranteed to break for USB certs :)
> 
> Tony,
> 
> Currently the flow is,
> 
> 1. Actual mA provided in all omap board files.
> 2. mA gets divided in usb-musb.c
> 3. mA multiplied by two in driver/usb/musb/musb_core.c to pass it to
>    hcd->power_budget.
> 
> So the current patch fixes the logic in step [1] above to fill mA value
> Above 255.

Felipe/Tony,

Any update on this patch ?

Regards,
Ajay
> 
> -Ajay
> >
> > Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
