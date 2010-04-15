From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/2] OMAP: OMAP3EVM: Add LCD Backlight brightness
 hookup function
Date: Thu, 15 Apr 2010 19:37:45 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136F3A@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1271073027-2628-2-git-send-email-hvaibhav@ti.com>
	 <1271339276.2690.248.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044E136F2C@dbde02.ent.ti.com>
 <1271339978.2690.255.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56183 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab0DOOHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 10:07:55 -0400
In-Reply-To: <1271339978.2690.255.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, April 15, 2010 7:30 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH-V2 2/2] OMAP: OMAP3EVM: Add LCD Backlight brightness
> hookup function
> 
> On Thu, 2010-04-15 at 15:52 +0200, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Thursday, April 15, 2010 7:18 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org; tony@atomide.com
> > > Subject: Re: [PATCH-V2 2/2] OMAP: OMAP3EVM: Add LCD Backlight brightness
> > > hookup function
> > >
> > > Hi,
> > >
> > > On Mon, 2010-04-12 at 13:50 +0200, ext hvaibhav@ti.com wrote:
> > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > >
> > > >
> > > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > >
> > > What tree is this patch based on? It doesn't apply:
> > >
> > > Applying: OMAP: OMAP3EVM: Add LCD Backlight brightness hookup function
> > > fatal: sha1 information is lacking or useless (arch/arm/mach-
> omap2/board-
> > > omap3evm.c).
> > > Repository lacks necessary blobs to fall back on 3-way merge.
> > > Cannot fall back to three-way merge.
> > >
> > [Hiremath, Vaibhav] I am really not sure why this error is coming up,
> actually I using same patch and rebasing it with latest linux-omap/master
> without any issue.
> >
> 
> I think this happens when you have some extra patches on your tree, and
> these two patches are on top of them. Then you email me only these two
> patches, and when I try to apply them, git will complain as the
> underlying patches are missing from my tree.
> 
> So you should always rebase the patches you will send on top of a clean
> public tree, preferably my dss2 tree or main linux tree.
[Hiremath, Vaibhav] I just send the 2 patches to you, and also verified it applies to linux-omap/dss2 branch cleanly.

Thanks,
Vaibhav

> 
>  Tomi
> 

