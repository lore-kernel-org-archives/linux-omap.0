From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dma: omap-dma: Implement device_slave_caps callback
Date: Sat, 29 Mar 2014 19:06:22 +0530
Message-ID: <20140329133622.GP1976@intel.com>
References: <1394199404-7870-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23995 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbaC2Nnq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Mar 2014 09:43:46 -0400
Content-Disposition: inline
In-Reply-To: <1394199404-7870-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com

On Fri, Mar 07, 2014 at 03:36:44PM +0200, Peter Ujfalusi wrote:
> With the callback implemented omap-dma can provide information to client
> drivers regarding to supported address widths, directions, residue
> granularity, etc.
>

Applied, thanks

-- 
~Vinod
