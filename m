From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: drm/omap: move where DMM driver is registered
Date: Thu, 5 Apr 2012 09:58:43 -0700
Message-ID: <20120405165843.GA17004@kroah.com>
References: <1333640096-24142-1-git-send-email-rob.clark@linaro.org>
 <20120405164112.GB16546@kroah.com>
 <CAF6AEGv7pUht3VkGqobCJd4+KPx2NUoju5++eRUpToAg1ZxPeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52453 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817Ab2DEQ6p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 12:58:45 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6535C219C2
	for <linux-omap@vger.kernel.org>; Thu,  5 Apr 2012 12:58:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAF6AEGv7pUht3VkGqobCJd4+KPx2NUoju5++eRUpToAg1ZxPeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, dri-devel@lists.freedesktop.org

On Thu, Apr 05, 2012 at 11:51:30AM -0500, Rob Clark wrote:
> On Thu, Apr 5, 2012 at 11:41 AM, Greg KH <greg@kroah.com> wrote:
> > On Thu, Apr 05, 2012 at 10:34:56AM -0500, Rob Clark wrote:
> >> From: Rob Clark <rob@ti.com>
> >>
> >> Not sure what triggered the change in behavior, but seems to
> >> result in recursively acquiring a mutex and hanging on boot. =A0Bu=
t
> >> omap_drm_init() seems a much more sane place to register the
> >> driver for the DMM sub-device.
> >> ---
> >> =A0drivers/staging/omapdrm/omap_drv.c | =A0 =A07 ++++---
> >> =A01 files changed, 4 insertions(+), 3 deletions(-)
> >
> > Is this needed for 3.4-final? =A0Any older kernels like 3.3 as well=
?
>=20
> Yeah, it is needed for 3.4-final..  I need to check on 3.3 (it was
> fine circa 3.3-rc6 or rc7)

Ok, I'll queue it up for 3.4-final, let me know if it's also needed in
3.3 if you get the chance.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
