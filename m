From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 03/11] ARM: OMAP2+: timer: Add suspend-resume
 callbacks for clkevent device
Date: Thu, 17 Jul 2014 01:16:05 -0700
Message-ID: <20140717081605.GI18374@atomide.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-4-git-send-email-d-gerlach@ti.com>
 <20140714111536.GC20068@atomide.com>
 <53C3EB1F.2010109@ti.com>
 <53C4166F.1050003@ti.com>
 <20140715064807.GJ20068@atomide.com>
 <53C6DDC6.9060705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24434 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbaGQIRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 04:17:31 -0400
Content-Disposition: inline
In-Reply-To: <53C6DDC6.9060705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

* Dave Gerlach <d-gerlach@ti.com> [140716 13:19]:
> On 07/15/2014 01:48 AM, Tony Lindgren wrote:
> > 
> > It's best to register these kind of functions as platform_data
> > in pdata-quirks.c auxdata. That way when this moves to live
> > in drivers/clocksource the driver does not need to know anything
> > about the interconnect specific registers.
> 
> Perhaps I spoke too soon on this, I can't use pdata-quirks right now to pass the
> idle/unidle functions. The clockevent source is special and reads the dt node
> itself and then marks it as disabled so nothing else can touch it. No device is
> created and no auxdata matched. I will gladly fix it up once the driver is ready
> to move but right now I can't use any existing functionality to do it.

OK. So maybe just initialize the function pointers during init and
use appropriate naming so the function pointers will stay usable
later on too once it's a driver.

Regards,

Tony
