From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v10 1/7] MFD: TWL4030: Fix for the TWL4030 sleep/wakeup
 sequence
Date: Fri, 13 May 2011 19:14:29 +0200
Message-ID: <20110513171428.GM8970@sortiz-mobl>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
 <1304687833-4578-2-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24549 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab1EMROb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 13:14:31 -0400
Content-Disposition: inline
In-Reply-To: <1304687833-4578-2-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Fri, May 06, 2011 at 06:47:07PM +0530, Lesly A M wrote:
> Only configure sleep script when the flag is TWL4030_SLEEP_SCRIPT.
> 
> Adding the missing brackets for fixing the issue.
This is already upstream.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
