From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [PATCH v2] mfd: twl: fix twl4030 rename for remaining driver,
 board files
Date: Wed, 16 Dec 2009 22:22:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F4378B@dbde02.ent.ti.com>
References: <1260887942-32644-1-git-send-email-balajitk@ti.com>
 <19F8576C6E063C45BE387C64729E739404372AAFA4@dbde02.ent.ti.com>
 <20091215174318.GJ4575@atomide.com> <20091215182103.GK4575@atomide.com>
 <20091215215016.GP4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759707AbZLPQwn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 11:52:43 -0500
In-Reply-To: <20091215215016.GP4575@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> 
> * Tony Lindgren <tony@atomide.com> [091215 10:19]:
> > * Tony Lindgren <tony@atomide.com> [091215 09:43]:
> > > * Krishnamoorthy, Balaji T <balajitk@ti.com> [091215 08:09]:
> > > > Hi Samuel,
> > > > Could you please take this patch through the mfd tree.
> > >
> > > NAK. Please redo the whole twl rename series so _every_ patch
> > > in the series builds for _every_ omap and x86. Then let's have
> > > it sit in for-next before merging it. Otherwise git bisect
> > > breaks on x86 also.
> >
> > Argh. Too late. This twl rename series already hit the mainline
> > just now.
> >
> > Has this patch been compile tested on all omaps and x86?
> 
> Looks like commit 8bea8672edfca7ec5f661cafb218f1205863b343 already
> took care of the x86 compile issue.
> 
> I'll merge the refreshed version below via omap-fixes queue.
Thanks

> 
> Regards,
> 
> Tony

