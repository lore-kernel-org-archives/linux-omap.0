From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/15] OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
Date: Thu, 26 May 2011 10:15:10 -0700
Message-ID: <8762oxgz8h.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-3-git-send-email-tarun.kanti@ti.com>
	<87sjs2sbvy.fsf@ti.com>
	<BANLkTik2=da94cZh23gwx1hzZQK6H_hy2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37296 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693Ab1EZRPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:15:14 -0400
Received: by pxi9 with SMTP id 9so711790pxi.14
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:15:13 -0700 (PDT)
In-Reply-To: <BANLkTik2=da94cZh23gwx1hzZQK6H_hy2Q@mail.gmail.com> (Charulatha
	Varadarajan's message of "Thu, 26 May 2011 15:08:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Thu, May 26, 2011 at 03:04, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> From: Charulatha V <charu@ti.com>
>>>
>>> Non-wakeup GPIOs are available only in OMAP2420 and OMAP3430. But
>>> the GPIO driver initializes the non-wakeup GPIO bits for OMAP24xx
>>> (bothe OMAP 2420 and 2430) & not for OMAP3 which is incorrect.
>>
>> Can you cite the documentation you're using for the OMAP3 non-wakeup
>> GPIOs?
>
> I am referring to Table 25-5. GPIO Channel Description at page no 3354
> OMAP3430 public TRM Version P.
>

Based on how I understand that, those non-wakeup GPIOs are non-wakeup
because they're not actually mapped anywhere, and not available on
external pins.  Therefore, they should not need any special case
handling for this triggering workaround.

Kevin

