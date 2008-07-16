From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/0] Refreshed omap2 clock and powerdomain patches
Date: Wed, 16 Jul 2008 10:41:03 +0100
Message-ID: <20080716094103.GD23468@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40486 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbYGPJlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 05:41:13 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, Jul 16, 2008 at 11:53:20AM +0300, Tony Lindgren wrote:
> This series contains the refreshed omap2 clock and powerdomain
> patches as some of the patches in this series have been already
> integrated.

I think the clock and power domain patches need much more review.
They're introducing a couple of new management subsystems which may
be of interest to other SoCs, maybe even different architectures.
