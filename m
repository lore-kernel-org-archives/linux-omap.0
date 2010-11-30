From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Tue, 30 Nov 2010 12:29:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCCA455A@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
 <20101124163100.GB5681@nokia.com>
 <19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
 <yw1xeia81nts.fsf@unicorn.mansr.com>
 <19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
 <20101126125539.GG8094@nokia.com> <20101130063440.GF17114@linux-sh.org>
 <20101130063934.GG17114@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab0K3G70 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 01:59:26 -0500
In-Reply-To: <20101130063934.GG17114@linux-sh.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Ville Syrj?l? <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: M?ns Rullg?rd <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: Paul Mundt [mailto:lethal@linux-sh.org]
> Sent: Tuesday, November 30, 2010 12:10 PM
> To: Ville Syrj?l?
> Cc: Hiremath, Vaibhav; M?ns Rullg?rd; linux-omap@vger.kernel.org; linux-
> fbdev@vger.kernel.org
> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> 
> On Tue, Nov 30, 2010 at 03:34:40PM +0900, Paul Mundt wrote:
> > On Fri, Nov 26, 2010 at 02:55:39PM +0200, Ville Syrj?l? wrote:
> > > On Fri, Nov 26, 2010 at 05:38:11PM +0530, ext Hiremath, Vaibhav wrote:
> > > > With this finding, in case of OMAP3 we have to use OMAPFB_WAITFORGO
> > > > (breaking standard applications).
> > >
> > > Applications using the standard fbdev API won't work with manual
> update
> > > displays anyway. You need omapfb specific code to handle it so having
> > > another small difference is not a big deal.
> > >
> > > In DirectFB the that's trivial since there's already a simple omap
> > > gfxdriver where you could override the default flip functionality with
> > > WAITFORGO based stuff.
> > >
> > > Or, as I said, you could add another standard ioctl and fix up
> userspace
> > > to use it where appropriate and if the kernel driver supports it.
> > >
> > It seems like the WAITFORGO semantics could be layered on top of drivers
> > using deferred I/O pretty easily, but the question is whether this is
> > something that userspace plans to make general use of or not. If the
> only
> > user of it in userspace code is OMAP-specific, then there's probably not
> > a lot of point in moving it over to be generic, but if there are
> > sufficient cases where userspace cares about this information
> independent
> > of WAITFORVSYNC for manual update displays, then we can certainly look
> at
> > moving it over for those cases.
> 
> Also, WAITFORGO is a pretty abysmal name. It seems like what you want is
> a WAITFORHWSYNC or something similar.
[Hiremath, Vaibhav] Yes exactly, this name fits to the use-case and sounds ok to me. 

Tomi,
Any comments?

Thanks,
Vaibhav
