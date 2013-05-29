From: Jon Hunter <jgchunter@gmail.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Wed, 29 May 2013 22:29:07 +0100
Message-ID: <51A67323.7030906@gmail.com>
References: <20130516180933.GG5600@atomide.com> <20130516210006.GA31836@blackmetal.musicnaut.iki.fi> <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com> <20130521173936.GE31836@blackmetal.musicnaut.iki.fi> <519BCCEC.8010303@gmail.com> <20130522212054.GG31836@blackmetal.musicnaut.iki.fi> <519E67AD.6070702@gmail.com> <20130526190710.GA3345@blackmetal.musicnaut.iki.fi> <51A4FAA1.5060504@gmail.com> <20130529185518.GB3345@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:47439 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935194Ab3E2V3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 17:29:12 -0400
Received: by mail-we0-f169.google.com with SMTP id q55so6912404wes.0
        for <linux-omap@vger.kernel.org>; Wed, 29 May 2013 14:29:11 -0700 (PDT)
In-Reply-To: <20130529185518.GB3345@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org


On 29/05/13 19:55, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, May 28, 2013 at 07:42:41PM +0100, Jon Hunter wrote:
>> Care to share the log?
> 
> Below are three logs from 3.10-rc3 / Nokia 770. I did not even compile
> Retu this time, as it has nothing to do with GPIO IRQs being broken
> on OMAP1.

That's not entirely true. v3.10-rc3 is booting fine on an osk5912 and
ethernet is working which is using a gpio for interrupts and it is
getting interrupts.

> 1) broken vanilla 3.10-rc3: serial wakeup GPIO irq gets IRQ 0 and no
> other GPIO IRQs seen in /proc/interrupts. genirq error logs seen in boot.

Getting 0 for the irq number definitely looks like the problem.

> 2) working 3.10-rc3 with Tony's fix <== this fix should be applied
> (http://marc.info/?l=linux-arm-kernel&m=136907202628855&w=2). GPIO IRQs
> are normal, e.g. touchscreen can be used.
> 
> 3) .config used.

I am using the omap1_defconfig. Can you try that one for comparison?

Jon
