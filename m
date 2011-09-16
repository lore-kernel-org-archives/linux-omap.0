From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
Date: Fri, 16 Sep 2011 10:07:26 +0530
Message-ID: <CAMQu2gyuzTX7AWFgz2=wVSzQoRUJy4_AY6qZYDipd_WXkBK6yQ@mail.gmail.com>
References: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com> <20110915203738.GA23208@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41965 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069Ab1IPEhr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 00:37:47 -0400
Received: by mail-gw0-f48.google.com with SMTP id 22so3355604gwj.21
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 21:37:46 -0700 (PDT)
In-Reply-To: <20110915203738.GA23208@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Fri, Sep 16, 2011 at 2:07 AM, Todd Poynor <toddpoynor@google.com> wr=
ote:
> On Tue, Sep 06, 2011 at 09:29:30PM +0530, Santosh Shilimkar wrote:
>> TWL6030 devices have an interrupt line which is connected to
>> application processor like OMAP. These devices support multiple feat=
ures
>> such as MMC card detect, USB cable detect, RTC interrupt, etc. that =
must
>> wake up the application processor.
>>
>> With this change, TWL6030 client drivers can make use of
>> irq_wake() if the wakeup is desirable on it's irq events.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0drivers/mfd/twl6030-irq.c | =A0 =A09 +++++++++
>> =A01 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
>> index eb3b5f8..4477134 100644
>> --- a/drivers/mfd/twl6030-irq.c
>> +++ b/drivers/mfd/twl6030-irq.c
>> @@ -187,6 +187,13 @@ static inline void activate_irq(int irq)
>> =A0#endif
>> =A0}
>>
>> +int twl6030_irq_set_wake(struct irq_data *d, unsigned int on)
>> +{
>> + =A0 =A0 int twl_irq =3D (int)irq_get_chip_data(d->irq);
>> +
>> + =A0 =A0 return irq_set_irq_wake(twl_irq, on);
>
> Note that when running with this previously, LOCKDEP warnings
> were seen. =A0LOCKDEP explicitly sets all irq_desc locks as a single
> lock-class, causing "possible recursive locking detected" when the TW=
L
> RTC (or other) driver calls through enable_irq_wake to
> twl6030_irq_set_wake, which recursively calls irq_set_irq_wake.
> Although the irq_desc and lock are different, LOCKDEP treats these as
> equivalent, presumably due to problems that can be incurred when
> locking more than one irq_desc.
>
> Currently we're running with twl6030_irq_set_wake keeping a count of
> sub-module wakeirqs, and setting the wakeup status for the twl_irq
> enabled or disabled as needed at suspend time. =A0Can send a patch if
> wanted.
>
Please do that.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
