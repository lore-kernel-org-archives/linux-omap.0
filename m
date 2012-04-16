From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Tue, 17 Apr 2012 00:56:17 +0530
Message-ID: <CAC83ZvKRMfP7xqmPLCwQWwTWxvoBwYycTyD7YLOO4wj+uhHpeg@mail.gmail.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
	<1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
	<alpine.DEB.2.00.1204161049250.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36282 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761Ab2DPT0T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 15:26:19 -0400
Received: by qadc11 with SMTP id c11so4545297qad.5
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 12:26:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204161049250.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

On Mon, Apr 16, 2012 at 10:20 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Tarun,
>
> by the way,
>
> On Mon, 16 Apr 2012, Tarun Kanti DebBarma wrote:
>
>> We do not use iclk anywhere in the dmtimer driver and so removing it=
=2E
>> Hence removing the timer iclk entries from OMAP4 clkdev table as wel=
l.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0| =A0 11 --------=
---
>> =A0arch/arm/mach-omap2/timer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
7 -------
>> =A0arch/arm/plat-omap/include/plat/dmtimer.h | =A0 =A02 +-
>> =A03 files changed, 1 insertions(+), 19 deletions(-)
>>
>
> ...
>
>> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/pl=
at-omap/include/plat/dmtimer.h
>> index 9418f00..be2b8c4 100644
>> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
>> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
>> @@ -259,7 +259,7 @@ struct omap_dm_timer {
>> =A0 =A0 =A0 unsigned long phys_base;
>> =A0 =A0 =A0 int id;
>> =A0 =A0 =A0 int irq;
>> - =A0 =A0 struct clk *iclk, *fclk;
>> + =A0 =A0 struct clk *fclk;
>>
>> =A0 =A0 =A0 void __iomem =A0 =A0*io_base;
>> =A0 =A0 =A0 void __iomem =A0 =A0*sys_stat; =A0 =A0 =A0/* TISTAT time=
r status */
>
> Am dropping this stray change, it seems unrelated to the rest of the
> patch.
Since the only usage of timer->iclk is removed from mach-omap2/timer.c
 there is no
point in keeping this field in struct omap_dm_timer {}.
Unless you are suggesting that both the above should be separated into
a separate patch?
--
Tarun

>
>
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
