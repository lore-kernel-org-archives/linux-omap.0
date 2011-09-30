From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
Date: Fri, 30 Sep 2011 14:44:56 +0530
Message-ID: <CAMQu2gzPyAObKwQ+CUXwseotJShA7Vfwb5AWPLzKPgx=NXjO-g@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
 <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1109291308060.26728@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:37699 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755329Ab1I3JPU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 05:15:20 -0400
Received: by yxk8 with SMTP id 8so1637347yxk.38
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 02:15:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109291308060.26728@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

On Fri, Sep 30, 2011 at 12:42 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Santosh,
>
> On Thu, 8 Sep 2011, Santosh Shilimkar wrote:
>
>> Local timer clock is sourced from the CPU clock and hence changes
>> along with CPU clock. These per CPU local timers are used as
>> clock-events, so they need to be reconfigured on CPU frequency
>> change as part of CPUfreq governor.
>>
>> Newly introduced clockevents_reconfigure() needs to know the
>> twd clock-rate. Provide a clock-node to make clk_get_rate() work
>> for TWD.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> This clock looks like the ARM Cortex-A9 MPCore PERIPHCLK, correct? =A0=
=46rom
> ARM Cortex-A9 MPCore Technical Reference Manual (DDI 0407G) Section 5=
=2E1
> "Clocks"?
>
Yes. Peripheral clock/2

> Assuming that is so, I've modified this patch appropriately, and adde=
d
> support to the autogeneration script to generate this clock node.
> Care to take a quick look at it to make sure it's okay?
>
Thanks a lot Paul. It looks good.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
