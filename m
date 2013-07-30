From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
Date: Tue, 30 Jul 2013 23:52:33 +0100
Message-ID: <20130730225233.GF21614@n2100.arm.linux.org.uk>
References: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39349 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3G3WxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 18:53:10 -0400
Content-Disposition: inline
In-Reply-To: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>

On Tue, Jul 30, 2013 at 04:49:18PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> DEBUG_UNCOMPRESS was previously disallowed for omap2plus due to
> omap2plus.S's use of .data, which is not allowed in the decompressor.
> Solve this by placing that data into .text when building the file into
> the decompressor. This relies on .text actually being writable in the
> decompressor, which it is in practice.

Unless you decide to use ZBOOT and flash the zImage.
