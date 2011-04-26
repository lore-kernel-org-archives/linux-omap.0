From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v9 1/9] OMAP3: PM: Fix for the TWL4030 sleep/wakeup
 sequence
Date: Tue, 26 Apr 2011 11:54:09 +0200
Message-ID: <20110426095409.GF2659@sortiz-mobl>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
 <1302784077-16697-2-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31885 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1DZJyM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 05:54:12 -0400
Content-Disposition: inline
In-Reply-To: <1302784077-16697-2-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Thu, Apr 14, 2011 at 05:57:49PM +0530, Lesly A M wrote:
> Only configure sleep script when the flag is TWL4030_SLEEP_SCRIPT.
> 
> Adding the missing brackets for fixing the issue.
Patch applied to my for-linus branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
