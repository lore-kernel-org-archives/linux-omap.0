From: Nicolae Rosia <nicolae.rosia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/6] Touchscreen performance related fixes
Date: Thu, 11 Dec 2014 22:34:10 +0200
Message-ID: <CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
	<20141124115116.GA14997@linutronix.de>
	<547C3A95.30605@ti.com>
	<547C3C19.5090501@linutronix.de>
	<547C42FF.5010700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <547C42FF.5010700-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

Any updates on this series? I don't see it applied in [1] or [2].

[1] https://github.com/RobertCNelson/ti-linux-kernel/commits/ti-linux-3.14.y/drivers/input/touchscreen/ti_am335x_tsc.c
[2] https://github.com/RobertCNelson/ti-linux-kernel/commits/ti-linux-3.14.y-exp/drivers/input/touchscreen/ti_am335x_tsc.c

Regards,
Nicolae Rosia

On Mon, Dec 1, 2014 at 12:29 PM, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>
> Hi,
>
> On Monday 01 December 2014 03:29 PM, Sebastian Andrzej Siewior wrote:
>> On 12/01/2014 10:53 AM, Vignesh R wrote:
>>> Hi Sebastian,
>>
>> Hi Vignesh,
>>
>>> I fixed the issue that was triggering the WARN_ON(). I think it would be
>>> better if you tested these patches, before I posted them on the
>>> mainline. I don't want to clutter the list with too main versions. Here
>>> is the link to the tree with latest changes:
>>
>> awesome, thank you.
>>
>>>
>>> git clone -b tsc-devel git://git.ti.com/kernel/tsc-adc.git
>>> (tsc-devel branch)
>>
>> I will and let you know.
>>
>>> Please test the above tree and let me know the results.
>>> I will post new version(v5) if there are no issues wrt IIO and TSC
>>> working at the same time.
>>
>> Cool. Were you able to get in touch with someone who has a 5-wire touch?
>
> I have asked Jeff Lance to verify 5-wire touch.
>
> Regards
> Vignesh
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
