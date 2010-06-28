From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with vdds_dsi
Date: Mon, 28 Jun 2010 14:57:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E9E3EF4@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1268997679-27869-1-git-send-email-hvaibhav@ti.com>
	 <19F8576C6E063C45BE387C64729E7394044E85304E@dbde02.ent.ti.com>
 <1277710673.2474.13.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55232 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab0F1J1l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 05:27:41 -0400
In-Reply-To: <1277710673.2474.13.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Monday, June 28, 2010 1:08 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with
> vdds_dsi
> 
> On Thu, 2010-06-10 at 17:41 +0200, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > > Sent: Friday, March 19, 2010 4:51 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: tomi.valkeinen@nokia.com; tony@atomide.com; Hiremath, Vaibhav
> > > Subject: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with
> vdds_dsi
> > >
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > With recent changes happened in OMAP2/3 DSS library for regulator
> interface,
> > > it
> > > is required to define DSI regulator supply, without this DSS (in turn
> Fbdev)
> > > fails to get regulator.
> > >
> > [Hiremath, Vaibhav] Tony,
> >
> > I have also completely missed about this patch, and today I realized that
> this patch is not merged.
> >
> > Tony,
> >
> > I have verified that this patch still gets applied cleanly ontop of linux-
> omap/master.
> >
> > Can it be merged, without this Video Display won't work on EVM?
> 
> I have taken this patch into my tree (again). Let's see if we manage to
> handle it without conflicts this time =).
> 
[Hiremath, Vaibhav] Thanks Tomi, 

Thanks,
Vaibhav

>  Tomi
> 

