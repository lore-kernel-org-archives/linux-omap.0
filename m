From: Tony Lindgren <tony@atomide.com>
Subject: Re: RCU stall on panda
Date: Thu, 15 May 2014 11:32:48 -0700
Message-ID: <20140515183247.GF23659@atomide.com>
References: <53675C5F.10509@linaro.org>
 <20140505180617.GM8754@linux.vnet.ibm.com>
 <20140512212102.GF5668@atomide.com>
 <5371BD69.8010600@linaro.org>
 <20140513153220.GC16837@atomide.com>
 <53747E6D.60500@linaro.org>
 <53748371.5030704@linaro.org>
 <5374C07C.1070400@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16368 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbaEOSc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 14:32:58 -0400
Content-Disposition: inline
In-Reply-To: <5374C07C.1070400@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "naresh.kamboju@linaro.org Kamboju" <naresh.kamboju@linaro.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, LAK <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@linaro.org>, linux-omap@vger.kernel.org

* Alex Shi <alex.shi@linaro.org> [140515 06:27]:
> On 05/15/2014 05:05 PM, Daniel Lezcano wrote:
> >>>
> >>
> >> After enable this patch, system maybe hang in idle. :(
> > 
> > Hi Alex,
> > 
> > do you mean even with this revert applied, the board hangs in idle ?
> > 
> 
> yes.
> My board is panda ES. without this revert, it works.

Care to specify what linux version you are testing against?

Does it hang in idle always immediately on booting?

Or does the serial console first hang with sysrq still
working (ctrl-a h in minicom for help) with device
eventually locking up hard?

Regards,

Tony
