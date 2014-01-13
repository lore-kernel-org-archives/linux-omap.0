From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Mon, 13 Jan 2014 14:17:13 +0000
Message-ID: <20140113141713.GC27282@n2100.arm.linux.org.uk>
References: <20140102150621.GJ16456@n2100.arm.linux.org.uk> <52CFE494.4010702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35646 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750899AbaAMOTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jan 2014 09:19:21 -0500
Content-Disposition: inline
In-Reply-To: <52CFE494.4010702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, sricharan.az@gmail.com

On Fri, Jan 10, 2014 at 05:46:20PM +0530, Sricharan R wrote:
> I tested this series on DRA7 with mmc peripheral dma and it looked
> fine. Some how dmaengine test cases were not fine. But that may not
> have anything to do with this series. I will check more on that and
> will come back with that results as well.

Not fine in what sense?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
