From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Thu, 16 May 2013 11:09:34 -0700
Message-ID: <20130516180933.GG5600@atomide.com>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58286 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751498Ab3EPSJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 14:09:44 -0400
Content-Disposition: inline
In-Reply-To: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>

* Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
> Hi,
> 
> I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
> 
> [    2.264221] retu-mfd 2-0001: Retu v3.2 found
> [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
> [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
> 
> The error is coming from regmap code. According to git bisect, it is
> caused by:
> 
> 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
> 	Author: Jon Hunter <jon-hunter@ti.com>
> 	Date:   Fri Mar 1 11:22:47 2013 -0600
> 
> 	    gpio/omap: convert gpio irq domain to linear mapping
> 
> The commit does not anymore revert cleanly, and I haven't yet tried
> crafting a manual revert, so any fix proposals/ideas are welcome...

Hmm this might be a bit trickier to fix. Obviously the real solution
is to convert omap1 to SPARSE_IRQ like we did for omap2+.

For the -rc cycle, it might be possible to fix this by adding a
different irq_to_gpio() and gpio_to_irq() functions for omap1.

Regards,

Tony
