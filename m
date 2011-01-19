From: Tony Lindgren <tony@atomide.com>
Subject: Re: Adio on BeagleBoard XM 2.6.37-rc8
Date: Wed, 19 Jan 2011 10:51:14 -0800
Message-ID: <20110119185114.GA4957@atomide.com>
References: <AANLkTikPks0AcOpAK6We5zvju9k9qR=9z0-ua7qkKsLt@mail.gmail.com>
 <20110119150233.b27475bc.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20588 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1ASSvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 13:51:24 -0500
Content-Disposition: inline
In-Reply-To: <20110119150233.b27475bc.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Ashok Babu <ashok3d@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

* Jarkko Nikula <jhnikula@gmail.com> [110119 05:01]:
> On Wed, 19 Jan 2011 17:17:11 +0530
> Ashok Babu <ashok3d@gmail.com> wrote:
> 
> > Hi folks,
> > 
> > After upgrading to 2.6.37-rc8, I am not able to play any audio.
> > 
> > Fund that the code in sound/soc/omap/omap-mcbsp.c uses the function
> > "cpu_is_omap343x()" which fails and returns ENODEV.
> > 
> > Does the call should be "cpu_is_omap34xx()" instead ?
> > 
> It looks like so. cpu_is_omap34xx() checks the lowest 8 bits from
> omap_rev (that are 0x34 for omap3x ) and cpu_is_omap343x() checks upper
> 12 bits (that are 0x363 for 3630).
> 
> Peter: I think cpu_is_omap343x() tests can be replaced by
> cpu_is_omap34xx() in omap-mcbsp.c? 

For next merge window, can you please git rid of cpu_is_omap
and machine_is usage under drivers?

You can pass the necessary flags in platform data.

Regards,

Tony
