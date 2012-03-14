From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 14 Mar 2012 15:43:44 +0200
Message-ID: <1331732624.1542.32.camel@lappy>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	 <1331728737.2386.76.camel@deskari>
	 <CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
	 <1331730465.1542.8.camel@lappy>
	 <CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:50781 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756854Ab2CNNnt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 09:43:49 -0400
Received: by mail-lb0-f182.google.com with SMTP id i15so1525199lbo.27
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 06:43:48 -0700 (PDT)
In-Reply-To: <CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, 2012-03-14 at 08:16 -0500, Rob Clark wrote:
> On Wed, Mar 14, 2012 at 8:07 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2012-03-14 at 07:55 -0500, Rob Clark wrote:
> >> On Wed, Mar 14, 2012 at 7:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > Hi,
> >> >
> >> > On Tue, 2012-03-13 at 15:34 -0500, Rob Clark wrote:
> >> >> From: Andy Gross <andy.gross@ti.com>
> >> >>
> >> >> Register OMAP DRM/KMS platform device, and reserve a CMA region for
> >> >> the device to use for buffer allocation.  DMM is split into a
> >> >> separate device using hwmod.
> >> >
> >> > What's the diff with this and the previous one?
> >>
> >> Moving drm.c to mach-omap2 (header could not move because
> >> omap_reserve() is in plat-omap.. but this seems to be the same as what
> >> is done for dspbridge).
> >>
> >> > I see you still have the platform data there. You didn't comment on
> >> > that. Where is it used after the board files are gone when we use DT?
> >>
> >> I was kind-of thinking that there would be some DT<->data-structure
> >> glue somewhere.. not sure if this goes in mach-omap2 or in the driver
> >> itself, but presumably it is needed somewhere.
> >>
> >> It is only really special cases where some board specific device-tree
> >> data is needed, so it seems like this is ok to handle later.
> >
> > Afaik DT data should only contain information about the hardware. This
> > is SW configuration, so I think DT people won't accept things like that.
> 
> hmm, then where *does* it go.. it is a bit too much for bootargs..

I have no idea =). And I may be wrong, but my understanding is the the
only thing DT data should have is information about the HW
configuration.

But is that kind of configuration needed at boot time? Why cannot the
userspace do the config? What configs are actually needed at boot time,
before userspace takes control? The only thing coming to my mind is to
define the display used for the console.

> >> > And how about the size of the contiguous memory area, it was left a bit
> >> > unclear to me why it cannot be dynamic.
> >>
> >> I don't think there is anything preventing adding a bootarg, but I
> >> think it is not essential so ok to add later
> >
> > Well, maybe not essential to you =). But you are reserving 32MB memory,
> > which is quite a big amount. Even if the reserved memory can be used for
> > some other purposes, it's still a big chunk of "special" memory being
> > reserved even if the user doesn't use or have a display at all.
> 
> If you didn't have display, and were tight on memory, wouldn't you
> just disable the display device in your kernel config?

Sure, if you want to modify your kernel. But you could as well use the
same kernel binary, and just say vram=0M which disables the vram
allocation. For DRM you would _have_ to modify your kernel.

Actually, I just realized vram=0M doesn't work, as the code checks for !
= 0, and just skips the vram argument when it's 0 =). So my code sucks
also...

> > Well, it's not an issue for me either, but I just feel that doing things
> > like that without allowing the user to avoid it is a bit bad thing.
> >
> > Btw, do you know why the dma_declare_contiguous() takes a dev pointer as
> > an argument, if the memory is not private to that device? (at least I
> > understood from you that the memory can be used for other purposes).
> 
> contiguous use of the memory is private to the device.  There is also
> a global CMA pool, from which all dma_alloc_xyz() which is not
> associated w/ a per-device pool comes from.. but the advantage of a
> per-device-pool is it puts an upper limit on how much dma memory that
> device can allocate so that it cannot starve other devices.

Ah, I see. So the 32MB you reserve there is not visible as contiguous
memory to anyone else than omapdrm, but userspace can still use the 32MB
area for pages that can be moved out as needed.

But then, if it's private, it's also rather bad. If I have a kernel with
omapfb and omapdrm enabled as modules, but I never use omapdrm, the 32MB
is still always reserver and away from other contiguous memory use.

Also, I just realized that besides the memory reservation being fixed,
it's also hidden. If I enable omapdrm in the kernel config, I get no
indication that 32MB of mem is being reserved. Perhaps a Kconfig option
for it, like with OMAP VRAM, and then a boot arg which will override the
Kconfig value.

Well, as I said, it's not an issue for me and from my side it can be
improved later.

 Tomi


