From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v9 2/9] OMAP3: PM: Correct the warning print during
 script loading
Date: Tue, 26 Apr 2011 11:57:59 +0200
Message-ID: <20110426095759.GG2659@sortiz-mobl>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
 <1302784077-16697-3-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43943 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab1DZJ6I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 05:58:08 -0400
Content-Disposition: inline
In-Reply-To: <1302784077-16697-3-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Thu, Apr 14, 2011 at 05:57:50PM +0530, Lesly A M wrote:
> Correcting the if condition check for printing the warning,
> if wakeup script is not updated before updating the sleep script.
> 
> Since the flag 'order' is set to '1' while updating the wakeup script for P1P2,
> the condition checking for printing the warning should be if(!order)
> (ie: print the warning if wakeup script is not updated before updating the sleep script)
>
Patch applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
