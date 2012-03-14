From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 14 Mar 2012 08:16:33 -0500
Message-ID: <CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	<1331728737.2386.76.camel@deskari>
	<CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
	<1331730465.1542.8.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35761 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030662Ab2CNNQe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 09:16:34 -0400
Received: by vcqp1 with SMTP id p1so1892165vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 06:16:34 -0700 (PDT)
In-Reply-To: <1331730465.1542.8.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Wed, Mar 14, 2012 at 8:07 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-03-14 at 07:55 -0500, Rob Clark wrote:
>> On Wed, Mar 14, 2012 at 7:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > Hi,
>> >
>> > On Tue, 2012-03-13 at 15:34 -0500, Rob Clark wrote:
>> >> From: Andy Gross <andy.gross@ti.com>
>> >>
>> >> Register OMAP DRM/KMS platform device, and reserve a CMA region f=
or
>> >> the device to use for buffer allocation. =A0DMM is split into a
>> >> separate device using hwmod.
>> >
>> > What's the diff with this and the previous one?
>>
>> Moving drm.c to mach-omap2 (header could not move because
>> omap_reserve() is in plat-omap.. but this seems to be the same as wh=
at
>> is done for dspbridge).
>>
>> > I see you still have the platform data there. You didn't comment o=
n
>> > that. Where is it used after the board files are gone when we use =
DT?
>>
>> I was kind-of thinking that there would be some DT<->data-structure
>> glue somewhere.. not sure if this goes in mach-omap2 or in the drive=
r
>> itself, but presumably it is needed somewhere.
>>
>> It is only really special cases where some board specific device-tre=
e
>> data is needed, so it seems like this is ok to handle later.
>
> Afaik DT data should only contain information about the hardware. Thi=
s
> is SW configuration, so I think DT people won't accept things like th=
at.

hmm, then where *does* it go.. it is a bit too much for bootargs..

>> > And how about the size of the contiguous memory area, it was left =
a bit
>> > unclear to me why it cannot be dynamic.
>>
>> I don't think there is anything preventing adding a bootarg, but I
>> think it is not essential so ok to add later
>
> Well, maybe not essential to you =3D). But you are reserving 32MB mem=
ory,
> which is quite a big amount. Even if the reserved memory can be used =
for
> some other purposes, it's still a big chunk of "special" memory being
> reserved even if the user doesn't use or have a display at all.

If you didn't have display, and were tight on memory, wouldn't you
just disable the display device in your kernel config?

> Well, it's not an issue for me either, but I just feel that doing thi=
ngs
> like that without allowing the user to avoid it is a bit bad thing.
>
> Btw, do you know why the dma_declare_contiguous() takes a dev pointer=
 as
> an argument, if the memory is not private to that device? (at least I
> understood from you that the memory can be used for other purposes).

contiguous use of the memory is private to the device.  There is also
a global CMA pool, from which all dma_alloc_xyz() which is not
associated w/ a per-device pool comes from.. but the advantage of a
per-device-pool is it puts an upper limit on how much dma memory that
device can allocate so that it cannot starve other devices.

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
