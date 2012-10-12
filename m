From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 12:04:36 -0700
Message-ID: <87txtzy0jf.fsf@deeprootsystems.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	<87ipag90om.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
	<87d30n7o9q.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C8C9F@DNCE04.ent.ti.com>
	<87r4p363ps.fsf@deeprootsystems.com>
	<CAM=Q2csQ7dVWUi2vrRMCQ653t_GxtXqH2yGMjY9YAkvA+_i9WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60913 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2JLTEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 15:04:31 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3096490pad.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 12:04:31 -0700 (PDT)
In-Reply-To: <CAM=Q2csQ7dVWUi2vrRMCQ653t_GxtXqH2yGMjY9YAkvA+_i9WA@mail.gmail.com>
	(Shubhrajyoti Datta's message of "Fri, 12 Oct 2012 23:41:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Kankroliwala, Huzefa" <huzefank@ti.com>

Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:

> On Fri, Oct 12, 2012 at 10:13 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> "Strashko, Grygorii" <grygorii.strashko@ti.com> writes:
>>
>>> Hi Kevin,
>>>
>>> yep, [1] is the same fix - thanks.
>>
>>> Hi Kalle,
>>>
>>> i've applied these changes and PM runtime fix on top of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git (omap2plus_defconfig)
>>> Could you check it with your use case, pls? (just to be sure that idea is right)
>>
>> I think the ideas is right, but [1] introduces more potential problems
>> since it disables the IRQ at the INTC well before being disabled at the
>> device.
> I fail to see this point. Current driver supports master mode only.
> So unless there is a msg queued by the core. May be no interrupts should fire.
>
> what I mean
>
> msg -> conf -> intr -> completion/error  -> autosuspend.
>
>>  With runtime PM autosuspend timeouts, that means any IRQs
>> firing during the autosuspend delay will be lost, which basically
>> nullifies the use of autosuspend.
>
> so I do not expect any interrupts between completion/error -> autosuspend.

Runtime PM is designed for concurrent users (hence the usecounting.)
The I2C driver may not fully support this, since there is a single bus
to share, but the usage of runtime PM currently allows multiple users to
do runtime PM get/put (though in this driver they will block in the
wait_for_bb.)

So the fundamental problem in doing the enable/disable IRQ in the xfer
function, and not the runtime PM callbacks is that you're ignoring the
runtime PM usecount.  You're assuming that the 'get' is *always*
incrementing the usecount from zero to 1, and the 'put' is *always* a
transition from 1 to zero.  This may be the case in current usage and
tests, but does not have to be the case.

Even if that never happens in practice, it can in theory, and to me
leads to confusing code.  It simply doesn't make sense in terms of
readability to disable the IRQ at the INTC in xfer, and disable IRQs at
the device level in the runtime PM callback.

To put it more simply: anything that needs to be done when the I2C is
about to be idled/enabled should be done in the runtime PM callbacks.

Please have a look at the patch I just sent[1].  In addition to making
it more readable (IMO), it elminates the need for an extra disable_irq()
in probe.

Kevin

[1] http://marc.info/?l=linux-omap&m=135006723121147&w=2
