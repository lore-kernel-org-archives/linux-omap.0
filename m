From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
Date: Wed, 7 Sep 2011 22:58:02 +0300
Message-ID: <CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com> <1314191356-10963-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab1IGT6X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 15:58:23 -0400
Received: by wwf5 with SMTP id 5so20510wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 12:58:22 -0700 (PDT)
In-Reply-To: <1314191356-10963-7-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Arnd Bergmann <arnd@arndb.de>, Mathieu Poirier <mathieu.poirier@linaro.org>

On Wed, Aug 24, 2011 at 4:09 PM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> Add a device-tree node for the spinlock.
> Remove the static device build code if CONFIG_OF
> is set.
> Update the hwspinlock driver to use the of_match method.
> Add the information in Documentation/devicetree.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> ---
=2E..
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spinlock {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
-spinlock";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwmods =3D "spinlock";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

This seem to satisfy the current hwspinlock driver, but I'm wondering
about an issue which was discussed awhile ago by Arnd and Mathieu:

Hwspinlock devices provide system-wide hardware locks that are used by
remote processors that have no other way to achieve synchronization.

=46or that to work, each physical lock must have a system-wide unique i=
d
number that all processors are familiar with, otherwise they can't
possibly assume they're using the same hardware lock.

Usually SoC have a single hwspinlock device, which provides several
hardware spinlocks, and in this case, the locks can be trivially
numbered 0 to (num-of-locks - 1).

In case boards have several hwspinlocks devices (each of which
providing numerous hardware spinlocks) a different base id should be
used for each hwspinlock device (they can't all use 0 as a starting
id!).

While this is certainly not common, it's just plain wrong for the
hwspinlock driver to silently use 0 as a base id whenever it is probed
with a device (and by that implicitly assume there will always be only
one device).

So we need to couple an hwspinlock device with a base id (which is
trivially zero when there's only a single hwspinlock device). This can
be easily achieved today using platform data, which boards will use to
set a different base id for each of the hwspinlock devices they have
(i'll send a patch demonstrating this soon), but I'm wondering how to
specify this hwspinlock-specific data with DT: is there an existing
binding we can use for this ? or should we create something like a
"baseid" one especially for the hwspinlock driver ?

> +#if defined(CONFIG_OF)
> +static const struct of_device_id spinlock_match[] =3D {
> + =A0 =A0 =A0 {.compatible =3D "ti,omap-spinlock", },
> + =A0 =A0 =A0 {},
> +}

you're missing a semicolon there (yeah I actually tried to build this ;=
)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
