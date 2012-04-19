From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/12] ARM: OMAP2xxx: hwmod data: start to fix the
	IVA1, IVA2 and DSP
Date: Thu, 19 Apr 2012 10:28:23 +0100
Message-ID: <20120419092823.GW25053@n2100.arm.linux.org.uk>
References: <20120308023614.8205.78768.stgit@dusk> <20120308023840.8205.51532.stgit@dusk> <alpine.DEB.2.00.1204190317030.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42130 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab2DSJ2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 05:28:32 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204190317030.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Apr 19, 2012 at 03:18:27AM -0600, Paul Walmsley wrote:
> N800 logs this message on boot:
> 
> [    0.182281] omap_hwmod: iva: cannot be enabled for reset (3)
> 
> Fix by creating basic IVA1 and DSP hwmods for OMAP2420, and a basic IVA2
> hwmod for OMAP2430.  There is still more information to be added, but
> this should resolve the immediate issue.

FYI, I'm also seeing omap_hwmod errors on boot:

3430ldp: http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=133
omap_hwmod: i2c1: softreset failed (waited 10000 usec)
omap_hwmod: i2c2: softreset failed (waited 10000 usec)
omap_hwmod: i2c3: softreset failed (waited 10000 usec)

4430sdp: http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=134
omap_hwmod: i2c1: softreset failed (waited 10000 usec)
omap_hwmod: i2c2: softreset failed (waited 10000 usec)
omap_hwmod: i2c3: softreset failed (waited 10000 usec)
omap_hwmod: i2c4: softreset failed (waited 10000 usec)
omap_hwmod: ipu: failed to hardreset
