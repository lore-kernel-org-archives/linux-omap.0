From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: set GPIO mode for mux
 mcspi1_cs2 pin
Date: Wed, 18 Jul 2012 00:20:53 -0700
Message-ID: <20120718072052.GK6522@atomide.com>
References: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
 <CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
 <CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24386 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab2GRHU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 03:20:57 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>, Tom Rini <trini@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [120717 00:16]:
> 
> Hi Tony,
> 
> Just pinging to see if you have further comments on this patch or if
> it can be applied. It solves a bug on IGEPv2 boards.
> 
> I know the trend is to move away from board code. I'll start working
> on an device tree for the IGEPv2 but it will take some time until is
> ready (and I'm not sure if all the OMAP3 support is already present on
> DT).
> 
> So could you please take bug fixes for the board code in the meantime?

Yes seems like something for the v3.6-rc series.

Regards,

Tony
