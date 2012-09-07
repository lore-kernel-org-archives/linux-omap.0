From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 0/3] GPMC driver conversion
Date: Fri, 7 Sep 2012 15:10:34 -0700
Message-ID: <20120907221034.GP1303@atomide.com>
References: <cover.1346846464.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:32076 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751431Ab2IGWKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:10:38 -0400
Content-Disposition: inline
In-Reply-To: <cover.1346846464.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120905 05:37]:
> Hi,
> 
> Basic gpmc driver conversion series. Driver that is now created out of
> gpmc code is a simple one, it handles tasks that were earlier executed
> by gpmc_init. Now instead of relying on cpu_is_* checks, it obtains
> resources and clk handle in the standard Linux way. The existing gpmc
> interface works as was without this series.
> 
> HWMOD patch also has been brought into this series back with v7 series
> 
> As this creates only a basic driver, further gpmc driver work can be
> based over this, while having a driver first in place.
> 
> This series is based on l-o/testing-cleanup as on 5-Sep-12,
> i.e. over commit,
> 
> e3a5c14 ARM: OMAP1: Move SoC specific headers from plat to mach for omap1
> 
> per Tony's suggestion.
> 
> It is available
> @git://gitorious.org/x0148406-public/linux-kernel.git gpmc-drv-v8

Great, this all looks good to me. I suggest that on top of this
we add minimal devicetree binding that does not even attempt to
deal with the timings yet.

Then once the minimal devicetree binding is in place, we can
call the current GPMC timing functions using the compatible flags
and auxdata in the gpmc.c driver.

That way we get all the legacy boards booting with GPMC support
for smsc911x etc, and can even remove some less used board-*.c
files.

Then we just add the generic GPMC timings when we're happy with
those.

Regards,

Tony
