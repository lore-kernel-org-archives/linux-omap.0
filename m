From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RESEND][PATCH] input: Added TSC2003
Date: Tue, 16 Jun 2009 10:16:13 +0200
Message-ID: <20090616081613.GA3679@avionic-design.de>
References: <4A366439.70005@mocean-labs.com> <5d5443650906151110u3f7d9d1cm1990e767d29a45b6@mail.gmail.com> <4A36A1C2.2060805@mocean-labs.com> <20090616062044.GA20209@avionic-design.de> <4A374C50.1000508@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61035 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbZFPIQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 04:16:24 -0400
Content-Disposition: inline
In-Reply-To: <4A374C50.1000508@mocean-labs.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Kwangwoo Lee <kwangwoo.lee@gmail.com>

[Cc'ing Kwangwoo Lee]

* Richard R=C3=B6jfors wrote:
> On 09-06-16 08.20, Thierry Reding wrote:
> >>>>
> >>> Meaning? I think I2C transaction can sleep.
> >> Yes that's what it means, and that's bad in a HR timer callback.
> >=20
> > Note that my patch to the tsc2007 to support the tsc2003 exactly fi=
xes this
> > problem. It moves the actual I2C transfers into a workqueue, so no =
sleeping
> > functions are called from the hrtimer callback.
>=20
> Ah good! The IRQ is disabled no sync too.
> We actually don't have the possibility to implement a pen down state =
callback,
> so I need to modify the code slightly to work even without one. (but =
not be
> as accurate when the callback is not available)
>=20
> Your patch where it schedules work rather than calling the I2C functi=
on directly
> isn't in mainline.
> I saw a patch where you added the work scheduling, and a later patch =
where you
> fixed some spinlock stuff, have you resent the patch for the work sch=
eduling?

I think there were still some issues with that patch. Kwangwoo Lee was =
the
last to comment. This is from the previous thread:

> On Tue, May 12, 2009 at 12:41 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, May 11, 2009 at 08:38:09AM -0700, Dmitry Torokhov wrote:
> >> Hi,
> >> On Mon, May 11, 2009 at 08:44:00PM +0900, Kwangwoo Lee wrote:
> >> > From d5de0d22109de7564f9bf1df688acbe6b18f41db Mon Sep 17 00:00:0=
0 2001
> >> > From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> >> > Date: Mon, 11 May 2009 20:05:50 +0900
> >> > Subject: [PATCH 2/2] Input: tsc2007: do I2C transfers in non-int=
errupt
> >> > context.
> >> >
> >> > This patch enhances pointer movements much smoother.
> >> > The original patch is written by Thierry.
> >> >
> >> > --- a/drivers/input/touchscreen/tsc2007.c
> >> > +++ b/drivers/input/touchscreen/tsc2007.c
> >> > @@ -70,6 +70,7 @@ struct ts_event {
> >> > =C2=A0struct tsc2007 {
> >> > =C2=A0 =C2=A0 struct input_dev =C2=A0 =C2=A0 =C2=A0 =C2=A0*input=
;
> >> > =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0phys[32];
> >> > + =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0work;
> >>
> >> Every time I see a work_struct in a driver and don't see
> >> cancel_work_sync() anywhere I know there are issues...
> >>
>=20
> Thanks for your comment. I also missed that thing, sorry.
>=20
> > Also, why do we need to chain irq->timer->work now? Surely we can b=
ypass
> > the timer if we have to read in process context.
>=20
> It's good point. I'll check again.
> Thanks.

So perhaps some more work is required to get this mainlined.

Thierry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
