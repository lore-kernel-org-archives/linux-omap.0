From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/02] ARM: OMAP: DMA: Don't mark channel active in omap_enable_channel_irq
Date: Sat, 14 Jun 2008 09:02:23 +0100
Message-ID: <20080614080222.GE32122@flint.arm.linux.org.uk>
References: <1212801708-17599-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32908 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbYFNICe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 04:02:34 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

On Fri, Jun 06, 2008 at 06:21:47PM -0700, Tony Lindgren wrote:
> From: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Channel should be marked active only when DMA is really started. Otherwise
> just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch will cause
> incorrect dump_stack().
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

BTW, this looks like something for -rc kernels.
