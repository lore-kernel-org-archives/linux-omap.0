From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 device tree conversion: how to do first step
Date: Thu, 13 Jun 2013 07:57:24 -0700
Message-ID: <20130613145724.GH8164@atomide.com>
References: <20130609015944.GA23559@amd.pavel.ucw.cz>
 <20130609201119.GA3190@blackmetal.musicnaut.iki.fi>
 <20130613132624.GA3464@amd.pavel.ucw.cz>
 <20130613141001.GF8164@atomide.com>
 <20130613142809.GA3775@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37968 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756331Ab3FMO5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 10:57:33 -0400
Content-Disposition: inline
In-Reply-To: <20130613142809.GA3775@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [130613 07:34]:
> On Thu 2013-06-13 07:10:01, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [130613 06:32]:
> >  
> > > If I init spi manually (and some more hacks), it works in the
> > > qemu. But I have not tested on real hw for a while.
> > 
> > You should be able to initialize spi by adding the .dts entry,
> > or is there something missing in drivers/spi/spi-omap2-mcspi.c?
> 
> Not sure, I guess I'll find out soon. Do you have example dts that
> uses drivers/spi/spi-omap2-mcspi.c? Grepping spi in dts/ was not too
> successful.

Hmm I think all we have is what's written in
Documentation/devicetree/bindings/spi/omap-spi.txt and
omap4-sdp.dts.

Regards,

Tony

