From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Wed, 8 Feb 2012 10:45:39 -0800
Message-ID: <20120208184539.GE29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58554 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2BHSpn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:45:43 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
> While testing on my OMAP3430 platform, this error message was emitted:
> 
> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
> 
> Trying to find this message was difficult because it was wrapped across
> several lines.  It also mis-spells "required", doesn't read very well,
> and has spaces lacking.  Let's replace it with a more concise:
> 
> omap_vc_init_channel: No PMIC info for vdd_core
> 
> While we're here, fix a simple spelling error in a comment.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
