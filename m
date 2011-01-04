From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Date: Tue, 04 Jan 2011 14:45:54 -0800
Message-ID: <1294181154.18162.39.camel@localhost>
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	 <87aajg7dzu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39846 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976Ab1ADWp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 17:45:59 -0500
Received: by eyd10 with SMTP id 10so6581429eyd.17
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 14:45:57 -0800 (PST)
In-Reply-To: <87aajg7dzu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Tue, 2011-01-04 at 09:52 -0800, Kevin Hilman wrote:
> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> 
> > In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
> > updating reg and l values. However, at the end of the function we
> > perform a write:
> >
> > 	__raw_writel(l, reg);
> >
> > So on OMAP2+ we end up writing 0 to the bank->base which is not
> > correct (typically this points to GPIO_REVISION register).
> >
> > Fix this by returning immediately after call to
> > set_24xx_gpio_triggering().
> >
> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, this should be added to omap-for-linus as it fixes a problem in
> the recently merged GPIO omap_device/hwmod conversion.

On second thought, it's a bit late for the main 2.6.38 window, so will
queue this in my pm-fixes branch for the .38-rc cycle.

Kevin


