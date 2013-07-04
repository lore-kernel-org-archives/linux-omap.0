From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/22] input/ti_am33x_tsc: Order of TSC wires, made configurable
Date: Thu, 4 Jul 2013 19:09:05 +0530
Message-ID: <51D57AF9.2020001@ti.com>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <1370950268-7224-5-git-send-email-bigeasy@linutronix.de> <51D5592F.6050208@ti.com> <51D55D80.6080803@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51D55D80.6080803-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 7/4/2013 5:03 PM, Sebastian Andrzej Siewior wrote:
> On 07/04/2013 01:14 PM, Sekhar Nori wrote:
>>
>> On 6/11/2013 5:00 PM, Sebastian Andrzej Siewior wrote:
>>> From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
>>>
>>> The current driver expected touchscreen input
>>> wires(XP,XN,YP,YN) to be connected in a particular order.
>>> Making changes to accept this as platform data
>>
>> The platform data part of this driver will never get used since it is
>> used on DT-only platforms (and future platforms will all be DT-only).
>> You should get rid of it as it will save you some code.
> 
> If you follow the series you will notice that the platform bits are
> removed later. Should I have overlooked something please say so.

Yes, I noticed that after sending the mail. To me it does not make sense
to make changes to accept something as platform data only to remove
platform data itself later.

May be reorder the series to move this to after platform data removal -
that way any platform data related changes in the patch will have to go
away.

Thanks,
Sekhar
