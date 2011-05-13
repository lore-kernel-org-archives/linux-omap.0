From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v10 2/7] MFD: TWL4030: Correct the warning print during
 script loading
Date: Fri, 13 May 2011 19:19:10 +0200
Message-ID: <20110513171909.GN8970@sortiz-mobl>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
 <1304687833-4578-3-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6832 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759697Ab1EMRTN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 13:19:13 -0400
Content-Disposition: inline
In-Reply-To: <1304687833-4578-3-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Fri, May 06, 2011 at 06:47:08PM +0530, Lesly A M wrote:
> Correcting the if condition check for printing the warning,
> if wakeup script is not updated before updating the sleep script.
> 
> Since the flag 'order' is set to '1' while updating the wakeup script for P1P2,
> the condition checking for printing the warning should be if(!order)
> (ie: print the warning if wakeup script is not updated before updating the sleep script)
> 
This one is already applied to my for-next.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
