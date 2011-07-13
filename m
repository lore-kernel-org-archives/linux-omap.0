From: Tony Lindgren <tony@atomide.com>
Subject: Re: Remaining omap pull requests
Date: Tue, 12 Jul 2011 23:25:30 -0700
Message-ID: <20110713062530.GH5783@atomide.com>
References: <20110711114736.GX5783@atomide.com>
 <1310460112.19324.3.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17088 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751791Ab1GMGZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 02:25:35 -0400
Content-Disposition: inline
In-Reply-To: <1310460112.19324.3.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <J.Weitzel@phytec.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

* Jan Weitzel <J.Weitzel@phytec.de> [110712 01:36]:
> Am Montag, den 11.07.2011, 04:47 -0700 schrieb Tony Lindgren:
> 
> > Then there are two new boards remaining, but they both are waiting
> > on the machine_id patch.
> > 
> 
> If one of them is our pcm049 OMAP4 board, the machine_id is already in.
> pcm049                  MACH_PCM049             PCM049                  3364

Yes, thanks for pointing that out. And now we also have an ack from Russell
for the Nook mach-types changes. I'll take one more look at the machine
patches and if no issues will apply them.

Regards,

Tony
