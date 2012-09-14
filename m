From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
Date: Fri, 14 Sep 2012 08:33:42 -0700
Message-ID: <CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:65141 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab2INPdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 11:33:43 -0400
Received: by weyx8 with SMTP id x8so2466841wey.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 08:33:42 -0700 (PDT)
In-Reply-To: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>, Alessandro Zummo <a.zummo@towertech.it>

On Thu, Sep 13, 2012 at 1:45 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> From: Kevin Hilman <khilman@ti.com>
>
> On some platforms, bootloaders are known to do some interesting RTC
> programming.  Without going into the obscurities as to why this may be
> the case, suffice it to say the the driver should not make any
> assumptions about the state of the RTC when the driver loads.  In
> particular, the driver probe should be sure that all interrupts are
> disabled until otherwise programmed.
>
> This was discovered when finding bursty I2C traffic every second on
> Overo platforms.  This I2C overhead was keeping the SoC from hitting
> deep power states.  The cause was found to be the RTC firing every
> second on the I2C-connected TWL PMIC.
>
> Special thanks to Felipe Balbi for suggesting to look for a rogue
> driver as the source of the I2C traffic rather than the I2C driver
> itself.
>
> Special thanks to Steve Sakoman for helping track down the source of
> the continuous RTC interrups on the Overo boards.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Steve Sakoman <steve@sakoman.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Tested on Overo/Tobi, and I no longer see the 1/second interrupts.
Also verified that alarm interrupts still work using rtcwake.

Tested-by: Steve Sakoman <steve@sakoman.com>
