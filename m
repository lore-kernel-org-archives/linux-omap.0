From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 6/7 v2] OMAP4: Clock stubs since clock
	management framework not in.
Date: Mon, 25 May 2009 14:04:19 +0100
Message-ID: <20090525130419.GE30553@n2100.arm.linux.org.uk>
References: <1242739959-12588-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35928 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbZEYNE0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 09:04:26 -0400
Content-Disposition: inline
In-Reply-To: <1242739959-12588-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, May 19, 2009 at 07:02:39PM +0530, Santosh Shilimkar wrote:
> (Patches are rebased on 2.6.30-rc6. The older version was based on 2.6.30-rc2)
> 
> This patch update the common clock.c file for OMAP4. The clk_get() and
> clk_put() sunctions are moved to  common place in arch/arm/common/clkdev.c

Just one small error - "functions"
