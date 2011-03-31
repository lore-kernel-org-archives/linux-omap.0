From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Thu, 31 Mar 2011 20:10:38 +0530
Message-ID: <20110331144010.GA18054@avinash-laptop>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
 <20110314161609.GA10506@avinash-laptop>
 <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com>
 <20110325062534.GA25480@avinash-laptop>
 <20110325072035.GB25480@avinash-laptop>
 <alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com>
 <20110326113538.GB3668@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57756 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752695Ab1CaOkz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 10:40:55 -0400
Received: by gwb15 with SMTP id 15so1150538gwb.13
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 07:40:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110326113538.GB3668@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

> > > [    0.208892] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> > > [    0.223114] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
> > > [    0.237335] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
> > > [    0.251525] omap_hwmod: gpio2: softreset failed (waited 10000 usec)
> > > [    0.265594] omap_hwmod: gpio3: softreset failed (waited 10000 usec)
> > > [    0.279693] omap_hwmod: gpio4: softreset failed (waited 10000 usec)
> > > [    0.293762] omap_hwmod: gpio5: softreset failed (waited 10000 usec)
> > > [    0.307861] omap_hwmod: gpio6: softreset failed (waited 10000 usec)

Hi Paul, 

I tested this on one more board and still got these softreset warnings.
So this wasn't a board specific issue and debugged into what is causing
these.

The problem is the FCLK isn't enabled for these gpios(2..6) while
resetting.  So the GPIO's are not resetting properly. Once i enable FCLK
for them and then set the SYSCONFIG.SOFTRESET, then they are resetting
and it is reflected in RESETDONE bit.

That being said, I was looking for accessing gpio2_fck in the
gpio2_hwmod. But i find the structure as below, 

static struct omap_hwmod omap3xxx_gpio2_hwmod = {
	.name		= "gpio2",
	.mpu_irqs	= omap3xxx_gpio2_irqs,
	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
	.main_clk	= "gpio2_ick",

Is there any reason, why 'iclk' is set as the 'main_clk' and not 'fclk'.
Also 'fclk' is structured as 'gpio2_dbck' and made as an optional clock.
I wasn't very sure, why the name 'dbck'? 

> > 
> > Just FYI, I don't see the gpio softreset failures on my boards here.

Most likely you aren't seeing this in N800 and beagle because the
bootloader may be enabling the clocks.

I am sorry if the above question seems silly. I am fairly new to this
frameworks and hence the question :-). Please clarify.

br ,
- avinash


 
