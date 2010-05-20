From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Thu, 20 May 2010 20:04:17 +0100
Message-ID: <20100520200417.5ec99735@lxorguk.ukuu.org.uk>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
	<1274090554-19420-2-git-send-email-felipe.balbi@nokia.com>
	<20100520110600.be702f58.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53030 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751481Ab0ETS5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 14:57:40 -0400
In-Reply-To: <20100520110600.be702f58.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>


> > +EXPORT_SYMBOL_GPL(gpio_set_debounce);
> 
> nitlet: I suspect this function is taking gpio_lock sooner than it
> strictly needs to.  Find-tuning that would decrease contention by an
> insignificant amount ;)

We need this for Intel MID boxes as well Andrew - so its a generic need.

Alan

