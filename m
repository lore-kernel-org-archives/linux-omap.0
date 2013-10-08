From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Tue, 8 Oct 2013 09:47:35 -0700
Message-ID: <20131008164735.GC7773@atomide.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <20131008054034.7445.48080@quantum>
 <5253BFB3.9040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53509 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab3JHQrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 12:47:41 -0400
Content-Disposition: inline
In-Reply-To: <5253BFB3.9040807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131008 01:26]:
> On 10/08/2013 08:40 AM, Mike Turquette wrote:
> 
> >3) Same concern as above but for the DT clkdev alias stuff. I guess
> >you'll need to make all of the dependent drivers play nice with DT. Do
> >you plan to remove it within a reasonable timeframe? It would be a nice
> >reduction in LoC and more importantly it would mean that drivers were
> >using clkdev in a more-correct fashion.
> 
> This is probably harder, I think Tony is better to comment here, but
> my idea is that in the worst case we can just break non-conforming
> drivers by dropping the clkdev tables if nothing else helps. :) Most
> of the tables are currently needed by hwmod, and there are already
> patches around for adding DT clock support for hwmods, so once these
> go in, we can at least reduce the table sizes considerably already.

It should be possible to remove these as we go as things become DT only.
Probably the biggest blocker right now is making omap3 DT only.

But let's not start breaking things intentionally!

Tony
