From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 14 Mar 2012 10:06:22 -0500
Message-ID: <CAF6AEGsCpz4zXCSXhP5qA7hL4Xac9+c03rS1PZejhUog_+SHkg@mail.gmail.com>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	<1331728737.2386.76.camel@deskari>
	<CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
	<1331730465.1542.8.camel@lappy>
	<CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
	<1331732624.1542.32.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42733 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149Ab2CNPGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 11:06:22 -0400
Received: by vcqp1 with SMTP id p1so2010059vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 08:06:22 -0700 (PDT)
In-Reply-To: <1331732624.1542.32.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, Mar 14, 2012 at 8:43 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-03-14 at 08:16 -0500, Rob Clark wrote:
>> On Wed, Mar 14, 2012 at 8:07 AM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Wed, 2012-03-14 at 07:55 -0500, Rob Clark wrote:
>> >> On Wed, Mar 14, 2012 at 7:38 AM, Tomi Valkeinen <tomi.valkeinen@t=
i.com> wrote:
>> >> > Hi,
>> >> >
>> >> > On Tue, 2012-03-13 at 15:34 -0500, Rob Clark wrote:
>> >> >> From: Andy Gross <andy.gross@ti.com>
>> >> >>
>> >> >> Register OMAP DRM/KMS platform device, and reserve a CMA regio=
n for
>> >> >> the device to use for buffer allocation. =A0DMM is split into =
a
>> >> >> separate device using hwmod.
>> >> >
>> >> > What's the diff with this and the previous one?
>> >>
>> >> Moving drm.c to mach-omap2 (header could not move because
>> >> omap_reserve() is in plat-omap.. but this seems to be the same as=
 what
>> >> is done for dspbridge).
>> >>
>> >> > I see you still have the platform data there. You didn't commen=
t on
>> >> > that. Where is it used after the board files are gone when we u=
se DT?
>> >>
>> >> I was kind-of thinking that there would be some DT<->data-structu=
re
>> >> glue somewhere.. not sure if this goes in mach-omap2 or in the dr=
iver
>> >> itself, but presumably it is needed somewhere.
>> >>
>> >> It is only really special cases where some board specific device-=
tree
>> >> data is needed, so it seems like this is ok to handle later.
>> >
>> > Afaik DT data should only contain information about the hardware. =
This
>> > is SW configuration, so I think DT people won't accept things like=
 that.
>>
>> hmm, then where *does* it go.. it is a bit too much for bootargs..
>
> I have no idea =3D). And I may be wrong, but my understanding is the =
the
> only thing DT data should have is information about the HW
> configuration.
>
> But is that kind of configuration needed at boot time? Why cannot the
> userspace do the config? What configs are actually needed at boot tim=
e,
> before userspace takes control? The only thing coming to my mind is t=
o
> define the display used for the console.

drm builds up list of resources at startup, and attempts to light up
any connected displays at boot..  the decision about what resources to
use must be taken before userspace starts.

Anyways, if it is too controversial, maybe I just remove it.  It is
really only very special cases (possibly multi-seat setups) where you
might want to do something other than the default (which is for a
single omapdrm instance to use all dss video pipes).  It is just code
I had written previously for a certain product, and it seemed
potentially useful enough to not strip out of the upstream driver.

>> >> > And how about the size of the contiguous memory area, it was le=
ft a bit
>> >> > unclear to me why it cannot be dynamic.
>> >>
>> >> I don't think there is anything preventing adding a bootarg, but =
I
>> >> think it is not essential so ok to add later
>> >
>> > Well, maybe not essential to you =3D). But you are reserving 32MB =
memory,
>> > which is quite a big amount. Even if the reserved memory can be us=
ed for
>> > some other purposes, it's still a big chunk of "special" memory be=
ing
>> > reserved even if the user doesn't use or have a display at all.
>>
>> If you didn't have display, and were tight on memory, wouldn't you
>> just disable the display device in your kernel config?
>
> Sure, if you want to modify your kernel. But you could as well use th=
e
> same kernel binary, and just say vram=3D0M which disables the vram
> allocation. For DRM you would _have_ to modify your kernel.
>
> Actually, I just realized vram=3D0M doesn't work, as the code checks =
for !
> =3D 0, and just skips the vram argument when it's 0 =3D). So my code =
sucks
> also...

well, I suppose there is always something somewhere to improve..

anyways, at this point omapdrm isn't enabled by default in
omap2plus_defconfig.. I just want to get the platform device
registration merged in some form so folks don't have to go poking
around to find some out of tree patch in order to enable it.

>> > Well, it's not an issue for me either, but I just feel that doing =
things
>> > like that without allowing the user to avoid it is a bit bad thing=
=2E
>> >
>> > Btw, do you know why the dma_declare_contiguous() takes a dev poin=
ter as
>> > an argument, if the memory is not private to that device? (at leas=
t I
>> > understood from you that the memory can be used for other purposes=
).
>>
>> contiguous use of the memory is private to the device. =A0There is a=
lso
>> a global CMA pool, from which all dma_alloc_xyz() which is not
>> associated w/ a per-device pool comes from.. but the advantage of a
>> per-device-pool is it puts an upper limit on how much dma memory tha=
t
>> device can allocate so that it cannot starve other devices.
>
> Ah, I see. So the 32MB you reserve there is not visible as contiguous
> memory to anyone else than omapdrm, but userspace can still use the 3=
2MB
> area for pages that can be moved out as needed.
>
> But then, if it's private, it's also rather bad. If I have a kernel w=
ith
> omapfb and omapdrm enabled as modules, but I never use omapdrm, the 3=
2MB
> is still always reserver and away from other contiguous memory use.
>
> Also, I just realized that besides the memory reservation being fixed=
,
> it's also hidden. If I enable omapdrm in the kernel config, I get no
> indication that 32MB of mem is being reserved. Perhaps a Kconfig opti=
on
> for it, like with OMAP VRAM, and then a boot arg which will override =
the
> Kconfig value.

well, there is a useful CMA debug option which will print some traces
when CMA pools are created, etc.. (but probably not what you meant)

> Well, as I said, it's not an issue for me and from my side it can be
> improved later.

yeah, when CMA is actually merged, there are a few other things I'd
like to do to, incl converting omapfb over to use CMA and remove
omap_vram.. but I guess those will be other patches.

BR,
-R

> =A0Tomi
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
