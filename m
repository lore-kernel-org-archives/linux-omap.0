From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Thu, 9 Jun 2011 14:29:30 +0900
Message-ID: <BANLkTimFJdRAipL0Gq_K=RYKcWmDNpds+w@mail.gmail.com>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
	<201106062029.36389.rjw@sisk.pl>
	<87zkluwqab.fsf@ti.com>
	<201106072332.30464.rjw@sisk.pl>
	<87hb80546c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40121 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab1FIF3b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 01:29:31 -0400
Received: by iyb14 with SMTP id 14so1035954iyb.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 22:29:30 -0700 (PDT)
In-Reply-To: <87hb80546c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Kevin,

On Thu, Jun 9, 2011 at 7:50 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>
> [...]
>
>> you need to separate the system suspend handling from runtime PM.
>
> /me risks getting yelled at again and jumps back in ;)

=3D)

>> Each of them requires a different approach, because the goal is real=
ly
>> different in both cases (basically, runtime PM triggers when the
>> device is _known_ to be idle, while system suspend may trigger while
>> it's actually being used).
>
> OK, but from the driver's perspective, the goals do not seem all that
> different to me:
>
> Runtime suspend
> 1. activity
> 2. activity finishes
> 3. device is _known_ to be idle
> 4. trigger device low-power transition
>
> system suspend [echo mem > /sys/power/state]
> 1. activity
> 2. prevent future activity, halt/wait for current activity
> 3. device is _known_ to be idle
> 4. trigger device low-power transition
>
> The only difference is step 2. =A0In runtime suspend, the activity
> finishes on its own, in system suspend, the activity is forcibly
> stopped. =A0In either case, after that point the device is known to b=
e
> idle, and proceeding from there is identical. =A0IOW, based on the ab=
ove,
> another way of looking at system PM is forcing idle so that runtime P=
M
> can happen.

I agree with the view that system wide suspend is similar to force
idle in the case of a non-wakeup device. If you flip that around then
from a device driver perspective, system wide suspend on a device
which is a wakeup source looks like forcing enable.

This is how I see the system wide suspend including wakeup support:

1. activity
(In case of an ethernet device for instance, the network may be up or d=
own)
2. save current state
3. prevent future activity, halt/wait for current activity
4. device is _known_ to be idle
5. if wakeup is enabled, force enable regardless of state in step 1 abo=
ve
6. trigger device low-power transition (if possible)

=46or system wide resume:

1. wake up from low-power state (if needed)
2. if wakeup was enabled, force idle - similar to suspend step 3 above
3. device is _known_ to be idle
4. restore state saved in suspend step 2 above
5. activity
(Also, make sure no interrupts are lost)

The two roles for each wakeup-capable driver, and switching between
those adds quite a bit of complexity. The absolute best part is the
interrupt leakage between the wakeup state and the real state. Almost
impossible to get right. =3D)

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
