From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Sat, 15 Nov 2008 14:12:03 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B75A@dbde02.ent.ti.com>
References: <1226678037.32348.81.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51130 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYKOImV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2008 03:42:21 -0500
In-Reply-To: <1226678037.32348.81.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Friday, November 14, 2008 9:24 PM
> To: Hiremath, Vaibhav
> Cc: linux-fbdev-devel@lists.sourceforge.net; linux-
> omap@vger.kernel.org
> Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> FBDEV/DSS Patches
> 
> Hi,
> On Fri, 2008-11-14 at 18:05 +0530, ext Hiremath, Vaibhav wrote:
> 
> > >
> > > I think the LCD panel on SDP and EVM boards are the same, so we
> > > should
> > > only have one driver. Do you have specifications about the LCD?
> The
> > > manufacturer, model etc?. I didn't find any proper information
> about
> > > the
> > > LCD.
> > >
> > [Hiremath, Vaibhav] The LCD on OMAP3EVM is Sharp LCD (Model No. -
> LS037V7DW01).
> > Koen has already conformed that panel3430sdp.c is working with
> OMAP3EVM, let me try at my end. If it works properly then we can
> have same file to build for both SDP and EVM. But in that case it
> make sense to rename file to panel-lcd.c.
> >
> 
> I took the liberty to add you EVM changes to my tree, with a comment
> about the origin. I also changed the SDP panel name to sharp panel,
> and
> made both EVM and SDP use that. But I can't test the EVM, as I don't
> have one.
> 
[Hiremath, Vaibhav] It's ok; you can incorporate required changes from my patches, no issues at all. Please share the code base which you merged from my patch so that I can validate it on EVM, since you don't have EVM to test. 

> > > The #ifdef mode selection in DVI panel is quit hack, I agree.
> The
> > > mode
> > > selection should be possible to be done runtime (or with kernel
