From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS
 Patches
Date: Mon, 17 Nov 2008 11:49:52 +0200
Message-ID: <1226915392.6860.18.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E739403E5F2B75A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34383 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYKQJuL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2008 04:50:11 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E5F2B75A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, 2008-11-15 at 14:12 +0530, ext Hiremath, Vaibhav wrote:
> 
> Thanks,
> Vaibhav Hiremath
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Friday, November 14, 2008 9:24 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-fbdev-devel@lists.sourceforge.net; linux-
> > omap@vger.kernel.org
> > Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> > FBDEV/DSS Patches
> > 
> > Hi,
> > On Fri, 2008-11-14 at 18:05 +0530, ext Hiremath, Vaibhav wrote:
> > 
> > > >
> > > > I think the LCD panel on SDP and EVM boards are the same, so we
> > > > should
> > > > only have one driver. Do you have specifications about the LCD?
> > The
> > > > manufacturer, model etc?. I didn't find any proper information
> > about
> > > > the
> > > > LCD.
> > > >
> > > [Hiremath, Vaibhav] The LCD on OMAP3EVM is Sharp LCD (Model No. -
> > LS037V7DW01).
> > > Koen has already conformed that panel3430sdp.c is working with
> > OMAP3EVM, let me try at my end. If it works properly then we can
> > have same file to build for both SDP and EVM. But in that case it
> > make sense to rename file to panel-lcd.c.
> > >
> > 
> > I took the liberty to add you EVM changes to my tree, with a comment
> > about the origin. I also changed the SDP panel name to sharp panel,
> > and
> > made both EVM and SDP use that. But I can't test the EVM, as I don't
> > have one.
> > 
> [Hiremath, Vaibhav] It's ok; you can incorporate required changes from my patches, no issues at all. Please share the code base which you merged from my patch so that I can validate it on EVM, since you don't have EVM to test. 
> 

My current version is available in master branch on
http://www.bat.org/~tomba/git/linux-omap-dss.git/

I will be keeping the master branch up to date with my changes and
linux-omap. And I will be rebasing the branch.

pub1 branch has the version that I emailed to mailing lists some time
ago. You can diff master and pub1 branches to see what's changed.

 Tomi


