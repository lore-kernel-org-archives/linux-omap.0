From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Fri, 13 May 2011 20:39:58 +0200
Message-ID: <20110513183958.GY8970@sortiz-mobl>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
 <1304687833-4578-5-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50532 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab1EMSkB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 14:40:01 -0400
Content-Disposition: inline
In-Reply-To: <1304687833-4578-5-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Fri, May 06, 2011 at 06:47:10PM +0530, Lesly A M wrote:
> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_reset.
> 
> TWL4030 power scripts which can be used by different OMAP3 boards
> with the power companion chip (TWL4030 series).
> 
> The twl4030 generic script can be used by any board file to update
> the power data in twl4030_platform_data.
> 
> Since the TWL4030 power script has dependency with APIs in twl4030-power.c
> removing the __init for these APIs.
> 
> For more information please see:
> 	http://omapedia.org/wiki/TWL4030_power_scripts
I understand you guys are trying to keep the arch/arm stats to a sane level,
but I don't see why this driver should be under drivers/mfd/. I'm usually
flexible about what goes into drivers/mfd, but this one seems out of context
to me.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
