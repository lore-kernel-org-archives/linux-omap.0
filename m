From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/7] ARM: OMAP2: Add MMC hwmod data for 2420
Date: Wed, 2 May 2012 18:44:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205021840160.19695@utopia.booyaka.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local> <20120424000832.17783.21327.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39291 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab2ECAoV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 20:44:21 -0400
In-Reply-To: <20120424000832.17783.21327.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

On Mon, 23 Apr 2012, Tony Lindgren wrote:

> Add MMC for 2420 so we can pass the DMA request lines the same
> way as we already do on omap2430 and later.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Made a few changes here so that it applies on the omap-devel-a-for-3.5 tag 
that you pulled in.  Also changed the 2420 MMC class name to "msdi" and 
the hwmod name to "msdi1" -- this is the IP block name that is listed in 
the 2420 TRM Rev. X Table 26-9 "Instance Summary".  It also is convenient 
for us, because the 2420 MMC driver is different than the 2430+ HSMMC 
driver, so we can just probe all of the hwmods of class "msdi" to register 
the 2420 MMC :-)


- Paul
