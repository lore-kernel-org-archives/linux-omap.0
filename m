From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Tue, 19 Apr 2011 09:26:33 +0300
Message-ID: <20110419062633.GA15620@atomide.com>
References: <no>
 <1303139217-10285-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40711 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1DSG0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 02:26:37 -0400
Content-Disposition: inline
In-Reply-To: <1303139217-10285-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com

* Varadarajan, Charulatha <charu@ti.com> [110418 18:00]:
> From: Charulatha V <charu@ti.com>
> 
> Use PM runtime framework in OMAP GPIO driver.
...
 
>  arch/arm/mach-omap2/gpio.c             |    6 +
>  arch/arm/mach-omap2/pm34xx.c           |   22 +-
>  arch/arm/plat-omap/gpio.c              |  766 ++++++++++++++++++--------------
>  arch/arm/plat-omap/include/plat/gpio.h |    3 +-
>  4 files changed, 439 insertions(+), 358 deletions(-)

Before this series gets merged we first need to do the following:

- Pass some registers in platform_data so we can have common
  functions in gpio.c instead of having to test for the bank->method
  in each function. This allows getting rid of the ifdefs as
  discussed in the ARM Linux consolidation thread.

- Move it to drivers/gpio

- Further consolidate with whatever common GPIO code might
  be coming up.

Regards,

Tony
