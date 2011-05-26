From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 12:39:53 -0500
Message-ID: <BANLkTikgD-EFGcJSh+EMQTwgTfBE15HkeQ@mail.gmail.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
 <1306247094-25372-3-git-send-email-tarun.kanti@ti.com> <87sjs2sbvy.fsf@ti.com>
 <BANLkTik2=da94cZh23gwx1hzZQK6H_hy2Q@mail.gmail.com> <8762oxgz8h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51399 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758005Ab1EZRkd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:40:33 -0400
Received: by mail-pv0-f181.google.com with SMTP id 13so477345pvg.12
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:40:33 -0700 (PDT)
In-Reply-To: <8762oxgz8h.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Kevin,

On Thu, May 26, 2011 at 12:15, Kevin Hilman <khilman@ti.com> wrote:
> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
>> On Thu, May 26, 2011 at 03:04, Kevin Hilman <khilman@ti.com> wrote:
>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>
>>>> From: Charulatha V <charu@ti.com>
>>>>
>>>> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
>>>> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
>>>> (bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.
>>>
>>> Can you cite the documentation you're using for the OMAP3 non-wakeu=
p
>>> GPIOs?
>>
>> I am referring to Table 25-5. GPIO Channel Description at page no 33=
54
>> OMAP3430 public TRM Version P.
>>
>
> Based on how I understand that, those non-wakeup GPIOs are non-wakeup
> because they're not actually mapped anywhere, and not available on
> external pins. =A0Therefore, they should not need any special case
> handling for this triggering workaround.

Okay. Thanks for clarifying. I will not  do this for OMAP3. The special=
 case
would be only for OMAP2420 against the current code which is handling
for OMAP24xx.

-V Charulatha

>
> Kevin
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
