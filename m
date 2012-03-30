From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 30 Mar 2012 14:50:02 +0530
Message-ID: <CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com> <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
 <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
 <4F7570FC.8000907@ti.com> <79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:37074 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751599Ab2C3JU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 05:20:26 -0400
Received: by qafl39 with SMTP id l39so320160qaf.0
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 02:20:24 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Fri, Mar 30, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> On Fri, Mar 30, 2012 at 14:08:20, Shilimkar, Santosh wrote:
>> On Friday 30 March 2012 02:02 PM, Hiremath, Vaibhav wrote:
>> > On Fri, Mar 30, 2012 at 13:11:35, Shilimkar, Santosh wrote:

[....]

>> >
>> > With this patch, will you be able to choose gptimer as a clocksour=
ce
>> > using bootparameter (or sysfs) for given kernel uImage?
>> >
>> Why do you want that ? Look at changelog. The gptimer based clocksou=
rce
>> is useless for OMAP and for AM devices synctimer is not available.
>>
>>
>> > The answer is simply NO...as the registration of gptimer is based =
on
>> > failure from omap_init_clocksource_32k(). And this is nothing diff=
erent
>> > than my original patch, my patch exactly does same thing.
>> >
>> I ight have missed your original patch. If that patch is similar the=
n
>> no problems.
>>
>> > The requirement after 'ming Lie' response on my patch was, there w=
ill be
>> > usecases where we might need to use gptimer for clocksource and wi=
th
>> > the patch it is not possible, since you will only register
>> > 32k_counter here.
>> >
>> I think Ming Lie might have expected that gptimer clocksource might
>> be better which is not the case.
>>
>> > So in order to allow user to choose between 32K and gptimer, you m=
ust
>> > register both and make 32k as a default thing.
>> >
>> As described in the commit log, its not needed at all. Let's not add
>> a feature which is just useless because the gptimer based clock
>> source has no advantage against the syntimer.
>>
>
> I completely agree with you, and that is my understanding too.
>
Thanks !!

> After Ming Lie's comment, the point that I came to my mind was,
> certainly there will be resolution difference between these two clock=
sources,
> if =A0gptimer2 is sourced from sys_ck (26Mhz).
>
GPTIMER2 with sysclock is not an option. GPTIMER is not in wakeup domai=
n
and when sysclock is cut, it stops.

> I am quite not sure, whether will there be any practical usecase wher=
e you
> change the kernel clocksource for high resolution dynamically through=
 sysfs
> or something. May be not....but still it is possible.
>
Even if there is a usecase, there no option with full PM.

>
> In that case my original patch still holds good here. I would still r=
equest
> you to review the same and give your acked-by =A0or tested-by.
>
I just looked at that.
It looks fine to me. Can you repost that patch addressing Kevin and
Tony's comments.
Also update the change log as describe in the patch i posted.

Once that done, will ack it.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
