From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] ARM: OMAP: Fix clockevent support for hrtimers
Date: Thu, 20 Mar 2008 14:43:46 +0000
Message-ID: <20080320144346.GA16166@flint.arm.linux.org.uk>
References: <1205423119-22292-1-git-send-email-tony@atomide.com> <1205423119-22292-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58600 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751AbYCTOn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 10:43:57 -0400
Content-Disposition: inline
In-Reply-To: <1205423119-22292-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Mar 13, 2008 at 05:45:14PM +0200, Tony Lindgren wrote:
> Signed-off-by: Tim Bird <tim.bird@am.sony.com>
> Signed-off-by: Kevin Hilman <khilman@mvista.com.

Only just spotted this... That trailing '.' should be a '>'.

> Signed-off-by: Tony Lindgren <tony@atomide.com>

Any chance of getting that fixed and I'll re-pull?
