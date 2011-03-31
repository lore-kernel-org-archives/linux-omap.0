From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3 hwmods
Date: Thu, 31 Mar 2011 08:04:37 -0700
Message-ID: <871v1njpq2.fsf@ti.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
	<alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
	<20110314161609.GA10506@avinash-laptop>
	<alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
	<20110325062534.GA25480@avinash-laptop>
	<20110325072035.GB25480@avinash-laptop>
	<alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com>
	<20110326113538.GB3668@avinash-laptop>
	<20110331144010.GA18054@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40420 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752982Ab1CaPEm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 11:04:42 -0400
Received: by gyf1 with SMTP id 1so1016040gyf.6
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 08:04:40 -0700 (PDT)
In-Reply-To: <20110331144010.GA18054@avinash-laptop> (Avinash H. M.'s message
	of "Thu, 31 Mar 2011 20:10:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

"Avinash.H.M." <avinashhm@ti.com> writes:

>> > > [    0.208892] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
>> > > [    0.223114] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
>> > > [    0.237335] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
>> > > [    0.251525] omap_hwmod: gpio2: softreset failed (waited 10000 usec)
>> > > [    0.265594] omap_hwmod: gpio3: softreset failed (waited 10000 usec)
>> > > [    0.279693] omap_hwmod: gpio4: softreset failed (waited 10000 usec)
>> > > [    0.293762] omap_hwmod: gpio5: softreset failed (waited 10000 usec)
>> > > [    0.307861] omap_hwmod: gpio6: softreset failed (waited 10000 usec)
>
> Hi Paul, 
>
> I tested this on one more board and still got these softreset warnings.
> So this wasn't a board specific issue and debugged into what is causing
> these.
>
> The problem is the FCLK isn't enabled for these gpios(2..6) while
> resetting.  So the GPIO's are not resetting properly. Once i enable FCLK
> for them and then set the SYSCONFIG.SOFTRESET, then they are resetting
> and it is reflected in RESETDONE bit.

What do you mean by fclk here.  GPIO doesn't have an fclk.  The
interface clock provides the functional clock, and the optional debounce
clock (dbclk) is needed only when GPIO debounce is enabled.

I suggest you look at the "integration" sub chapter of the TRM for the
GPIO module.

> That being said, I was looking for accessing gpio2_fck in the
> gpio2_hwmod. But i find the structure as below, 
>
> static struct omap_hwmod omap3xxx_gpio2_hwmod = {
> 	.name		= "gpio2",
> 	.mpu_irqs	= omap3xxx_gpio2_irqs,
> 	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
> 	.main_clk	= "gpio2_ick",
>
> Is there any reason, why 'iclk' is set as the 'main_clk' and not 'fclk'.

There are no GPIO fclks.

> Also 'fclk' is structured as 'gpio2_dbck' and made as an optional
> clock.  I wasn't very sure, why the name 'dbck'?

dbck == debounce clock

Kevin
