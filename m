From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
Date: Fri, 2 Aug 2013 10:03:47 +0100
Message-ID: <20130802090347.GD23053@n2100.arm.linux.org.uk>
References: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org> <20130730225233.GF21614@n2100.arm.linux.org.uk> <51F845C7.8020106@wwwdotorg.org> <20130731064634.GR7656@atomide.com> <51F94200.2060202@wwwdotorg.org> <20130802072925.GX7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39894 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3HBJFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 05:05:34 -0400
Content-Disposition: inline
In-Reply-To: <20130802072925.GX7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>

On Fri, Aug 02, 2013 at 12:29:25AM -0700, Tony Lindgren wrote:
> It seems the best strategy seems to be to just init things later on
> so DEBUG_LL is only needed when booting breaks really early on
> during the boot process.

... which is exactly the whole point and use case of DEBUG_LL. :)
