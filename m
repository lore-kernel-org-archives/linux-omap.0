From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 17:03:00 +0530
Message-ID: <5077FFEC.5040407@ti.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>,<87ipag90om.fsf@deeprootsystems.com> <902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48754 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758546Ab2JLLeM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Oct 2012 07:34:12 -0400
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kankroliwala, Huzefa" <huzefank@ti.com>

On Friday 12 October 2012 03:48 PM, Strashko, Grygorii wrote:
> Hi All,
>
> Sorry, for the late reply.
> + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.
>
> Regarding this patch
hmm I had similar ideas however my idea was to pacify the arm interrupts
when the ip is used by another processor.(something my hw spin patch missed)

Any-ways will wait for Huzefa to comment.


>  -  from my point of view, it fixes corner case and not an issue in general.
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
>
> Grygorii
> ______________________

