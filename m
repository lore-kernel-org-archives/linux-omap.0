From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
Date: Mon, 13 Jan 2014 23:12:27 +0000
Message-ID: <20140113231227.GI27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk> <20140113221425.GD7993@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36049 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751747AbaAMXMg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jan 2014 18:12:36 -0500
Content-Disposition: inline
In-Reply-To: <20140113221425.GD7993@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Mon, Jan 13, 2014 at 02:14:26PM -0800, Tony Lindgren wrote:
> * Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:17]:
> > Consolidate the setup of the channel control register.  Prepare the
> > basic value in the preparation of the DMA descriptor, and write it into
> > the register upon descriptor execution.
> 
> FYI, this patch seems to be the one that causes the
> "DMA timeout with device 55" error for omap1.

Okay, looks like I've missed some bit of muxing for DMA signals or
something.  I've yet to find any information on this in the OMAP5912
docs, so I guess I'm going to have to do this not only blind, but also
without hardware.  GAH.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
