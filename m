From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 07:34:09 -0700
Message-ID: <87d30n7o9q.fsf@deeprootsystems.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	<87ipag90om.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51658 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab2JLOeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 10:34:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2986988pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 07:34:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Kankroliwala, Huzefa" <huzefank@ti.com>

"Strashko, Grygorii" <grygorii.strashko@ti.com> writes:

> Hi All,
>
> Sorry, for the late reply.
> + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.

Hi Grygorii, thanks for reviewing.  I was hoping you would have some
ideas here as this was sounding familiar to something you had
mentioned elsewhere.

> Regarding this patch -  from my point of view, it fixes corner case and not an issue in general.
> Let take a look on resume sequence:
>    - platform resume
>    - syscore resume
>    - resume_noirq
>    - enable IRQs - resume_device_irqs()
>      |- at this point IRQ handler will be invoked if IRQ state is IRQS_PENDING.
>      |- so, the I2C device IRQ handler may be called at time when I2C adapter IRQ is still disabled and, as result, the I2C device IRQ-handler may fail. (I2C device and I2C adapter may use different physical IRQ lines)
>    - resume_late
>      |- enable I2C bus IRQ
>
> Possibly, the better way is to enable/disable I2C bus IRQ when needed - in our case in omap_i2c_xfer().
> We use such approach in Android kernel 3.4
> (http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=1445a4d3b587c164bd30d108b61760aaaa07365e)

I agree, that should work and cover the cases where I2C is used by other
processors also.  Shubhrajyoti already posted something similar[1] but
it needed some rework (comments from Russell and myself.)

Huzefa, Shubhrajyoti, who can rework this idea for the upstream and/or
follow up with the earlier patch[1]?

Wolfram, I guess for now lets hold off on $SUBJECT patch.  Seems we can
come up with a broader solution.  Thanks.

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124427.html
