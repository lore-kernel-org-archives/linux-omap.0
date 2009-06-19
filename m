From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: Re: [RESEND][PATCH] input: Added TSC2003
Date: Fri, 19 Jun 2009 09:50:05 +0900
Message-ID: <483a38b80906181750l353ba24ewb7ea37652c77a2e4@mail.gmail.com>
References: <4A366439.70005@mocean-labs.com>
	 <5d5443650906151110u3f7d9d1cm1990e767d29a45b6@mail.gmail.com>
	 <4A36A1C2.2060805@mocean-labs.com>
	 <20090616062044.GA20209@avionic-design.de>
	 <4A374C50.1000508@mocean-labs.com>
	 <20090616081613.GA3679@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:50562 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbZFSAuE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 20:50:04 -0400
In-Reply-To: <20090616081613.GA3679@avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org

Hi,

On Tue, Jun 16, 2009 at 5:16 PM, Thierry
Reding<thierry.reding@avionic-design.de> wrote:
> [Cc'ing Kwangwoo Lee]
>
> * Richard R=F6jfors wrote:
>> On 09-06-16 08.20, Thierry Reding wrote:
>> >>>>
>> >>> Meaning? I think I2C transaction can sleep.
>> >> Yes that's what it means, and that's bad in a HR timer callback.
>> >
>> > Note that my patch to the tsc2007 to support the tsc2003 exactly f=
ixes this
>> > problem. It moves the actual I2C transfers into a workqueue, so no=
 sleeping
>> > functions are called from the hrtimer callback.
>>
>> Ah good! The IRQ is disabled no sync too.
>> We actually don't have the possibility to implement a pen down state=
 callback,
>> so I need to modify the code slightly to work even without one. (but=
 not be
>> as accurate when the callback is not available)
>>
>> Your patch where it schedules work rather than calling the I2C funct=
ion directly
>> isn't in mainline.
>> I saw a patch where you added the work scheduling, and a later patch=
 where you
>> fixed some spinlock stuff, have you resent the patch for the work sc=
heduling?
>
> I think there were still some issues with that patch. Kwangwoo Lee wa=
s the
> last to comment. This is from the previous thread:
>
>> On Tue, May 12, 2009 at 12:41 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Mon, May 11, 2009 at 08:38:09AM -0700, Dmitry Torokhov wrote:
>> >> Hi,
>> >> On Mon, May 11, 2009 at 08:44:00PM +0900, Kwangwoo Lee wrote:
>> >> > From d5de0d22109de7564f9bf1df688acbe6b18f41db Mon Sep 17 00:00:=
00 2001
>> >> > From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
>> >> > Date: Mon, 11 May 2009 20:05:50 +0900
>> >> > Subject: [PATCH 2/2] Input: tsc2007: do I2C transfers in non-in=
terrupt
>> >> > context.
>> >> >
>> >> > This patch enhances pointer movements much smoother.
>> >> > The original patch is written by Thierry.
>> >> >
>> >> > --- a/drivers/input/touchscreen/tsc2007.c
>> >> > +++ b/drivers/input/touchscreen/tsc2007.c
>> >> > @@ -70,6 +70,7 @@ struct ts_event {
>> >> > =A0struct tsc2007 {
>> >> > =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*input;
>> >> > =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys[32];
>> >> > + =A0 struct work_struct =A0 =A0 =A0work;
>> >>
>> >> Every time I see a work_struct in a driver and don't see
>> >> cancel_work_sync() anywhere I know there are issues...
>> >>
>>
>> Thanks for your comment. I also missed that thing, sorry.
>>
>> > Also, why do we need to chain irq->timer->work now? Surely we can =
bypass
>> > the timer if we have to read in process context.
>>
>> It's good point. I'll check again.
>> Thanks.
>
> So perhaps some more work is required to get this mainlined.

Sorry for my late reply.

I think that the driver need to be fixed to send i2c command
asynchronously (if possible)
or replace hrtimer with delayed workqueue as Dmitry pointed out above.

Hmm.. I'm going to move to the other company, so I do not have the
testing environment anymore.
I can see the emails from the list, but can anyone else follow up the
driver, please?

Thanks.

--=20
Kwangwoo Lee <kwangwoo.lee@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
