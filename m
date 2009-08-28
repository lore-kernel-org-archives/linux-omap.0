From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/3] MFD: TWL4030: Add support for TWL4030/5030 dynamic
 power switching
Date: Fri, 28 Aug 2009 19:47:24 +0200
Message-ID: <20090828174722.GB6162@sortiz.org>
References: <1250517469-15899-1-git-send-email-amit.kucheria@verdurent.com>
 <1250517706-16053-1-git-send-email-amit.kucheria@verdurent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54726 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbZH1RpT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 13:45:19 -0400
Content-Disposition: inline
In-Reply-To: <1250517706-16053-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org

Hi Amit,

On Mon, Aug 17, 2009 at 05:01:46PM +0300, Amit Kucheria wrote:
> +
> +#include <asm/mach-types.h>
You'll have to make your Kconfig entry depend on ARM if you want to include
this file. Too bad you need it just for the special sdp and ldp cases, but I
guess there's no other solution.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
