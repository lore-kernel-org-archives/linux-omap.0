From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/21] ARM: OMAP: Add OMAP3430 base defines
Date: Sat, 14 Jun 2008 09:01:46 +0100
Message-ID: <20080614080146.GD32122@flint.arm.linux.org.uk>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32906 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbYFNIB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 04:01:56 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 06:30:35PM -0700, Tony Lindgren wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> Add symbolic constants for OMAP3430 base addresses; include that file
> in hardware.h.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

> +#define IRQ_SIR_IRQ		0x0040

Aren't IRQ numbers normally decimal?
