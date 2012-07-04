From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: architected timers: Mark the clockevent with the
 C3_STOP feature
Date: Wed, 4 Jul 2012 15:30:53 +0530
Message-ID: <CAMQu2gy6ynmCviYpW2qH-_6i614zrtO7P_8CM6O7--V-0FvvKA@mail.gmail.com>
References: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com> <4FF41366.4060504@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49750 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756622Ab2GDKBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 06:01:15 -0400
Received: by qadb33 with SMTP id b33so4291547qad.16
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 03:01:13 -0700 (PDT)
In-Reply-To: <4FF41366.4060504@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jul 4, 2012 at 3:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 04/07/12 10:54, Santosh Shilimkar wrote:
> > ARM arch timers stop in low power state and hence can not wakeup CPUs in
> > deeper idle states when used as cloc event devices. Marking these clock
> > event
> > devices with C3_STOP so that during lowpower states, the tick is managed
> > by
> > wakeup capable broadcast timer.
> >
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Hi Santosh,
>
> I already have queued an identical patch from Lorenzo.
> Thanks for reminder anyway!
>
OK. Thanks for the information Mark.
Looks like I missed that one on the list.

Regards,
Santosh
