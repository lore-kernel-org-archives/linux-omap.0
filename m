From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 7 Mar 2012 07:06:17 -0600
Message-ID: <CAF6AEGsoXye0jdbZrkBpXTSHPhV6Zue7K9YLw_FopoLHGwE2vg@mail.gmail.com>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
	<CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	<1331044544.2059.150.camel@deskari>
	<CAF6AEGvtGjgw+uEKTu34ukXNqZ-+gS6pQtv2oFM11X8ik1zY5w@mail.gmail.com>
	<1331121599.4348.22.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43299 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab2CGNGS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 08:06:18 -0500
Received: by vcqp1 with SMTP id p1so5352405vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 05:06:18 -0800 (PST)
In-Reply-To: <1331121599.4348.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, Mar 7, 2012 at 5:59 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Tue, 2012-03-06 at 09:29 -0600, Rob Clark wrote:
>> On Tue, Mar 6, 2012 at 8:35 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>> > On Tue, 2012-03-06 at 08:01 -0600, Rob Clark wrote:
>> >> On Tue, Mar 6, 2012 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@ti=
=2Ecom> wrote:
>> >
>> >> > Can there be more than one omapdrm device? I guess not. If so, =
the id
>> >> > should be -1.
>> >>
>> >> in the past, we have used multiple devices (using the platform-da=
ta to
>> >> divide up the dss resources), although this was sort of a
>> >> special-case. =A0But in theory you could have multiple. =A0(Think=
 of a
>> >> multi-seat scenario, where multiple compositors need to run and e=
ach
>> >> need to be drm-master of their own device to do mode-setting on t=
heir
>> >> corresponding display.)
>> >>
>> >> I think if we use .id =3D -1, then we'd end up with a funny looki=
ng
>> >> bus-id for the device: "platform:omapdrm:-1"
>> >
>> > I don't know about that, but it's the way platform devices are mea=
nt to
>> > be used if there can be only one instance. If the case where there=
 are
>> > multiple omapdrm devices is rather theoretical, or only used for c=
ertain
>> > debugging scenarios or such, I think having the id as -1 in the ma=
inline
>> > is cleaner.
>>
>> well, I don't care much one way or another, but need to check if the=
re
>> is a small patch needed in drm core code that generates the bus-id f=
or
>> .id =3D -1..
>
> Hmm, why does the drm core care about it?

Because it is the one generating the bus-id.. see
drivers/gpu/drm/drm_platform.c drm_platform_set_busid()

Anyways, it's just a detail about how libdrm/drmOpen() can
differentiate between multiple instances of the same driver, similar
to how PCI bus-id is used in the desktop world.  It is not difficult
to change in drm_platform_set_busid(), although not sure if that would
be considered an ABI change to userspace.  (Maybe it is less critical,
I'm under the impression that other platform-drm users didn't even
realize we had a bus-id.)

> And generally, I think if the bus id is -1, there is no bus id in a
> sense. For example, with bus id 0 you'll get a device "omapdrm.0". Wi=
th
> bus id -1 you'll get a device "omapdrm".
>
>> >> >> +arch_initcall(omap_init_gpu);
>> >> >> +
>> >> >> +void omapdrm_reserve_vram(void)
>> >> >> +{
>> >> >> +#ifdef CONFIG_CMA
>> >> >> + =A0 =A0 /*
>> >> >> + =A0 =A0 =A0* Create private 32MiB contiguous memory area for=
 omapdrm.0 device
>> >> >> + =A0 =A0 =A0* TODO revisit size.. if uc/wc buffers are alloca=
ted from CMA pages
>> >> >> + =A0 =A0 =A0* then the amount of memory we need goes up..
>> >> >> + =A0 =A0 =A0*/
>> >> >> + =A0 =A0 dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ=
_1M, 0, 0);
>> >> >
>> >> > What does this actually do? Does it reserve the memory, i.e. it=
's not
>> >> > usable for others? If so, shouldn't there be a way for the user=
 to
>> >> > configure it?
>> >>
>> >> It can be re-used by others.. see http://lwn.net/Articles/479297/
>> >
>> > The link didn't tell much. I looked at the patches, and
>> > dma_declare_contiguous allocates the memory with memblock_alloc. S=
o is
>> > that allocated memory available for any users? If so, why does the
>> > function want a device pointer as an argument...
>> >
>> > Is the memory available for normal kmalloc, or only available via =
the
>> > CMA functions? Surely there must be some downside to the above? =3D=
) And
>> > if so, it should be configurable. You could have a board with no d=
isplay
>> > at all, and you probably don't want to have 32MB allocated for DRM=
 in
>> > that case.
>>
>> Basically the short version is memory from a CMA carveout can be
>> re-used for unpinnable memory. =A0Not kmalloc, but it can be used fo=
r
>> anon userspace pages, for example. =A0Userspace needs memory too.
>
> Okay, let me ask the other way. Is 32MB enough for everyone? Hardcodi=
ng
> a value like that without any possibility to adjust it just sounds li=
ke
> a rather bad thing.

The main requirement is that, on omap3 or before (platforms without
DMM) you need enough to allocate all of your scanout buffers.

I'm not against having a bootarg to adjust, although I strongly prefer
sane defaults and not requiring a million bootargs just to boot in
some usable fashion.

BR,
-R

> =A0Tomi
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
