From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Tue, 25 Sep 2012 08:38:06 -0700
Message-ID: <20120925153806.GC4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19870 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754600Ab2IYPiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 11:38:09 -0400
Content-Disposition: inline
In-Reply-To: <1348568474.2342.35.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 03:22]:
> Hi Tony,
> 
> Each pin of OMAP requires a particular power to be enabled for the pin
> to function (Ball Characteristics table from data manual). Is there a
> plan how this is managed with pinctrl? Currently each driver needs to
> make sure the correct regulators are enabled for the pins it uses, which
> is platform specific and messy.
> 
> As a driver maintainer, I would wish that the pins would just get
> enabled automatically when I call pm_runtime_get()...

Hmm can you clarify a bit what exactly do you want to do there
with pm_runtime_get()? Call the regulator framework?

Regards,

Tony
