From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 3/3] OMAP3: Remove auto-selection of PMICs
Date: Mon, 22 Aug 2011 17:03:01 +0200
Message-ID: <20110822150301.GY4607@sortiz-mobl>
References: <1313754573-11498-1-git-send-email-abhilash.kv@ti.com>
 <1313754573-11498-2-git-send-email-abhilash.kv@ti.com>
 <1313754573-11498-3-git-send-email-abhilash.kv@ti.com>
 <1313754573-11498-4-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25256 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab1HVPBJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 11:01:09 -0400
Content-Disposition: inline
In-Reply-To: <1313754573-11498-4-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, santosh.shilimkar@ti.com, premi@ti.com, david.woodhouse@intel.com

Hi Anhilash,

On Fri, Aug 19, 2011 at 05:19:33PM +0530, Abhilash K V wrote:
> The current implementation almost assumes that only
> TWL4030/TWL5030/TWl6030 are (or can be) used with the
> OMAP processors. This is, however, not true.

I don't like the mfd/Kconfig change. Why would those drivers be only buildable
on OMAP processors ?
Unless there is a real reason for this, you should fix the drivers instead.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
