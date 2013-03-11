From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4 pandaboard: clock input for TiWi module inactive
Date: Mon, 11 Mar 2013 10:58:31 +0200
Message-ID: <513D9CB7.2010402@ti.com>
References: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59310 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab3CKI6g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 04:58:36 -0400
In-Reply-To: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Levi Pearson <levipearson@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "Coelho, Luciano" <coelho@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>

(+ Peter, Luca, Balaji)

else your e-mail might just go unnoticed ;)

On 03/07/2013 10:37 PM, Levi Pearson wrote:
> I recently upgraded from a 3.4 kernel to a 3.8 kernel and found that
> the drivers for the functionality provided by the TiWi module on the
> pandaboard (Bluetooth, WiFI, etc.) could no longer probe the device.
> After some investigation, it turned out that the TiWi clock is
> provided by the twl6030 PMIC chip.
> 
> The clock output of the twl6030 was first enabled via these commits:
> 
> https://patchwork.kernel.org/patch/546381/
> https://patchwork.kernel.org/patch/546401/
> 
> Since most of the functionality of the TWL6030 is power regulation and
> the clock is enabled via a similar mechanism to the power outputs, the
> clock was added as a 'pseudo-regulator' to
> drivers/regulator/twl-regulator.c.
> 
> Some time later, a series of commits removed the clock functionality
> from twl-regulator.c, apparently due to being out-of-place in the
> Device Tree listings or something.
> 
> The first of these is recorded here: https://lkml.org/lkml/2012/6/4/330
> The next two just clean up the code that was orphaned by the previous:
>  e76ab829 "regulator: twl: Remove references to the twl4030 regulator"
>  029dd3ce "regulator: twl: Remove another unused variable warning"
> 
> Luciano Cuelho, who maintains the driver for the WiFi portion of the
> TiWi modules, reported the resulting breakage some time later on the
> LKML: https://lkml.org/lkml/2012/11/15/72
> 
> Despite the protestation of Mark Brown that his code removal wasn't
> the cause of the problem, reverting his changes does indeed enable the
> clock.  However, it also seems to be the case that there ought to be a
> better home for the clock than twl-regulator.c.  At the time of the
> previous discussion, it wasn't clear if the framework was in place to
> support a clock driver for the twl6030's clock, but it seems like the
> support exists now, since there's a clock driver for the twl6030's
> companion, the twl6040 audio chip.
> 
> So: Is there any chance of simply reverting the 3 commits that broke
> the clock?  I have done this locally, but I hate to see pandaboard
> support in the mainstream kernel continue to be broken in this way.
> 
> If for whatever reason the commits cannot be reverted, would creating
> a driver like drivers/clk/clk-twl6040.c that enabled the twl6030's
> clock output be a suitable alternative?  I'd be willing to take a stab
> at writing it if there's not something like that in the works already.
> 
> ---
> Levi Pearson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

