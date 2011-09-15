From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: twl6030: Setup irq_wake infrastructure.
Date: Thu, 15 Sep 2011 19:02:03 +0200
Message-ID: <20110915170203.GJ32263@sortiz-mobl>
References: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51524 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934142Ab1IOQ7X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 12:59:23 -0400
Content-Disposition: inline
In-Reply-To: <1315324770-14530-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Santosh,

On Tue, Sep 06, 2011 at 09:29:30PM +0530, Santosh Shilimkar wrote:
> TWL6030 devices have an interrupt line which is connected to
> application processor like OMAP. These devices support multiple features
> such as MMC card detect, USB cable detect, RTC interrupt, etc. that must
> wake up the application processor.
> 
> With this change, TWL6030 client drivers can make use of
> irq_wake() if the wakeup is desirable on it's irq events.
Patch applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
