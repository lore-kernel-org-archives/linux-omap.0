From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
	related functions as __init
Date: Thu, 16 Feb 2012 10:11:23 +0000
Message-ID: <20120216101123.GI15338@n2100.arm.linux.org.uk>
References: <20120215182355.18884.18682.stgit@kaulin.local> <20120215182829.18884.69168.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58224 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2BPKLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 05:11:38 -0500
Content-Disposition: inline
In-Reply-To: <20120215182829.18884.69168.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Feb 15, 2012 at 10:28:30AM -0800, Tony Lindgren wrote:
> Now that omap hsmmc init is split into two functions, it's safe
> to mark omap_hsmmc_init and omap_mux related functions to __init.
> 
> This basically reverts the following fixes for the case where
> TWL was compiled as a module:
> 
> d5de63 (ARM: omap: preemptively fix section mismatch in omap4_sdp4430_wifi_mux_init())

Why did you include this one?  This is unrelated to the TWL problems.
