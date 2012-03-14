From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 14 Mar 2012 15:07:45 +0200
Message-ID: <1331730465.1542.8.camel@lappy>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	 <1331728737.2386.76.camel@deskari>
	 <CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:45597 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932278Ab2CNNHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 09:07:50 -0400
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so2249906lag.17
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 06:07:48 -0700 (PDT)
In-Reply-To: <CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Wed, 2012-03-14 at 07:55 -0500, Rob Clark wrote:
> On Wed, Mar 14, 2012 at 7:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > Hi,
> >
> > On Tue, 2012-03-13 at 15:34 -0500, Rob Clark wrote:
> >> From: Andy Gross <andy.gross@ti.com>
> >>
> >> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> >> the device to use for buffer allocation.  DMM is split into a
> >> separate device using hwmod.
> >
> > What's the diff with this and the previous one?
> 
> Moving drm.c to mach-omap2 (header could not move because
> omap_reserve() is in plat-omap.. but this seems to be the same as what
> is done for dspbridge).
> 
> > I see you still have the platform data there. You didn't comment on
> > that. Where is it used after the board files are gone when we use DT?
> 
> I was kind-of thinking that there would be some DT<->data-structure
> glue somewhere.. not sure if this goes in mach-omap2 or in the driver
> itself, but presumably it is needed somewhere.
> 
> It is only really special cases where some board specific device-tree
> data is needed, so it seems like this is ok to handle later.

Afaik DT data should only contain information about the hardware. This
is SW configuration, so I think DT people won't accept things like that.

> > And how about the size of the contiguous memory area, it was left a bit
> > unclear to me why it cannot be dynamic.
> 
> I don't think there is anything preventing adding a bootarg, but I
> think it is not essential so ok to add later

Well, maybe not essential to you =). But you are reserving 32MB memory,
which is quite a big amount. Even if the reserved memory can be used for
some other purposes, it's still a big chunk of "special" memory being
reserved even if the user doesn't use or have a display at all.

Well, it's not an issue for me either, but I just feel that doing things
like that without allowing the user to avoid it is a bit bad thing.

Btw, do you know why the dma_declare_contiguous() takes a dev pointer as
an argument, if the memory is not private to that device? (at least I
understood from you that the memory can be used for other purposes).

 Tomi


