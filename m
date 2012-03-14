From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Wed, 14 Mar 2012 07:55:07 -0500
Message-ID: <CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	<1331728737.2386.76.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44319 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2CNMzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 08:55:08 -0400
Received: by vcqp1 with SMTP id p1so1870016vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 05:55:07 -0700 (PDT)
In-Reply-To: <1331728737.2386.76.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Wed, Mar 14, 2012 at 7:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi,
>
> On Tue, 2012-03-13 at 15:34 -0500, Rob Clark wrote:
>> From: Andy Gross <andy.gross@ti.com>
>>
>> Register OMAP DRM/KMS platform device, and reserve a CMA region for
>> the device to use for buffer allocation. =A0DMM is split into a
>> separate device using hwmod.
>
> What's the diff with this and the previous one?

Moving drm.c to mach-omap2 (header could not move because
omap_reserve() is in plat-omap.. but this seems to be the same as what
is done for dspbridge).

> I see you still have the platform data there. You didn't comment on
> that. Where is it used after the board files are gone when we use DT?

I was kind-of thinking that there would be some DT<->data-structure
glue somewhere.. not sure if this goes in mach-omap2 or in the driver
itself, but presumably it is needed somewhere.

It is only really special cases where some board specific device-tree
data is needed, so it seems like this is ok to handle later.

> And how about the size of the contiguous memory area, it was left a b=
it
> unclear to me why it cannot be dynamic.

I don't think there is anything preventing adding a bootarg, but I
think it is not essential so ok to add later

BR,
-R

> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
