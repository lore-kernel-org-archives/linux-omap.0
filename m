From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: Re: [PATCH 2/2] Input: tsc2007: do I2C transfers in non-interrupt
	context
Date: Tue, 12 May 2009 10:40:38 +0900
Message-ID: <483a38b80905111840k6b7e7aaao9b70f17753bebada@mail.gmail.com>
References: <483a38b80905110444n7d55b967j70cf2639dff1c706@mail.gmail.com>
	 <20090511153808.GA6973@dtor-d630.eng.vmware.com>
	 <20090511154122.GB6973@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20090511154122.GB6973@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, May 12, 2009 at 12:41 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, May 11, 2009 at 08:38:09AM -0700, Dmitry Torokhov wrote:
>> Hi,
>> On Mon, May 11, 2009 at 08:44:00PM +0900, Kwangwoo Lee wrote:
>> > From d5de0d22109de7564f9bf1df688acbe6b18f41db Mon Sep 17 00:00:00 =
2001
>> > From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
>> > Date: Mon, 11 May 2009 20:05:50 +0900
>> > Subject: [PATCH 2/2] Input: tsc2007: do I2C transfers in non-inter=
rupt context.
>> >
>> > This patch enhances pointer movements much smoother.
>> > The original patch is written by Thierry.
>> >
>> > --- a/drivers/input/touchscreen/tsc2007.c
>> > +++ b/drivers/input/touchscreen/tsc2007.c
>> > @@ -70,6 +70,7 @@ struct ts_event {
>> > =A0struct tsc2007 {
>> > =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*input;
>> > =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys[32];
>> > + =A0 struct work_struct =A0 =A0 =A0work;
>>
>> Every time I see a work_struct in a driver and don't see
>> cancel_work_sync() anywhere I know there are issues...
>>

Thanks for your comment. I also missed that thing, sorry.

> Also, why do we need to chain irq->timer->work now? Surely we can byp=
ass
> the timer if we have to read in process context.

It's good point. I'll check again.
Thanks.

--=20
Kwangwoo Lee <kwangwoo.lee@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
