From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Add support for memcpy
Date: Mon, 4 May 2015 14:05:45 +0530
Message-ID: <20150504083545.GD3521@localhost>
References: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28592 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbbEDIfD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 04:35:03 -0400
Content-Disposition: inline
In-Reply-To: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com

On Wed, Apr 22, 2015 at 10:34:29AM +0300, Peter Ujfalusi wrote:
> The sDMA controller is capable of performing memory copy operation. It need
> to be configured to software triggered mode and without HW synchronization.
> The sDMA can copy data which is aligned to 8, 16 or 32 bits.
Applied, thanks

-- 
~Vinod

