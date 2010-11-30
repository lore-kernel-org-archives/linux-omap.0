From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Tue, 30 Nov 2010 12:27:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCCA4556@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
 <20101124163100.GB5681@nokia.com>
 <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
 <yw1xeia81nts.fsf@unicorn.mansr.com>
 <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
 <20101126125539.GG8094@nokia.com> <20101130063440.GF17114@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41090 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab0K3G6C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 01:58:02 -0500
In-Reply-To: <20101130063440.GF17114@linux-sh.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Ville Syrj?l? <ville.syrjala@nokia.com>
Cc: M?ns Rullg?rd <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

> -----Original Message-----
> From: Paul Mundt [mailto:lethal@linux-sh.org]
> Sent: Tuesday, November 30, 2010 12:05 PM
> To: Ville Syrj?l?
> Cc: Hiremath, Vaibhav; M?ns Rullg?rd; linux-omap@vger.kernel.org; linux-
> fbdev@vger.kernel.org
> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> 
> On Fri, Nov 26, 2010 at 02:55:39PM +0200, Ville Syrj?l? wrote:
> > On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav wrote:
> > > With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO
> > > (breaking standard applications).
> >
> > Applications using the standard fbdev API won't work with manual update
> > displays anyway. You need omapfb specific code to handle it so having
> > another small difference is not a big deal.
> >
> > In DirectFB the that's trivial since there's already a simple omap
> > gfxdriver where you could override the default flip functionality with
> > WAITFORGO based stuff.
> >
> > Or, as I said, you could add another standard ioctl and fix up userspace
> > to use it where appropriate and if the kernel driver supports it.
> >
> It seems like the WAITFORGO semantics could be layered on top of drivers
> using deferred I/O pretty easily, but the question is whether this is
> something that userspace plans to make general use of or not. If the only
> user of it in userspace code is OMAP-specific, then there's probably not
> a lot of point in moving it over to be generic, but if there are
> sufficient cases where userspace cares about this information independent
> of WAITFORVSYNC for manual update displays, then we can certainly look at
> moving it over for those cases.
[Hiremath, Vaibhav] As part of this thread, I was referring to couple of other platforms like Samsung S3C, etc... and neither they do have GO bit concept nor OMAP3 like issue (I was referring to). 
In case of S3C, the device is capable of giving interrupt for all VFP, vsync, VBP, etc... instances if timing cycle and I believe driver makes use of vsync under WAITFORVSYNC.

Thanks,
Vaibhav
