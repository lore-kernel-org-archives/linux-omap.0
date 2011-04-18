From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 4/9] OMAP3: PM: TWL4030 power scripts for OMAP3
 boards
Date: Mon, 18 Apr 2011 15:32:40 +0300
Message-ID: <20110418123240.GN12272@atomide.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
 <1302784077-16697-5-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29512 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1DRMcl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 08:32:41 -0400
Content-Disposition: inline
In-Reply-To: <1302784077-16697-5-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi,

* Lesly A M <leslyam@ti.com> [110414 15:25]:
> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.
> 
> TWL4030 power scripts which can be used by different OMAP3 boards
> with the power companion chip (TWL4030 series).
> 
> The twl4030 generic script can be used by any board file to update
> the power data in twl4030_platform_data.
> 
> http://omapedia.org/wiki/TWL4030_power_scripts
> 
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/mach-omap2/twl4030-script.c |  331 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/twl4030-script.h |   23 +++
>  include/linux/i2c/twl.h              |   33 +++-
>  3 files changed, 384 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/twl4030-script.c
>  create mode 100644 arch/arm/mach-omap2/twl4030-script.h

To me it seems this should go into drivers/mfd instead.
The script may contain omap specific values, but can be
a loadable driver module.

Maybe drivers/mfd/twl4030-script-omap.c?

Tony
