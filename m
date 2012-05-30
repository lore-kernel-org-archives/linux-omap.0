From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/2] remoteproc: maintain a generic child device for each rproc
Date: Wed, 30 May 2012 15:16:12 +0300
Message-ID: <CAK=WgbZJJJPuNWVv8WgL=KKm6Hrx2krDD9gBOTP7sA8p7mh_rA@mail.gmail.com>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com> <4FC5DBFA.2030300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46316 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab2E3MQd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 08:16:33 -0400
Received: by gglu4 with SMTP id u4so3374350ggl.19
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 05:16:32 -0700 (PDT)
In-Reply-To: <4FC5DBFA.2030300@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>

Hi Stephen,

As always - thanks for your review!

On Wed, May 30, 2012 at 11:36 AM, Stephen Boyd <sboyd@codeaurora.org> w=
rote:
> It looks like remoteproc0, remoteproc1, etc. is what's used.

Thanks, I'll update the commit log.

> One complaint I've gotten is that the error messages are essentially
> useless now. I believe there are some ongoing discussions on lkml to =
fix
> this by traversing the device hierarchy to find the "real" device but
> the hard part is finding the real device.

You probably refer to the discussions around the input subsystem's pull=
 request.

I was thinking about that too when creating this patch, and it looks
like whatever Greg will come up with on that matter will benefit us
too. So taking that into account, it might make more sense to do stick
with the virtual device rather than use the real one here (we'll end
up having more information in the long run).

>> +/* Unique numbering for remoteproc devices */
>> +static unsigned int dev_index;
>> +
>
> Hm... perhaps use that ida stuff instead of a raw integer?

That one got me thinking.

The immediate instinct is to do want to have a fully dynamic and
recyclable enumeration method, like ida provides.

But if you think of it, a mere integer have a strong advantage here:
the fact that the indices it provides don't recycle so fast is a plus,
because if a device was removed and recreated (or just removed and
another one then shows up), you get different indices. So a quick
glimpse at the logs is enough to tell that a new device was created.

But adding a spin lock to make this thread safe takes the simplicity
charm away. So in that respect, using an ida is much more attractive.

> I'm not clear on busses versus classes.

I think that busses is a whole lot more complex beast. Probably the
main indication we want one is when we need to match drivers to
devices.

In this case, I was more wondering between using a class to a device ty=
pe.

> I recall seeing a thread where
> someone said classes were on the way out and shouldn't be used but I
> can't find it anymore.

I also remembered a similar discussion at a plumbers mini-conf about
2-3 years ago too, so I looked at device_type as an alternative to
class. The former looks somewhat simpler, but I couldn't find any
major advantage for using one over the other, and both seem to be in
use by many subsystems.

> Should we use classes for devices that will never
> have a matching driver?

It's not strictly required, but in case we want to provide these
devices some common behavior (and in our case we want them all to have
the same release handler, and very soon, the same PM handlers, too),
then a class (or a type) is helpful.

It looks like moving from a class to a type is quite trivial, in case
classes do eventually go away (or an advantage of using the latter
shows up), but I'm not aware of any other viable alternative for us
other than class/type.

>> + =A0 =A0 /* Assign a unique device index and name */
>> + =A0 =A0 rproc->index =3D dev_index++;
>> + =A0 =A0 dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
>> +
>
> This doesn't look thread safe. ida would fix this (ida_simple_get/rem=
ove
> looks like what you want).

Yes, that's a good point, and will probably win this integer vs. ida ca=
se.

>> @@ -391,7 +392,7 @@ struct rproc {
>> =A0 =A0 =A0 const char *firmware;
>> =A0 =A0 =A0 void *priv;
>> =A0 =A0 =A0 const struct rproc_ops *ops;
>> - =A0 =A0 struct device *dev;
>> + =A0 =A0 struct device dev;
>
> I'm not sure if the kernel-doc for this field is accurate anymore. Is=
 it
> an 'underlying device' still?

It's not, thanks for pointing it out!

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
