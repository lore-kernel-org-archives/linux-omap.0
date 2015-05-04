From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Mon, 4 May 2015 11:10:46 +0530
Message-ID: <20150504054046.GZ3521@localhost>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19577 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbbEDFkL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 01:40:11 -0400
Content-Disposition: inline
In-Reply-To: <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com

On Thu, Apr 09, 2015 at 12:35:54PM +0300, Peter Ujfalusi wrote:
> The sDMA requests are routed through the DMA crossbar and without the
> crossbar only peripherals using DMA request 0-127 can be used.
> 
Need an ACK from ARM folks before I apply this and the DT ones too please

-- 
~Vinod

